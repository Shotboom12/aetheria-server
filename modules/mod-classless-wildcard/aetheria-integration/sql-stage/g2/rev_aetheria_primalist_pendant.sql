-- Earthmother's Pendant proc, gated in source to the Hero's own Primalist aura.
DELETE FROM `spell_proc` WHERE `SpellId` = 504446;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(504446, 0, 0, 0, 0, 0, 332116, 1, 2, 3, 2, 0, 0, 100, 500, 0);

DELETE FROM `spell_script_names` WHERE `spell_id` = 504446 AND `ScriptName` = 'aura_ascension_earthmother_pendant';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (504446, 'aura_ascension_earthmother_pendant');
