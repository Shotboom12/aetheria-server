-- creature_model_info rows carried by the Conquest of Azeroth pending migrations (coa-core-input), for displays the
-- worldserver reported as "No model data exist for CreatureDisplayID". INSERT IGNORE: rows already present are kept.
-- Rollback for a given id: DELETE FROM `creature_model_info` WHERE `DisplayID` = <id>;

START TRANSACTION;
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (46087, 0.6111119985580444, 2.031280040740967, 2, 0, NULL); -- rev_20260831_00_local_collectible_creatures.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (49116, 0.611111, 2.03128, 2, 0, NULL); -- rev_20260925_40_venomancer_fungarian_model.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (49195, 0.6111109852790833, 2.031280040740967, 2, 0, NULL); -- rev_20260831_00_local_collectible_creatures.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (64748, 0.6093840364370351, 0.30000001192092896, 2, 0, NULL); -- rev_20260831_00_local_collectible_creatures.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (131041, 0.5, 0, 2, 0, NULL); -- rev_20260914_06_runemaster_travel.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (135809, 0.5, 0, 2, 0, NULL); -- rev_20260914_07_wind_gate.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (137539, 0.5, 0, 2, 0, NULL); -- rev_20260914_11_ranger_red_flowers.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (173031, 0.8091, 2.325, 0, 0, NULL); -- rev_20260926_34_honored_ancestor.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (236827, 0.389, 1.5, 2, 0, NULL); -- rev_1789365018824773600.sql
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (274803, 0.6111109852790833, 2.031280040740967, 2, 0, NULL); -- rev_20260831_00_local_collectible_creatures.sql
COMMIT;
