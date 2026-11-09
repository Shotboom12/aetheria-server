-- mod-classless-wildcard CoA catalog tables.
-- Spell and talent rows are supplied by the paired CoA data import in a later update.

CREATE TABLE IF NOT EXISTS `cw_coa_classes` (
    `class` TINYINT UNSIGNED NOT NULL COMMENT 'CoA class id, 12-32',
    `name` VARCHAR(32) NOT NULL,
    `icon_spell` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'spell whose icon the browser shows',
    PRIMARY KEY (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA catalog classes';

CREATE TABLE IF NOT EXISTS `cw_coa_tabs` (
    `tab_id` INT UNSIGNED NOT NULL COMMENT 'talenttab_dbc id',
    `class` TINYINT UNSIGNED NOT NULL,
    `spec` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'CoA ChrSpecs id, 0 = class-wide',
    `name` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`tab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA catalog trees';

CREATE TABLE IF NOT EXISTS `cw_coa_entries` (
    `entry` INT UNSIGNED NOT NULL COMMENT 'CoA CharacterAdvancement id',
    `class` TINYINT UNSIGNED NOT NULL,
    `spec` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    `tab_id` INT UNSIGNED NOT NULL,
    `kind` TINYINT UNSIGNED NOT NULL COMMENT '0 ability line, 1 talent',
    `first_spell` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'ability: rank 1',
    `talent_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'talent: talent_dbc id',
    `req_level` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `requires` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'CoA entry ids, space separated',
    `in_pool` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Wildcard can roll it',
    `enabled` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `choice_group` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'CoA choice group: owning one removes the others',
    `free` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'a free choice: costs no essence',
    PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA catalog entries';

CREATE TABLE IF NOT EXISTS `cw_coa_automatic` (
    `entry` INT UNSIGNED NOT NULL COMMENT 'CoA CharacterAdvancement id of the automatic entry',
    `class` TINYINT UNSIGNED NOT NULL,
    `spec` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = granted with the class',
    `spell` INT UNSIGNED NOT NULL,
    `req_level` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `requires` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'CoA entry ids that must be held, space separated',
    `baseline` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '1 = CoA ClassSpells baseline',
    `team` TINYINT UNSIGNED NOT NULL DEFAULT 2 COMMENT 'TeamId: 0 Alliance, 1 Horde, 2 any',
    PRIMARY KEY (`entry`, `spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA automatic entries';

CREATE TABLE IF NOT EXISTS `cw_coa_taught` (
    `parent` INT UNSIGNED NOT NULL COMMENT 'learning this spell',
    `spell` INT UNSIGNED NOT NULL COMMENT 'also teaches this spell',
    PRIMARY KEY (`parent`, `spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA taught abilities';

CREATE TABLE IF NOT EXISTS `cw_coa_spell_scaling` (
    `spell` INT UNSIGNED NOT NULL,
    `effect_mask` TINYINT UNSIGNED NOT NULL COMMENT 'effects whose base points follow the level curve',
    PRIMARY KEY (`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA level-scaled spells';
