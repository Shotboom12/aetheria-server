-- Ancient of War (#3710): tie the authored movement penalty to the active transformation.
DELETE FROM `spell_script_names` WHERE `spell_id` = 504222 AND `ScriptName` = 'aura_ascension_ancient_war';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (504222, 'aura_ascension_ancient_war');
