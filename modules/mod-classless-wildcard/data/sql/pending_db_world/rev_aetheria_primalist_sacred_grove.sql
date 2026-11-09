-- Hero-only Sacred Grove handlers and source coefficients.
-- Source: CoA pending_db_world rev_1789953855057652300.sql.
-- Preview migration only; inspect live rows before applying.

START TRANSACTION;

DELETE FROM `spell_script_names`
WHERE (`spell_id` = 800180 AND `ScriptName` = 'aura_ascension_sacred_grove')
    OR (`spell_id` = 800179 AND `ScriptName` = 'spell_ascension_sacred_grove_recovery');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800180, 'aura_ascension_sacred_grove'),
(800179, 'spell_ascension_sacred_grove_recovery');

DELETE FROM `spell_bonus_data` WHERE `entry` IN (800180, 800179);
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(800180, 0, 0, 1, 0, 'Sacred Grove instant heal: one hundred percent AP'),
(800179, 0, 0, 0, 0, 'Sacred Grove: three percent missing health, Mana and Rage');

COMMIT;
