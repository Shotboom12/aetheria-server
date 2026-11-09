-- Exact negative all-ranks CoA spell/script bindings from the pinned upstream SQL state.
-- This core treats spell_id <= 0 as all-ranks: it negates the ID and walks its rank chain.
-- All 15 positive IDs are in the generated CoA catalog and are rank-1 or single-rank spells.
-- Classless participation is restricted to Hero class 10; three non-catalog positive rows remain excluded.

DELETE FROM `spell_script_names`
    WHERE ScriptName = 'aura_ascension_arcane_palm_sigil'
        AND spell_id IN (-805380);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'aura_ascension_damage_palm_sigil'
        AND spell_id IN (-534803);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_bloodmage_bloodfang_bite'
        AND spell_id IN (-800156);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_bloodmage_sanguine_rupture'
        AND spell_id IN (-800774);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_hookshot'
        AND spell_id IN (-800360);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_ranger_assault'
        AND spell_id IN (-803108);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_ranger_skullpiercer'
        AND spell_id IN (-802036);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_reaper_weakened_souls'
        AND spell_id IN (-573316);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_running_instinct'
        AND spell_id IN (-500696);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_witch_doctor_dark_incantation'
        AND spell_id IN (-801669);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_witch_hunter_dark_tonic'
        AND spell_id IN (-680491);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_witch_hunter_flame_grant'
        AND spell_id IN (-802140, -802019, -680537);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_witch_hunter_stake'
        AND spell_id IN (-680537);
DELETE FROM `spell_script_names`
    WHERE ScriptName = 'spell_ascension_witch_hunter_tonic_supply'
        AND spell_id IN (-802279, -680491);
INSERT INTO `spell_script_names`
    (`spell_id`, `ScriptName`)
VALUES
    (-805380, 'aura_ascension_arcane_palm_sigil'),
    (-534803, 'aura_ascension_damage_palm_sigil'),
    (-800156, 'spell_ascension_bloodmage_bloodfang_bite'),
    (-800774, 'spell_ascension_bloodmage_sanguine_rupture'),
    (-800360, 'spell_ascension_hookshot'),
    (-803108, 'spell_ascension_ranger_assault'),
    (-802036, 'spell_ascension_ranger_skullpiercer'),
    (-573316, 'spell_ascension_reaper_weakened_souls'),
    (-500696, 'spell_ascension_running_instinct'),
    (-801669, 'spell_ascension_witch_doctor_dark_incantation'),
    (-680491, 'spell_ascension_witch_hunter_dark_tonic'),
    (-802140, 'spell_ascension_witch_hunter_flame_grant'),
    (-802019, 'spell_ascension_witch_hunter_flame_grant'),
    (-680537, 'spell_ascension_witch_hunter_flame_grant'),
    (-680537, 'spell_ascension_witch_hunter_stake'),
    (-802279, 'spell_ascension_witch_hunter_tonic_supply'),
    (-680491, 'spell_ascension_witch_hunter_tonic_supply');

-- Exact upstream proc data for the all-rank Palm Sigil bindings.
DELETE FROM `spell_proc`
    WHERE `SpellId` IN (-805380, -534803);
INSERT INTO `spell_proc`
    (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
     `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`,
     `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`)
VALUES
    (-805380, 126, 0, 0, 0, 0, 332116, 1, 2, 3, 2, 6, 0, 100, 0, 1),
    (-534803, 0, 0, 0, 0, 0, 69972, 1, 2, 3, 2, 0, 0, 100, 0, 1);
