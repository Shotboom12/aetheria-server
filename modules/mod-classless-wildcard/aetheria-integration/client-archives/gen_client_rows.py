import sys, os, struct, subprocess

sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib import clientfs

BS = chr(92)
NUL = bytes([0])
HB = r'D:\AcoreRaceFix\HeroBuild' + BS
# usage: gen_client_rows.py <DbcName> <table> <id,id,...>   (column types read from the world DB)
dbc, table, ids = sys.argv[1], sys.argv[2], [int(x) for x in sys.argv[3].split(',')]
q = ('SELECT COLUMN_NAME,COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() '
     'AND TABLE_NAME="%s" ORDER BY ORDINAL_POSITION' % table)
res = subprocess.run(['pwsh', '-NoProfile', '-File', HB + r'tmp\Q.ps1', '-Db', 'world', '-Sql', q],
                     capture_output=True, text=True)
cols = [l.split(chr(9)) for l in res.stdout.splitlines()[1:] if l.strip()]
data = r'E:\Aetheria-Staging\clean-client-20261023\Data'
found = []
for folder in (data, os.path.join(data, 'enUS')):
    if os.path.isdir(folder):
        found += [os.path.join(folder, n) for n in os.listdir(folder) if n.lower().endswith('.mpq')]
found.sort(key=lambda p: os.path.basename(p).lower())
f = clientfs.ClientFiles(data, 'enUS')
f.chain = list(reversed(found))
raw, src = f.find('DBFilesClient' + BS + dbc + '.dbc')
_, n, fc, rs, ss = struct.unpack('<4sIIII', raw[:20])
assert fc == len(cols), (fc, len(cols))
pool = raw[20 + n * rs:]


def quote(b):
    return "'" + b.decode('utf8', 'replace').replace(BS, BS * 2).replace("'", "''") + "'"


out = []
for i in range(n):
    v = struct.unpack('<%dI' % fc, raw[20 + i * rs:20 + (i + 1) * rs])
    if v[0] not in ids:
        continue
    vals = []
    for (name, typ), x in zip(cols, v):
        base = typ.split('(')[0]
        if base in ('varchar', 'text'):
            vals.append(quote(pool[x:pool.index(NUL, x)]) if x < len(pool) else "''")
        elif base == 'float':
            vals.append(repr(struct.unpack('<f', struct.pack('<I', x))[0]))
        elif 'unsigned' in typ:
            vals.append(str(x))
        else:
            vals.append(str(struct.unpack('<i', struct.pack('<I', x))[0]))
    out.append('DELETE FROM `%s` WHERE `ID` = %d;\nINSERT INTO `%s` (%s) VALUES\n(%s);' % (
        table, v[0], table, ', '.join('`%s`' % c[0] for c in cols), ', '.join(vals)))
assert len(out) == len(ids), (len(out), len(ids))
print('\n'.join(out))
