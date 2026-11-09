-- REVIEW ONLY: missing CoA spell_group memberships and stack rules for paired catalog spells.
-- Scope is restricted to spell IDs in the paired client manifest (Hero/CoA catalog).
-- Existing target group members are preserved; every delete below is limited to exact IDs/pairs.
-- Source: pinned CoA SQL update tree; no database queried or changed.
START TRANSACTION;
DELETE FROM `spell_group` WHERE `id` = 1029 AND `spell_id` IN (704994);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1029, 704994);
DELETE FROM `spell_group` WHERE `id` = 1033 AND `spell_id` IN (560288);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1033, 560288);
DELETE FROM `spell_group` WHERE `id` = 1039 AND `spell_id` IN (523485, 523510);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1039, 523485),
(1039, 523510);
DELETE FROM `spell_group` WHERE `id` = 1040 AND `spell_id` IN (680303, 706741);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1040, 680303),
(1040, 706741);
DELETE FROM `spell_group` WHERE `id` = 1041 AND `spell_id` IN (681442, 707684);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1041, 681442),
(1041, 707684);
DELETE FROM `spell_group` WHERE `id` = 1042 AND `spell_id` IN (561237, 561241);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1042, 561237),
(1042, 561241);
DELETE FROM `spell_group` WHERE `id` = 1043 AND `spell_id` IN (561236, 561242);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1043, 561236),
(1043, 561242);
DELETE FROM `spell_group` WHERE `id` = 1044 AND `spell_id` IN (560295, 561243);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1044, 560295),
(1044, 561243);
DELETE FROM `spell_group` WHERE `id` = 1078 AND `spell_id` IN (523478, 523495);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1078, 523478),
(1078, 523495);
DELETE FROM `spell_group` WHERE `id` = 1094 AND `spell_id` IN (504348);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1094, 504348);
DELETE FROM `spell_group` WHERE `id` = 1127 AND `spell_id` IN (574360, 800510, 801123, 801128, 802203, 805356);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1127, 574360),
(1127, 800510),
(1127, 801123),
(1127, 801128),
(1127, 802203),
(1127, 805356);
DELETE FROM `spell_group` WHERE `id` = 1128 AND `spell_id` IN (801441, 801461, 801463, 801466, 805423);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1128, 801441),
(1128, 801461),
(1128, 801463),
(1128, 801466),
(1128, 805423);
DELETE FROM `spell_group` WHERE `id` = 1129 AND `spell_id` IN (504296, 504849, 504897);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1129, 504296),
(1129, 504849),
(1129, 504897);
DELETE FROM `spell_group` WHERE `id` = 1130 AND `spell_id` IN (680388, 681460, 681529);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1130, 680388),
(1130, 681460),
(1130, 681529);
DELETE FROM `spell_group` WHERE `id` = 1131 AND `spell_id` IN (803489, 803491, 803719, 807435, 807547, 807749);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1131, 803489),
(1131, 803491),
(1131, 803719),
(1131, 807435),
(1131, 807547),
(1131, 807749);
DELETE FROM `spell_group` WHERE `id` = 1132 AND `spell_id` IN (500935, 500939, 500943, 504856, 800137);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1132, 500935),
(1132, 500939),
(1132, 500943),
(1132, 504856),
(1132, 800137);
DELETE FROM `spell_group` WHERE `id` = 1133 AND `spell_id` IN (704540, 705070, 705156, 805442, 806124);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1133, 704540),
(1133, 705070),
(1133, 705156),
(1133, 805442),
(1133, 806124);
DELETE FROM `spell_group` WHERE `id` = 1134 AND `spell_id` IN (680491, 802276, 802277, 802278, 802279, 803535);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1134, 680491),
(1134, 802276),
(1134, 802277),
(1134, 802278),
(1134, 802279),
(1134, 803535);
DELETE FROM `spell_group` WHERE `id` = 1135 AND `spell_id` IN (572391, 572396, 680307, 801523);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1135, 572391),
(1135, 572396),
(1135, 680307),
(1135, 801523);
DELETE FROM `spell_group` WHERE `id` = 1136 AND `spell_id` IN (680315, 706742, 803658, 803665);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1136, 680315),
(1136, 706742),
(1136, 803658),
(1136, 803665);
DELETE FROM `spell_group` WHERE `id` = 1137 AND `spell_id` IN (500982, 500983, 500985);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1137, 500982),
(1137, 500983),
(1137, 500985);
DELETE FROM `spell_group` WHERE `id` = 1138 AND `spell_id` IN (680312, 707689, 712459, 803177, 803651, 803657);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1138, 680312),
(1138, 707689),
(1138, 712459),
(1138, 803177),
(1138, 803651),
(1138, 803657);
DELETE FROM `spell_group` WHERE `id` = 1139 AND `spell_id` IN (523485, 523510, 680303, 681442, 706741, 707684);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1139, 523485),
(1139, 523510),
(1139, 680303),
(1139, 681442),
(1139, 706741),
(1139, 707684);
DELETE FROM `spell_group` WHERE `id` = 1140 AND `spell_id` IN (560295, 561236, 561237, 561241, 561242, 561243);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1140, 560295),
(1140, 561236),
(1140, 561237),
(1140, 561241),
(1140, 561242),
(1140, 561243);
DELETE FROM `spell_group` WHERE `id` = 1150 AND `spell_id` IN (300255, 680301);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1150, 300255),
(1150, 680301);
DELETE FROM `spell_group` WHERE `id` = 1151 AND `spell_id` IN (573343, 573348);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1151, 573343),
(1151, 573348);
DELETE FROM `spell_group` WHERE `id` = 1152 AND `spell_id` IN (804435, 804436, 804438, 806203);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1152, 804435),
(1152, 804436),
(1152, 804438),
(1152, 806203);
DELETE FROM `spell_group` WHERE `id` = 1153 AND `spell_id` IN (520307, 800841, 800912, 803183, 803212, 804980);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1153, 520307),
(1153, 800841),
(1153, 800912),
(1153, 803183),
(1153, 803212),
(1153, 804980);
DELETE FROM `spell_group` WHERE `id` = 1154 AND `spell_id` IN (680308, 800212);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1154, 680308),
(1154, 800212);
DELETE FROM `spell_group` WHERE `id` = 1160 AND `spell_id` IN (300916, 300917, 300918, 300919, 300923, 572629, 572630, 680306, 706634);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1160, 300916),
(1160, 300917),
(1160, 300918),
(1160, 300919),
(1160, 300923),
(1160, 572629),
(1160, 572630),
(1160, 680306),
(1160, 706634);
DELETE FROM `spell_group` WHERE `id` = 1170 AND `spell_id` IN (572399, 803563, 803564, 803565);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1170, 572399),
(1170, 803563),
(1170, 803564),
(1170, 803565);
DELETE FROM `spell_group` WHERE `id` = 1171 AND `spell_id` IN (503319, 503320, 503321, 503322, 503323, 578311, 578312, 578313, 578314, 578315, 804018);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1171, 503319),
(1171, 503320),
(1171, 503321),
(1171, 503322),
(1171, 503323),
(1171, 578311),
(1171, 578312),
(1171, 578313),
(1171, 578314),
(1171, 578315),
(1171, 804018);
DELETE FROM `spell_group` WHERE `id` = 1210 AND `spell_id` IN (300857, 300882, 300883, 300884, 300885, 300886, 680302, 681439, 681440, 681441);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1210, 300857),
(1210, 300882),
(1210, 300883),
(1210, 300884),
(1210, 300885),
(1210, 300886),
(1210, 680302),
(1210, 681439),
(1210, 681440),
(1210, 681441);
DELETE FROM `spell_group` WHERE `id` = 103955 AND `spell_id` IN (572810, 572817, 680310, 800197);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(103955, 572810),
(103955, 572817),
(103955, 680310),
(103955, 800197);
DELETE FROM `spell_group` WHERE `id` = 111001 AND `spell_id` IN (801094, 801106, 801107, 802630, 803748, 807834);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(111001, 801094),
(111001, 801106),
(111001, 801107),
(111001, 802630),
(111001, 803748),
(111001, 807834);
DELETE FROM `spell_group` WHERE `id` = 111010 AND `spell_id` IN (680282, 680316, 680334);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(111010, 680282),
(111010, 680316),
(111010, 680334);
DELETE FROM `spell_group` WHERE `id` = 2000180 AND `spell_id` IN (300871, 524854, 560001, 560531, 560550, 560593, 704994, 706633, 712367, 804730);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2000180, 300871),
(2000180, 524854),
(2000180, 560001),
(2000180, 560531),
(2000180, 560550),
(2000180, 560593),
(2000180, 704994),
(2000180, 706633),
(2000180, 712367),
(2000180, 804730);
DELETE FROM `spell_group` WHERE `id` = 2000181 AND `spell_id` IN (300565, 300873, 300877, 300879, 300889, 300958, 300968, 301974, 500264, 520372, 560533, 560535, 560539, 560568, 560821, 680709, 800031);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2000181, 300565),
(2000181, 300873),
(2000181, 300877),
(2000181, 300879),
(2000181, 300889),
(2000181, 300958),
(2000181, 300968),
(2000181, 301974),
(2000181, 500264),
(2000181, 520372),
(2000181, 560533),
(2000181, 560535),
(2000181, 560539),
(2000181, 560568),
(2000181, 560821),
(2000181, 680709),
(2000181, 800031);
DELETE FROM `spell_group` WHERE `id` = 2000182 AND `spell_id` IN (300872, 300876, 300957, 300959, 503707, 560525, 560526, 560527, 560537, 560540, 560541, 560542, 560549, 560946, 567572, 680476, 704644, 705031, 706632, 800704, 804257, 804731);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2000182, 300872),
(2000182, 300876),
(2000182, 300957),
(2000182, 300959),
(2000182, 503707),
(2000182, 560525),
(2000182, 560526),
(2000182, 560527),
(2000182, 560537),
(2000182, 560540),
(2000182, 560541),
(2000182, 560542),
(2000182, 560549),
(2000182, 560946),
(2000182, 567572),
(2000182, 680476),
(2000182, 704644),
(2000182, 705031),
(2000182, 706632),
(2000182, 800704),
(2000182, 804257),
(2000182, 804731);
DELETE FROM `spell_group` WHERE `id` = 2000183 AND `spell_id` IN (500069, 504159, 704632, 803511, 805443, 805888);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2000183, 500069),
(2000183, 504159),
(2000183, 704632),
(2000183, 803511),
(2000183, 805443),
(2000183, 805888);
DELETE FROM `spell_group` WHERE `id` = 2000184 AND `spell_id` IN (300929, 300944, 300961, 300963, 503738, 520371, 560528, 560534, 560545);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2000184, 300929),
(2000184, 300944),
(2000184, 300961),
(2000184, 300963),
(2000184, 503738),
(2000184, 520371),
(2000184, 560528),
(2000184, 560534),
(2000184, 560545);
DELETE FROM `spell_group` WHERE `id` = 2000185 AND `spell_id` IN (300974, 560002, 704434, 704785);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2000185, 300974),
(2000185, 560002),
(2000185, 704434),
(2000185, 704785);
DELETE FROM `spell_group` WHERE `id` = 2000200 AND `spell_id` IN (300730, 685028, 705094, 707541, 707547, 807460);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2000200, 300730),
(2000200, 685028),
(2000200, 705094),
(2000200, 707541),
(2000200, 707547),
(2000200, 807460);
DELETE FROM `spell_group` WHERE `id` = 2100001 AND `spell_id` IN (575839, 575842, 578126, 578130, 680298, 800198);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2100001, 575839),
(2100001, 575842),
(2100001, 578126),
(2100001, 578130),
(2100001, 680298),
(2100001, 800198);
DELETE FROM `spell_group` WHERE `id` = 2100002 AND `spell_id` IN (523489, 523513);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2100002, 523489),
(2100002, 523513);
DELETE FROM `spell_group` WHERE `id` = 2100003 AND `spell_id` IN (680294, 800266);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2100003, 680294),
(2100003, 800266);
DELETE FROM `spell_group` WHERE `id` = 2104883 AND `spell_id` IN (803649, 808060);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2104883, 803649),
(2104883, 808060);
DELETE FROM `spell_group` WHERE `id` = 2106086 AND `spell_id` IN (680286, 800199);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2106086, 680286),
(2106086, 800199);
DELETE FROM `spell_group` WHERE `id` = 2106087 AND `spell_id` IN (572787, 572790);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2106087, 572787),
(2106087, 572790);
DELETE FROM `spell_group` WHERE `id` = 2106088 AND `spell_id` IN (500967, 572214);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(2106088, 500967),
(2106088, 572214);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1039;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1039, 1, 'Local CoA: Knight\'s Edict and Greater Knight\'s Edict');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1040;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1040, 1, 'Local CoA: Inquisitor\'s Edict and Greater Inquisitor\'s Edict');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1041;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1041, 1, 'Local CoA: Witching Edict and Greater Witching Edict');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1042;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1042, 1, 'Local CoA: Etching of the Dextrous and its Greater version');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1043;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1043, 1, 'Local CoA: Etching of the Leylines and its Greater version');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1044;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1044, 1, 'Local CoA: Etching of the Magi and its Greater version');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1127;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1127, 2, 'Local Starcaller: one active Aspect per caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1128;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1128, 2, 'Local Templar: one active Libram per caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1129;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1129, 2, 'Local Bloodmage: one active Shield per caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1130;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1130, 2, 'Local Necromancer: one active Ward per caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1131;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1131, 2, 'Local Sun Cleric: one active Vow per caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1132;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1132, 2, 'Local Primalist: one active Boon per caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1133;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1133, 4, 'Local CoA: strongest common raid attack and spell power buff');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1134;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1134, 2, 'Local CoA: one active Witch Hunter Tonic');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1135;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1135, 2, 'Local CoA: one Chronomancer Wisdom per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1136;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1136, 2, 'Local CoA: one Tinker Module per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1137;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1137, 2, 'Necromancer: one active Undead Stance per caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1138;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1138, 2, 'Local CoA: one Venomancer Pheromone per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1139;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1139, 2, 'Local CoA: one Witch Hunter Edict per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1140;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1140, 2, 'Local CoA: one Runemaster Etching per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1150;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1150, 2, 'Local CoA: one Celestial Mind per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1151;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1151, 2, 'Local CoA: one Arcane Protection per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1152;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1152, 2, 'Local Chronomancer: one active Continuum spell per caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1153;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (1153, 1);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1154;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1154, 2, 'Local CoA: one Illidari Intuition per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1160;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1160, 2, 'Local CoA: Templar Gift of Fervor/Gift of Zeal and their raid versions are mutually exclusive per caster (#4449)');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1170;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1170, 2, 'Local CoA: one Stormbringer Pressure aura per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1171;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1171, 2, 'Local CoA: one Stormbringer Call (of the Storm or Wind) per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1210;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (1210, 2, 'Local CoA: one Barbarian shout (Brutal or Enduring) per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 103955;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (103955, 2, 'Primalist: one Instinct per caster on each recipient');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 111001;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (111001, 1, 'Runemaster: one active Runic Tattoo');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 111010;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (111010, 2, 'Stormbringer Aegis - exclusive from same caster');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2000180;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2000180, 3);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2000181;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2000181, 3);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2000182;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2000182, 3);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2000183;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2000183, 3);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2000184;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES (2000184, 3, 'Local CoA: only the strongest raid damage percent aura applies');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2000185;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2000185, 3);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2000200;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2000200, 3);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2100001;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2100001, 1);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2100002;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2100002, 4);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2100003;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2100003, 4);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2104883;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2104883, 4);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2106086;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2106086, 4);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2106087;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2106087, 4);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 2106088;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (2106088, 4);
COMMIT;
