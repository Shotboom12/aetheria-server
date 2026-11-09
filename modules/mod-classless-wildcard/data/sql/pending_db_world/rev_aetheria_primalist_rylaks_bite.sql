-- Hero-only Rylak's Bite owner/pet charge helper.
-- Source: CoA pending_db_world rev_20260926_65_primalist_rylaks_bite_charge.sql.
-- Preview migration only; inspect live rows before applying.

DELETE FROM `spell_script_names`
WHERE `spell_id` = -706342 AND `ScriptName` = 'spell_ascension_rylaks_bite';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-706342, 'spell_ascension_rylaks_bite');
