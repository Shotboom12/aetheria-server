import sys, os, struct, hashlib

sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib import mpq

BS = chr(92)
PAYLOAD = (r'C:\Users\mandr\Documents\Codex\2026-09-27\thi\kali-integration-20261021\client-repair-20261022'
           r'\reference-portraits\payload\Interface\Glues\CharacterCreate')
TOKENS = {74: 'CentaurHorde', 75: 'SlimeGiantAlliance', 76: 'SlimeGiantHorde'}
HEADER = 148 + 1024


def drop_top_mip(raw):
    """128x128 uncompressed BLP2 (8 mip levels, offsets/sizes tables) -> 64x64 by dropping level 0."""
    magic, ver, comp, alpha, aty, hasmip, w, h = struct.unpack('<4sIBBBBII', raw[:20])
    assert magic == b'BLP2' and comp == 3 and w == 128 and h == 128 and hasmip == 1
    offs = list(struct.unpack('<16I', raw[20:84]))
    sizes = list(struct.unpack('<16I', raw[84:148]))
    palette = raw[148:HEADER]
    levels = [raw[offs[i]:offs[i] + sizes[i]] for i in range(16) if sizes[i]]
    assert len(levels) == 8 and len(levels[0]) == 128 * 128 * 4 and len(levels[1]) == 64 * 64 * 4
    levels = levels[1:]
    new_offs, new_sizes, pos = [0] * 16, [0] * 16, HEADER
    for i, level in enumerate(levels):
        new_offs[i], new_sizes[i] = pos, len(level)
        pos += len(level)
    out = struct.pack('<4sIBBBBII', magic, ver, comp, alpha, aty, hasmip, 64, 64)
    out += struct.pack('<16I', *new_offs) + struct.pack('<16I', *new_sizes) + palette + b''.join(levels)
    assert len(out) == 23016, len(out)
    return out


CC = 'Interface' + BS + 'Glues' + BS + 'CharacterCreate' + BS
CS = 'Interface' + BS + 'Glues' + BS + 'CharacterSelect' + BS
CF = 'Interface' + BS + 'CharacterFrame' + BS
out = {}
for race, token in TOKENS.items():
    for sex in ('Male', 'Female'):
        big = open(os.path.join(PAYLOAD, 'AetheriaCreatorPortrait-v1-%d%s.blp' % (race, sex)), 'rb').read()
        small = drop_top_mip(big)
        out[CC + 'AetheriaCreatorPortrait-v1-%d%s.blp' % (race, sex)] = big
        out[CC + 'UI-CharacterCreate-%s%s.blp' % (token, sex)] = small
        out[CS + 'ECS-Portrait-%s%s.blp' % (token, sex)] = small
        out[CF + 'TemporaryPortrait-%s-%s.blp' % (sex, token)] = small
        out[CF + 'TemporaryPortrait-%s-%s' % (sex, token)] = small
out['Interface' + BS + 'GlueXML' + BS + 'ECS_Schema.lua'] = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'ECS_Schema.patched.lua'), 'rb').read()
for name in sorted(out):
    print(len(out[name]), name.split(BS)[-1])
dst = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                   'Patch-zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz-AetheriaRacePortraits.MPQ')
if '--write' in sys.argv:
    mpq.write_archive(dst, out)
    print('wrote', dst, os.path.getsize(dst), hashlib.sha256(open(dst, 'rb').read()).hexdigest())
