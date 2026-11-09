-- Aetheria bindings for reviewed CoA SpellScripts already present in the selected Hero port.
-- Source rows were matched to the pinned CoA pending-world SQL; selected scripts are Hero/owned-kit gated.
-- Staged only. Do not treat as applied or gameplay accepted.

-- Decoder's aura proc script replaces the unsupported aura:354 default action and prevents its helper cast.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_decoder' AND `spell_id` IN (706523);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706523, 'aura_ascension_runemaster_decoder');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_blessed_by_earth' AND `spell_id` IN (300695);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300695, 'aura_ascension_blessed_by_earth');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_earths_guidance' AND `spell_id` IN (706138);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706138, 'aura_ascension_earths_guidance');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_eternally_chosen' AND `spell_id` IN (802888);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802888, 'aura_ascension_eternally_chosen');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_mountain_threshold' AND `spell_id` IN (806068);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806068, 'aura_ascension_mountain_threshold');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_natural_efficiency' AND `spell_id` IN (706167);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706167, 'aura_ascension_natural_efficiency');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_power_hammer' AND `spell_id` IN (303014);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(303014, 'aura_ascension_power_hammer');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_primalist_cataclysm' AND `spell_id` IN (680444);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680444, 'aura_ascension_primalist_cataclysm');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_primalist_periodic_damage' AND `spell_id` IN (574323);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(574323, 'aura_ascension_primalist_periodic_damage');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_rexxar_might' AND `spell_id` IN (806559);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806559, 'aura_ascension_rexxar_might');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_rexxar_ready' AND `spell_id` IN (806561);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806561, 'aura_ascension_rexxar_ready');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_son_of_ursoc' AND `spell_id` IN (806549);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806549, 'aura_ascension_son_of_ursoc');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_totemic_echoes' AND `spell_id` IN (547213);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(547213, 'aura_ascension_totemic_echoes');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_barbarian_ability' AND `spell_id` IN (500913, 500996, 500997, 500998, 500999, 501000, 501001, 501002);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500913, 'spell_ascension_barbarian_ability'),
(500996, 'spell_ascension_barbarian_ability'),
(500997, 'spell_ascension_barbarian_ability'),
(500998, 'spell_ascension_barbarian_ability'),
(500999, 'spell_ascension_barbarian_ability'),
(501000, 'spell_ascension_barbarian_ability'),
(501001, 'spell_ascension_barbarian_ability'),
(501002, 'spell_ascension_barbarian_ability');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_empowered' AND `spell_id` IN (520314, 520836, 520838, 572895, 572898, 801952);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520314, 'spell_ascension_bloodmage_empowered'),
(520836, 'spell_ascension_bloodmage_empowered'),
(520838, 'spell_ascension_bloodmage_empowered'),
(572895, 'spell_ascension_bloodmage_empowered'),
(572898, 'spell_ascension_bloodmage_empowered'),
(801952, 'spell_ascension_bloodmage_empowered');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_transfusion' AND `spell_id` IN (705734);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705734, 'spell_ascension_bloodmage_transfusion');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_earthmother_missing_health' AND `spell_id` IN (301307);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(301307, 'spell_ascension_earthmother_missing_health');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_lesser_spirit_charge' AND `spell_id` IN (572830);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(572830, 'spell_ascension_lesser_spirit_charge');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_mountain_fury_pull' AND `spell_id` IN (806186);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806186, 'spell_ascension_mountain_fury_pull');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_necromancer_summon' AND `spell_id` IN (500331);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500331, 'spell_ascension_necromancer_summon');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_primal_totem' AND `spell_id` IN (504229);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504229, 'spell_ascension_primal_totem');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_primalist_therazane_update' AND `spell_id` IN (680439);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680439, 'spell_ascension_primalist_therazane_update');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_primordial_spirit' AND `spell_id` IN (572826, 572853);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(572826, 'spell_ascension_primordial_spirit'),
(572853, 'spell_ascension_primordial_spirit');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_running_instinct' AND `spell_id` IN (500696);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500696, 'spell_ascension_running_instinct');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_running_instinct_heal' AND `spell_id` IN (301203);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(301203, 'spell_ascension_running_instinct_heal');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_verdant_chase' AND `spell_id` IN (560306);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560306, 'spell_ascension_verdant_chase');
