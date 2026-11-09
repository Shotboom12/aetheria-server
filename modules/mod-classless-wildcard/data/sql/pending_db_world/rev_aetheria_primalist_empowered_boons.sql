-- Empowered Boons proc and helper scripts, gated at runtime to Hero Primalists.
DELETE FROM `spell_proc` WHERE `SpellId` = 706340;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(706340, 0, 37, 0, 0, 16, 69904, 1, 1, 0, 2, 0, 0, 100, 0, 0);

DELETE FROM `spell_script_names` WHERE (`spell_id` = 706340 AND `ScriptName` = 'aura_ascension_empowered_boons') OR (`spell_id` = 523526 AND `ScriptName` = 'spell_ascension_empowered_hawk') OR (`spell_id` = 523527 AND `ScriptName` = 'spell_ascension_empowered_wolf');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706340, 'aura_ascension_empowered_boons'),
(523526, 'spell_ascension_empowered_hawk'),
(523527, 'spell_ascension_empowered_wolf');
