ALTER TABLE `characters`
    ADD COLUMN `extraAppearance` BIGINT UNSIGNED NOT NULL DEFAULT 0 AFTER `facialStyle`;
