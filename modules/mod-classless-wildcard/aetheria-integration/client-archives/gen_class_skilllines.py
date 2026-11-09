import sys, os, struct

sys.path.insert(0, r'D:\AcoreRaceFix\HeroBuild\server\modules\mod-classless-wildcard\client-patch')
from lib import clientfs

BS = chr(92)
HERE = os.path.dirname(os.path.abspath(__file__))
data = r'E:\Aetheria-Staging\clean-client-20261023\Data'
found = []
for folder in (data, os.path.join(data, 'enUS')):
    if os.path.isdir(folder):
        found += [os.path.join(folder, n) for n in os.listdir(folder) if n.lower().endswith('.mpq')
                  and 'classtabs' not in n.lower()]
found.sort(key=lambda p: os.path.basename(p).lower())
f = clientfs.ClientFiles(data, 'enUS')
f.chain = list(reversed(found))
raw, _ = f.find('DBFilesClient' + BS + 'Spell.dbc')
_, n, fc, rs, ss = struct.unpack('<4sIIII', raw[:20])
icon = {}
for i in range(n):
    v = struct.unpack('<%dI' % fc, raw[20 + i * rs:20 + (i + 1) * rs])
    icon[v[0]] = v[133]

rows = [l.rstrip('\n').split('\t') for l in open(os.path.join(HERE, 'tabs', 'classes.tsv'), encoding='utf8') if l.strip()][1:]
out = ["-- Class spellbook tab skill lines (2000 + CoA class id); the client rows are in AetheriaClassTabs.MPQ",
       "DROP TEMPORARY TABLE IF EXISTS tmp_sl;",
       "CREATE TEMPORARY TABLE tmp_sl SELECT * FROM skillline_dbc WHERE ID = 990;"]
for c, name, ic in rows:
    c = int(c)
    out.append("UPDATE tmp_sl SET ID=%d, DisplayName_Lang_enUS='%s', SpellIconID=%d;" % (2000 + c, name.replace("'", "''"), icon[int(ic)]))
    out.append("DELETE FROM skillline_dbc WHERE ID=%d;" % (2000 + c))
    out.append("INSERT INTO skillline_dbc SELECT * FROM tmp_sl;")
out.append("DROP TEMPORARY TABLE tmp_sl;")
open(os.path.join(HERE, 'class_tab_skilllines.sql'), 'w').write('\n'.join(out) + '\n')
print(len(rows), 'lines')
