import sys, os, struct, hashlib, csv

sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib import clientfs, mpq

BS = chr(92)
HERE = os.path.dirname(os.path.abspath(__file__))
TABS = os.path.join(HERE, 'tabs')
data = r'E:\Aetheria-Staging\clean-client-20261023\Data'
found = []
for folder in (data, os.path.join(data, 'enUS')):
    if os.path.isdir(folder):
        found += [os.path.join(folder, n) for n in os.listdir(folder) if n.lower().endswith('.mpq')
                  and 'classtabs' not in n.lower()]
found.sort(key=lambda p: os.path.basename(p).lower())
f = clientfs.ClientFiles(data, 'enUS')
f.chain = list(reversed(found))


class Dbc:
    def __init__(self, name):
        raw, self.src = f.find('DBFilesClient' + BS + name + '.dbc')
        _, n, self.fc, self.rs, ss = struct.unpack('<4sIIII', raw[:20])
        self.rows = [list(struct.unpack('<%dI' % self.fc, raw[20 + i * self.rs:20 + (i + 1) * self.rs]))
                     for i in range(n)]
        self.pool = bytearray(raw[20 + n * self.rs:])
        self.by_id = {r[0]: r for r in self.rows}

    def add_string(self, text):
        off = len(self.pool)
        self.pool += text.encode('utf8') + bytes([0])
        return off

    def write(self):
        body = b''.join(struct.pack('<%dI' % self.fc, *r) for r in self.rows)
        return struct.pack('<4sIIII', b'WDBC', len(self.rows), self.fc, self.rs, len(self.pool)) + body + bytes(self.pool)


def tsv(name):
    with open(os.path.join(TABS, name + '.tsv'), encoding='utf8') as fh:
        rows = [l.rstrip('\n').split('\t') for l in fh if l.strip()]
    return rows[1:]


spell, sl, sla, srci = Dbc('Spell'), Dbc('SkillLine'), Dbc('SkillLineAbility'), Dbc('SkillRaceClassInfo')
print('sources:', [os.path.basename(d.src)[:48] for d in (spell, sl, sla)])
assert sl.fc == 56 and sla.fc == 14 and srci.fc == 8

classes = {int(c): (n, int(i)) for c, n, i in tsv('classes')}
ranks = {}                                    # first spell -> [spell ids]
for first, sid in ((int(a), int(b)) for a, b in tsv('ranks')):
    ranks.setdefault(first, []).append(sid)

owner = {}                                    # spell -> class, first writer wins


def claim(spell_id, cls):
    owner.setdefault(spell_id, cls)


first_class = {}
for cls, first in ((int(a), int(b)) for a, b in tsv('entries')):
    first_class.setdefault(first, cls)
for first, cls in first_class.items():
    claim(first, cls)
    for r in ranks.get(first, []):
        claim(r, cls)
for variant, base in ((int(a), int(b)) for a, b in tsv('variants')):
    cls = first_class.get(base)
    if cls:
        claim(variant, cls)
        for r in ranks.get(variant, []):
            claim(r, cls)
for parent, child in ((int(a), int(b)) for a, b in tsv('taught')):
    cls = owner.get(parent)
    if cls:
        claim(child, cls)
for cls, sid in ((int(a), int(b)) for a, b in tsv('auto')):
    claim(sid, cls)

already = {r[2] for r in sla.rows}            # spells that already have a skill line keep it
HERO_CLASS_MASK = 512                         # class 10; the same mask the module's Hero line uses
ICON_FIELD = 133                              # Spell.dbc SpellIconID
SL_ICON = 37                                  # SkillLine.dbc SpellIconID
LINE_BASE = 2000

per_class = {}
skipped = 0
for sid, cls in sorted(owner.items()):
    if cls not in classes or sid not in spell.by_id or sid in already:
        skipped += 1
        continue
    per_class.setdefault(cls, []).append(sid)

template = sl.by_id[990]
next_sla = max(sla.by_id) + 1
next_srci = max(srci.by_id) + 1
for cls in sorted(per_class):
    name, icon_spell = classes[cls]
    line = LINE_BASE + cls
    assert line not in sl.by_id
    row = list(template)
    row[0] = line
    off = sl.add_string(name)
    for i in range(3, 19):
        row[i] = off
    srow = spell.by_id.get(icon_spell)
    row[SL_ICON] = srow[ICON_FIELD] if srow else template[SL_ICON]
    sl.rows.append(row); sl.by_id[line] = row
    srci_row = [next_srci, line, 0, 0, 1040, 0, 0, 0]
    srci.rows.append(srci_row); srci.by_id[next_srci] = srci_row; next_srci += 1
    for sid in per_class[cls]:
        new = [next_sla, line, sid, 0, HERO_CLASS_MASK, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        sla.rows.append(new); sla.by_id[next_sla] = new
        next_sla += 1
    print('%-14s line %d: %d spells' % (name, line, len(per_class[cls])))
print('spells assigned:', sum(len(v) for v in per_class.values()), 'skipped:', skipped, 'tabs:', len(per_class))

# Stock classes get a section of their own (Rogue rather than Combat). The stock rows stay as they are, so real
# warriors, rogues and the rest are untouched; each stock spell also gets a Hero-only row on a new class line.
HERO_BIT = 512
STOCK = {1: ('Warrior', 78), 2: ('Paladin', 635), 3: ('Hunter', 75), 4: ('Rogue', 1752), 5: ('Priest', 585),
         6: ('Death Knight', 45902), 7: ('Shaman', 403), 8: ('Mage', 133), 9: ('Warlock', 686), 11: ('Druid', 5176)}
line_counts = {}
for r in sla.rows:
    line = sl.by_id.get(r[1])
    # only rows naming a single class say whose line this is; "every class" rows (Dodge, Parry...) sit on every line
    if line and line[1] == 7 and r[1] < 2000 and r[1] != 990 and r[4] and (r[4] & (r[4] - 1)) == 0:
        counts = line_counts.setdefault(r[1], {})
        counts[r[4]] = counts.get(r[4], 0) + 1
line_class = {}
for ln, counts in line_counts.items():
    mask, top = max(counts.items(), key=lambda kv: kv[1])
    # the dominant class owns the line when it has nearly all the single-class rows (Holy: 178 Paladin, 1 Priest)
    if top >= 0.9 * sum(counts.values()):
        for c in STOCK:
            if mask == (1 << (c - 1)):
                line_class[ln] = c
have = {r[2] for r in sla.rows if r[1] >= 2000}
stock_names = {}
for c, (name, icon_spell) in STOCK.items():
    line = LINE_BASE + c
    assert line not in sl.by_id
    row = list(template)
    row[0] = line
    off = sl.add_string(name)
    for i in range(3, 19):
        row[i] = off
    srow = spell.by_id.get(icon_spell)
    row[SL_ICON] = srow[ICON_FIELD] if srow else template[SL_ICON]
    sl.rows.append(row); sl.by_id[line] = row
    srci_row = [next_srci, line, 0, 0, 1040, 0, 0, 0]
    srci.rows.append(srci_row); srci.by_id[next_srci] = srci_row; next_srci += 1
stock_assigned = 0
for r in list(sla.rows):
    c = line_class.get(r[1])
    if c and r[2] not in have and r[2] in spell.by_id:
        new = [next_sla, LINE_BASE + c, r[2], 0, HERO_BIT, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        sla.rows.append(new); sla.by_id[next_sla] = new
        next_sla += 1
        have.add(r[2])
        stock_assigned += 1
print('stock class lines:', len(STOCK), 'stock spells assigned:', stock_assigned)
out = {'DBFilesClient' + BS + 'SkillRaceClassInfo.dbc': srci.write(),
       'DBFilesClient' + BS + 'SkillLine.dbc': sl.write(),
       'DBFilesClient' + BS + 'SkillLineAbility.dbc': sla.write()}
for k, v in out.items():
    print(len(v), k)
dst = os.path.join(HERE, 'Patch-' + 'z' * 45 + '-AetheriaClassTabs.MPQ')
if '--write' in sys.argv:
    mpq.write_archive(dst, out)
    print('wrote', dst, os.path.getsize(dst), hashlib.sha256(open(dst, 'rb').read()).hexdigest())
