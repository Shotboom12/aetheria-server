CREATE TABLE IF NOT EXISTS `character_retail_appearance` (
  `guid` INT UNSIGNED NOT NULL,
  `appearance` MEDIUMBLOB NOT NULL,
  PRIMARY KEY (`guid`),
  CONSTRAINT `fk_character_retail_appearance_guid` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
