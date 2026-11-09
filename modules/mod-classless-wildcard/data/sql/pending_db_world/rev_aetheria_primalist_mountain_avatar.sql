-- Mountain Avatar proc, with Hero/owned-Primalist gates in the paired scripts.
DELETE FROM `spell_proc` WHERE `SpellId` = 707616;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(707616, 0, 37, 4096, 32, 4096, 332048, 1, 2, 3, 2, 2, 0, 5, 0, 0);

DELETE FROM `spell_script_names` WHERE (`spell_id` = 707616 AND `ScriptName` = 'aura_ascension_mountain_avatar') OR (`spell_id` = 680421 AND `ScriptName` = 'aura_ascension_earthen_avatar');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707616, 'aura_ascension_mountain_avatar'),
(680421, 'aura_ascension_earthen_avatar');
