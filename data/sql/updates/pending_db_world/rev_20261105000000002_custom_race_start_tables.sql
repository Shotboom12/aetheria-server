-- Structure only of the custom race start tables (spells/skills granted at creation per custom race). The race pack inserts its rows here.
-- Taken from the verified test realm database.

-- Table structure for table `custom_race_start_skill`
--

DROP TABLE IF EXISTS `custom_race_start_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_race_start_skill` (
  `race` smallint unsigned NOT NULL,
  `classMask` int unsigned NOT NULL DEFAULT '0',
  `skill` int unsigned NOT NULL,
  `rank` int unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`race`,`classMask`,`skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_race_start_skill_exclude`
--

DROP TABLE IF EXISTS `custom_race_start_skill_exclude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_race_start_skill_exclude` (
  `race` smallint unsigned NOT NULL,
  `skill` int unsigned NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`race`,`skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_race_start_spell`
--

DROP TABLE IF EXISTS `custom_race_start_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_race_start_spell` (
  `race` smallint unsigned NOT NULL,
  `classMask` int unsigned NOT NULL DEFAULT '0',
  `spell` int unsigned NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`race`,`classMask`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_race_start_spell_exclude`
--

DROP TABLE IF EXISTS `custom_race_start_spell_exclude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_race_start_spell_exclude` (
  `race` smallint unsigned NOT NULL,
  `spell` int unsigned NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`race`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
