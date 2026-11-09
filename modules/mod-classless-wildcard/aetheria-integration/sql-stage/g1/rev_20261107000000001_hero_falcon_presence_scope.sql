-- Stage a scoped script binding; live rows must be backed up and checked before applying.
DELETE FROM `spell_script_names`
    WHERE `spell_id` = 680278 AND `ScriptName` = 'aura_aetheria_hero_falcon_presence';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
    (680278, 'aura_aetheria_hero_falcon_presence');
