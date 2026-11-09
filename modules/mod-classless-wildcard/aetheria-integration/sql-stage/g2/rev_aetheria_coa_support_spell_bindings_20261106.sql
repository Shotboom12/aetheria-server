-- Exact CoA support spell bindings from pinned upstream updates at
-- Conquest-of-AzerothCore/azerothcore-wotlk-coa commit 2f823e28dff86e3c1affb435b3a7f88607e9f01e.
-- Spell.dbc rows 301005 and 572904 are now included by the paired catalog/client manifest.
-- Sun Cleric and Guardian script owners require Hero class 10 and the matching CoA kit.

DELETE FROM `spell_script_names`
    WHERE `spell_id` = 301005 AND `ScriptName` = 'aura_ascension_sun_cleric_event';
DELETE FROM `spell_script_names`
    WHERE `spell_id` = 301005 AND `ScriptName` = 'aura_ascension_sun_cleric_lifecycle';
DELETE FROM `spell_script_names`
    WHERE `spell_id` = 572904 AND `ScriptName` = 'spell_ascension_guardian_ability';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
    (301005, 'aura_ascension_sun_cleric_event'),
    (301005, 'aura_ascension_sun_cleric_lifecycle'),
    (572904, 'spell_ascension_guardian_ability');

-- Upstream Sun Cleric proc row; omitted columns use the core table defaults.
DELETE FROM `spell_proc` WHERE `SpellId` = 301005;
INSERT INTO `spell_proc`
    (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
     `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`,
     `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`)
VALUES
    (301005, 0, 0, 0, 0, 0, 1048575, 7, 2, 32767, 2, 0, 0, 100, 0, 0);