import math, os

HERE = os.path.dirname(os.path.abspath(__file__))
ft = {}
for l in open(os.path.join(HERE, 'factiontemplate.tsv'), encoding='utf8').read().splitlines()[1:]:
    a = l.split('\t')
    ft[int(a[0])] = int(a[1])
rows = [l.split('\t') for l in open(os.path.join(HERE, 'class_trainers.tsv'), encoding='utf8').read().splitlines()[1:]]
pts = [dict(map=int(r[0]), name=r[1], sub=r[2], fac=int(r[3]), x=float(r[4]), y=float(r[5]), z=float(r[6]), o=float(r[7]))
       for r in rows]

clusters = []
for p in pts:
    for c in clusters:
        if c['map'] == p['map'] and math.hypot(c['cx'] - p['x'], c['cy'] - p['y']) < 90:
            c['m'].append(p)
            n = len(c['m'])
            c['cx'] = sum(q['x'] for q in c['m']) / n
            c['cy'] = sum(q['y'] for q in c['m']) / n
            break
    else:
        clusters.append(dict(map=p['map'], cx=p['x'], cy=p['y'], m=[p]))

for c in clusters:
    team = [ft.get(q['fac'], 0) for q in c['m']]
    a = sum(1 for t in team if t & 2)
    h = sum(1 for t in team if t & 4)
    c['team'] = 'A' if a > h else ('H' if h > a else 'N')

accepted = []
for c in sorted((c for c in clusters if len(c['m']) >= 3 and c['team'] != 'N'), key=lambda c: -len(c['m'])):
    if any(a['map'] == c['map'] and a['team'] == c['team'] and math.hypot(a['cx'] - c['cx'], a['cy'] - c['cy']) < 250
           for a in accepted):
        continue
    accepted.append(c)

ENTRY = {'A': 990150, 'H': 990151}
DISPLAYS = {'A': (60083, 60084), 'H': (60085, 60086)}
GUID0 = 5301000
sql = ['-- Hero Trainers: Kyrian (Alliance) and Venthyr (Horde) NPCs that open the Hero Advancement menu, placed beside class trainers.',
       'DELETE FROM `creature` WHERE `guid` BETWEEN %d AND %d;' % (GUID0, GUID0 + 99),
       'DELETE FROM `creature_template_model` WHERE `CreatureID` IN (990150, 990151);',
       'DELETE FROM `creature_template` WHERE `entry` IN (990150, 990151);',
       'DELETE FROM `creature_model_info` WHERE `DisplayID` IN (60083, 60084, 60085, 60086);',
       "INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES",
       "(60083, 0.306, 1.5, 0, 60084, 0), (60084, 0.208, 1.5, 1, 60083, 0), (60085, 0.306, 1.5, 0, 60086, 0), (60086, 0.208, 1.5, 1, 60085, 0);",
       'DROP TEMPORARY TABLE IF EXISTS tmp_t;',
       'CREATE TEMPORARY TABLE tmp_t SELECT * FROM `creature_template` WHERE `entry` = 990100;']
for side, entry in ENTRY.items():
    sql.append("UPDATE tmp_t SET `entry` = %d, `name` = 'Hero Trainer', `subname` = 'Hero Advancement';" % entry)
    sql.append('INSERT INTO `creature_template` SELECT * FROM tmp_t;')
    for idx, disp in enumerate(DISPLAYS[side]):
        sql.append("INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (%d, %d, %d, 1, 1, 12340);" % (entry, idx, disp))
sql.append('DROP TEMPORARY TABLE tmp_t;')
sql.append('DROP TEMPORARY TABLE IF EXISTS tmp_c;')
sql.append('CREATE TEMPORARY TABLE tmp_c SELECT * FROM `creature` WHERE `guid` = 5300690;')

report = []
guid = GUID0
for c in accepted:
    near = min(c['m'], key=lambda q: math.hypot(q['x'] - c['cx'], q['y'] - c['cy']))
    ang = near['o'] + math.pi / 2
    x, y, z = near['x'] + 2.5 * math.cos(ang), near['y'] + 2.5 * math.sin(ang), near['z']
    sql.append("UPDATE tmp_c SET `guid` = %d, `id` = %d, `map` = %d, `position_x` = %.2f, `position_y` = %.2f, `position_z` = %.2f, `orientation` = %.3f;"
               % (guid, ENTRY[c['team']], c['map'], x, y, z, near['o']))
    sql.append('INSERT INTO `creature` SELECT * FROM tmp_c;')
    report.append((guid, c['team'], c['map'], round(x), round(y), len(c['m']), near['name']))
    guid += 1
sql.append('DROP TEMPORARY TABLE tmp_c;')
open(os.path.join(HERE, 'hero_trainers.sql'), 'w', encoding='utf8').write('\n'.join(sql) + '\n')
open(os.path.join(HERE, 'hero_trainers_rollback.sql'), 'w', encoding='utf8').write(
    'DELETE FROM `creature` WHERE `guid` BETWEEN %d AND %d;\n'
    'DELETE FROM `creature_template_model` WHERE `CreatureID` IN (990150, 990151);\n'
    'DELETE FROM `creature_template` WHERE `entry` IN (990150, 990151);\n'
    'DELETE FROM `creature_model_info` WHERE `DisplayID` IN (60083, 60084, 60085, 60086);\n' % (GUID0, GUID0 + 99))
print(len(accepted), 'Hero Trainer spawns')
for r in report:
    print(r)
