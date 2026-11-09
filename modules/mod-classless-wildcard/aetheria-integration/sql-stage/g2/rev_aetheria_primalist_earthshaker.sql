-- Earthshaker (#1732): physical Seismic periodic damage uses Nature spell critical chance.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-803981, -680442)
AND `ScriptName` = 'aura_ascension_earthshaker_periodic';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-803981, 'aura_ascension_earthshaker_periodic'),
(-680442, 'aura_ascension_earthshaker_periodic');
