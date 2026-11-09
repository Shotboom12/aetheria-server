import sys, os, struct, hashlib
sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib import clientfs, mpq
data = r'E:\Aetheria-Staging\clean-client-20261023\Data'
found = []
for folder in (data, os.path.join(data, 'enUS')):
    found += [os.path.join(folder, n) for n in os.listdir(folder) if n.lower().endswith('.mpq')]
arch = {os.path.basename(p).lower(): p for p in found}
f = clientfs.ClientFiles(data, 'enUS')

def read(name, archive):
    try:
        return f._archive(arch[archive]).read_file(name)
    except Exception:
        return None

# Stock sources, best first: patch.mpq (3.3.5 updated), then common-2, then common.
stock_order = ('patch.mpq', 'common-2.mpq', 'common.mpq')
hd = 'patch-f.mpq'
BS = chr(92)
folder = 'Creature' + BS + 'FleshGolem' + BS

names = [folder + 'FleshGolem.m2'] + [folder + 'FleshGolem%02d.skin' % i for i in range(0, 8)]
for anim in range(0, 800):
    for var in range(0, 8):
        names.append(folder + 'FleshGolem%04d-%02d.anim' % (anim, var))

out = {}
report = []
for n in names:
    stock = None
    src = None
    for a in stock_order:
        stock = read(n, a)
        if stock:
            src = a
            break
    in_hd = read(n, hd) is not None
    if stock:
        out[n] = stock
        report.append((n.split(BS)[-1], src, len(stock), 'overrides HD' if in_hd else 'stock only (also add)'))
    elif in_hd:
        report.append((n.split(BS)[-1], '-', 0, 'HD only, no stock version (left as is)'))

for r in report:
    print(r)
print('files to pack:', len(out))
dst = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Patch-zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz-AetheriaStockGolem.MPQ')
if '--write' in sys.argv:
    mpq.write_archive(dst, out)
    print('wrote', dst, os.path.getsize(dst), hashlib.sha256(open(dst, 'rb').read()).hexdigest())
