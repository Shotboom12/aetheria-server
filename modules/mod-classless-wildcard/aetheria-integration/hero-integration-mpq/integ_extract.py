import sys, os
sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib.mpq import MPQArchive
p = r'E:\Aetheria-Staging\clean-client-20261023\Data\Patch-zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz-AetheriaHeroIntegration.MPQ'
out = r'D:\AcoreRaceFix\HeroBuild\tmp\integ'
with MPQArchive(p) as a:
    names = [n for n in a.read_file('(listfile)').decode().split('\r\n') if n and n != '(listfile)']
    for n in names:
        fp = os.path.join(out, *n.split('\\'))
        os.makedirs(os.path.dirname(fp), exist_ok=True)
        open(fp, 'wb').write(a.read_file(n))
print(len(names))
