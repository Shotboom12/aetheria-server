-- Aetheria Hero/Classless support tables: structure and seed data for the tables the module reads at startup
-- (cw_ability_override, cw_ability_variants(+meta), cw_archetypes, cw_form_kits, cw_talent_override).
-- Taken from the verified 2026-11-08 test realm database; no creating SQL for them existed in the source tree.

-- Table structure for table `cw_ability_override`
--

DROP TABLE IF EXISTS `cw_ability_override`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cw_ability_override` (
  `first_spell` int unsigned NOT NULL COMMENT 'first-rank spell id of the line',
  `rarity` tinyint unsigned NOT NULL DEFAULT '255' COMMENT '0 common .. 4 legendary, 255 = keep heuristic',
  `cost` int unsigned NOT NULL DEFAULT '0' COMMENT 'ability essence cost, 0 = by rarity',
  `weight` int unsigned NOT NULL DEFAULT '0' COMMENT 'wildcard roll weight, 0 = by rarity',
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`first_spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless ability tuning';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw_ability_override`
--

LOCK TABLES `cw_ability_override` WRITE;
/*!40000 ALTER TABLE `cw_ability_override` DISABLE KEYS */;
INSERT INTO `cw_ability_override` VALUES (136,255,0,0,0),(883,255,0,0,0),(982,255,0,0,0),(1002,255,0,0,0),(2641,255,0,0,0),(6991,255,0,0,0);
/*!40000 ALTER TABLE `cw_ability_override` ENABLE KEYS */;
UNLOCK TABLES;
-- Table structure for table `cw_ability_variants`
--

DROP TABLE IF EXISTS `cw_ability_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cw_ability_variants` (
  `variant_first_spell` int unsigned NOT NULL COMMENT 'rank 1 of the variant line',
  `base_first_spell` int unsigned NOT NULL COMMENT 'rank 1 of the ability it varies',
  `element` tinyint unsigned NOT NULL COMMENT '1 fire 2 frost 3 earth 4 poison 5 arcane 6 shadow 7 holy',
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`variant_first_spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless elemental ability variants';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw_ability_variants`
--

LOCK TABLES `cw_ability_variants` WRITE;
/*!40000 ALTER TABLE `cw_ability_variants` DISABLE KEYS */;
INSERT INTO `cw_ability_variants` VALUES (950000,53,1,1),(950016,53,2,1),(950032,53,3,1),(950048,53,4,1),(950064,53,5,1),(950080,53,6,1),(950096,53,7,1),(950112,78,1,1),(950128,78,2,1),(950144,78,3,1),(950160,78,4,1),(950176,78,5,1),(950192,78,6,1),(950208,78,7,1),(950336,845,1,1),(950352,845,2,1),(950368,845,3,1),(950384,845,4,1),(950400,845,5,1),(950416,845,6,1),(950432,845,7,1),(950448,1082,1,1),(950464,1082,2,1),(950480,1082,3,1),(950496,1082,4,1),(950512,1082,5,1),(950528,1082,6,1),(950544,1082,7,1),(950560,1680,1,1),(950576,1680,2,1),(950592,1680,3,1),(950608,1680,4,1),(950624,1680,5,1),(950640,1680,6,1),(950656,1680,7,1),(950672,1752,1,1),(950688,1752,2,1),(950704,1752,3,1),(950720,1752,4,1),(950736,1752,5,1),(950752,1752,6,1),(950768,1752,7,1),(950784,2643,1,1),(950800,2643,2,1),(950816,2643,3,1),(950832,2643,4,1),(950848,2643,5,1),(950864,2643,6,1),(950880,2643,7,1),(950896,2973,1,1),(950912,2973,2,1),(950928,2973,3,1),(950944,2973,4,1),(950960,2973,5,1),(950976,2973,6,1),(950992,2973,7,1),(951008,5221,1,1),(951024,5221,2,1),(951040,5221,3,1),(951056,5221,4,1),(951072,5221,5,1),(951088,5221,6,1),(951104,5221,7,1),(951120,6785,1,1),(951136,6785,2,1),(951152,6785,3,1),(951168,6785,4,1),(951184,6785,5,1),(951200,6785,6,1),(951216,6785,7,1),(951232,6807,1,1),(951248,6807,2,1),(951264,6807,3,1),(951280,6807,4,1),(951296,6807,5,1),(951312,6807,6,1),(951328,6807,7,1),(951344,7384,1,1),(951360,7384,2,1),(951376,7384,3,1),(951392,7384,4,1),(951408,7384,5,1),(951424,7384,6,1),(951440,7384,7,1),(951456,8676,1,1),(951472,8676,2,1),(951488,8676,3,1),(951504,8676,4,1),(951520,8676,5,1),(951536,8676,6,1),(951552,8676,7,1),(951568,17347,1,1),(951584,17347,2,1),(951600,17347,3,1),(951616,17347,4,1),(951632,17347,5,1),(951648,17347,6,1),(951664,17347,7,1),(951680,21551,1,1),(951696,21551,2,1),(951712,21551,3,1),(951728,21551,4,1),(951744,21551,5,1),(951760,21551,6,1),(951776,21551,7,1),(951792,22570,1,1),(951808,22570,2,1),(951824,22570,3,1),(951840,22570,4,1),(951856,22570,5,1),(951872,22570,6,1),(951888,22570,7,1),(952016,27065,1,1),(952032,27065,2,1),(952048,27065,3,1),(952064,27065,4,1),(952080,27065,5,1),(952096,27065,6,1),(952112,27065,7,1),(952128,30016,1,1),(952144,30016,2,1),(952160,30016,3,1),(952176,30016,4,1),(952192,30016,5,1),(952208,30016,6,1),(952224,30016,7,1),(952240,33982,1,1),(952256,33982,2,1),(952272,33982,3,1),(952288,33982,4,1),(952304,33982,5,1),(952320,33982,6,1),(952336,33982,7,1),(952352,33986,1,1),(952368,33986,2,1),(952384,33986,3,1),(952400,33986,4,1),(952416,33986,5,1),(952432,33986,6,1),(952448,33986,7,1),(952464,45462,1,1),(952480,45462,2,1),(952496,45462,3,1),(952512,45462,4,1),(952528,45462,5,1),(952544,45462,6,1),(952560,45462,7,1),(952576,45902,1,1),(952592,45902,2,1),(952608,45902,3,1),(952624,45902,4,1),(952640,45902,5,1),(952656,45902,6,1),(952672,45902,7,1),(952688,49020,1,1),(952704,49020,2,1),(952720,49020,3,1),(952736,49020,4,1),(952752,49020,5,1),(952768,49020,6,1),(952784,49020,7,1),(952800,49998,1,1),(952816,49998,2,1),(952832,49998,3,1),(952848,49998,4,1),(952864,49998,5,1),(952880,49998,6,1),(952896,49998,7,1),(952912,51723,1,1),(952928,51723,2,1),(952944,51723,3,1),(952960,51723,4,1),(952976,51723,5,1),(952992,51723,6,1),(953008,51723,7,1),(953024,61005,1,1),(953040,61005,2,1),(953056,61005,3,1),(953072,61005,4,1),(953088,61005,5,1),(953104,61005,6,1),(953120,61005,7,1),(953136,62078,1,1),(953152,62078,2,1),(953168,62078,3,1),(953184,62078,4,1),(953200,62078,5,1),(953216,62078,6,1),(953232,62078,7,1);
/*!40000 ALTER TABLE `cw_ability_variants` ENABLE KEYS */;
UNLOCK TABLES;
-- Table structure for table `cw_ability_variants_meta`
--

DROP TABLE IF EXISTS `cw_ability_variants_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cw_ability_variants_meta` (
  `key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Which generator run the variant rows came from';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw_ability_variants_meta`
--

LOCK TABLES `cw_ability_variants_meta` WRITE;
/*!40000 ALTER TABLE `cw_ability_variants_meta` DISABLE KEYS */;
INSERT INTO `cw_ability_variants_meta` VALUES ('generation','3506960c9d02');
/*!40000 ALTER TABLE `cw_ability_variants_meta` ENABLE KEYS */;
UNLOCK TABLES;
-- Table structure for table `cw_archetypes`
--

DROP TABLE IF EXISTS `cw_archetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cw_archetypes` (
  `id` int unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `talents` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless starter archetypes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw_archetypes`
--

LOCK TABLES `cw_archetypes` WRITE;
/*!40000 ALTER TABLE `cw_archetypes` DISABLE KEYS */;
INSERT INTO `cw_archetypes` VALUES (1,'Blade Dancer','Fast melee striker: rogue strikes backed by warrior mobility.','1752,2098,1784,100,772,53,1776,1715,5277,5171,1766,703,8676,1943,1856,5308,1833,408,18499,1680,6552,12294,1719,31224,5938,57934,51723','201:2,221:5,181:5,1827:2,204:2,186:3,1122:5,223:1,242:5,1703:2,1706:2,1705:3,205:1,1707:2,1825:5,1709:1,2074:2,2075:2,2076:1,127:2,130:3,126:2,128:3,131:2,137:1,662:2,121:3,2232:2'),(2,'Battle Mage','Armored caster: fireballs up close, sword in hand.','133,168,1459,100,116,772,2136,118,5143,122,7384,1449,2120,1953,11366,2948,2139,45438,20252,6117,1680,11426,31661,1719,30482,44614,55342','27:2,1141:3,26:5,34:5,31:3,30:3,23:2,1639:3,33:3,35:5,1733:3,36:1,1732:2,1734:3,1850:3,1851:1,25:3,28:1,127:2,130:3,126:2,128:3,131:2,137:1,662:2,121:3,2232:2'),(3,'Ranger of the Light','Hybrid archer-paladin: shoot from range, heal and bless in melee.','2973,635,465,20154,1978,20271,19740,3044,5116,13165,2974,19742,7294,2643,19434,19750,3045,5384,642,1510,20473,4987,24275,56641,19801,31884,53351','1344:5,2197:3,1806:3,1349:5,1818:2,1819:2,1348:3,1353:1,1347:3,1804:2,1362:3,2130:3,1361:1,1821:3,1807:5,2134:5,2135:1,1432:5,1463:5,1444:3,1449:5,1628:2,1435:1'),(4,'Shadow Mender','Priest hybrid: shield and mend allies, wither foes with shadow.','585,2050,1243,589,17,139,586,8092,588,8122,2054,527,2061,15407,596,976,605,552,2060,21562,34914,32379,32546,48045,64843','465:3,462:5,482:2,463:3,481:5,461:3,881:2,484:1,1777:3,1781:2,521:1,1778:5,1816:3,1906:2,1909:3,1907:5,1910:1,2027:2,1898:5,346:3,344:2,352:1,347:3,348:1,343:3,341:2'),(5,'Stealthy Healer','Druidic infiltrator: slip through shadows, restore life from hiding.','5185,1784,5176,1126,774,8921,467,339,16689,8936,783,475,768,5215,1856,2893,740,29166,22812,21849,48438,33763,31224,33786,50464','821:2,823:3,824:5,841:3,829:3,827:1,843:5,830:3,831:1,828:5,1788:2,825:5,1797:3,844:1,1789:5,1791:1,1930:2,2264:1,2244:1,241:3,261:2,244:3,262:2,247:2,1123:3,245:3,246:1'),(6,'Storm Warrior','Shamanistic bruiser: lightning from afar, heroic strikes up close.','403,331,78,8017,8042,100,2484,324,8050,370,2645,57994,8056,845,5308,5675,8232,421,1680,1064,974,1719,51490,3738,51505,57755','614:5,610:3,613:5,607:3,611:3,617:1,602:5,1647:2,616:1,2083:3,1689:3,1643:3,1690:1,1692:3,901:1,2249:1,2054:2,2057:5,2058:1,157:5,2250:3,159:5,166:3,154:4'),(7,'Hellfire Knight','Burning warrior: fiery strikes and warlock fire, fed by the Destruction tree.','950112,6673,348,100,1454,1715,2687,951344,5676,950336,5308,20252,1949,18499,950560,6552,951680,6353,1719,50796,29722,55694','943:5,941:3,982:2,967:5,985:2,965:3,961:3,981:1,1817:3,966:5,968:1,986:3,1678:3,1677:5,1888:3,1890:5,1887:1,157:5,2250:3,159:5,166:3,1542:2'),(8,'Rime Reaver','Frozen rogue: chilling strikes and frost magic that slow and shatter.','950688,2098,950016,116,1776,5277,122,5171,1766,951472,1943,1856,120,1833,408,45438,2094,11426,1329,30455,31224,5938,952928','37:5,73:3,1649:3,61:3,69:1,67:3,741:2,66:3,72:1,1736:3,68:3,1737:2,38:1,1738:5,1853:2,1740:2,1854:3,1856:5,1857:1,270:5,276:3,273:3,277:3,269:5,382:1'),(9,'Stoneguard','Earthen bear: slowing mauls and shaman totems, built to hold the line.','331,1126,8017,8042,2484,324,5487,951264,8075,5229,5211,779,16857,5394,5209,8177,8232,22842,22812,974,952384,2062,33745','796:5,799:3,794:3,1162:1,798:3,807:2,803:3,801:2,804:1,797:2,2242:3,1794:3,808:5,809:1,1798:2,2241:3,1919:3,1793:1,1918:5,1927:1,614:5,610:3,607:3,613:5,601:3'),(10,'Venomstalker','Venomous hunter: poisoned shots and stings, with a rogue\'s opening moves.','950944,1784,1978,3044,1130,5116,13165,2983,2974,1495,950832,952064,1499,3045,5384,19306,3034,19386,1510,3674,56641,34600,953072,57934','1621:2,1820:3,1310:3,1810:2,1622:5,2229:3,1306:3,1321:3,2228:3,1303:5,1811:3,1812:3,2141:3,1813:5,2143:3,1304:2,2144:3,2145:1,270:5,272:2,273:3,277:3,269:3'),(11,'Nightclaw','Shadow cat: darkened claws and shreds, sharpened by the Shadow tree.','5176,1126,5185,589,8921,774,586,8092,8936,768,950528,5215,1079,951088,5217,1822,22568,951200,9005,20719,22812,952320,951872,953216,52610','465:3,462:5,2027:2,482:2,463:3,481:5,461:3,483:2,484:1,1777:3,1781:2,1638:2,1778:5,1816:3,1909:3,1908:1,1907:5,796:5,805:2,799:3,798:3,807:2,803:3,801:2,802:1'),(12,'Dawnward','Holy bulwark: shield and strikes that heal you, backed by both Protection trees.','950208,635,20154,20271,19740,498,853,2687,72,31789,25780,2565,26573,950432,871,642,23922,20925,4987,952224,31935,25898,54428,53600','2185:5,1629:5,1423:5,1501:3,1521:2,1431:1,1426:5,1750:2,1429:3,1751:3,2282:2,1421:3,1753:3,2195:3,2194:2,1748:2,2204:3,2196:1,1601:5,142:2,144:3,138:5,1654:2,153:1'),(13,'Spellblade','Arcane duelist: arcane-laced strikes, with Intellect turned into damage.','950736,1459,2098,950064,1776,5143,5277,5171,1766,1449,951520,1953,1943,1856,2139,1833,408,1329,44425,30451,31224,5938,952976','76:3,74:2,75:5,81:3,1845:2,2222:3,1142:2,86:1,77:5,421:3,1725:2,87:1,1727:3,1728:5,201:2,221:5,181:5,1827:2,204:1,186:3,1122:5,223:1,242:5,1703:2');
/*!40000 ALTER TABLE `cw_archetypes` ENABLE KEYS */;
UNLOCK TABLES;
-- Table structure for table `cw_form_kits`
--

DROP TABLE IF EXISTS `cw_form_kits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cw_form_kits` (
  `form_spell` int unsigned NOT NULL COMMENT 'the form or stance spell; any rank of the line matches',
  `granted_spell` int unsigned NOT NULL COMMENT 'spell handed over free when that form is gained',
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  `comment` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`form_spell`,`granted_spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless form/stance starter kits';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw_form_kits`
--

LOCK TABLES `cw_form_kits` WRITE;
/*!40000 ALTER TABLE `cw_form_kits` DISABLE KEYS */;
INSERT INTO `cw_form_kits` VALUES (71,355,1,'default: Defensive Stance -> Taunt'),(691,1120,1,'default: Summon Felhunter -> Drain Soul'),(693,1120,1,'default: Create Soulstone -> Drain Soul'),(697,1120,1,'default: Summon Voidwalker -> Drain Soul'),(698,1120,1,'default: Ritual of Summoning -> Drain Soul'),(712,1120,1,'default: Summon Succubus -> Drain Soul'),(755,688,1,'default: Health Funnel -> Summon Imp'),(768,1082,1,'default: Cat Form -> Claw'),(768,5215,1,'default: Cat Form -> Prowl'),(1098,1120,1,'default: Enslave Demon -> Drain Soul'),(1515,136,1,'default: Tame Beast -> Mend Pet'),(1515,883,1,'default: Tame Beast -> Call Pet'),(1515,982,1,'default: Tame Beast -> Revive Pet'),(1515,1002,1,'default: Tame Beast -> Eyes of the Beast'),(1515,2641,1,'default: Tame Beast -> Dismiss Pet'),(1515,6991,1,'default: Tame Beast -> Feed Pet'),(2362,1120,1,'default: Create Spellstone -> Drain Soul'),(2457,100,1,'default: Battle Stance -> Charge'),(2458,6552,1,'default: Berserker Stance -> Pummel'),(5487,99,1,'default: Bear Form -> Demoralizing Roar'),(5487,6807,1,'default: Bear Form -> Maul'),(6201,1120,1,'default: Create Healthstone -> Drain Soul'),(6353,1120,1,'default: Soul Fire -> Drain Soul'),(6366,1120,1,'default: Create Firestone -> Drain Soul'),(9634,99,1,'default: Dire Bear Form -> Demoralizing Roar'),(9634,6807,1,'default: Dire Bear Form -> Maul'),(17877,1120,1,'default: Shadowburn -> Drain Soul'),(18220,688,1,'default: Dark Pact -> Summon Imp'),(19028,688,1,'default: Soul Link -> Summon Imp'),(19574,136,1,'default: Bestial Wrath -> Mend Pet'),(19574,883,1,'default: Bestial Wrath -> Call Pet'),(19574,982,1,'default: Bestial Wrath -> Revive Pet'),(19574,1515,1,'default: Bestial Wrath -> Tame Beast'),(19574,2641,1,'default: Bestial Wrath -> Dismiss Pet'),(19574,6991,1,'default: Bestial Wrath -> Feed Pet'),(19577,136,1,'default: Intimidation -> Mend Pet'),(19577,883,1,'default: Intimidation -> Call Pet'),(19577,982,1,'default: Intimidation -> Revive Pet'),(19577,1515,1,'default: Intimidation -> Tame Beast'),(19577,2641,1,'default: Intimidation -> Dismiss Pet'),(19577,6991,1,'default: Intimidation -> Feed Pet'),(29858,1120,1,'default: Soulshatter -> Drain Soul'),(29893,1120,1,'default: Ritual of Souls -> Drain Soul'),(30146,1120,1,'default: Summon Felguard -> Drain Soul'),(34026,136,1,'default: Kill Command -> Mend Pet'),(34026,883,1,'default: Kill Command -> Call Pet'),(34026,982,1,'default: Kill Command -> Revive Pet'),(34026,1515,1,'default: Kill Command -> Tame Beast'),(34026,2641,1,'default: Kill Command -> Dismiss Pet'),(34026,6991,1,'default: Kill Command -> Feed Pet'),(47193,688,1,'default: Demonic Empowerment -> Summon Imp'),(48020,48018,1,'default: Demonic Circle: Teleport -> Demonic Circle: Summon'),(48743,46584,1,'default: Death Pact -> Raise Dead'),(52610,768,1,'default: Savage Roar -> Cat Form'),(53271,136,1,'default: Master\'s Call -> Mend Pet'),(53271,883,1,'default: Master\'s Call -> Call Pet'),(53271,982,1,'default: Master\'s Call -> Revive Pet'),(53271,1515,1,'default: Master\'s Call -> Tame Beast'),(53271,2641,1,'default: Master\'s Call -> Dismiss Pet'),(53271,6991,1,'default: Master\'s Call -> Feed Pet'),(61336,768,1,'default: Survival Instincts -> Cat Form'),(63560,46584,1,'default: Ghoul Frenzy -> Raise Dead');
/*!40000 ALTER TABLE `cw_form_kits` ENABLE KEYS */;
UNLOCK TABLES;
-- Table structure for table `cw_talent_override`
--

DROP TABLE IF EXISTS `cw_talent_override`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cw_talent_override` (
  `talent_id` int unsigned NOT NULL,
  `rarity` tinyint unsigned NOT NULL DEFAULT '255' COMMENT '0 common .. 4 legendary, 255 = keep heuristic',
  `weight` int unsigned NOT NULL DEFAULT '0' COMMENT 'wildcard roll weight, 0 = by rarity',
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`talent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless talent tuning';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw_talent_override`
--

LOCK TABLES `cw_talent_override` WRITE;
/*!40000 ALTER TABLE `cw_talent_override` DISABLE KEYS */;
/*!40000 ALTER TABLE `cw_talent_override` ENABLE KEYS */;
UNLOCK TABLES;
