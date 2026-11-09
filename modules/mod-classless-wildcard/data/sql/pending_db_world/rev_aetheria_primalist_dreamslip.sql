-- Dreamslip native pacify/silence and recovery, gated to the Hero's own Primalist aura.
DELETE FROM `spell_script_names` WHERE `spell_id` = 805867 AND `ScriptName` = 'aura_ascension_dreamslip';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (805867, 'aura_ascension_dreamslip');
