# Client archive build scripts (2026-11-08)
Each script builds one patch archive from the client's own DBC/Lua data and writes it next to the script. The scripts still hard-code the test client path (E:\Aetheria-Staging\clean-client-20261023\Data) and the HeroBuild lib path; adjust before running elsewhere. They must be re-run if the base Spell, SkillLine or ChrRaces data is regenerated.
- build_race_portraits.py (+ ECS_Schema.patched.lua): Centaur/Slime Giant select-screen and create-screen portraits and the patched ECS_Schema.lua. Name: Patch-<43 z>-AetheriaRacePortraits.MPQ.
- build_melee_anim.py: weapon-swing visuals and the ability flag for 45 CoA melee abilities (Spell.dbc field 131/attributes, SpellVisual, SpellVisualKit). Name: Patch-<44 z>-AetheriaMeleeAnim.MPQ.
- build_class_tabs.py (+ tabs/*.tsv, dumped from cw_coa_* and spell_ranks; gen_class_skilllines.py makes the matching server SQL): per-class spellbook sections. Name: Patch-<45 z>-AetheriaClassTabs.MPQ. Load order is by base name, so the z-count keeps each archive after the ones whose data it edits.
- gen_client_rows.py: client DBC rows to server *_dbc SQL. verify_race_portraits.py: readback check.
