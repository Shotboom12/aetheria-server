DELETE FROM `creature` WHERE `guid` BETWEEN 5301000 AND 5301099;
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (990150, 990151);
DELETE FROM `creature_template` WHERE `entry` IN (990150, 990151);
DELETE FROM `creature_model_info` WHERE `DisplayID` IN (60083, 60084, 60085, 60086);
