-- Boulder Dash helper links and damage coefficients, adapted from the staged CoA source SQL.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 500692 AND `spell_effect` IN (680473, 681302, 500693);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(500692, 680473, 2, 'Primalist Boulder Dash helper'),
(500692, 681302, 2, 'Primalist Boulder Dash helper'),
(500692, 500693, 2, 'Primalist Boulder Dash helper');

DELETE FROM `spell_bonus_data` WHERE `entry` = 500693;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(500693, 1, 0, 0.5, 0, 'Hero Primalist - Boulder Dash damage per enemy rolled over');
