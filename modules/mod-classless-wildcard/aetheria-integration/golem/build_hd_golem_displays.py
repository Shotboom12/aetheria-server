import sys, os, struct, hashlib
sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib import clientfs, mpq
data = r'E:\Aetheria-Staging\clean-client-20261023\Data'
found = []
for folder in (data, os.path.join(data, 'enUS')):
    found += [os.path.join(folder, n) for n in os.listdir(folder) if n.lower().endswith('.mpq')]
arch = {os.path.basename(p).lower(): p for p in found}
f = clientfs.ClientFiles(data, 'enUS')
BS = chr(92)
CDI = 'DBFilesClient' + BS + 'CreatureDisplayInfo.dbc'
CMD = 'DBFilesClient' + BS + 'CreatureModelData.dbc'

def read(archive, name):
    try:
        return f._archive(arch[archive.lower()]).read_file(name)
    except Exception:
        return None

def parse(raw):
    _, n, fc, rs, ss = struct.unpack('<4sIIII', raw[:20])
    sb = 20 + n * rs
    recs = [list(struct.unpack('<%dI' % fc, raw[20 + i * rs:20 + (i + 1) * rs])) for i in range(n)]
    return recs, raw[sb:sb + ss], fc, rs

def sstr(block, off):
    return block[off:block.index(b'\0', off)].decode('utf-8', 'replace')

# Which archives carry CreatureDisplayInfo, so the base is the one the client really ends up with
print('archives with CreatureDisplayInfo:', [os.path.basename(p) for p in found if read(os.path.basename(p), CDI)][-8:])
base_name = 'Patch-ZZZZZZZZZZZZZZZZZZZZZZZZCoA.MPQ'
base = read(base_name, CDI)
recs, block, fc, rs = parse(base)

# Golem model ids from the base's CreatureModelData
cmd = read(base_name, CMD)
crecs, cblock, cfc, crs = parse(cmd)
golem_models = {r[0] for r in crecs if 'fleshgolem' in sstr(cblock, r[2]).lower()}
print('golem model ids:', sorted(golem_models))

# HD texture names per display id, from the HD pack's own display rows
hd = {}
for a in ('patch-f.mpq', 'patch-enus-f.mpq'):
    raw = read(a, CDI)
    if not raw:
        continue
    r2, b2, _, _ = parse(raw)
    for r in r2:
        if r[1] in golem_models and r[6]:
            hd.setdefault(r[0], sstr(b2, r[6]))
print('HD display rows:', len(hd))

# stock first-texture name -> HD name, learned from rows present in both
stock_to_hd = {}
for r in recs:
    if r[0] in hd and r[6]:
        stock_to_hd.setdefault(sstr(block, r[6]), hd[r[0]])
print('stock->HD map:', stock_to_hd)

# which HD textures actually exist in the HD archive
hd_archive = f._archive(arch['patch-f.mpq'])
def exists(name):
    return hd_archive.read_file('Creature' + BS + 'FleshGolem' + BS + name + '.blp') is not None

new_strings = {}
newblock = bytearray(block)
def add_string(s):
    if s in new_strings:
        return new_strings[s]
    off = len(newblock)
    newblock.extend(s.encode('utf-8') + b'\0')
    new_strings[s] = off
    return off

changed = []
for r in recs:
    if r[1] not in golem_models or not r[6]:
        continue
    cur = sstr(block, r[6])
    target = hd.get(r[0]) or stock_to_hd.get(cur)
    if not target or target == cur:
        continue
    if not exists(target):
        print('   HD texture missing for', r[0], target)
        continue
    r[6] = add_string(target)
    changed.append((r[0], cur, target))
print('rows changed:', len(changed))
for c in changed[:50]:
    print('   ', c)

out = bytearray(b'WDBC' + struct.pack('<IIII', len(recs), fc, rs, len(newblock)))
for r in recs:
    out.extend(struct.pack('<%dI' % fc, *r))
out.extend(newblock)
dst = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Patch-zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz-AetheriaHdGolem.MPQ')
if '--write' in sys.argv:
    mpq.write_archive(dst, {CDI: bytes(out)})
    print('wrote', dst, os.path.getsize(dst), hashlib.sha256(open(dst, 'rb').read()).hexdigest())
