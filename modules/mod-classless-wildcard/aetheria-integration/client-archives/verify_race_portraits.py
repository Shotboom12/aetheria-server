import sys, os, struct, zlib

sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib import clientfs

BS = chr(92)
T = r'D:\AcoreRaceFix\HeroBuild\tmp'
arch = os.path.join(T, 'Patch-zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz-AetheriaRacePortraits.MPQ')
data = r'E:\Aetheria-Staging\clean-client-20261023\Data'
f = clientfs.ClientFiles(data, 'enUS')
mine = f._archive(arch)
CF = 'Interface' + BS + 'CharacterFrame' + BS


def header(raw):
    magic, ver, comp, alpha, aty, hasmip, w, h = struct.unpack('<4sIBBBBII', raw[:20])
    offs = struct.unpack('<16I', raw[20:84])
    sizes = struct.unpack('<16I', raw[84:148])
    return (magic, ver, comp, alpha, aty, hasmip, w, h), offs, sizes


ref, src = f.find(CF + 'TemporaryPortrait-Male-DracthyrHorde.blp')
print('reference header', header(ref))
ok = True
for token in ('CentaurHorde', 'SlimeGiantAlliance', 'SlimeGiantHorde'):
    for sex in ('Male', 'Female'):
        raw = mine.read_file(CF + 'TemporaryPortrait-%s-%s.blp' % (sex, token))
        same = header(raw) == header(ref)
        ok = ok and same
        print(token, sex, len(raw), 'header matches working portrait:', same)
print('ALL MATCH' if ok else 'MISMATCH')


def png(path, w, h, bgra):
    rows = b''.join(bytes([0]) + b''.join(bytes([bgra[(y * w + x) * 4 + 2], bgra[(y * w + x) * 4 + 1],
                                                 bgra[(y * w + x) * 4], bgra[(y * w + x) * 4 + 3]]) for x in range(w))
                    for y in range(h))

    def chunk(tag, body):
        c = struct.pack('>I', len(body)) + tag + body
        return c + struct.pack('>I', zlib.crc32(tag + body) & 0xffffffff)
    open(path, 'wb').write(b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', w, h, 8, 6, 0, 0, 0)) +
                           chunk(b'IDAT', zlib.compress(rows)) + chunk(b'IEND', b''))


# contact sheet: Centaur M/F, Slime Alliance, Slime Horde, Dracthyr reference (64x64 each)
tiles = []
for token, sex in (('CentaurHorde', 'Male'), ('CentaurHorde', 'Female'), ('SlimeGiantAlliance', 'Male'), ('SlimeGiantHorde', 'Male')):
    raw = mine.read_file(CF + 'TemporaryPortrait-%s-%s.blp' % (sex, token))
    _, offs, sizes = header(raw)
    tiles.append(raw[offs[0]:offs[0] + sizes[0]])
_, offs, sizes = header(ref)
tiles.append(ref[offs[0]:offs[0] + sizes[0]])
W = 64 * len(tiles)
sheet = bytearray(W * 64 * 4)
for i, tile in enumerate(tiles):
    for y in range(64):
        sheet[(y * W + i * 64) * 4:(y * W + i * 64 + 64) * 4] = tile[y * 256:(y + 1) * 256]
png(os.path.join(T, 'portrait_preview.png'), W, 64, bytes(sheet))
print('preview written')
