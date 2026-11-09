-- Rock Barrier (#5037): stacks decrement on damage and launch the authored Geode.
DELETE FROM `spell_proc` WHERE `SpellId` = 503630;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
`SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
`DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(503630, 0, 0, 0, 0, 0, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `spell_proc` WHERE `SpellId` = 680412;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
`SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
`DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(680412, 0, 37, 4096, 32, 0, 65536, 1, 2, 3, 2, 1, 0, 15, 0, 0);
DELETE FROM `spell_script_names` WHERE `spell_id` IN (503630, 560298)
AND `ScriptName` = 'aura_ascension_earthmother_protection_link';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503630, 'aura_ascension_earthmother_protection_link'),
(560298, 'aura_ascension_earthmother_protection_link');
DELETE FROM `spell_script_names` WHERE `spell_id` = 680412
AND `ScriptName` = 'aura_ascension_fury_of_earthmother';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680412, 'aura_ascension_fury_of_earthmother');
DELETE FROM `spell_script_names` WHERE `spell_id` = 520134
AND `ScriptName` = 'spell_ascension_fury_of_earthmother_charge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520134, 'spell_ascension_fury_of_earthmother_charge');
