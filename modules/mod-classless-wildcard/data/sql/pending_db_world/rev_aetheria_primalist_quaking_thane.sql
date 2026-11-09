-- Quaking Thane: reward qualifying Hero Primalist casts and calculate Thane's Rage dynamically.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-803974, -681130) AND `ScriptName` = 'spell_ascension_quaking_thane';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-803974, 'spell_ascension_quaking_thane'),
(-681130, 'spell_ascension_quaking_thane');

DELETE FROM `spell_script_names` WHERE `spell_id` = 804124 AND `ScriptName` = 'aura_ascension_thanes_rage';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (804124, 'aura_ascension_thanes_rage');
