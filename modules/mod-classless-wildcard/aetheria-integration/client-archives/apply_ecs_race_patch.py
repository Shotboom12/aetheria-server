"""Re-applies the Centaur / Slime Giant select-screen edits to a base GlueXML ECS_Schema.lua (a Patch-ZY copy).

Usage: python apply_ecs_race_patch.py <base ECS_Schema.lua> <output ECS_Schema.lua>

The shipped override (ECS_Schema.patched.lua, packed into the AetheriaRacePortraits archive by build_race_portraits.py)
is the Patch-ZY ECS_Schema.lua plus exactly three insertions. When ECS changes upstream, run this on the new file and
rebuild the archive instead of editing a copy by hand. It fails loudly if an anchor is missing or no longer unique.
gen_swap_races.py imports patched_text() so the EsteriaSwap wheel table is generated from the same patched schema.
"""
import sys

ENTRIES = '''    {"CENTAURHORDE",{name="Centaur",faction=2,artKey="CentaurHorde"}},
    {"SLIMEGIANTALLIANCE",{name="Slime Giant",faction=1,artKey="SlimeGiantAlliance"}},
    {"SLIMEGIANTHORDE",{name="Slime Giant",faction=2,artKey="SlimeGiantHorde"}},
'''
DISPLAY = '''    ["CENTAUR"] = {
        {id=74, name="Centaur", faction=2, artKey="CentaurHorde", fileKey="CENTAURHORDE"},
    },
    ["SLIMEGIANT"] = {
        {id=75, name="Slime Giant", faction=1, artKey="SlimeGiantAlliance", fileKey="SLIMEGIANTALLIANCE"},
        {id=76, name="Slime Giant", faction=2, artKey="SlimeGiantHorde", fileKey="SLIMEGIANTHORDE"},
    },
'''
SHORTCUT = '''    end
    -- Centaur and Slime Giant share one display name per faction pair (Slime Giant) or have a single entry;
    -- when the file token names the exact variant, trust it over the display-name default.
    if ( byRaceFile and (byRaceFile.artKey == "SlimeGiantAlliance" or byRaceFile.artKey == "SlimeGiantHorde"
        or byRaceFile.artKey == "CentaurHorde") ) then
        byRaceFile.id = raceID;
        return byRaceFile;
'''
CRLF = chr(13) + chr(10)
LF = chr(10)


def insert_after(text, anchor, block, label):
    if text.count(anchor) != 1:
        sys.exit('anchor for %s found %d times, expected 1: %r' % (label, text.count(anchor), anchor))
    at = text.index(anchor) + len(anchor)
    return text[:at] + block + text[at:]


def patched_text(raw):
    """The patched ECS_Schema.lua text (LF line endings) for a base file's text."""
    text = raw.replace(CRLF, LF)
    text = insert_after(text, 'S.RaceByModelKey = {' + LF, ENTRIES, 'RaceByModelKey')
    text = insert_after(text, 'local DISPLAY_RACES = {' + LF, DISPLAY, 'DISPLAY_RACES')
    anchor = 'if ( HasFactionQualifiedIllidari(byRaceHint, raceHint) ) then' + LF + '        return byRaceHint;' + LF
    return insert_after(text, anchor, SHORTCUT, 'GetRace shortcut')


def main(src, dst):
    raw = open(src, encoding='utf-8', errors='replace', newline='').read()
    text = patched_text(raw)
    if CRLF in raw:
        text = text.replace(LF, CRLF)
    open(dst, 'w', encoding='utf-8', newline='').write(text)
    print('wrote', dst)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
