-- CoA: restore Bloodmoon Blast's advertised spell power coefficient; rank lookup uses chain head 500125.
DELETE FROM `spell_bonus_data` WHERE `entry` = 500125;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`)
VALUES (500125, 0.466229, 0, 0, 0, 'CoA Bloodmoon Blast spell power coefficient');
