-- CoA Cultist aura lifecycle source binding; not applied to a database.
DELETE FROM `spell_script_names` WHERE `spell_id` = 800432 AND `ScriptName` = 'aura_ascension_cultist_lifecycle';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES (800432, 'aura_ascension_cultist_lifecycle');
