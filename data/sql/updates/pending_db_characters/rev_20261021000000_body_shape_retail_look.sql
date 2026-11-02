-- Body customization persistence, ported from STRHercules/EsteriaWoW.
-- Source author: Zachary Kaiser (STRHercules). No existing character rows are changed.
CREATE TABLE IF NOT EXISTS `character_body_shape` (
  `guid` int unsigned NOT NULL,
  `data` binary(49) NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `character_retail_look` (
  `guid` int unsigned NOT NULL,
  `data` binary(132) NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
