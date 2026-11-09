import os, re, sys

# Usage: python gen_swap_races.py [base ECS_Schema.lua (a Patch-ZY copy)] [output Races.lua]
# The base schema is run through ../client-archives/apply_ecs_race_patch.py first, so the swap wheel knows the same
# races (Centaur, Slime Giants) as the select screen the AetheriaRacePortraits archive ships. Regenerating from a
# fresh base therefore cannot drop that patch.
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..', 'client-archives'))
from apply_ecs_race_patch import patched_text

BASE = sys.argv[1] if len(sys.argv) > 1 else r'D:\AcoreRaceFix\HeroBuild\tmp\ECS_Schema_ZY.lua'
OUT = sys.argv[2] if len(sys.argv) > 2 else r'D:\AcoreRaceFix\HeroBuild\client\Addons\EsteriaSwap\Races.lua'
src = patched_text(open(BASE, encoding='utf-8', errors='replace').read())

def block(name):
    start = src.index(name + ' = {')
    end = src.index('\n};', start) + 3
    return src[start:end]

override = block('S.RaceOverride').replace('S.RaceOverride', 'EsteriaSwapRaces.RaceOverride')
bymodel = block('S.RaceByModelKey').replace('S.RaceByModelKey', 'EsteriaSwapRaces.RaceByModelKey')
paths = block('S.PortraitPaths').replace('S.PortraitPaths', 'EsteriaSwapRaces.PortraitPaths')

out = '''-- The character select's race -> portrait tables, copied verbatim from the CURRENT ECS
-- (Interface\\GlueXML\\ECS_Schema.lua in Patch-ZY.mpq plus the Centaur/Slime Giant patch; regenerate with
-- gen_swap_races.py when ECS changes).
-- The glue's code cannot be loaded in the game. Used by EsteriaSwap.lua (EsteriaSwapRaces.Portrait).

EsteriaSwapRaces = {}

''' + override + '\n\n' + bymodel + '\n\n' + paths + '''

-- The portrait file for an art key and sex (0/1), or nil (ECS S.GetPortrait without its question-mark fallback)
function EsteriaSwapRaces.PortraitPath(artKey, sex)
    local pair = EsteriaSwapRaces.PortraitPaths[artKey]
    if pair then
        return pair[sex == 1 and 2 or 1]
    end
end
'''
open(OUT, 'w', encoding='utf-8', newline='\n').write(out)
print(len(out), 'bytes;', out.count('artKey ='), 'artKey refs;', 'KyrianAlliance' in out, '[60]' in out, 'CentaurHorde' in out)
