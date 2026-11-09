-- Crushing Earth helper aura, runtime gated to Hero characters with the Primalist kit.
DELETE FROM `spell_script_names` WHERE `spell_id` = 300697 AND `ScriptName` = 'aura_ascension_crushing_earth';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (300697, 'aura_ascension_crushing_earth');
