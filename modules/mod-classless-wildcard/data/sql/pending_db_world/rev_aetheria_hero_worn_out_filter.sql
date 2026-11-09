-- Hero Classless Worn Out target filter for Frenzy (source: CoA Ranger Talents).
START TRANSACTION;
DELETE FROM `spell_script_names` WHERE `spell_id` = 520492 AND `ScriptName` = 'spell_ascension_ranger_frenzy_hero';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES (520492, 'spell_ascension_ranger_frenzy_hero');
COMMIT;
