-- Hero-only Primalist talent bindings. Inspect existing matching rows in the target world DB before applying.
DELETE FROM `spell_script_names` WHERE `spell_id` = 500764 AND `ScriptName` = 'spell_ascension_throat_clamp';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (500764, 'spell_ascension_throat_clamp');

DELETE FROM `spell_script_names` WHERE `spell_id` = 560150 AND `ScriptName` = 'aura_ascension_earthmaker';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (560150, 'aura_ascension_earthmaker');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (504669, 504670, 504671, 504672, 504673, 504674, 504675, 504676, 504684) AND `ScriptName` = 'aura_ascension_primal_shred_critical';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504669, 'aura_ascension_primal_shred_critical'),
(504670, 'aura_ascension_primal_shred_critical'),
(504671, 'aura_ascension_primal_shred_critical'),
(504672, 'aura_ascension_primal_shred_critical'),
(504673, 'aura_ascension_primal_shred_critical'),
(504674, 'aura_ascension_primal_shred_critical'),
(504675, 'aura_ascension_primal_shred_critical'),
(504676, 'aura_ascension_primal_shred_critical'),
(504684, 'aura_ascension_primal_shred_critical');
