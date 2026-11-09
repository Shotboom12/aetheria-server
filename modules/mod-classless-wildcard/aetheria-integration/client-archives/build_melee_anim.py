import sys, os, struct, hashlib

sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib import clientfs, mpq

BS = chr(92)
data = r'E:\Aetheria-Staging\clean-client-20261023\Data'
found = []
for folder in (data, os.path.join(data, 'enUS')):
    if os.path.isdir(folder):
        found += [os.path.join(folder, n) for n in os.listdir(folder) if n.lower().endswith('.mpq')
                  and 'meleeanim' not in n.lower()]
found.sort(key=lambda p: os.path.basename(p).lower())
f = clientfs.ClientFiles(data, 'enUS')
f.chain = list(reversed(found))


class Dbc:
    def __init__(self, name):
        self.name = name
        raw, self.src = f.find('DBFilesClient' + BS + name + '.dbc')
        _, self.n, self.fc, self.rs, ss = struct.unpack('<4sIIII', raw[:20])
        self.rows = [list(struct.unpack('<%dI' % self.fc, raw[20 + i * self.rs:20 + (i + 1) * self.rs]))
                     for i in range(self.n)]
        self.pool = bytearray(raw[20 + self.n * self.rs:])
        self.src_raw_n = self.n
        self.by_id = {r[0]: r for r in self.rows}

    def add_string(self, text):
        off = len(self.pool)
        self.pool += text.encode('utf8') + bytes([0])
        return off

    def write(self):
        body = b''.join(struct.pack('<%dI' % self.fc, *r) for r in self.rows)
        return struct.pack('<4sIIII', b'WDBC', len(self.rows), self.fc, self.rs, len(self.pool)) + body + bytes(self.pool)


spell, vis, kit = Dbc('Spell'), Dbc('SpellVisual'), Dbc('SpellVisualKit')
print('sources:', [os.path.basename(d.src)[:50] for d in (spell, vis, kit)])
assert spell.fc == 234

SPELL_VISUAL = 131
ATTACK_1H, ATTACK_2H, PIERCE = 17, 18, 85
TWO_HAND_SUB = (1 << 1) | (1 << 5) | (1 << 6) | (1 << 8) | (1 << 10)   # 2h axe/mace/polearm/2h sword/staff
GESTURE = (53, 54)                  # SpellCastDirected / SpellCastOmni: a cast gesture, not a weapon swing
SOUL_STRIKE = {500517, 500518, 500519, 500520, 500521, 500646}
EXCLUDE = {805657}                  # Sprocket Zap! is a gadget zap, not a weapon strike


def animation_for(sub):
    if sub == 0x8000:               # dagger-only abilities stab
        return PIERCE
    if sub & ~TWO_HAND_SUB == 0:    # two-handed weapons only
        return ATTACK_2H
    return ATTACK_1H


targets = {}
for r in spell.rows:
    sid = r[0]
    if sid < 500000 or sid in EXCLUDE or r[68] != 2 or r[28] not in (0, 1) or r[46] != 2:
        continue
    v = vis.by_id.get(r[SPELL_VISUAL]) if r[SPELL_VISUAL] else None
    if sid == 950772 and v is not None and not v[2]:
        targets[sid] = animation_for(r[69])          # Holy Sinister Strike: visual without any cast kit
        continue
    k = kit.by_id.get(v[2]) if v and v[2] else None
    if k and k[2] in GESTURE:
        targets[sid] = animation_for(r[69])
print('spells to change:', len(targets))

next_kit = max(kit.by_id) + 1
next_vis = max(vis.by_id) + 1
made = {}                           # (old visual, animation) -> new visual
log = []
flagged = []
for sid, anim in sorted(targets.items()):
    row = spell.by_id[sid]
    old = row[SPELL_VISUAL]
    key = (old, anim)
    if key not in made:
        base_vis = list(vis.by_id[old])
        base_kit_id = base_vis[2]
        if base_kit_id and base_kit_id in kit.by_id:
            new_kit = list(kit.by_id[base_kit_id])
        else:
            new_kit = list(kit.rows[0])
            new_kit[1:] = [0xFFFFFFFF] + [0] * (len(new_kit) - 2)
            new_kit[1] = 0xFFFFFFFF
        new_kit[0] = next_kit
        new_kit[2] = anim
        kit.rows.append(new_kit); kit.by_id[next_kit] = new_kit
        base_vis[0] = next_vis
        base_vis[2] = next_kit
        vis.rows.append(base_vis); vis.by_id[next_vis] = base_vis
        made[key] = next_vis
        next_kit += 1; next_vis += 1
    # Known-working stock/CoA visuals beat synthesized ones: Backstab's stab for daggers, Reap's shadow strike for
    # the Reaper's Soul Strike, Sinister Strike's swing for the rest.
    name_row = spell.by_id[sid]
    if anim == PIERCE:
        chosen = 155
    elif sid in SOUL_STRIKE:
        chosen = 2279
    else:
        chosen = 253
    row[SPELL_VISUAL] = chosen
    # Every ability that animates (Sinister Strike, Backstab, Reap, Soul Strike) carries SPELL_ATTR0 "ability" 0x10;
    # Rusty Shiv is a bare aura spell without it and plays no weapon animation.
    if not row[4] & 0x10:
        row[4] |= 0x10
        flagged.append(sid)
    log.append((sid, old, chosen, anim))


# Engraving helper spells that exist on the server (engraving_helper_spells.sql) but not in the client: without a
# client row the combat log prints a blank name for the damage/heal they deal. Cloned from a plain damage helper row.
HELPERS = {712492: ('Weapon Engraving: Water', 1), 712493: ('Arcane Engraving: Stored Healing', 27305)}
TEMPLATE = 712491
for hid, (hname, hicon) in HELPERS.items():
    assert hid not in spell.by_id
    row = list(spell.by_id[TEMPLATE])
    row[0] = hid
    off = spell.add_string(hname)
    for i in range(136, 152):
        if row[i]:
            row[i] = off
    for base in (153, 170, 187):               # rank, description and tooltip blocks: empty
        for i in range(base, base + 16):
            row[i] = 0
    row[133] = hicon
    spell.rows.append(row); spell.by_id[hid] = row
print('helper rows added:', sorted(HELPERS))
print('new kits/visuals:', len(made), 'ability flag added to:', flagged)
out = {
    'DBFilesClient' + BS + 'Spell.dbc': spell.write(),
    'DBFilesClient' + BS + 'SpellVisual.dbc': vis.write(),
    'DBFilesClient' + BS + 'SpellVisualKit.dbc': kit.write(),
}
for name, blob in out.items():
    print(len(blob), name)
dst = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                   'Patch-' + 'z' * 44 + '-AetheriaMeleeAnim.MPQ')
if '--write' in sys.argv:
    mpq.write_archive(dst, out)
    print('wrote', dst, os.path.getsize(dst), hashlib.sha256(open(dst, 'rb').read()).hexdigest())
    with open(os.path.join(os.path.dirname(dst), 'melee_anim_changes.csv'), 'w') as fh:
        fh.write('spell,old_visual,new_visual,anim\n')
        for l in log:
            fh.write('%d,%d,%d,%d\n' % l)
