-- REVIEW ONLY: exact-race eligibility for CoA racial abilities in Hero's classless catalog.
-- Apply before rev_20261106000000001_coa_catalog_data.sql; not installed or applied.
CREATE TABLE IF NOT EXISTS `cw_classless_racial_abilities` (
    `spell_id` INT UNSIGNED NOT NULL,
    `race_id` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (`spell_id`),
    KEY `idx_cw_classless_racial_abilities_race` (`race_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
