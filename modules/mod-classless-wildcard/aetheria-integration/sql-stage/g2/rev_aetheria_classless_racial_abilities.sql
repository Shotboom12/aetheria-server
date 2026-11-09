-- Exact eligibility for imported racial abilities on the Hero classless page.
-- RaceMask in Wrath aliases several Aetheria races onto the same 32-bit bit;
-- this table preserves the source race id for server-side access checks.
CREATE TABLE IF NOT EXISTS `cw_classless_racial_abilities` (
    `spell_id` INT UNSIGNED NOT NULL,
    `race_id` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (`spell_id`),
    KEY `idx_cw_classless_racial_abilities_race` (`race_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
