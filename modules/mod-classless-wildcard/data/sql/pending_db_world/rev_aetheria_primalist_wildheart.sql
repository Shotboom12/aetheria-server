-- Wildheart cooldown reduction and missing-resource recovery, gated to Hero Primalists.
DELETE FROM `spell_script_names` WHERE (`spell_id` = 803980 AND `ScriptName` = 'aura_ascension_wildheart') OR (`spell_id` = 810040 AND `ScriptName` = 'spell_ascension_wildheart_recovery');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803980, 'aura_ascension_wildheart'),
(810040, 'spell_ascension_wildheart_recovery');

DELETE FROM `spell_bonus_data` WHERE `entry` = 810040;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(810040, 0, 0, 0, 0, 'Hero Primalist - Wildheart recovery is based on missing resources');
