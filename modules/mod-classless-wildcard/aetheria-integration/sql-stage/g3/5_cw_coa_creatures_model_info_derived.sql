-- creature_model_info rows derived from the Conquest of Azeroth client for creature displays that neither the stock
-- tables nor the CoA pending migrations cover. The CoA client's CreatureModelData collision width/height are exactly the
-- bounding radius / combat reach the CoA SQL publishes (checked against display 49116: 0.611111 / 2.03128), scaled by the
-- display and model scale. Models with no collision data (spell-effect models) and displays absent from every client get a
-- neutral 0.5 / 1.5. INSERT IGNORE keeps rows that already exist.
-- Rollback for a given id: DELETE FROM `creature_model_info` WHERE `DisplayID` = <id>;

START TRANSACTION;
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (33924, 0.6111, 2.031, 2, 0, NULL); -- from CoA client StandardGargoyle.mdx
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (35355, 0.672223, 2.234408, 2, 0, NULL); -- from CoA client MASTIFF.M2
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (40004, 0.6111, 2.031, 2, 0, NULL); -- from CoA client TuskarrMale.mdx
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (40388, 0.916666, 3.04692, 2, 0, NULL); -- from CoA client worserobot_nobelt_COA.m2
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (94943, 0.458334, 1.52346, 2, 0, NULL); -- from CoA client MECHANICALBEARCUB.M2
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (98192, 2.03128, 1.0, 2, 0, NULL); -- from CoA client abominationsmall.mdx
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (100188, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (110049, 2.03128, 1.0, 2, 0, NULL); -- from CoA client custom_rocketshredder9001.mdx
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (128263, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (136859, 2.03128, 1.0, 2, 0, NULL); -- from CoA client maldraxxusskeleton.mdx
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (310061, 0.152775, 0.50775, 2, 0, NULL); -- from CoA client IcecrownFleshBeast.mdx
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (401712, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (401941, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (405700, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (406700, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (407073, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (407282, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (427391, 0.5, 1.5, 2, 0, NULL); -- neutral default
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (561413, 0.5, 1.5, 2, 0, NULL); -- neutral default
COMMIT;
