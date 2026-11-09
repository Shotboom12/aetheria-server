-- Rockslide (#638): one 15 percent roll per completed Stoneshard, including its own delayed repeats.
DELETE FROM `spell_proc` WHERE `SpellId` = 560154;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
`SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
`DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(560154, 0, 37, 0, 512, 0, 65536, 0, 4, 0, 2, 0, 0, 15, 0, 0);
DELETE FROM `spell_script_names` WHERE `spell_id` = 560154 AND `ScriptName` = 'aura_ascension_rockslide';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (560154, 'aura_ascension_rockslide');
DELETE FROM `spell_script_names` WHERE `spell_id` = 520696
AND `ScriptName` = 'aura_ascension_tectonic_resonance_slow';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520696, 'aura_ascension_tectonic_resonance_slow');
DELETE FROM `spell_bonus_data` WHERE `entry` = 680448;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`)
VALUES (680448, 1, 0, 0.1, 0, 'Primalist - Stoneshard: Nature spell power and attack power');
