-- Spiritual Frenzy player and current-pet proc definitions, gated to Hero Primalists.
DELETE FROM `spell_proc` WHERE `SpellId` IN (707367, 707369);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(707367, 0, 37, 0, 0, 32, 69904, 7, 1, 0, 0, 0, 0, 100, 0, 0),
(707369, 0, 0, 0, 0, 0, 4, 1, 2, 3, 0, 0, 0, 100, 0, 0);

DELETE FROM `spell_script_names` WHERE (`spell_id` = 707367 AND `ScriptName` = 'aura_ascension_spiritual_frenzy') OR (`spell_id` = 707369 AND `ScriptName` = 'aura_ascension_spiritual_frenzy_pet');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707367, 'aura_ascension_spiritual_frenzy'),
(707369, 'aura_ascension_spiritual_frenzy_pet');
