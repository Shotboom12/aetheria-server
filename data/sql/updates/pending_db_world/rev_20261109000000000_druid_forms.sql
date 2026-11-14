-- Aetheria druid forms (Medviten WHE F-011/F-014/F-017/F-024/F-025/F-028/F-031/F-084/F-085/F-086) remapped to Aetheria race and display ids. Taunka excluded.
-- Generated 2026-11-09 against the live player_shapeshift_model (591 rows, dump: D:\AcoreRaceFix\HeroBuild\live-backup-20261109-druid-forms).
-- INSERT IGNORE adds 143 new keys. REPLACE overrides 117 keys whose live value is the generic per-form default (e.g. every race's plain cat 892 or oak 864); specific live rows (20: Worgen cat/bear forms, race 17, three moonkin rows) are kept.
START TRANSACTION;
INSERT IGNORE INTO `player_shapeshift_model` (`ShapeshiftID`, `RaceID`, `CustomizationID`, `GenderID`, `ModelID`) VALUES
(1, 8, 0, 2, 9100015), -- F-084_troll_druid
(1, 8, 1, 2, 9100018), -- F-084_troll_druid
(1, 8, 2, 2, 9100018), -- F-084_troll_druid
(1, 8, 3, 2, 9100017), -- F-084_troll_druid
(1, 8, 4, 2, 9100016), -- F-084_troll_druid
(1, 8, 5, 2, 9100016), -- F-084_troll_druid
(1, 8, 6, 2, 9100016), -- F-084_troll_druid
(1, 8, 7, 2, 9100016), -- F-084_troll_druid
(1, 8, 8, 2, 9100019), -- F-084_troll_druid
(1, 8, 9, 2, 9100019), -- F-084_troll_druid
(1, 22, 0, 2, 9100036), -- F-017_mod-zandalari-troll
(1, 22, 1, 2, 9100037), -- F-017_mod-zandalari-troll
(1, 22, 2, 2, 9100038), -- F-017_mod-zandalari-troll
(1, 22, 3, 2, 9100038), -- F-017_mod-zandalari-troll
(1, 22, 4, 2, 9100038), -- F-017_mod-zandalari-troll
(1, 22, 5, 2, 9100039), -- F-017_mod-zandalari-troll
(1, 22, 6, 2, 9100039), -- F-017_mod-zandalari-troll
(1, 25, 0, 2, 9100062), -- F-025_mod-kul-tiran
(1, 25, 1, 2, 9100063), -- F-025_mod-kul-tiran
(1, 25, 2, 2, 9100064), -- F-025_mod-kul-tiran
(1, 25, 3, 2, 9100064), -- F-025_mod-kul-tiran
(1, 25, 4, 2, 9100065), -- F-025_mod-kul-tiran
(1, 25, 5, 2, 9100065), -- F-025_mod-kul-tiran
(1, 25, 6, 2, 9100065), -- F-025_mod-kul-tiran
(1, 46, 0, 2, 9100053), -- F-028_mod-highmountain-tauren
(1, 46, 1, 2, 9100054), -- F-028_mod-highmountain-tauren
(1, 46, 2, 2, 9100055), -- F-028_mod-highmountain-tauren
(1, 46, 3, 2, 9100056), -- F-028_mod-highmountain-tauren
(2, 5, 255, 0, 9100087), -- F-011_mod-druid-forms
(2, 5, 255, 1, 9100085), -- F-011_mod-druid-forms
(2, 7, 1, 2, 9100089), -- F-011_mod-druid-forms
(2, 7, 2, 2, 9100089), -- F-011_mod-druid-forms
(2, 7, 3, 2, 9100089), -- F-011_mod-druid-forms
(2, 7, 4, 2, 9100089), -- F-011_mod-druid-forms
(2, 7, 5, 2, 9100090), -- F-011_mod-druid-forms
(2, 7, 8, 2, 9100090), -- F-011_mod-druid-forms
(2, 7, 9, 2, 9100090), -- F-011_mod-druid-forms
(2, 23, 255, 2, 9100021), -- F-085
(2, 60, 255, 2, 9100022), -- F-085 default
(2, 61, 255, 2, 9100022), -- F-085 default
(3, 25, 0, 2, 9100074), -- F-086
(3, 25, 1, 2, 9100075), -- F-086
(3, 25, 2, 2, 9100076), -- F-086
(3, 25, 3, 2, 9100076), -- F-086
(3, 25, 4, 2, 9100077), -- F-086
(3, 25, 5, 2, 9100077), -- F-086
(3, 25, 6, 2, 9100077), -- F-086
(3, 60, 255, 2, 9100029), -- F-086 default
(3, 61, 255, 2, 9100030), -- F-086 default
(4, 22, 0, 2, 9100045), -- F-017_mod-zandalari-troll
(4, 22, 1, 2, 9100044), -- F-017_mod-zandalari-troll
(4, 22, 2, 2, 9100046), -- F-017_mod-zandalari-troll
(4, 22, 3, 2, 9100046), -- F-017_mod-zandalari-troll
(4, 22, 4, 2, 9100046), -- F-017_mod-zandalari-troll
(4, 22, 5, 2, 9100047), -- F-017_mod-zandalari-troll
(4, 22, 6, 2, 9100047), -- F-017_mod-zandalari-troll
(4, 25, 0, 2, 9100078), -- F-025_mod-kul-tiran
(4, 25, 1, 2, 9100079), -- F-025_mod-kul-tiran
(4, 25, 2, 2, 9100080), -- F-025_mod-kul-tiran
(4, 25, 3, 2, 9100080), -- F-025_mod-kul-tiran
(4, 25, 4, 2, 9100081), -- F-025_mod-kul-tiran
(4, 25, 5, 2, 9100081), -- F-025_mod-kul-tiran
(4, 25, 6, 2, 9100081), -- F-025_mod-kul-tiran
(5, 5, 0, 2, 9100084), -- F-011_mod-druid-forms
(5, 8, 0, 2, 9100006), -- F-084_troll_druid
(5, 8, 1, 2, 9100007), -- F-084_troll_druid
(5, 8, 2, 2, 9100007), -- F-084_troll_druid
(5, 8, 3, 2, 9100009), -- F-084_troll_druid
(5, 8, 4, 2, 9100005), -- F-084_troll_druid
(5, 8, 5, 2, 9100005), -- F-084_troll_druid
(5, 8, 6, 2, 9100005), -- F-084_troll_druid
(5, 8, 7, 2, 9100005), -- F-084_troll_druid
(5, 8, 8, 2, 9100008), -- F-084_troll_druid
(5, 8, 9, 2, 9100008), -- F-084_troll_druid
(5, 22, 0, 2, 9100033), -- F-017_mod-zandalari-troll
(5, 22, 1, 2, 9100032), -- F-017_mod-zandalari-troll
(5, 22, 2, 2, 9100034), -- F-017_mod-zandalari-troll
(5, 22, 3, 2, 9100034), -- F-017_mod-zandalari-troll
(5, 22, 4, 2, 9100034), -- F-017_mod-zandalari-troll
(5, 22, 5, 2, 9100035), -- F-017_mod-zandalari-troll
(5, 22, 6, 2, 9100035), -- F-017_mod-zandalari-troll
(5, 25, 0, 2, 9100058), -- F-025_mod-kul-tiran
(5, 25, 1, 2, 9100059), -- F-025_mod-kul-tiran
(5, 25, 2, 2, 9100060), -- F-025_mod-kul-tiran
(5, 25, 3, 2, 9100060), -- F-025_mod-kul-tiran
(5, 25, 4, 2, 9100061), -- F-025_mod-kul-tiran
(5, 25, 5, 2, 9100061), -- F-025_mod-kul-tiran
(5, 25, 6, 2, 9100061), -- F-025_mod-kul-tiran
(5, 46, 0, 2, 9100048), -- F-028_mod-highmountain-tauren
(5, 46, 1, 2, 9100049), -- F-028_mod-highmountain-tauren
(5, 46, 2, 2, 9100050), -- F-028_mod-highmountain-tauren
(5, 46, 3, 2, 9100051), -- F-028_mod-highmountain-tauren
(5, 46, 4, 2, 9100052), -- F-028_mod-highmountain-tauren
(8, 8, 0, 2, 9100006), -- F-084_troll_druid
(8, 8, 1, 2, 9100007), -- F-084_troll_druid
(8, 8, 2, 2, 9100007), -- F-084_troll_druid
(8, 8, 3, 2, 9100009), -- F-084_troll_druid
(8, 8, 4, 2, 9100005), -- F-084_troll_druid
(8, 8, 5, 2, 9100005), -- F-084_troll_druid
(8, 8, 6, 2, 9100005), -- F-084_troll_druid
(8, 8, 7, 2, 9100005), -- F-084_troll_druid
(8, 8, 8, 2, 9100008), -- F-084_troll_druid
(8, 8, 9, 2, 9100008), -- F-084_troll_druid
(8, 22, 0, 2, 9100033), -- F-017_mod-zandalari-troll
(8, 22, 1, 2, 9100032), -- F-017_mod-zandalari-troll
(8, 22, 2, 2, 9100034), -- F-017_mod-zandalari-troll
(8, 22, 3, 2, 9100034), -- F-017_mod-zandalari-troll
(8, 22, 4, 2, 9100034), -- F-017_mod-zandalari-troll
(8, 22, 5, 2, 9100035), -- F-017_mod-zandalari-troll
(8, 22, 6, 2, 9100035), -- F-017_mod-zandalari-troll
(8, 25, 0, 2, 9100058), -- F-025_mod-kul-tiran
(8, 25, 1, 2, 9100059), -- F-025_mod-kul-tiran
(8, 25, 2, 2, 9100060), -- F-025_mod-kul-tiran
(8, 25, 3, 2, 9100060), -- F-025_mod-kul-tiran
(8, 25, 4, 2, 9100061), -- F-025_mod-kul-tiran
(8, 25, 5, 2, 9100061), -- F-025_mod-kul-tiran
(8, 25, 6, 2, 9100061), -- F-025_mod-kul-tiran
(8, 46, 0, 2, 9100048), -- F-028_mod-highmountain-tauren
(8, 46, 1, 2, 9100049), -- F-028_mod-highmountain-tauren
(8, 46, 2, 2, 9100050), -- F-028_mod-highmountain-tauren
(8, 46, 3, 2, 9100051), -- F-028_mod-highmountain-tauren
(8, 46, 4, 2, 9100052), -- F-028_mod-highmountain-tauren
(27, 25, 0, 2, 9100066), -- F-025_mod-kul-tiran
(27, 25, 1, 2, 9100067), -- F-025_mod-kul-tiran
(27, 25, 2, 2, 9100068), -- F-025_mod-kul-tiran
(27, 25, 3, 2, 9100068), -- F-025_mod-kul-tiran
(27, 25, 4, 2, 9100069), -- F-025_mod-kul-tiran
(27, 25, 5, 2, 9100069), -- F-025_mod-kul-tiran
(27, 25, 6, 2, 9100069), -- F-025_mod-kul-tiran
(29, 25, 0, 2, 9100066), -- F-025_mod-kul-tiran
(29, 25, 1, 2, 9100067), -- F-025_mod-kul-tiran
(29, 25, 2, 2, 9100068), -- F-025_mod-kul-tiran
(29, 25, 3, 2, 9100068), -- F-025_mod-kul-tiran
(29, 25, 4, 2, 9100069), -- F-025_mod-kul-tiran
(29, 25, 5, 2, 9100069), -- F-025_mod-kul-tiran
(29, 25, 6, 2, 9100069), -- F-025_mod-kul-tiran
(31, 25, 0, 2, 9100070), -- F-025_mod-kul-tiran
(31, 25, 1, 2, 9100071), -- F-025_mod-kul-tiran
(31, 25, 2, 2, 9100072), -- F-025_mod-kul-tiran
(31, 25, 3, 2, 9100072), -- F-025_mod-kul-tiran
(31, 25, 4, 2, 9100073), -- F-025_mod-kul-tiran
(31, 25, 5, 2, 9100073), -- F-025_mod-kul-tiran
(31, 25, 6, 2, 9100073); -- F-025_mod-kul-tiran
REPLACE INTO `player_shapeshift_model` (`ShapeshiftID`, `RaceID`, `CustomizationID`, `GenderID`, `ModelID`) VALUES
(1, 10, 255, 2, 9100091), -- F-011_mod-druid-forms (was 892)
(2, 1, 255, 2, 9100022), -- F-085 default (was 864)
(2, 2, 255, 2, 9100022), -- F-085 default (was 864)
(2, 3, 255, 2, 9100022), -- F-085 default (was 864)
(2, 4, 255, 2, 9100022), -- F-085 (was 864)
(2, 6, 255, 2, 9100020), -- F-085 (was 864)
(2, 7, 255, 2, 9100088), -- F-011_mod-druid-forms (was 864)
(2, 8, 255, 2, 9100023), -- F-085 (was 864)
(2, 9, 255, 2, 9100022), -- F-085 default (was 864)
(2, 10, 255, 2, 9100022), -- F-085 default (was 864)
(2, 11, 255, 2, 9100022), -- F-085 default (was 864)
(2, 12, 255, 2, 9100021), -- F-085 (was 864)
(2, 14, 255, 2, 9100022), -- F-085 default (was 864)
(2, 15, 255, 2, 9100022), -- F-085 default (was 864)
(2, 16, 255, 2, 9100022), -- F-085 default (was 864)
(2, 18, 255, 2, 9100022), -- F-085 default (was 864)
(2, 19, 255, 2, 9100022), -- F-085 default (was 864)
(2, 20, 255, 2, 9100022), -- F-085 default (was 864)
(2, 21, 255, 2, 9100022), -- F-085 default (was 864)
(2, 22, 255, 2, 9100043), -- F-085 (was 864)
(2, 24, 255, 2, 9100022), -- F-085 default (was 864)
(2, 25, 255, 2, 9100082), -- F-085 (was 864)
(2, 26, 255, 2, 9100022), -- F-085 default (was 864)
(2, 27, 255, 2, 9100021), -- F-085 (was 864)
(2, 28, 255, 2, 9100022), -- F-085 default (was 864)
(2, 29, 255, 2, 9100022), -- F-085 default (was 864)
(2, 30, 255, 2, 9100022), -- F-085 default (was 864)
(2, 31, 255, 2, 9100022), -- F-085 default (was 864)
(2, 46, 255, 2, 9100020), -- F-085 (was 864)
(2, 47, 255, 2, 9100022), -- F-085 default (was 864)
(2, 50, 255, 2, 9100022), -- F-085 default (was 864)
(2, 51, 255, 2, 9100022), -- F-085 default (was 864)
(2, 52, 255, 2, 9100022), -- F-085 default (was 864)
(2, 53, 255, 2, 9100022), -- F-085 default (was 864)
(2, 54, 255, 2, 9100022), -- F-085 default (was 864)
(2, 55, 255, 2, 9100022), -- F-085 default (was 864)
(2, 56, 255, 2, 9100022), -- F-085 default (was 864)
(2, 62, 255, 2, 9100022), -- F-085 default (was 864)
(2, 63, 255, 2, 9100022), -- F-085 default (was 864)
(2, 64, 255, 2, 9100022), -- F-085 default (was 864)
(2, 65, 255, 2, 9100022), -- F-085 default (was 864)
(2, 66, 255, 2, 9100022), -- F-085 default (was 864)
(2, 67, 255, 2, 9100022), -- F-085 default (was 864)
(2, 68, 255, 2, 9100022), -- F-085 default (was 864)
(2, 69, 255, 2, 9100022), -- F-085 default (was 864)
(2, 70, 255, 2, 9100022), -- F-085 default (was 864)
(2, 71, 255, 2, 9100022), -- F-085 default (was 864)
(2, 72, 255, 2, 9100022), -- F-085 default (was 864)
(3, 1, 255, 2, 9100029), -- F-086 default (was 918)
(3, 2, 255, 2, 9100030), -- F-086 default (was 918)
(3, 3, 255, 2, 9100029), -- F-086 default (was 918)
(3, 4, 255, 2, 9100029), -- F-086 default (was 918)
(3, 5, 255, 2, 9100030), -- F-086 default (was 918)
(3, 6, 255, 2, 9100030), -- F-086 default (was 918)
(3, 7, 255, 2, 9100029), -- F-086 default (was 918)
(3, 8, 255, 2, 9100030), -- F-086 default (was 918)
(3, 9, 255, 2, 9100030), -- F-086 default (was 918)
(3, 10, 255, 2, 9100030), -- F-086 default (was 918)
(3, 11, 255, 2, 9100029), -- F-086 default (was 918)
(3, 12, 255, 2, 9100029), -- F-086 default (was 918)
(3, 14, 255, 2, 9100030), -- F-086 default (was 918)
(3, 15, 255, 2, 9100030), -- F-086 default (was 918)
(3, 16, 255, 2, 9100029), -- F-086 default (was 918)
(3, 18, 255, 2, 9100030), -- F-086 default (was 918)
(3, 19, 255, 2, 9100029), -- F-086 default (was 918)
(3, 20, 255, 2, 9100030), -- F-086 default (was 918)
(3, 21, 255, 2, 9100029), -- F-086 default (was 918)
(3, 22, 255, 2, 9100042), -- F-086 (was 918)
(3, 24, 255, 2, 9100029), -- F-086 default (was 918)
(3, 26, 255, 2, 9100030), -- F-086 default (was 918)
(3, 27, 255, 2, 9100029), -- F-086 default (was 918)
(3, 28, 255, 2, 9100030), -- F-086 default (was 918)
(3, 29, 255, 2, 9100029), -- F-086 default (was 918)
(3, 30, 255, 2, 9100029), -- F-086 default (was 918)
(3, 31, 255, 2, 9100030), -- F-086 default (was 918)
(3, 46, 255, 2, 9100030), -- F-086 default (was 918)
(3, 47, 255, 2, 9100029), -- F-086 default (was 918)
(3, 50, 255, 2, 9100029), -- F-086 default (was 918)
(3, 51, 255, 2, 9100030), -- F-086 default (was 918)
(3, 52, 255, 2, 9100029), -- F-086 default (was 918)
(3, 53, 255, 2, 9100030), -- F-086 default (was 918)
(3, 54, 255, 2, 9100030), -- F-086 default (was 918)
(3, 55, 255, 2, 9100029), -- F-086 default (was 918)
(3, 56, 255, 2, 9100029), -- F-086 default (was 918)
(3, 62, 255, 2, 9100029), -- F-086 default (was 918)
(3, 63, 255, 2, 9100030), -- F-086 default (was 918)
(3, 64, 255, 2, 9100030), -- F-086 default (was 918)
(3, 65, 255, 2, 9100029), -- F-086 default (was 918)
(3, 66, 255, 2, 9100030), -- F-086 default (was 918)
(3, 67, 255, 2, 9100029), -- F-086 default (was 918)
(3, 68, 255, 2, 9100030), -- F-086 default (was 918)
(3, 69, 255, 2, 9100029), -- F-086 default (was 918)
(3, 70, 255, 2, 9100030), -- F-086 default (was 918)
(3, 71, 255, 2, 9100030), -- F-086 default (was 918)
(3, 72, 255, 2, 9100029), -- F-086 default (was 918)
(4, 5, 255, 2, 9100086), -- F-011_mod-druid-forms (was 2428)
(4, 10, 255, 2, 9100094), -- F-011_mod-druid-forms (was 2428)
(4, 22, 255, 2, 9100046), -- F-017_mod-zandalari-troll (was 2428)
(5, 5, 255, 2, 9100083), -- F-011_mod-druid-forms (was 2281)
(5, 7, 255, 2, 23946), -- F-011_mod-druid-forms (was 2281)
(5, 22, 255, 2, 9100034), -- F-017_mod-zandalari-troll (was 2281)
(8, 7, 255, 2, 23946), -- F-011_mod-druid-forms (was 2281)
(8, 22, 255, 2, 9100034), -- F-017_mod-zandalari-troll (was 2281)
(27, 5, 255, 2, 10007), -- F-011_mod-druid-forms (was 21243)
(27, 8, 255, 2, 9100027), -- F-084_troll_druid (was 21243)
(27, 10, 255, 2, 9100093), -- F-011_mod-druid-forms (was 21243)
(27, 12, 255, 2, 9100026), -- F-024_mod-playable-worgen (was 21243)
(27, 22, 255, 2, 9100040), -- F-017_mod-zandalari-troll (was 21243)
(27, 46, 255, 2, 9100031), -- F-028_mod-highmountain-tauren (was 21243)
(29, 5, 255, 2, 10007), -- F-011_mod-druid-forms (was 20857)
(29, 8, 255, 2, 9100028), -- F-084_troll_druid (was 20857)
(29, 10, 255, 2, 9100092), -- F-011_mod-druid-forms (was 20857)
(29, 12, 255, 2, 9100026), -- F-024_mod-playable-worgen (was 20857)
(29, 22, 255, 2, 9100040), -- F-017_mod-zandalari-troll (was 20857)
(29, 46, 255, 2, 9100031), -- F-028_mod-highmountain-tauren (was 20857)
(31, 7, 255, 2, 24978), -- F-011_mod-druid-forms (was 15374)
(31, 12, 255, 2, 9100024); -- F-024_mod-playable-worgen (was 15374)
COMMIT;
