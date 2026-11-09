-- Primal Weapons spell and selected weapon-specific aura scripts.
DELETE FROM `spell_script_names` WHERE `spell_id` = 537218 AND `ScriptName` = 'spell_ascension_primal_weapons';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (537218, 'spell_ascension_primal_weapons');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (801242, 704098) AND `ScriptName` = 'aura_ascension_primal_weapon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801242, 'aura_ascension_primal_weapon'),
(704098, 'aura_ascension_primal_weapon');
