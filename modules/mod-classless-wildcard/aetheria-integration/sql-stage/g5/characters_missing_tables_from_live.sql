CREATE TABLE IF NOT EXISTS `character_form_look` (
  `guid` int unsigned NOT NULL,
  `data` varbinary(132) NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `character_speedflying` (
  `guid` int unsigned NOT NULL,
  `points` int unsigned NOT NULL DEFAULT '0',
  `yard_partial` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `character_speedflying_talents` (
  `guid` int unsigned NOT NULL,
  `talent_id` smallint unsigned NOT NULL,
  `rank` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`talent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `custom_transmogrification_outfit_slots` (
  `Owner` int unsigned NOT NULL COMMENT 'Player guidlow',
  `Bought` int unsigned NOT NULL DEFAULT '0' COMMENT 'Outfit slots bought in the transmog window',
  PRIMARY KEY (`Owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
