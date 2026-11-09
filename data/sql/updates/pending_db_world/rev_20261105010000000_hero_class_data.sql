-- Hero class foundation. Class 10 is unused in the paired Wrath class tables and fits MAX_CLASSES.
-- Player stats and starting positions use existing Paladin-compatible baselines; classless abilities
-- and initial action-bar contents are handled by the later Hero/Classless module port.

-- The chrclasses_dbc row for class 10 is deliberately NOT written here: the Hero class comes from the server ChrClasses.dbc overlay
-- (aetheria-integration/server-dbc/hero-charged), exactly as on the verified test realm. (The original insert also failed on PetNameToken.)

DELETE FROM `player_class_stats` WHERE `Class` = 10;
INSERT INTO `player_class_stats` (`Class`, `Level`, `Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`, `BaseHP`, `BaseMana`)
SELECT 10, `Level`, `Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`, `BaseHP`, `BaseMana`
FROM `player_class_stats` WHERE `Class` = 2;

DELETE FROM `playercreateinfo` WHERE `class` = 10;
INSERT INTO `playercreateinfo` (`race`, `class`, `map`, `zone`, `position_x`, `position_y`, `position_z`, `orientation`)
SELECT `p`.`race`, 10, `p`.`map`, `p`.`zone`, `p`.`position_x`, `p`.`position_y`, `p`.`position_z`, `p`.`orientation`
FROM `playercreateinfo` AS `p`
WHERE `p`.`class` = (
    SELECT `candidate`.`class`
    FROM `playercreateinfo` AS `candidate`
    WHERE `candidate`.`race` = `p`.`race` AND `candidate`.`class` <> 10
    ORDER BY (`candidate`.`class` = 6), `candidate`.`class`
    LIMIT 1
);

-- These 12340 game tables reserve class-10 slots, but the current values are placeholders.
-- Use the existing Paladin rows for the initial Hero chassis until classless stat rules are ported.
DELETE FROM `gtoctclasscombatratingscalar_dbc` WHERE `ID` BETWEEN 289 AND 320;
INSERT INTO `gtoctclasscombatratingscalar_dbc` (`ID`, `Data`)
SELECT `ID` + 256, `Data` FROM `gtoctclasscombatratingscalar_dbc` WHERE `ID` BETWEEN 33 AND 64;
UPDATE `gtoctclasscombatratingscalar_dbc` SET `Data` = 1.25 WHERE `ID` = 313;

DELETE FROM `gtchancetomeleecritbase_dbc` WHERE `ID` = 9;
INSERT INTO `gtchancetomeleecritbase_dbc` (`ID`, `Data`)
SELECT 9, `Data` FROM `gtchancetomeleecritbase_dbc` WHERE `ID` = 1;

DELETE FROM `gtchancetospellcritbase_dbc` WHERE `ID` = 9;
INSERT INTO `gtchancetospellcritbase_dbc` (`ID`, `Data`)
SELECT 9, `Data` FROM `gtchancetospellcritbase_dbc` WHERE `ID` = 1;

DELETE FROM `gtchancetomeleecrit_dbc` WHERE `ID` BETWEEN 900 AND 999;
INSERT INTO `gtchancetomeleecrit_dbc` (`ID`, `Data`)
SELECT `ID` + 800, `Data` FROM `gtchancetomeleecrit_dbc` WHERE `ID` BETWEEN 100 AND 199;

DELETE FROM `gtchancetospellcrit_dbc` WHERE `ID` BETWEEN 900 AND 999;
INSERT INTO `gtchancetospellcrit_dbc` (`ID`, `Data`)
SELECT `ID` + 800, `Data` FROM `gtchancetospellcrit_dbc` WHERE `ID` BETWEEN 100 AND 199;

DELETE FROM `gtregenhpperspt_dbc` WHERE `ID` BETWEEN 900 AND 999;
INSERT INTO `gtregenhpperspt_dbc` (`ID`, `Data`)
SELECT `ID` + 800, `Data` FROM `gtregenhpperspt_dbc` WHERE `ID` BETWEEN 100 AND 199;

DELETE FROM `gtregenmpperspt_dbc` WHERE `ID` BETWEEN 900 AND 999;
INSERT INTO `gtregenmpperspt_dbc` (`ID`, `Data`)
SELECT `ID` + 800, `Data` FROM `gtregenmpperspt_dbc` WHERE `ID` BETWEEN 100 AND 199;
UPDATE `gtregenmpperspt_dbc` SET `Data` = CASE `ID`
    WHEN 900 THEN 0.020979000255465508
    WHEN 901 THEN 0.020515000447630882
    WHEN 902 THEN 0.020078999921679497
    WHEN 903 THEN 0.019516000524163246
    WHEN 904 THEN 0.01899700053036213
    WHEN 905 THEN 0.01864599995315075
    WHEN 906 THEN 0.018314000219106674
    WHEN 907 THEN 0.017997000366449356
    WHEN 908 THEN 0.017583999782800674
    WHEN 909 THEN 0.017196999862790108
    WHEN 910 THEN 0.016550999134778976
    WHEN 911 THEN 0.01572900079190731
    WHEN 912 THEN 0.01522899977862835
    WHEN 913 THEN 0.014580000191926956
END WHERE `ID` BETWEEN 900 AND 913;

DELETE FROM `gtoctregenhp_dbc` WHERE `ID` BETWEEN 900 AND 999;
INSERT INTO `gtoctregenhp_dbc` (`ID`, `Data`)
SELECT `ID` + 800, `Data` FROM `gtoctregenhp_dbc` WHERE `ID` BETWEEN 100 AND 199;
