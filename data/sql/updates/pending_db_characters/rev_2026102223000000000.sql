-- Store the complete first/last display name without truncating either part.
ALTER TABLE `characters`
    MODIFY `name` varchar(25) COLLATE utf8mb4_bin NOT NULL,
    MODIFY `deleteInfos_Name` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL;
ALTER TABLE `gm_ticket`
    MODIFY `name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Name of ticket creator';
ALTER TABLE `reserved_name`
    MODIFY `name` varchar(25) COLLATE utf8mb4_bin NOT NULL;
ALTER TABLE `profanity_name`
    MODIFY `name` varchar(25) COLLATE utf8mb4_bin NOT NULL;
ALTER TABLE `character_declinedname`
    MODIFY `genitive` varchar(28) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    MODIFY `dative` varchar(28) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    MODIFY `accusative` varchar(28) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    MODIFY `instrumental` varchar(28) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    MODIFY `prepositional` varchar(28) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '';
