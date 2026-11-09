-- creature_model_info rows for the Conquest of Azeroth creature displays.
-- cw_coa_creatures_displays.sql recolours stock displays into new ids (977364+) in creaturedisplayinfo_dbc and points
-- creature_template_model at them, but creature_model_info (bounding radius / combat reach) is keyed by display id too.
-- Without a row the worldserver logs "No model data exist for CreatureDisplayID" and refuses to load the creature
-- ("has no model ... defined in table creature_template_model, can't load"), so summons such as the Necromancer
-- Abomination existed but were invisible. Each new display inherits its stock display's row; anything without a
-- stock row gets a neutral default. Rollback: DELETE FROM `creature_model_info` WHERE `DisplayID` BETWEEN 977000 AND 977999;

START TRANSACTION;
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES
(977363, 0.5, 1.5, 2, 0, NULL),
(977364, 0.5, 1.5, 2, 0, NULL),
(977365, 0.5, 1.5, 2, 0, NULL),
(977366, 0.5, 1.5, 2, 0, NULL),
(977367, 0.5, 1.5, 2, 0, NULL),
(977368, 0.5, 1.5, 2, 0, NULL),
(977369, 0.5, 1.5, 2, 0, NULL),
(977370, 0.5, 1.5, 2, 0, NULL),
(977371, 0.5, 1.5, 2, 0, NULL),
(977372, 0.5, 1.5, 2, 0, NULL),
(977373, 0.5, 1.5, 2, 0, NULL),
(977374, 0.5, 1.5, 2, 0, NULL),
(977375, 0.5, 1.5, 2, 0, NULL),
(977376, 0.5, 1.5, 2, 0, NULL),
(977377, 0.5, 1.5, 2, 0, NULL),
(977378, 0.5, 1.5, 2, 0, NULL),
(977379, 0.5, 1.5, 2, 0, NULL),
(977380, 0.5, 1.5, 2, 0, NULL),
(977381, 0.5, 1.5, 2, 0, NULL),
(977382, 0.5, 1.5, 2, 0, NULL),
(977383, 0.5, 1.5, 2, 0, NULL),
(977384, 0.5, 1.5, 2, 0, NULL),
(977385, 0.5, 1.5, 2, 0, NULL),
(977386, 0.5, 1.5, 2, 0, NULL),
(977387, 0.5, 1.5, 2, 0, NULL),
(977388, 0.5, 1.5, 2, 0, NULL),
(977389, 0.5, 1.5, 2, 0, NULL),
(977390, 0.5, 1.5, 2, 0, NULL),
(977391, 0.5, 1.5, 2, 0, NULL),
(977392, 0.5, 1.5, 2, 0, NULL),
(977393, 0.5, 1.5, 2, 0, NULL),
(977394, 0.5, 1.5, 2, 0, NULL),
(977395, 0.5, 1.5, 2, 0, NULL),
(977396, 0.5, 1.5, 2, 0, NULL),
(977397, 0.5, 1.5, 2, 0, NULL),
(977398, 0.5, 1.5, 2, 0, NULL),
(977399, 0.5, 1.5, 2, 0, NULL),
(977400, 0.5, 1.5, 2, 0, NULL),
(977401, 0.5, 1.5, 2, 0, NULL),
(977402, 0.5, 1.5, 2, 0, NULL),
(977403, 0.5, 1.5, 2, 0, NULL),
(977404, 0.5, 1.5, 2, 0, NULL),
(977405, 0.5, 1.5, 2, 0, NULL),
(977406, 0.5, 1.5, 2, 0, NULL),
(977407, 0.5, 1.5, 2, 0, NULL),
(977408, 0.5, 1.5, 2, 0, NULL),
(977409, 0.5, 1.5, 2, 0, NULL),
(977410, 0.5, 1.5, 2, 0, NULL),
(977411, 0.5, 1.5, 2, 0, NULL),
(977412, 0.5, 1.5, 2, 0, NULL),
(977413, 0.5, 1.5, 2, 0, NULL),
(977414, 0.5, 1.5, 2, 0, NULL),
(977415, 0.5, 1.5, 2, 0, NULL),
(977416, 0.5, 1.5, 2, 0, NULL),
(977417, 0.5, 1.5, 2, 0, NULL),
(977418, 0.5, 1.5, 2, 0, NULL),
(977419, 0.5, 1.5, 2, 0, NULL),
(977420, 0.5, 1.5, 2, 0, NULL),
(977421, 0.5, 1.5, 2, 0, NULL),
(977422, 0.5, 1.5, 2, 0, NULL),
(977423, 0.5, 1.5, 2, 0, NULL),
(977424, 0.5, 1.5, 2, 0, NULL);

UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 49 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977364;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 169 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977365;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 525 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977366;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 775 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977367;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 955 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977368;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 1405 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977369;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 1421 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977370;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 4449 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977371;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 6977 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977372;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 7550 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977373;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 8714 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977374;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 8824 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977375;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 9786 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977376;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 9905 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977377;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 10045 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977378;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 10626 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977379;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 10752 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977380;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 10971 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977381;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 10973 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977382;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 10975 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977383;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 11396 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977384;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 11686 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977385;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 12073 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977386;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 14554 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977387;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 15292 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977388;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 15788 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977389;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 15958 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977390;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 15983 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977391;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 16049 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977392;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 16888 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977393;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 16986 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977394;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 16997 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977395;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 17308 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977396;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 17545 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977397;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 18987 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977398;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 22633 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977399;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 22878 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977400;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 23229 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977401;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 23719 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977402;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 24868 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977403;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 25398 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977404;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 25495 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977405;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 25498 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977406;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 26079 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977407;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 26576 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977408;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 27064 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977409;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 27101 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977410;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 28526 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977411;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 28813 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977412;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 28814 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977413;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 28815 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977414;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 28830 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977415;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 28844 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977416;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 29118 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977417;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 30300 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977418;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 30547 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977419;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 30616 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977420;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 30641 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977421;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 30810 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977422;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 31089 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977423;
UPDATE `creature_model_info` AS n JOIN `creature_model_info` AS o ON o.`DisplayID` = 200003 SET n.`BoundingRadius` = o.`BoundingRadius`, n.`CombatReach` = o.`CombatReach`, n.`Gender` = o.`Gender` WHERE n.`DisplayID` = 977424;
COMMIT;
