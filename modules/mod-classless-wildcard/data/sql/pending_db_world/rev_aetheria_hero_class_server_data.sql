-- Aetheria Hero class (class 10): server-side creation data, cloned from the Paladin chassis (the donor class used
-- for the client DBC patch, ChrClasses/gt* tables). World database. Idempotent (INSERT IGNORE); no existing row is
-- changed, so Classic classes are untouched. Apply after the CoA catalog migrations. Requires the server DBCs
-- (ChrClasses.dbc, CharBaseInfo.dbc and the gt* tables) that already contain class 10.
START TRANSACTION;

-- 1. start position: every race that can already create a Warrior starts its Hero where the Warrior starts
INSERT IGNORE INTO `playercreateinfo` (`race`, `class`, `map`, `zone`, `position_x`, `position_y`, `position_z`, `orientation`)
SELECT `race`, 10, `map`, `zone`, `position_x`, `position_y`, `position_z`, `orientation`
FROM `playercreateinfo` WHERE `class` = 1;

-- 2. action bars: Paladin's where the race has them, otherwise Human Paladin's
INSERT IGNORE INTO `playercreateinfo_action` (`race`, `class`, `button`, `action`, `type`)
SELECT `race`, 10, `button`, `action`, `type` FROM `playercreateinfo_action` WHERE `class` = 2;

INSERT IGNORE INTO `playercreateinfo_action` (`race`, `class`, `button`, `action`, `type`)
SELECT r.`race`, 10, a.`button`, a.`action`, a.`type`
FROM (SELECT DISTINCT `race` FROM `playercreateinfo` WHERE `class` = 1) r
JOIN `playercreateinfo_action` a ON a.`race` = 1 AND a.`class` = 2
WHERE r.`race` NOT IN (SELECT `race` FROM `playercreateinfo_action` WHERE `class` = 2);

-- 3. base health/mana/stats per level: Paladin's
INSERT IGNORE INTO `player_class_stats` (`Class`, `Level`, `BaseHP`, `BaseMana`, `Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`)
SELECT 10, `Level`, `BaseHP`, `BaseMana`, `Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`
FROM `player_class_stats` WHERE `Class` = 2;

-- 4. starting spells every class shares (language, generic, detect, opening, ...): Warrior's rows filtered to the
--    spells that at least three classes receive, so no class-specific ability is handed to the Hero
INSERT IGNORE INTO `playercreateinfo_spell_custom` (`racemask`, `classmask`, `Spell`, `Note`)
SELECT s.`racemask`, 512, s.`Spell`, s.`Note`
FROM `playercreateinfo_spell_custom` s
WHERE s.`classmask` = 1
  AND s.`Spell` IN (SELECT `Spell` FROM (SELECT `Spell` FROM `playercreateinfo_spell_custom`
                    GROUP BY `Spell` HAVING COUNT(DISTINCT `classmask`) >= 3) common);

COMMIT;