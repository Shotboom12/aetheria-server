-- Hero-only Spirit Beast taming channel and triggered tame validation.
-- Source: CoA pending_db_world rev_20260907_31_primalist_spirit_beast.sql.
-- Preview migration only; inspect live rows before applying.

DELETE FROM `spell_script_names`
WHERE (`spell_id` = 574301 AND `ScriptName` = 'spell_ascension_primalist_harness')
    OR (`spell_id` = 574304 AND `ScriptName` = 'spell_ascension_primalist_harness_tame');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(574301, 'spell_ascension_primalist_harness'),
(574304, 'spell_ascension_primalist_harness_tame');
