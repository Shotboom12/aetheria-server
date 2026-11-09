-- Focused Hero-only Primalist Secondary hooks and required Wrath spell data.
-- Inspect matching rows in the target world DB before applying.
START TRANSACTION;

DELETE FROM `spell_script_names` WHERE (`spell_id` = 807466 AND `ScriptName` = 'aura_ascension_natures_blessing') OR (`spell_id` = 803973 AND `ScriptName` = 'aura_ascension_hammer_of_life');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807466, 'aura_ascension_natures_blessing'),
(803973, 'aura_ascension_hammer_of_life');

DELETE FROM `spell_script_names` WHERE `spell_id` = 805919 AND `ScriptName` = 'spell_ascension_gaze_of_theradras';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (805919, 'spell_ascension_gaze_of_theradras');

DELETE FROM `spell_script_names` WHERE `spell_id` = -805462 AND `ScriptName` = 'spell_ascension_seismic_wave';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-805462, 'spell_ascension_seismic_wave');

DELETE FROM `spell_proc` WHERE `SpellId` IN (807466, 572908);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(807466, 0, 37, 0, 256, 0, 16384, 2, 2, 0, 0, 0, 0, 100, 0, 0),
(572908, 0, 0, 0, 0, 0, 68, 1, 2, 12287, 0, 0, 0, 100, 0, 1);

DELETE FROM `spell_bonus_data` WHERE `entry` IN (805462, 807561);
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(805462, 0.3, 0, 0.28, 0, 'Seismic Wave: heal gets another 0.3 SP from its script'),
(807561, 0, 0, 0, 0, 'Primalist - Natures Blessing resolved healing payload');

-- Totem Warrior repeats its configured percentage of qualifying Wildclaw hits while Boon of the Bear is active.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_totem_warrior' AND `spell_id` IN (-800140, 504240);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-800140, 'spell_ascension_totem_warrior'),
(504240, 'spell_ascension_totem_warrior');

-- Volcanic Blast copies a percentage of qualifying critical damage; Hero-only checks live in the AuraScript.
-- CoA leaves the secondary rank at Chance=0 to use its Spell.dbc ProcChance (90%); preserve that loader fallback.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_volcanic_blast';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680451, 'aura_ascension_volcanic_blast'),
(681480, 'aura_ascension_volcanic_blast');

DELETE FROM `spell_proc` WHERE `SpellId` IN (680451, 681480);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
`SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
`DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(680451, 9, 0, 0, 0, 0, 332116, 1, 2, 2, 2, 0, 0, 100, 0, 0),
(681480, 9, 0, 0, 0, 0, 332116, 1, 2, 2, 2, 0, 0, 0, 0, 0);

DELETE FROM `spell_bonus_data` WHERE `entry` = 681353;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`)
VALUES (681353, 0, 0, 0, 0, 'CoA Volcanic Blast: copied resolved critical damage');

COMMIT;
