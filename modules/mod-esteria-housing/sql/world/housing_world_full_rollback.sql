-- Complete rollback of the mod-esteria-housing WORLD database changes (housing_world, commerce, adventure, collections and
-- household SQL). Generated 2026-11-09 from those files' own DELETE ranges (the keys each file owns before it inserts) and
-- CREATE TABLE list. The upstream housing_world_rollback.sql / housing_commerce_world_rollback.sql leave the adventure,
-- collections and household rows, the map rows and housing_portal_destination behind; this script does not.
-- Verified 2026-11-09 on a scratch copy of the live backup: after the five housing files + this script all 353 pre-existing world tables have
-- the same CHECKSUM TABLE as before, and no housing_* table is left. The shop creature pool is 9510000-9513999 (Aetheria moved it off
-- 9501000-9504999, where the retail druid form creatures and the Mograine shade live).
-- It does NOT restore map 35 / instance_template 35 overrides because the live database had none (the apply deletes them if present).
-- Run with EsteriaHousing.Enable = 0 and the server stopped. Housing player data lives in the characters DB (housing_characters_rollback.sql).
START TRANSACTION;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 9500000 AND 9500799;
DELETE FROM `gameobjectdisplayinfo_dbc` WHERE `ID` BETWEEN 60000 AND 60799;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 9501000 AND 9501999;
DELETE FROM `gameobjectdisplayinfo_dbc` WHERE `ID` BETWEEN 61000 AND 61999;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 9503000 AND 9505999;
DELETE FROM `gameobjectdisplayinfo_dbc` WHERE `ID` BETWEEN 63000 AND 65999;
DELETE FROM `creature_template` WHERE `entry` = 9500100;
DELETE FROM `creature_template_model` WHERE `CreatureID` = 9500100;
DELETE FROM `instance_template` WHERE `map` = 35;
DELETE FROM `map_dbc` WHERE `ID` = 35;
DELETE FROM `map_dbc` WHERE `ID` IN (2783, 2735, 2736);
DELETE FROM `areatable_dbc` WHERE `ID` IN (16105, 16300, 15524);
DELETE FROM `instance_template` WHERE `map` IN (2783, 2735, 2736);
DELETE FROM `mapdifficulty_dbc` WHERE `ID` IN (2783, 2735, 2736);
DELETE FROM `gameobject` WHERE `id` = 9500199;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 9502000 AND 9502999;
DELETE FROM `gameobjectdisplayinfo_dbc` WHERE `ID` BETWEEN 62000 AND 62999;
DELETE FROM `creature` WHERE `guid` IN (9500100, 9500101);
DELETE FROM `creature_template_model` WHERE `CreatureID` BETWEEN 9510000 AND 9513999;
DELETE FROM `creature_template` WHERE `entry` BETWEEN 9510000 AND 9513999;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 9506000 AND 9506006;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 9506010 AND 9506059;
DELETE FROM `creature_template_model` WHERE `CreatureID` BETWEEN 9505000 AND 9505009;
DELETE FROM `creature_template` WHERE `entry` BETWEEN 9505000 AND 9505009;
DELETE FROM `creature_model_info` WHERE `DisplayID` BETWEEN 977500 AND 977509;
DELETE FROM `creaturedisplayinfo_dbc` WHERE `ID` BETWEEN 977500 AND 977509;
DELETE FROM `creaturemodeldata_dbc` WHERE `ID` BETWEEN 2290300 AND 2290309;
DELETE FROM `spell_dbc` WHERE `ID` IN (9500100, 9500101);
DELETE FROM `spell_script_names` WHERE `spell_id` IN (9500100, 9500101);
DELETE FROM `creature_template_model` WHERE `CreatureID` BETWEEN 9507100 AND 9509999;
DELETE FROM `creature_template` WHERE `entry` BETWEEN 9507100 AND 9509999;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 9506060 AND 9506099;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 9506100 AND 9506219;
DELETE FROM `creature_template_model` WHERE `CreatureID` = 9505020;
DELETE FROM `creature_template` WHERE `entry` = 9505020;
DELETE FROM `item_template` WHERE `entry` = 9500200;
DELETE FROM `spell_dbc` WHERE `ID` = 9500102;
DELETE FROM `spell_script_names` WHERE `spell_id` = 9500102;
COMMIT;

-- Housing tables created in the world database (DDL commits implicitly).
DROP TABLE IF EXISTS `housing_portal_destination`;
DROP TABLE IF EXISTS `housing_exterior_fixture_hook`;
DROP TABLE IF EXISTS `housing_exterior_fixture`;
DROP TABLE IF EXISTS `housing_exterior_style`;
DROP TABLE IF EXISTS `housing_exterior_piece`;
DROP TABLE IF EXISTS `housing_plot`;
DROP TABLE IF EXISTS `housing_room_theme`;
DROP TABLE IF EXISTS `housing_room_stairs`;
DROP TABLE IF EXISTS `housing_room_kit_theme`;
DROP TABLE IF EXISTS `housing_room_kit`;
DROP TABLE IF EXISTS `housing_room_kind`;
DROP TABLE IF EXISTS `housing_room_template`;
DROP TABLE IF EXISTS `housing_decor_catalog`;
