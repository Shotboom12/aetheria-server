-- Hero-only Primalist Lithic Lance script bindings; inspect matching target world rows before applying.
DELETE FROM `spell_script_names` WHERE `spell_id` = 706159 AND `ScriptName` = 'aura_ascension_lithic_lance_talent';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (706159, 'aura_ascension_lithic_lance_talent');

DELETE FROM `spell_script_names` WHERE `spell_id` = 807048 AND `ScriptName` = 'aura_ascension_lithic_lance_ready';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (807048, 'aura_ascension_lithic_lance_ready');

DELETE FROM `spell_script_names` WHERE `spell_id` = 681251 AND `ScriptName` = 'spell_ascension_lithic_lance';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (681251, 'spell_ascension_lithic_lance');
