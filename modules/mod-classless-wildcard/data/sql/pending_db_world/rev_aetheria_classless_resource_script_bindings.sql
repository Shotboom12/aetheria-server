-- Preserve stock class behavior while enabling Hero resource and rune replacements.
-- Replace only the exact core script bindings used by these registered ClasslessPlayerScript AuraScripts.

DELETE FROM `spell_script_names` WHERE `spell_id` = 22842 AND `ScriptName` IN ('spell_dru_frenzied_regeneration', 'spell_cw_frenzied_regeneration');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (22842, 'spell_cw_frenzied_regeneration');

DELETE FROM `spell_script_names` WHERE `spell_id` = 20186 AND `ScriptName` IN ('spell_pal_judgement_of_wisdom_mana', 'spell_cw_judgement_of_wisdom');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (20186, 'spell_cw_judgement_of_wisdom');

DELETE FROM `spell_script_names` WHERE `spell_id` = 61013 AND `ScriptName` IN ('spell_pet_hit_expertise_scalling', 'spell_cw_pet_hit_expertise_scaling');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (61013, 'spell_cw_pet_hit_expertise_scaling');

DELETE FROM `spell_script_names` WHERE `spell_id` = 61017 AND `ScriptName` IN ('spell_pet_hit_expertise_scalling', 'spell_cw_pet_hit_expertise_scaling');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (61017, 'spell_cw_pet_hit_expertise_scaling');

DELETE FROM `spell_script_names` WHERE `spell_id` = -49182 AND `ScriptName` IN ('spell_dk_blade_barrier', 'spell_cw_dk_blade_barrier');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-49182, 'spell_cw_dk_blade_barrier');

DELETE FROM `spell_script_names` WHERE `spell_id` = -49208 AND `ScriptName` IN ('spell_dk_death_rune', 'spell_cw_dk_death_rune');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-49208, 'spell_cw_dk_death_rune');

DELETE FROM `spell_script_names` WHERE `spell_id` = -49467 AND `ScriptName` IN ('spell_dk_death_rune', 'spell_cw_dk_death_rune');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-49467, 'spell_cw_dk_death_rune');

DELETE FROM `spell_script_names` WHERE `spell_id` = -54639 AND `ScriptName` IN ('spell_dk_death_rune', 'spell_cw_dk_death_rune');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-54639, 'spell_cw_dk_death_rune');
