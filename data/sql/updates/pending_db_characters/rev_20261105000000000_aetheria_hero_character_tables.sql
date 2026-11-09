-- Hero/Classless per-character tables (state, owned abilities, owned talents, bans). The source tree had no SQL that created them;
-- structure taken from the verified 2026-11-08 test realm characters database. Safe to re-run.

CREATE TABLE IF NOT EXISTS `cw_char_state` (
  `guid` int unsigned NOT NULL,
  `mode` tinyint unsigned NOT NULL DEFAULT '255',
  `ability_essence` int unsigned NOT NULL DEFAULT '0',
  `talent_essence` int unsigned NOT NULL DEFAULT '0',
  `pity` int unsigned NOT NULL DEFAULT '0',
  `rerolls` int unsigned NOT NULL DEFAULT '0' COMMENT 'earned reroll charges, spent on abilities or talents',
  `last_level` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_str` int unsigned NOT NULL DEFAULT '0',
  `stat_agi` int unsigned NOT NULL DEFAULT '0',
  `stat_sta` int unsigned NOT NULL DEFAULT '0',
  `stat_int` int unsigned NOT NULL DEFAULT '0',
  `stat_spi` int unsigned NOT NULL DEFAULT '0',
  `display_power` tinyint unsigned NOT NULL DEFAULT '255' COMMENT '0 mana, 1 rage, 3 energy, 255 chassis default',
  `archetype` int unsigned NOT NULL DEFAULT '0' COMMENT 'cw_archetypes.id the Hero follows, 0 none',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless/Wildcard character state';

CREATE TABLE IF NOT EXISTS `cw_char_abilities` (
  `guid` int unsigned NOT NULL,
  `first_spell` int unsigned NOT NULL,
  `source` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '0 picked, 1 rolled, 2 granted by an ability talent, 3 came free with a form or stance',
  `locked` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`first_spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Owned classless ability lines';

CREATE TABLE IF NOT EXISTS `cw_char_talents` (
  `guid` int unsigned NOT NULL,
  `talent_id` int unsigned NOT NULL,
  `talent_rank` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`guid`,`talent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Owned classless talents';

CREATE TABLE IF NOT EXISTS `cw_char_bans` (
  `guid` int unsigned NOT NULL,
  `is_talent` tinyint unsigned NOT NULL DEFAULT '0',
  `entry` int unsigned NOT NULL,
  `rolls_left` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`is_talent`,`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Wildcard bad-luck-protection roll bans';
