import sys, os, hashlib
sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib.mpq import MPQArchive, write_archive
src = r'E:\Aetheria-Staging\clean-client-20261023\Data\Patch-zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz-AetheriaHeroIntegration.MPQ'
root = r'D:\AcoreRaceFix\HeroBuild\tmp\integ'
out = r'D:\AcoreRaceFix\HeroBuild\tmp\Patch-HeroIntegration-new.MPQ'
files = {}
with MPQArchive(src) as a:
    names = [n for n in a.read_file('(listfile)').decode().split('\r\n') if n and n != '(listfile)']
    for n in names:
        files[n] = open(os.path.join(root, *n.split('\\')), 'rb').read()
write_archive(out, files)
# verify: every file reads back identical, and only CharacterCreate.lua differs from the installed archive
with MPQArchive(out) as b, MPQArchive(src) as a:
    for n in names:
        same = b.read_file(n) == a.read_file(n)
        assert b.read_file(n) == files[n]
        print(('same   ' if same else 'CHANGED'), n)
print(hashlib.sha256(open(out, 'rb').read()).hexdigest())
