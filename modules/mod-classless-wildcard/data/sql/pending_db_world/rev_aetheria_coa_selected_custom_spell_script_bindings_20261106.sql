-- Materialized exact spell_script_names pairs for selected CoA scripts from the pinned CoA SQL state.
-- Source: Conquest-of-AzerothCore/azerothcore-wotlk-coa at 2f823e28dff86e3c1affb435b3a7f88607e9f01e.
-- Scope: positive custom spell IDs present in generated cw_spells_coa.sql; stock/negative-ID
-- overrides are handled separately so their Hero-only behavior can be reviewed explicitly.
-- Existing active exact pairs are preserved; each insert below first deletes only its exact pair set.

-- aura_ascension_ahead_of_the_game
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ahead_of_the_game'
    AND `spell_id` IN (
        560948
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560948, 'aura_ascension_ahead_of_the_game');

-- aura_ascension_air_invigoration
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_air_invigoration'
    AND `spell_id` IN (
        806020
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806020, 'aura_ascension_air_invigoration');

-- aura_ascension_ancestral_evolution
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ancestral_evolution'
    AND `spell_id` IN (
        806229
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806229, 'aura_ascension_ancestral_evolution');

-- aura_ascension_backtrack
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_backtrack'
    AND `spell_id` IN (
        706973
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706973, 'aura_ascension_backtrack');

-- aura_ascension_barbarian_bleed
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_barbarian_bleed'
    AND `spell_id` IN (
        300870, 782801, 783054
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300870, 'aura_ascension_barbarian_bleed'),
(782801, 'aura_ascension_barbarian_bleed'),
(783054, 'aura_ascension_barbarian_bleed');

-- aura_ascension_barbarian_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_barbarian_event'
    AND `spell_id` IN (
        300499, 500061, 520539, 560364, 560450, 560586, 560880, 560939, 561332, 561360, 561397, 573064,
        573077, 573224, 573225, 573256, 704240, 705158, 705162, 705211, 705214, 705238, 705240, 706354,
        706804, 706821, 707389, 707764, 712468, 712673, 800131, 800943, 801549, 801759, 801782, 803499,
        804141, 804745, 804746, 805780, 805804, 805811, 805821, 805893, 805997, 807861
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300499, 'aura_ascension_barbarian_event'),
(500061, 'aura_ascension_barbarian_event'),
(520539, 'aura_ascension_barbarian_event'),
(560364, 'aura_ascension_barbarian_event'),
(560450, 'aura_ascension_barbarian_event'),
(560586, 'aura_ascension_barbarian_event'),
(560880, 'aura_ascension_barbarian_event'),
(560939, 'aura_ascension_barbarian_event'),
(561332, 'aura_ascension_barbarian_event'),
(561360, 'aura_ascension_barbarian_event'),
(561397, 'aura_ascension_barbarian_event'),
(573064, 'aura_ascension_barbarian_event'),
(573077, 'aura_ascension_barbarian_event'),
(573224, 'aura_ascension_barbarian_event'),
(573225, 'aura_ascension_barbarian_event'),
(573256, 'aura_ascension_barbarian_event'),
(704240, 'aura_ascension_barbarian_event'),
(705158, 'aura_ascension_barbarian_event'),
(705162, 'aura_ascension_barbarian_event'),
(705211, 'aura_ascension_barbarian_event'),
(705214, 'aura_ascension_barbarian_event'),
(705238, 'aura_ascension_barbarian_event'),
(705240, 'aura_ascension_barbarian_event'),
(706354, 'aura_ascension_barbarian_event'),
(706804, 'aura_ascension_barbarian_event'),
(706821, 'aura_ascension_barbarian_event'),
(707389, 'aura_ascension_barbarian_event'),
(707764, 'aura_ascension_barbarian_event'),
(712468, 'aura_ascension_barbarian_event'),
(712673, 'aura_ascension_barbarian_event'),
(800131, 'aura_ascension_barbarian_event'),
(800943, 'aura_ascension_barbarian_event'),
(801549, 'aura_ascension_barbarian_event'),
(801759, 'aura_ascension_barbarian_event'),
(801782, 'aura_ascension_barbarian_event'),
(803499, 'aura_ascension_barbarian_event'),
(804141, 'aura_ascension_barbarian_event'),
(804745, 'aura_ascension_barbarian_event'),
(804746, 'aura_ascension_barbarian_event'),
(805780, 'aura_ascension_barbarian_event'),
(805804, 'aura_ascension_barbarian_event'),
(805811, 'aura_ascension_barbarian_event'),
(805821, 'aura_ascension_barbarian_event'),
(805893, 'aura_ascension_barbarian_event'),
(805997, 'aura_ascension_barbarian_event'),
(807861, 'aura_ascension_barbarian_event');

-- aura_ascension_barbarian_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_barbarian_lifecycle'
    AND `spell_id` IN (
        355562, 560521, 560933, 705198, 706487, 707410, 707763, 707764, 707775, 712467, 712468, 800637,
        801761, 804141, 805804, 805832, 806882, 806883, 806884, 806885, 806886, 806887
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(355562, 'aura_ascension_barbarian_lifecycle'),
(560521, 'aura_ascension_barbarian_lifecycle'),
(560933, 'aura_ascension_barbarian_lifecycle'),
(705198, 'aura_ascension_barbarian_lifecycle'),
(706487, 'aura_ascension_barbarian_lifecycle'),
(707410, 'aura_ascension_barbarian_lifecycle'),
(707763, 'aura_ascension_barbarian_lifecycle'),
(707764, 'aura_ascension_barbarian_lifecycle'),
(707775, 'aura_ascension_barbarian_lifecycle'),
(712467, 'aura_ascension_barbarian_lifecycle'),
(712468, 'aura_ascension_barbarian_lifecycle'),
(800637, 'aura_ascension_barbarian_lifecycle'),
(801761, 'aura_ascension_barbarian_lifecycle'),
(804141, 'aura_ascension_barbarian_lifecycle'),
(805804, 'aura_ascension_barbarian_lifecycle'),
(805832, 'aura_ascension_barbarian_lifecycle'),
(806882, 'aura_ascension_barbarian_lifecycle'),
(806883, 'aura_ascension_barbarian_lifecycle'),
(806884, 'aura_ascension_barbarian_lifecycle'),
(806885, 'aura_ascension_barbarian_lifecycle'),
(806886, 'aura_ascension_barbarian_lifecycle'),
(806887, 'aura_ascension_barbarian_lifecycle');

-- aura_ascension_barbarian_tankard
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_barbarian_tankard'
    AND `spell_id` IN (
        805813
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805813, 'aura_ascension_barbarian_tankard');

-- aura_ascension_barbarian_volley
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_barbarian_volley'
    AND `spell_id` IN (
        707584, 807482
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707584, 'aura_ascension_barbarian_volley'),
(807482, 'aura_ascension_barbarian_volley');

-- aura_ascension_barometric_pressure
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_barometric_pressure'
    AND `spell_id` IN (
        803563
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803563, 'aura_ascension_barometric_pressure');

-- aura_ascension_battle_cleric
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_battle_cleric'
    AND `spell_id` IN (
        300347, 680639
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300347, 'aura_ascension_battle_cleric'),
(680639, 'aura_ascension_battle_cleric');

-- aura_ascension_blood_veil
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_blood_veil'
    AND `spell_id` IN (
        504263, 572277, 572278, 572279
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504263, 'aura_ascension_blood_veil'),
(572277, 'aura_ascension_blood_veil'),
(572278, 'aura_ascension_blood_veil'),
(572279, 'aura_ascension_blood_veil');

-- aura_ascension_bloodmage_atheranns_anguish
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_atheranns_anguish'
    AND `spell_id` IN (
        680680
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680680, 'aura_ascension_bloodmage_atheranns_anguish');

-- aura_ascension_bloodmage_bite_wound
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_bite_wound'
    AND `spell_id` IN (
        706654
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706654, 'aura_ascension_bloodmage_bite_wound');

-- aura_ascension_bloodmage_blood_bond
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_blood_bond'
    AND `spell_id` IN (
        504627
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504627, 'aura_ascension_bloodmage_blood_bond');

-- aura_ascension_bloodmage_blood_moon
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_blood_moon'
    AND `spell_id` IN (
        707623
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707623, 'aura_ascension_bloodmage_blood_moon');

-- aura_ascension_bloodmage_blood_scent
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_blood_scent'
    AND `spell_id` IN (
        804223
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804223, 'aura_ascension_bloodmage_blood_scent');

-- aura_ascension_bloodmage_blood_shard_counter
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_blood_shard_counter'
    AND `spell_id` IN (
        505366
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(505366, 'aura_ascension_bloodmage_blood_shard_counter');

-- aura_ascension_bloodmage_blood_shard_expiry
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_blood_shard_expiry'
    AND `spell_id` IN (
        505349
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(505349, 'aura_ascension_bloodmage_blood_shard_expiry');

-- aura_ascension_bloodmage_cardiac_arrest
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_cardiac_arrest'
    AND `spell_id` IN (
        806944
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806944, 'aura_ascension_bloodmage_cardiac_arrest');

-- aura_ascension_bloodmage_coagulation
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_coagulation'
    AND `spell_id` IN (
        706258
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706258, 'aura_ascension_bloodmage_coagulation');

-- aura_ascension_bloodmage_crimson_feast
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_crimson_feast'
    AND `spell_id` IN (
        804602
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804602, 'aura_ascension_bloodmage_crimson_feast');

-- aura_ascension_bloodmage_cursed_blood
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_cursed_blood'
    AND `spell_id` IN (
        707435
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707435, 'aura_ascension_bloodmage_cursed_blood');

-- aura_ascension_bloodmage_dark_sigil
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_dark_sigil'
    AND `spell_id` IN (
        560535
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560535, 'aura_ascension_bloodmage_dark_sigil');

-- aura_ascension_bloodmage_essence_harvester
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_essence_harvester'
    AND `spell_id` IN (
        806421
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806421, 'aura_ascension_bloodmage_essence_harvester');

-- aura_ascension_bloodmage_forbidden_power
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_forbidden_power'
    AND `spell_id` IN (
        500447
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500447, 'aura_ascension_bloodmage_forbidden_power');

-- aura_ascension_bloodmage_grim_omen
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_grim_omen'
    AND `spell_id` IN (
        800154
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800154, 'aura_ascension_bloodmage_grim_omen');

-- aura_ascension_bloodmage_hemal_excision
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_hemal_excision'
    AND `spell_id` IN (
        803734
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803734, 'aura_ascension_bloodmage_hemal_excision');

-- aura_ascension_bloodmage_infection
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_infection'
    AND `spell_id` IN (
        704624
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704624, 'aura_ascension_bloodmage_infection');

-- aura_ascension_bloodmage_infuse
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_infuse'
    AND `spell_id` IN (
        681403
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681403, 'aura_ascension_bloodmage_infuse');

-- aura_ascension_bloodmage_malediction
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_malediction'
    AND `spell_id` IN (
        704120
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704120, 'aura_ascension_bloodmage_malediction');

-- aura_ascension_bloodmage_night_stalker
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_night_stalker'
    AND `spell_id` IN (
        807774
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807774, 'aura_ascension_bloodmage_night_stalker');

-- aura_ascension_bloodmage_packleader
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_packleader'
    AND `spell_id` IN (
        504290
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504290, 'aura_ascension_bloodmage_packleader');

-- aura_ascension_bloodmage_sacrificial_rite
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_sacrificial_rite'
    AND `spell_id` IN (
        800785
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800785, 'aura_ascension_bloodmage_sacrificial_rite');

-- aura_ascension_bloodmage_sanguine_essence
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_sanguine_essence'
    AND `spell_id` IN (
        680692
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680692, 'aura_ascension_bloodmage_sanguine_essence');

-- aura_ascension_bloodmage_taldarams_torment
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_taldarams_torment'
    AND `spell_id` IN (
        802568, 802569, 802570, 802571, 802572, 802573, 802580
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802568, 'aura_ascension_bloodmage_taldarams_torment'),
(802569, 'aura_ascension_bloodmage_taldarams_torment'),
(802570, 'aura_ascension_bloodmage_taldarams_torment'),
(802571, 'aura_ascension_bloodmage_taldarams_torment'),
(802572, 'aura_ascension_bloodmage_taldarams_torment'),
(802573, 'aura_ascension_bloodmage_taldarams_torment'),
(802580, 'aura_ascension_bloodmage_taldarams_torment');

-- aura_ascension_bloodmage_thick_pelt
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_thick_pelt'
    AND `spell_id` IN (
        556233
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(556233, 'aura_ascension_bloodmage_thick_pelt');

-- aura_ascension_bloodmage_thirst_for_blood
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_thirst_for_blood'
    AND `spell_id` IN (
        570023
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(570023, 'aura_ascension_bloodmage_thirst_for_blood');

-- aura_ascension_bloodmage_thirst_rage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_bloodmage_thirst_rage'
    AND `spell_id` IN (
        706613
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706613, 'aura_ascension_bloodmage_thirst_rage');

-- aura_ascension_borrowed_time
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_borrowed_time'
    AND `spell_id` IN (
        680373
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680373, 'aura_ascension_borrowed_time');

-- aura_ascension_champion_of_the_sun_arrival
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_champion_of_the_sun_arrival'
    AND `spell_id` IN (
        800612
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800612, 'aura_ascension_champion_of_the_sun_arrival');

-- aura_ascension_charged_conduit
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_charged_conduit'
    AND `spell_id` IN (
        803790
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803790, 'aura_ascension_charged_conduit');

-- aura_ascension_crimson_thirst
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_crimson_thirst'
    AND `spell_id` IN (
        807415
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807415, 'aura_ascension_crimson_thirst');

-- aura_ascension_cultist_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_cultist_event'
    AND `spell_id` IN (
        255283, 300278, 300280, 300286, 300295, 300300, 300308, 300313, 301262, 500719, 500721, 500767,
        504642, 520388, 520405, 524887, 525065, 525078, 525307, 560091, 560320, 560715, 561336, 570246,
        570247, 570248, 570249, 570250, 570251, 570252, 570253, 570254, 570255, 570256, 570257, 570258,
        570259, 570260, 570261, 570262, 570264, 570265, 570266, 570267, 570268, 570269, 572064, 574318,
        600327, 680508, 680579, 680581, 681425, 681474, 704527, 704871, 706182, 706245, 706911, 706926,
        707640, 707749, 707785, 800463, 802043, 803035, 803037, 803082, 803339, 805110, 805606, 807307
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(255283, 'aura_ascension_cultist_event'),
(300278, 'aura_ascension_cultist_event'),
(300280, 'aura_ascension_cultist_event'),
(300286, 'aura_ascension_cultist_event'),
(300295, 'aura_ascension_cultist_event'),
(300300, 'aura_ascension_cultist_event'),
(300308, 'aura_ascension_cultist_event'),
(300313, 'aura_ascension_cultist_event'),
(301262, 'aura_ascension_cultist_event'),
(500719, 'aura_ascension_cultist_event'),
(500721, 'aura_ascension_cultist_event'),
(500767, 'aura_ascension_cultist_event'),
(504642, 'aura_ascension_cultist_event'),
(520388, 'aura_ascension_cultist_event'),
(520405, 'aura_ascension_cultist_event'),
(524887, 'aura_ascension_cultist_event'),
(525065, 'aura_ascension_cultist_event'),
(525078, 'aura_ascension_cultist_event'),
(525307, 'aura_ascension_cultist_event'),
(560091, 'aura_ascension_cultist_event'),
(560320, 'aura_ascension_cultist_event'),
(560715, 'aura_ascension_cultist_event'),
(561336, 'aura_ascension_cultist_event'),
(570246, 'aura_ascension_cultist_event'),
(570247, 'aura_ascension_cultist_event'),
(570248, 'aura_ascension_cultist_event'),
(570249, 'aura_ascension_cultist_event'),
(570250, 'aura_ascension_cultist_event'),
(570251, 'aura_ascension_cultist_event'),
(570252, 'aura_ascension_cultist_event'),
(570253, 'aura_ascension_cultist_event'),
(570254, 'aura_ascension_cultist_event'),
(570255, 'aura_ascension_cultist_event'),
(570256, 'aura_ascension_cultist_event'),
(570257, 'aura_ascension_cultist_event'),
(570258, 'aura_ascension_cultist_event'),
(570259, 'aura_ascension_cultist_event'),
(570260, 'aura_ascension_cultist_event'),
(570261, 'aura_ascension_cultist_event'),
(570262, 'aura_ascension_cultist_event'),
(570264, 'aura_ascension_cultist_event'),
(570265, 'aura_ascension_cultist_event'),
(570266, 'aura_ascension_cultist_event'),
(570267, 'aura_ascension_cultist_event'),
(570268, 'aura_ascension_cultist_event'),
(570269, 'aura_ascension_cultist_event'),
(572064, 'aura_ascension_cultist_event'),
(574318, 'aura_ascension_cultist_event'),
(600327, 'aura_ascension_cultist_event'),
(680508, 'aura_ascension_cultist_event'),
(680579, 'aura_ascension_cultist_event'),
(680581, 'aura_ascension_cultist_event'),
(681425, 'aura_ascension_cultist_event'),
(681474, 'aura_ascension_cultist_event'),
(704527, 'aura_ascension_cultist_event'),
(704871, 'aura_ascension_cultist_event'),
(706182, 'aura_ascension_cultist_event'),
(706245, 'aura_ascension_cultist_event'),
(706911, 'aura_ascension_cultist_event'),
(706926, 'aura_ascension_cultist_event'),
(707640, 'aura_ascension_cultist_event'),
(707749, 'aura_ascension_cultist_event'),
(707785, 'aura_ascension_cultist_event'),
(800463, 'aura_ascension_cultist_event'),
(802043, 'aura_ascension_cultist_event'),
(803035, 'aura_ascension_cultist_event'),
(803037, 'aura_ascension_cultist_event'),
(803082, 'aura_ascension_cultist_event'),
(803339, 'aura_ascension_cultist_event'),
(805110, 'aura_ascension_cultist_event'),
(805606, 'aura_ascension_cultist_event'),
(807307, 'aura_ascension_cultist_event');

-- aura_ascension_cultist_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_cultist_lifecycle'
    AND `spell_id` IN (
        92130, 255070, 255281, 255283, 300277, 300287, 300290, 301186, 301259, 500706, 500715, 500727,
        500751, 502133, 502244, 502245, 502246, 502247, 502267, 502268, 502269, 502270, 502271, 502272,
        502273, 502274, 502275, 520326, 520345, 520346, 520388, 520450, 520497, 561288, 561386, 561387,
        561389, 561390, 561391, 561392, 567524, 567529, 567548, 567549, 567550, 567551, 567552, 572637,
        572791, 572819, 572905, 573067, 574147, 578114, 578115, 582591, 600327, 680574, 680607, 680609,
        681104, 681476, 681794, 704476, 706910, 800105, 800430, 800965, 803035, 803037, 803061, 803082,
        803339, 804153, 804275, 804670, 804711, 806039, 806250, 806745, 806769, 807124, 807216, 807883,
        850002
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92130, 'aura_ascension_cultist_lifecycle'),
(255070, 'aura_ascension_cultist_lifecycle'),
(255281, 'aura_ascension_cultist_lifecycle'),
(255283, 'aura_ascension_cultist_lifecycle'),
(300277, 'aura_ascension_cultist_lifecycle'),
(300287, 'aura_ascension_cultist_lifecycle'),
(300290, 'aura_ascension_cultist_lifecycle'),
(301186, 'aura_ascension_cultist_lifecycle'),
(301259, 'aura_ascension_cultist_lifecycle'),
(500706, 'aura_ascension_cultist_lifecycle'),
(500715, 'aura_ascension_cultist_lifecycle'),
(500727, 'aura_ascension_cultist_lifecycle'),
(500751, 'aura_ascension_cultist_lifecycle'),
(502133, 'aura_ascension_cultist_lifecycle'),
(502244, 'aura_ascension_cultist_lifecycle'),
(502245, 'aura_ascension_cultist_lifecycle'),
(502246, 'aura_ascension_cultist_lifecycle'),
(502247, 'aura_ascension_cultist_lifecycle'),
(502267, 'aura_ascension_cultist_lifecycle'),
(502268, 'aura_ascension_cultist_lifecycle'),
(502269, 'aura_ascension_cultist_lifecycle'),
(502270, 'aura_ascension_cultist_lifecycle'),
(502271, 'aura_ascension_cultist_lifecycle'),
(502272, 'aura_ascension_cultist_lifecycle'),
(502273, 'aura_ascension_cultist_lifecycle'),
(502274, 'aura_ascension_cultist_lifecycle'),
(502275, 'aura_ascension_cultist_lifecycle'),
(520326, 'aura_ascension_cultist_lifecycle'),
(520345, 'aura_ascension_cultist_lifecycle'),
(520346, 'aura_ascension_cultist_lifecycle'),
(520388, 'aura_ascension_cultist_lifecycle'),
(520450, 'aura_ascension_cultist_lifecycle'),
(520497, 'aura_ascension_cultist_lifecycle'),
(561288, 'aura_ascension_cultist_lifecycle'),
(561386, 'aura_ascension_cultist_lifecycle'),
(561387, 'aura_ascension_cultist_lifecycle'),
(561389, 'aura_ascension_cultist_lifecycle'),
(561390, 'aura_ascension_cultist_lifecycle'),
(561391, 'aura_ascension_cultist_lifecycle'),
(561392, 'aura_ascension_cultist_lifecycle'),
(567524, 'aura_ascension_cultist_lifecycle'),
(567529, 'aura_ascension_cultist_lifecycle'),
(567548, 'aura_ascension_cultist_lifecycle'),
(567549, 'aura_ascension_cultist_lifecycle'),
(567550, 'aura_ascension_cultist_lifecycle'),
(567551, 'aura_ascension_cultist_lifecycle'),
(567552, 'aura_ascension_cultist_lifecycle'),
(572637, 'aura_ascension_cultist_lifecycle'),
(572791, 'aura_ascension_cultist_lifecycle'),
(572819, 'aura_ascension_cultist_lifecycle'),
(572905, 'aura_ascension_cultist_lifecycle'),
(573067, 'aura_ascension_cultist_lifecycle'),
(574147, 'aura_ascension_cultist_lifecycle'),
(578114, 'aura_ascension_cultist_lifecycle'),
(578115, 'aura_ascension_cultist_lifecycle'),
(582591, 'aura_ascension_cultist_lifecycle'),
(600327, 'aura_ascension_cultist_lifecycle'),
(680574, 'aura_ascension_cultist_lifecycle'),
(680607, 'aura_ascension_cultist_lifecycle'),
(680609, 'aura_ascension_cultist_lifecycle'),
(681104, 'aura_ascension_cultist_lifecycle'),
(681476, 'aura_ascension_cultist_lifecycle'),
(681794, 'aura_ascension_cultist_lifecycle'),
(704476, 'aura_ascension_cultist_lifecycle'),
(706910, 'aura_ascension_cultist_lifecycle'),
(800105, 'aura_ascension_cultist_lifecycle'),
(800430, 'aura_ascension_cultist_lifecycle'),
(800965, 'aura_ascension_cultist_lifecycle'),
(803035, 'aura_ascension_cultist_lifecycle'),
(803037, 'aura_ascension_cultist_lifecycle'),
(803061, 'aura_ascension_cultist_lifecycle'),
(803082, 'aura_ascension_cultist_lifecycle'),
(803339, 'aura_ascension_cultist_lifecycle'),
(804153, 'aura_ascension_cultist_lifecycle'),
(804275, 'aura_ascension_cultist_lifecycle'),
(804670, 'aura_ascension_cultist_lifecycle'),
(804711, 'aura_ascension_cultist_lifecycle'),
(806039, 'aura_ascension_cultist_lifecycle'),
(806250, 'aura_ascension_cultist_lifecycle'),
(806745, 'aura_ascension_cultist_lifecycle'),
(806769, 'aura_ascension_cultist_lifecycle'),
(807124, 'aura_ascension_cultist_lifecycle'),
(807216, 'aura_ascension_cultist_lifecycle'),
(807883, 'aura_ascension_cultist_lifecycle'),
(850002, 'aura_ascension_cultist_lifecycle');

-- aura_ascension_cultist_shadow_training
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_cultist_shadow_training'
    AND `spell_id` IN (
        805607
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805607, 'aura_ascension_cultist_shadow_training');

-- aura_ascension_damage_palm_sigil
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_damage_palm_sigil'
    AND `spell_id` IN (
        500639, 805381
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500639, 'aura_ascension_damage_palm_sigil'),
(805381, 'aura_ascension_damage_palm_sigil');

-- aura_ascension_dark_skies
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_dark_skies'
    AND `spell_id` IN (
        300593
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300593, 'aura_ascension_dark_skies');

-- aura_ascension_decoy_window
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_decoy_window'
    AND `spell_id` IN (
        557326
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(557326, 'aura_ascension_decoy_window');

-- aura_ascension_desynchronization
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_desynchronization'
    AND `spell_id` IN (
        561310
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(561310, 'aura_ascension_desynchronization');

-- aura_ascension_dirty_fighter
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_dirty_fighter'
    AND `spell_id` IN (
        806978
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806978, 'aura_ascension_dirty_fighter');

-- aura_ascension_echo_duration
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_echo_duration'
    AND `spell_id` IN (
        804455
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804455, 'aura_ascension_echo_duration');

-- aura_ascension_electrical_charge
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_electrical_charge'
    AND `spell_id` IN (
        704149
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704149, 'aura_ascension_electrical_charge');

-- aura_ascension_electrified_waters
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_electrified_waters'
    AND `spell_id` IN (
        573436
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(573436, 'aura_ascension_electrified_waters');

-- aura_ascension_endure_the_curse
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_endure_the_curse'
    AND `spell_id` IN (
        681190
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681190, 'aura_ascension_endure_the_curse');

-- aura_ascension_enveloping_winds
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_enveloping_winds'
    AND `spell_id` IN (
        707546
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707546, 'aura_ascension_enveloping_winds');

-- aura_ascension_epoch_renewal
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_epoch_renewal'
    AND `spell_id` IN (
        560355
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560355, 'aura_ascension_epoch_renewal');

-- aura_ascension_eternal_presence
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_eternal_presence'
    AND `spell_id` IN (
        560001
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560001, 'aura_ascension_eternal_presence');

-- aura_ascension_felsworn_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_felsworn_event'
    AND `spell_id` IN (
        92087, 300474, 300476, 300478, 300480, 300483, 300484, 300490, 520244, 520246, 520833, 560503,
        560542, 560639, 570077, 570158, 572889, 574143, 574145, 681376, 685321, 704370, 704606, 704610,
        705131, 707902, 800214, 801899, 803904, 804822, 805239, 805245, 805249, 805998, 806111, 806235,
        807426, 807461
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92087, 'aura_ascension_felsworn_event'),
(300474, 'aura_ascension_felsworn_event'),
(300476, 'aura_ascension_felsworn_event'),
(300478, 'aura_ascension_felsworn_event'),
(300480, 'aura_ascension_felsworn_event'),
(300483, 'aura_ascension_felsworn_event'),
(300484, 'aura_ascension_felsworn_event'),
(300490, 'aura_ascension_felsworn_event'),
(520244, 'aura_ascension_felsworn_event'),
(520246, 'aura_ascension_felsworn_event'),
(520833, 'aura_ascension_felsworn_event'),
(560503, 'aura_ascension_felsworn_event'),
(560542, 'aura_ascension_felsworn_event'),
(560639, 'aura_ascension_felsworn_event'),
(570077, 'aura_ascension_felsworn_event'),
(570158, 'aura_ascension_felsworn_event'),
(572889, 'aura_ascension_felsworn_event'),
(574143, 'aura_ascension_felsworn_event'),
(574145, 'aura_ascension_felsworn_event'),
(681376, 'aura_ascension_felsworn_event'),
(685321, 'aura_ascension_felsworn_event'),
(704370, 'aura_ascension_felsworn_event'),
(704606, 'aura_ascension_felsworn_event'),
(704610, 'aura_ascension_felsworn_event'),
(705131, 'aura_ascension_felsworn_event'),
(707902, 'aura_ascension_felsworn_event'),
(800214, 'aura_ascension_felsworn_event'),
(801899, 'aura_ascension_felsworn_event'),
(803904, 'aura_ascension_felsworn_event'),
(804822, 'aura_ascension_felsworn_event'),
(805239, 'aura_ascension_felsworn_event'),
(805245, 'aura_ascension_felsworn_event'),
(805249, 'aura_ascension_felsworn_event'),
(805998, 'aura_ascension_felsworn_event'),
(806111, 'aura_ascension_felsworn_event'),
(806235, 'aura_ascension_felsworn_event'),
(807426, 'aura_ascension_felsworn_event'),
(807461, 'aura_ascension_felsworn_event');

-- aura_ascension_felsworn_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_felsworn_lifecycle'
    AND `spell_id` IN (
        92089, 300470, 300486, 500610, 520252, 520253, 520853, 525001, 525027, 552210, 552211, 552212,
        552213, 555276, 555277, 555738, 561216, 574140, 574145, 574146, 704368, 704611, 705122, 705129,
        705146, 706269, 706415, 706416, 706417, 706418, 706419, 706420, 706818, 707518, 707523, 707524,
        707525, 707526, 707527, 707901, 707902, 707903, 712483, 800029, 800031, 800206, 800355, 801902,
        802058, 802108, 803343, 803465, 803478, 803716, 803881, 803882, 803883, 803884, 803885, 803904,
        804216, 804610, 804764, 804823, 805236, 805998, 806109, 806128, 807163, 807421, 807424, 807426,
        807428, 807438, 807727, 807962
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92089, 'aura_ascension_felsworn_lifecycle'),
(300470, 'aura_ascension_felsworn_lifecycle'),
(300486, 'aura_ascension_felsworn_lifecycle'),
(500610, 'aura_ascension_felsworn_lifecycle'),
(520252, 'aura_ascension_felsworn_lifecycle'),
(520253, 'aura_ascension_felsworn_lifecycle'),
(520853, 'aura_ascension_felsworn_lifecycle'),
(525001, 'aura_ascension_felsworn_lifecycle'),
(525027, 'aura_ascension_felsworn_lifecycle'),
(552210, 'aura_ascension_felsworn_lifecycle'),
(552211, 'aura_ascension_felsworn_lifecycle'),
(552212, 'aura_ascension_felsworn_lifecycle'),
(552213, 'aura_ascension_felsworn_lifecycle'),
(555276, 'aura_ascension_felsworn_lifecycle'),
(555277, 'aura_ascension_felsworn_lifecycle'),
(555738, 'aura_ascension_felsworn_lifecycle'),
(561216, 'aura_ascension_felsworn_lifecycle'),
(574140, 'aura_ascension_felsworn_lifecycle'),
(574145, 'aura_ascension_felsworn_lifecycle'),
(574146, 'aura_ascension_felsworn_lifecycle'),
(704368, 'aura_ascension_felsworn_lifecycle'),
(704611, 'aura_ascension_felsworn_lifecycle'),
(705122, 'aura_ascension_felsworn_lifecycle'),
(705129, 'aura_ascension_felsworn_lifecycle'),
(705146, 'aura_ascension_felsworn_lifecycle'),
(706269, 'aura_ascension_felsworn_lifecycle'),
(706415, 'aura_ascension_felsworn_lifecycle'),
(706416, 'aura_ascension_felsworn_lifecycle'),
(706417, 'aura_ascension_felsworn_lifecycle'),
(706418, 'aura_ascension_felsworn_lifecycle'),
(706419, 'aura_ascension_felsworn_lifecycle'),
(706420, 'aura_ascension_felsworn_lifecycle'),
(706818, 'aura_ascension_felsworn_lifecycle'),
(707518, 'aura_ascension_felsworn_lifecycle'),
(707523, 'aura_ascension_felsworn_lifecycle'),
(707524, 'aura_ascension_felsworn_lifecycle'),
(707525, 'aura_ascension_felsworn_lifecycle'),
(707526, 'aura_ascension_felsworn_lifecycle'),
(707527, 'aura_ascension_felsworn_lifecycle'),
(707901, 'aura_ascension_felsworn_lifecycle'),
(707902, 'aura_ascension_felsworn_lifecycle'),
(707903, 'aura_ascension_felsworn_lifecycle'),
(712483, 'aura_ascension_felsworn_lifecycle'),
(800029, 'aura_ascension_felsworn_lifecycle'),
(800031, 'aura_ascension_felsworn_lifecycle'),
(800206, 'aura_ascension_felsworn_lifecycle'),
(800355, 'aura_ascension_felsworn_lifecycle'),
(801902, 'aura_ascension_felsworn_lifecycle'),
(802058, 'aura_ascension_felsworn_lifecycle'),
(802108, 'aura_ascension_felsworn_lifecycle'),
(803343, 'aura_ascension_felsworn_lifecycle'),
(803465, 'aura_ascension_felsworn_lifecycle'),
(803478, 'aura_ascension_felsworn_lifecycle'),
(803716, 'aura_ascension_felsworn_lifecycle'),
(803881, 'aura_ascension_felsworn_lifecycle'),
(803882, 'aura_ascension_felsworn_lifecycle'),
(803883, 'aura_ascension_felsworn_lifecycle'),
(803884, 'aura_ascension_felsworn_lifecycle'),
(803885, 'aura_ascension_felsworn_lifecycle'),
(803904, 'aura_ascension_felsworn_lifecycle'),
(804216, 'aura_ascension_felsworn_lifecycle'),
(804610, 'aura_ascension_felsworn_lifecycle'),
(804764, 'aura_ascension_felsworn_lifecycle'),
(804823, 'aura_ascension_felsworn_lifecycle'),
(805236, 'aura_ascension_felsworn_lifecycle'),
(805998, 'aura_ascension_felsworn_lifecycle'),
(806109, 'aura_ascension_felsworn_lifecycle'),
(806128, 'aura_ascension_felsworn_lifecycle'),
(807163, 'aura_ascension_felsworn_lifecycle'),
(807421, 'aura_ascension_felsworn_lifecycle'),
(807424, 'aura_ascension_felsworn_lifecycle'),
(807426, 'aura_ascension_felsworn_lifecycle'),
(807428, 'aura_ascension_felsworn_lifecycle'),
(807438, 'aura_ascension_felsworn_lifecycle'),
(807727, 'aura_ascension_felsworn_lifecycle'),
(807962, 'aura_ascension_felsworn_lifecycle');

-- aura_ascension_felsworn_resolve
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_felsworn_resolve'
    AND `spell_id` IN (
        804823
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804823, 'aura_ascension_felsworn_resolve');

-- aura_ascension_felsworn_stagger
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_felsworn_stagger'
    AND `spell_id` IN (
        807727
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807727, 'aura_ascension_felsworn_stagger');

-- aura_ascension_ghostly_weapon
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ghostly_weapon'
    AND `spell_id` IN (
        803997
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803997, 'aura_ascension_ghostly_weapon');

-- aura_ascension_gift_of_air
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_gift_of_air'
    AND `spell_id` IN (
        705715
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705715, 'aura_ascension_gift_of_air');

-- aura_ascension_gravesite
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_gravesite'
    AND `spell_id` IN (
        572213
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(572213, 'aura_ascension_gravesite');

-- aura_ascension_guardian_advance
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_advance'
    AND `spell_id` IN (
        500170, 503344, 503345, 503346, 503347, 503348, 503349, 503350, 503351
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500170, 'aura_ascension_guardian_advance'),
(503344, 'aura_ascension_guardian_advance'),
(503345, 'aura_ascension_guardian_advance'),
(503346, 'aura_ascension_guardian_advance'),
(503347, 'aura_ascension_guardian_advance'),
(503348, 'aura_ascension_guardian_advance'),
(503349, 'aura_ascension_guardian_advance'),
(503350, 'aura_ascension_guardian_advance'),
(503351, 'aura_ascension_guardian_advance');

-- aura_ascension_guardian_converted_bleed
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_converted_bleed'
    AND `spell_id` IN (
        705380, 706808
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705380, 'aura_ascension_guardian_converted_bleed'),
(706808, 'aura_ascension_guardian_converted_bleed');

-- aura_ascension_guardian_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_event'
    AND `spell_id` IN (
        300927, 503634, 504910, 505202, 520651, 524694, 524932, 560093, 570759, 582901, 653281, 653303,
        653386, 653410, 705379, 706514, 706807, 707137, 707170, 801121, 801774, 802188, 803432, 803524,
        804383, 804891
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300927, 'aura_ascension_guardian_event'),
(503634, 'aura_ascension_guardian_event'),
(504910, 'aura_ascension_guardian_event'),
(505202, 'aura_ascension_guardian_event'),
(520651, 'aura_ascension_guardian_event'),
(524694, 'aura_ascension_guardian_event'),
(524932, 'aura_ascension_guardian_event'),
(560093, 'aura_ascension_guardian_event'),
(570759, 'aura_ascension_guardian_event'),
(582901, 'aura_ascension_guardian_event'),
(653281, 'aura_ascension_guardian_event'),
(653303, 'aura_ascension_guardian_event'),
(653386, 'aura_ascension_guardian_event'),
(653410, 'aura_ascension_guardian_event'),
(705379, 'aura_ascension_guardian_event'),
(706514, 'aura_ascension_guardian_event'),
(706807, 'aura_ascension_guardian_event'),
(707137, 'aura_ascension_guardian_event'),
(707170, 'aura_ascension_guardian_event'),
(801121, 'aura_ascension_guardian_event'),
(801774, 'aura_ascension_guardian_event'),
(802188, 'aura_ascension_guardian_event'),
(803432, 'aura_ascension_guardian_event'),
(803524, 'aura_ascension_guardian_event'),
(804383, 'aura_ascension_guardian_event'),
(804891, 'aura_ascension_guardian_event');

-- aura_ascension_guardian_favor_gain
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_favor_gain'
    AND `spell_id` IN (
        704322
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704322, 'aura_ascension_guardian_favor_gain');

-- aura_ascension_guardian_hold_the_line
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_hold_the_line'
    AND `spell_id` IN (
        803830
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803830, 'aura_ascension_guardian_hold_the_line');

-- aura_ascension_guardian_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_lifecycle'
    AND `spell_id` IN (
        300542, 300860, 503634, 504139, 505199, 524610, 705376, 705381, 706514, 707662, 801774, 803130,
        803738, 803956, 804691, 804891, 807297, 807794
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300542, 'aura_ascension_guardian_lifecycle'),
(300860, 'aura_ascension_guardian_lifecycle'),
(503634, 'aura_ascension_guardian_lifecycle'),
(504139, 'aura_ascension_guardian_lifecycle'),
(505199, 'aura_ascension_guardian_lifecycle'),
(524610, 'aura_ascension_guardian_lifecycle'),
(705376, 'aura_ascension_guardian_lifecycle'),
(705381, 'aura_ascension_guardian_lifecycle'),
(706514, 'aura_ascension_guardian_lifecycle'),
(707662, 'aura_ascension_guardian_lifecycle'),
(801774, 'aura_ascension_guardian_lifecycle'),
(803130, 'aura_ascension_guardian_lifecycle'),
(803738, 'aura_ascension_guardian_lifecycle'),
(803956, 'aura_ascension_guardian_lifecycle'),
(804691, 'aura_ascension_guardian_lifecycle'),
(804891, 'aura_ascension_guardian_lifecycle'),
(807297, 'aura_ascension_guardian_lifecycle'),
(807794, 'aura_ascension_guardian_lifecycle');

-- aura_ascension_guardian_recovery
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_recovery'
    AND `spell_id` IN (
        500266
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500266, 'aura_ascension_guardian_recovery');

-- aura_ascension_guardian_tower
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_tower'
    AND `spell_id` IN (
        800317
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800317, 'aura_ascension_guardian_tower');

-- aura_ascension_guardian_valiance
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_guardian_valiance'
    AND `spell_id` IN (
        501538, 501539, 501540, 501541, 501542, 501543, 501544, 501545, 800315
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(501538, 'aura_ascension_guardian_valiance'),
(501539, 'aura_ascension_guardian_valiance'),
(501540, 'aura_ascension_guardian_valiance'),
(501541, 'aura_ascension_guardian_valiance'),
(501542, 'aura_ascension_guardian_valiance'),
(501543, 'aura_ascension_guardian_valiance'),
(501544, 'aura_ascension_guardian_valiance'),
(501545, 'aura_ascension_guardian_valiance'),
(800315, 'aura_ascension_guardian_valiance');

-- aura_ascension_harvester
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_harvester'
    AND `spell_id` IN (
        92145
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92145, 'aura_ascension_harvester');

-- aura_ascension_hemostasis
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_hemostasis'
    AND `spell_id` IN (
        681304
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681304, 'aura_ascension_hemostasis');

-- aura_ascension_hemostasis_ready
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_hemostasis_ready'
    AND `spell_id` IN (
        302895
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(302895, 'aura_ascension_hemostasis_ready');

-- aura_ascension_hookshot_ready
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_hookshot_ready'
    AND `spell_id` IN (
        803857
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803857, 'aura_ascension_hookshot_ready');

-- aura_ascension_invigorating_winds
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_invigorating_winds'
    AND `spell_id` IN (
        705661
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705661, 'aura_ascension_invigorating_winds');

-- aura_ascension_jailers_call
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_jailers_call'
    AND `spell_id` IN (
        805195
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805195, 'aura_ascension_jailers_call');

-- aura_ascension_lightning_cage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_lightning_cage'
    AND `spell_id` IN (
        560030
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560030, 'aura_ascension_lightning_cage');

-- aura_ascension_necromancer_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_necromancer_event'
    AND `spell_id` IN (
        805011, 805015
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805011, 'aura_ascension_necromancer_event'),
(805015, 'aura_ascension_necromancer_event');

-- aura_ascension_necromancer_ghoul_mastery
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_necromancer_ghoul_mastery'
    AND `spell_id` IN (
        503740
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503740, 'aura_ascension_necromancer_ghoul_mastery');

-- aura_ascension_necromancer_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_necromancer_lifecycle'
    AND `spell_id` IN (
        301207, 500217, 500338, 500456, 500457, 500458, 500459, 500539, 500730, 500965, 500968, 500981,
        500982, 500983, 500985, 501055, 501855, 501856, 501857, 501858, 501859, 501860, 501861, 501880,
        501881, 501882, 501883, 501884, 501885, 501886, 501887, 501888, 501890, 501891, 501892, 501940,
        501941, 501942, 503095, 503640, 504866, 525388, 525389, 525600, 531126, 560012, 561138, 562210,
        562211, 562212, 562213, 570131, 572638, 572777, 572842, 572843, 572844, 572845, 573233, 583255,
        583256, 680388, 681460, 681529, 704676, 705746, 705754, 706472, 707176, 707194, 800979, 801747,
        801945, 802122, 803530, 803782, 804371, 805197, 807796, 807856, 850012, 850013
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(301207, 'aura_ascension_necromancer_lifecycle'),
(500217, 'aura_ascension_necromancer_lifecycle'),
(500338, 'aura_ascension_necromancer_lifecycle'),
(500456, 'aura_ascension_necromancer_lifecycle'),
(500457, 'aura_ascension_necromancer_lifecycle'),
(500458, 'aura_ascension_necromancer_lifecycle'),
(500459, 'aura_ascension_necromancer_lifecycle'),
(500539, 'aura_ascension_necromancer_lifecycle'),
(500730, 'aura_ascension_necromancer_lifecycle'),
(500965, 'aura_ascension_necromancer_lifecycle'),
(500968, 'aura_ascension_necromancer_lifecycle'),
(500981, 'aura_ascension_necromancer_lifecycle'),
(500982, 'aura_ascension_necromancer_lifecycle'),
(500983, 'aura_ascension_necromancer_lifecycle'),
(500985, 'aura_ascension_necromancer_lifecycle'),
(501055, 'aura_ascension_necromancer_lifecycle'),
(501855, 'aura_ascension_necromancer_lifecycle'),
(501856, 'aura_ascension_necromancer_lifecycle'),
(501857, 'aura_ascension_necromancer_lifecycle'),
(501858, 'aura_ascension_necromancer_lifecycle'),
(501859, 'aura_ascension_necromancer_lifecycle'),
(501860, 'aura_ascension_necromancer_lifecycle'),
(501861, 'aura_ascension_necromancer_lifecycle'),
(501880, 'aura_ascension_necromancer_lifecycle'),
(501881, 'aura_ascension_necromancer_lifecycle'),
(501882, 'aura_ascension_necromancer_lifecycle'),
(501883, 'aura_ascension_necromancer_lifecycle'),
(501884, 'aura_ascension_necromancer_lifecycle'),
(501885, 'aura_ascension_necromancer_lifecycle'),
(501886, 'aura_ascension_necromancer_lifecycle'),
(501887, 'aura_ascension_necromancer_lifecycle'),
(501888, 'aura_ascension_necromancer_lifecycle'),
(501890, 'aura_ascension_necromancer_lifecycle'),
(501891, 'aura_ascension_necromancer_lifecycle'),
(501892, 'aura_ascension_necromancer_lifecycle'),
(501940, 'aura_ascension_necromancer_lifecycle'),
(501941, 'aura_ascension_necromancer_lifecycle'),
(501942, 'aura_ascension_necromancer_lifecycle'),
(503095, 'aura_ascension_necromancer_lifecycle'),
(503640, 'aura_ascension_necromancer_lifecycle'),
(504866, 'aura_ascension_necromancer_lifecycle'),
(525388, 'aura_ascension_necromancer_lifecycle'),
(525389, 'aura_ascension_necromancer_lifecycle'),
(525600, 'aura_ascension_necromancer_lifecycle'),
(531126, 'aura_ascension_necromancer_lifecycle'),
(560012, 'aura_ascension_necromancer_lifecycle'),
(561138, 'aura_ascension_necromancer_lifecycle'),
(562210, 'aura_ascension_necromancer_lifecycle'),
(562211, 'aura_ascension_necromancer_lifecycle'),
(562212, 'aura_ascension_necromancer_lifecycle'),
(562213, 'aura_ascension_necromancer_lifecycle'),
(570131, 'aura_ascension_necromancer_lifecycle'),
(572638, 'aura_ascension_necromancer_lifecycle'),
(572777, 'aura_ascension_necromancer_lifecycle'),
(572842, 'aura_ascension_necromancer_lifecycle'),
(572843, 'aura_ascension_necromancer_lifecycle'),
(572844, 'aura_ascension_necromancer_lifecycle'),
(572845, 'aura_ascension_necromancer_lifecycle'),
(573233, 'aura_ascension_necromancer_lifecycle'),
(583255, 'aura_ascension_necromancer_lifecycle'),
(583256, 'aura_ascension_necromancer_lifecycle'),
(680388, 'aura_ascension_necromancer_lifecycle'),
(681460, 'aura_ascension_necromancer_lifecycle'),
(681529, 'aura_ascension_necromancer_lifecycle'),
(704676, 'aura_ascension_necromancer_lifecycle'),
(705746, 'aura_ascension_necromancer_lifecycle'),
(705754, 'aura_ascension_necromancer_lifecycle'),
(706472, 'aura_ascension_necromancer_lifecycle'),
(707176, 'aura_ascension_necromancer_lifecycle'),
(707194, 'aura_ascension_necromancer_lifecycle'),
(800979, 'aura_ascension_necromancer_lifecycle'),
(801747, 'aura_ascension_necromancer_lifecycle'),
(801945, 'aura_ascension_necromancer_lifecycle'),
(802122, 'aura_ascension_necromancer_lifecycle'),
(803530, 'aura_ascension_necromancer_lifecycle'),
(803782, 'aura_ascension_necromancer_lifecycle'),
(804371, 'aura_ascension_necromancer_lifecycle'),
(805197, 'aura_ascension_necromancer_lifecycle'),
(807796, 'aura_ascension_necromancer_lifecycle'),
(807856, 'aura_ascension_necromancer_lifecycle'),
(850012, 'aura_ascension_necromancer_lifecycle'),
(850013, 'aura_ascension_necromancer_lifecycle');

-- aura_ascension_necromancer_transfer_life
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_necromancer_transfer_life'
    AND `spell_id` IN (
        801530
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801530, 'aura_ascension_necromancer_transfer_life');

-- aura_ascension_outmaneuver_mark
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_outmaneuver_mark'
    AND `spell_id` IN (
        557325
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(557325, 'aura_ascension_outmaneuver_mark');

-- aura_ascension_playing_dirty
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_playing_dirty'
    AND `spell_id` IN (
        681787
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681787, 'aura_ascension_playing_dirty');

-- aura_ascension_primalist_direct_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_primalist_direct_damage'
    AND `spell_id` IN (
        503717, 504226, 560182, 560286, 706220, 800185
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503717, 'aura_ascension_primalist_direct_damage'),
(504226, 'aura_ascension_primalist_direct_damage'),
(560182, 'aura_ascension_primalist_direct_damage'),
(560286, 'aura_ascension_primalist_direct_damage'),
(706220, 'aura_ascension_primalist_direct_damage'),
(800185, 'aura_ascension_primalist_direct_damage');

-- aura_ascension_pyromancer_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_pyromancer_event'
    AND `spell_id` IN (
        300755, 300757, 300932, 300975, 504380, 504720, 504733, 524624, 535650, 535651, 538441, 572582,
        582762, 582763, 582764, 680378, 680387, 704275, 704800, 704801, 704855, 704856, 704863, 706239,
        706464, 707432, 707483, 802068, 802117, 805468, 806736, 807146, 807400
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300755, 'aura_ascension_pyromancer_event'),
(300757, 'aura_ascension_pyromancer_event'),
(300932, 'aura_ascension_pyromancer_event'),
(300975, 'aura_ascension_pyromancer_event'),
(504380, 'aura_ascension_pyromancer_event'),
(504720, 'aura_ascension_pyromancer_event'),
(504733, 'aura_ascension_pyromancer_event'),
(524624, 'aura_ascension_pyromancer_event'),
(535650, 'aura_ascension_pyromancer_event'),
(535651, 'aura_ascension_pyromancer_event'),
(538441, 'aura_ascension_pyromancer_event'),
(572582, 'aura_ascension_pyromancer_event'),
(582762, 'aura_ascension_pyromancer_event'),
(582763, 'aura_ascension_pyromancer_event'),
(582764, 'aura_ascension_pyromancer_event'),
(680378, 'aura_ascension_pyromancer_event'),
(680387, 'aura_ascension_pyromancer_event'),
(704275, 'aura_ascension_pyromancer_event'),
(704800, 'aura_ascension_pyromancer_event'),
(704801, 'aura_ascension_pyromancer_event'),
(704855, 'aura_ascension_pyromancer_event'),
(704856, 'aura_ascension_pyromancer_event'),
(704863, 'aura_ascension_pyromancer_event'),
(706239, 'aura_ascension_pyromancer_event'),
(706464, 'aura_ascension_pyromancer_event'),
(707432, 'aura_ascension_pyromancer_event'),
(707483, 'aura_ascension_pyromancer_event'),
(802068, 'aura_ascension_pyromancer_event'),
(802117, 'aura_ascension_pyromancer_event'),
(805468, 'aura_ascension_pyromancer_event'),
(806736, 'aura_ascension_pyromancer_event'),
(807146, 'aura_ascension_pyromancer_event'),
(807400, 'aura_ascension_pyromancer_event');

-- aura_ascension_pyromancer_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_pyromancer_lifecycle'
    AND `spell_id` IN (
        92128, 502020, 502021, 502022, 502023, 502024, 502025, 502026, 502027, 502028, 502029, 502030,
        502031, 504707, 504720, 520823, 520826, 520927, 520937, 524707, 534600, 534601, 534602, 534603,
        534604, 572159, 572160, 573220, 573284, 680369, 680378, 680387, 680842, 680962, 681314, 706874,
        707478, 800791, 802120, 802168, 804301, 805500, 806783, 807146, 807147, 807400, 807403, 807944,
        1119751, 1119754, 1119755, 1119756, 1119757, 1119758, 1119901, 1119944, 1119953
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92128, 'aura_ascension_pyromancer_lifecycle'),
(502020, 'aura_ascension_pyromancer_lifecycle'),
(502021, 'aura_ascension_pyromancer_lifecycle'),
(502022, 'aura_ascension_pyromancer_lifecycle'),
(502023, 'aura_ascension_pyromancer_lifecycle'),
(502024, 'aura_ascension_pyromancer_lifecycle'),
(502025, 'aura_ascension_pyromancer_lifecycle'),
(502026, 'aura_ascension_pyromancer_lifecycle'),
(502027, 'aura_ascension_pyromancer_lifecycle'),
(502028, 'aura_ascension_pyromancer_lifecycle'),
(502029, 'aura_ascension_pyromancer_lifecycle'),
(502030, 'aura_ascension_pyromancer_lifecycle'),
(502031, 'aura_ascension_pyromancer_lifecycle'),
(504707, 'aura_ascension_pyromancer_lifecycle'),
(504720, 'aura_ascension_pyromancer_lifecycle'),
(520823, 'aura_ascension_pyromancer_lifecycle'),
(520826, 'aura_ascension_pyromancer_lifecycle'),
(520927, 'aura_ascension_pyromancer_lifecycle'),
(520937, 'aura_ascension_pyromancer_lifecycle'),
(524707, 'aura_ascension_pyromancer_lifecycle'),
(534600, 'aura_ascension_pyromancer_lifecycle'),
(534601, 'aura_ascension_pyromancer_lifecycle'),
(534602, 'aura_ascension_pyromancer_lifecycle'),
(534603, 'aura_ascension_pyromancer_lifecycle'),
(534604, 'aura_ascension_pyromancer_lifecycle'),
(572159, 'aura_ascension_pyromancer_lifecycle'),
(572160, 'aura_ascension_pyromancer_lifecycle'),
(573220, 'aura_ascension_pyromancer_lifecycle'),
(573284, 'aura_ascension_pyromancer_lifecycle'),
(680369, 'aura_ascension_pyromancer_lifecycle'),
(680378, 'aura_ascension_pyromancer_lifecycle'),
(680387, 'aura_ascension_pyromancer_lifecycle'),
(680842, 'aura_ascension_pyromancer_lifecycle'),
(680962, 'aura_ascension_pyromancer_lifecycle'),
(681314, 'aura_ascension_pyromancer_lifecycle'),
(706874, 'aura_ascension_pyromancer_lifecycle'),
(707478, 'aura_ascension_pyromancer_lifecycle'),
(800791, 'aura_ascension_pyromancer_lifecycle'),
(802120, 'aura_ascension_pyromancer_lifecycle'),
(802168, 'aura_ascension_pyromancer_lifecycle'),
(804301, 'aura_ascension_pyromancer_lifecycle'),
(805500, 'aura_ascension_pyromancer_lifecycle'),
(806783, 'aura_ascension_pyromancer_lifecycle'),
(807146, 'aura_ascension_pyromancer_lifecycle'),
(807147, 'aura_ascension_pyromancer_lifecycle'),
(807400, 'aura_ascension_pyromancer_lifecycle'),
(807403, 'aura_ascension_pyromancer_lifecycle'),
(807944, 'aura_ascension_pyromancer_lifecycle'),
(1119751, 'aura_ascension_pyromancer_lifecycle'),
(1119754, 'aura_ascension_pyromancer_lifecycle'),
(1119755, 'aura_ascension_pyromancer_lifecycle'),
(1119756, 'aura_ascension_pyromancer_lifecycle'),
(1119757, 'aura_ascension_pyromancer_lifecycle'),
(1119758, 'aura_ascension_pyromancer_lifecycle'),
(1119901, 'aura_ascension_pyromancer_lifecycle'),
(1119944, 'aura_ascension_pyromancer_lifecycle'),
(1119953, 'aura_ascension_pyromancer_lifecycle');

-- aura_ascension_pyromancer_phoenix
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_pyromancer_phoenix'
    AND `spell_id` IN (
        92126
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92126, 'aura_ascension_pyromancer_phoenix');

-- aura_ascension_raid_damage_aura
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_raid_damage_aura'
    AND `spell_id` IN (
        520839, 520929, 537248, 560530
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520839, 'aura_ascension_raid_damage_aura'),
(520929, 'aura_ascension_raid_damage_aura'),
(537248, 'aura_ascension_raid_damage_aura'),
(560530, 'aura_ascension_raid_damage_aura');

-- aura_ascension_ranger_advantage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_advantage'
    AND `spell_id` IN (
        804329
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804329, 'aura_ascension_ranger_advantage');

-- aura_ascension_ranger_barbed_quills
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_barbed_quills'
    AND `spell_id` IN (
        800077
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800077, 'aura_ascension_ranger_barbed_quills');

-- aura_ascension_ranger_dream_flowers
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_dream_flowers'
    AND `spell_id` IN (
        92117
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92117, 'aura_ascension_ranger_dream_flowers');

-- aura_ascension_ranger_guidance
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_guidance'
    AND `spell_id` IN (
        532261
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(532261, 'aura_ascension_ranger_guidance');

-- aura_ascension_ranger_hawkeye
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_hawkeye'
    AND `spell_id` IN (
        800358
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800358, 'aura_ascension_ranger_hawkeye');

-- aura_ascension_ranger_highwayman
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_highwayman'
    AND `spell_id` IN (
        707744
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707744, 'aura_ascension_ranger_highwayman');

-- aura_ascension_ranger_petalkeeper
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_petalkeeper'
    AND `spell_id` IN (
        520925
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520925, 'aura_ascension_ranger_petalkeeper');

-- aura_ascension_ranger_pierced_bleed
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_pierced_bleed'
    AND `spell_id` IN (
        782754
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(782754, 'aura_ascension_ranger_pierced_bleed');

-- aura_ascension_ranger_red_dream
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_red_dream'
    AND `spell_id` IN (
        521451
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(521451, 'aura_ascension_ranger_red_dream');

-- aura_ascension_ranger_wingman
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ranger_wingman'
    AND `spell_id` IN (
        705098
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705098, 'aura_ascension_ranger_wingman');

-- aura_ascension_reaper_blood_frenzy
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_blood_frenzy'
    AND `spell_id` IN (
        707899
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707899, 'aura_ascension_reaper_blood_frenzy');

-- aura_ascension_reaper_dark_soul
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_dark_soul'
    AND `spell_id` IN (
        706784
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706784, 'aura_ascension_reaper_dark_soul');

-- aura_ascension_reaper_decimation_counter
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_decimation_counter'
    AND `spell_id` IN (
        573289
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(573289, 'aura_ascension_reaper_decimation_counter');

-- aura_ascension_reaper_ghastly_form
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_ghastly_form'
    AND `spell_id` IN (
        704358
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704358, 'aura_ascension_reaper_ghastly_form');

-- aura_ascension_reaper_harvesting_grounds
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_harvesting_grounds'
    AND `spell_id` IN (
        705413
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705413, 'aura_ascension_reaper_harvesting_grounds');

-- aura_ascension_reaper_jailers_will_helper
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_jailers_will_helper'
    AND `spell_id` IN (
        578264
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(578264, 'aura_ascension_reaper_jailers_will_helper');

-- aura_ascension_reaper_mind_screech
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_mind_screech'
    AND `spell_id` IN (
        705448
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705448, 'aura_ascension_reaper_mind_screech');

-- aura_ascension_reaper_redshade_spells
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_redshade_spells'
    AND `spell_id` IN (
        524735
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(524735, 'aura_ascension_reaper_redshade_spells');

-- aura_ascension_reaper_redshade_transform
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_redshade_transform'
    AND `spell_id` IN (
        525058, 525299
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(525058, 'aura_ascension_reaper_redshade_transform'),
(525299, 'aura_ascension_reaper_redshade_transform');

-- aura_ascension_reaper_shade
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_shade'
    AND `spell_id` IN (
        573038
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(573038, 'aura_ascension_reaper_shade');

-- aura_ascension_reaper_siphon_anima
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_siphon_anima'
    AND `spell_id` IN (
        572768
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(572768, 'aura_ascension_reaper_siphon_anima');

-- aura_ascension_reaper_soulrot
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_soulrot'
    AND `spell_id` IN (
        804660
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804660, 'aura_ascension_reaper_soulrot');

-- aura_ascension_reaper_souls_for_slaughter
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_souls_for_slaughter'
    AND `spell_id` IN (
        504304
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504304, 'aura_ascension_reaper_souls_for_slaughter');

-- aura_ascension_reaper_tormented_souls
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_reaper_tormented_souls'
    AND `spell_id` IN (
        500481
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500481, 'aura_ascension_reaper_tormented_souls');

-- aura_ascension_rejuvenating_rays
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_rejuvenating_rays'
    AND `spell_id` IN (
        807239
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807239, 'aura_ascension_rejuvenating_rays');

-- aura_ascension_resource_talent
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_resource_talent'
    AND `spell_id` IN (
        301287, 504252
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(301287, 'aura_ascension_resource_talent'),
(504252, 'aura_ascension_resource_talent');

-- aura_ascension_resource_talent_refresh
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_resource_talent_refresh'
    AND `spell_id` IN (
        706613, 800058
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706613, 'aura_ascension_resource_talent_refresh'),
(800058, 'aura_ascension_resource_talent_refresh');

-- aura_ascension_ripple_aeon
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ripple_aeon'
    AND `spell_id` IN (
        806296
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806296, 'aura_ascension_ripple_aeon');

-- aura_ascension_ripple_debt
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ripple_debt'
    AND `spell_id` IN (
        806733
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806733, 'aura_ascension_ripple_debt');

-- aura_ascension_ripple_protection
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ripple_protection'
    AND `spell_id` IN (
        560394
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560394, 'aura_ascension_ripple_protection');

-- aura_ascension_ripple_pulses
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ripple_pulses'
    AND `spell_id` IN (
        560384, 560388
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560384, 'aura_ascension_ripple_pulses'),
(560388, 'aura_ascension_ripple_pulses');

-- aura_ascension_ripple_release
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ripple_release'
    AND `spell_id` IN (
        806296
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806296, 'aura_ascension_ripple_release');

-- aura_ascension_ripple_resilience
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_ripple_resilience'
    AND `spell_id` IN (
        560396
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560396, 'aura_ascension_ripple_resilience');

-- aura_ascension_runemaster_air_engraving
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_air_engraving'
    AND `spell_id` IN (
        653225
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653225, 'aura_ascension_runemaster_air_engraving');

-- aura_ascension_runemaster_burned_etching
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_burned_etching'
    AND `spell_id` IN (
        500475
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500475, 'aura_ascension_runemaster_burned_etching');

-- aura_ascension_runemaster_convergence
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_convergence'
    AND `spell_id` IN (
        801086
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801086, 'aura_ascension_runemaster_convergence');

-- aura_ascension_runemaster_fire_engraving
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_fire_engraving'
    AND `spell_id` IN (
        653211
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653211, 'aura_ascension_runemaster_fire_engraving');

-- aura_ascension_runemaster_frigid_fusion
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_frigid_fusion'
    AND `spell_id` IN (
        803225
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803225, 'aura_ascension_runemaster_frigid_fusion');

-- aura_ascension_runemaster_genesis
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_genesis'
    AND `spell_id` IN (
        500501
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500501, 'aura_ascension_runemaster_genesis');

-- aura_ascension_runemaster_granite_shield
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_granite_shield'
    AND `spell_id` IN (
        806996
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806996, 'aura_ascension_runemaster_granite_shield');

-- aura_ascension_runemaster_harvested_ley_energy
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_harvested_ley_energy'
    AND `spell_id` IN (
        803258
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803258, 'aura_ascension_runemaster_harvested_ley_energy');

-- aura_ascension_runemaster_hurricane
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_hurricane'
    AND `spell_id` IN (
        645435
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(645435, 'aura_ascension_runemaster_hurricane');

-- aura_ascension_runemaster_icebound_momentum
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_icebound_momentum'
    AND `spell_id` IN (
        712490
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712490, 'aura_ascension_runemaster_icebound_momentum');

-- aura_ascension_runemaster_leyfrost
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_leyfrost'
    AND `spell_id` IN (
        712308
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712308, 'aura_ascension_runemaster_leyfrost');

-- aura_ascension_runemaster_primordial_alteration
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_primordial_alteration'
    AND `spell_id` IN (
        713003, 717070, 718040, 721085, 805742
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(713003, 'aura_ascension_runemaster_primordial_alteration'),
(717070, 'aura_ascension_runemaster_primordial_alteration'),
(718040, 'aura_ascension_runemaster_primordial_alteration'),
(721085, 'aura_ascension_runemaster_primordial_alteration'),
(805742, 'aura_ascension_runemaster_primordial_alteration');

-- aura_ascension_runemaster_speed_rune_stealth
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_speed_rune_stealth'
    AND `spell_id` IN (
        572136
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(572136, 'aura_ascension_runemaster_speed_rune_stealth');

-- aura_ascension_runemaster_turbulence
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_turbulence'
    AND `spell_id` IN (
        705575
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705575, 'aura_ascension_runemaster_turbulence');

-- aura_ascension_runemaster_wind_walker
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_wind_walker'
    AND `spell_id` IN (
        807376
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807376, 'aura_ascension_runemaster_wind_walker');

-- aura_ascension_runemaster_windsage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_runemaster_windsage'
    AND `spell_id` IN (
        705569
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705569, 'aura_ascension_runemaster_windsage');

-- aura_ascension_spiritual_reflexes
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_spiritual_reflexes'
    AND `spell_id` IN (
        705436
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705436, 'aura_ascension_spiritual_reflexes');

-- aura_ascension_starcaller_absorb
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_starcaller_absorb'
    AND `spell_id` IN (
        574351, 680786, 704785
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(574351, 'aura_ascension_starcaller_absorb'),
(680786, 'aura_ascension_starcaller_absorb'),
(704785, 'aura_ascension_starcaller_absorb');

-- aura_ascension_starcaller_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_starcaller_event'
    AND `spell_id` IN (
        300992, 504001, 504628, 504786, 524642, 536216, 536217, 560440, 560501, 560539, 560956, 561022,
        680215, 680784, 704741, 704777, 706230, 706575, 800394, 800510, 801123, 801128, 801143, 801145,
        801155, 801231, 803887, 803888, 804733, 804735, 805356, 805439, 805505, 806155, 807659
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300992, 'aura_ascension_starcaller_event'),
(504001, 'aura_ascension_starcaller_event'),
(504628, 'aura_ascension_starcaller_event'),
(504786, 'aura_ascension_starcaller_event'),
(524642, 'aura_ascension_starcaller_event'),
(536216, 'aura_ascension_starcaller_event'),
(536217, 'aura_ascension_starcaller_event'),
(560440, 'aura_ascension_starcaller_event'),
(560501, 'aura_ascension_starcaller_event'),
(560539, 'aura_ascension_starcaller_event'),
(560956, 'aura_ascension_starcaller_event'),
(561022, 'aura_ascension_starcaller_event'),
(680215, 'aura_ascension_starcaller_event'),
(680784, 'aura_ascension_starcaller_event'),
(704741, 'aura_ascension_starcaller_event'),
(704777, 'aura_ascension_starcaller_event'),
(706230, 'aura_ascension_starcaller_event'),
(706575, 'aura_ascension_starcaller_event'),
(800394, 'aura_ascension_starcaller_event'),
(800510, 'aura_ascension_starcaller_event'),
(801123, 'aura_ascension_starcaller_event'),
(801128, 'aura_ascension_starcaller_event'),
(801143, 'aura_ascension_starcaller_event'),
(801145, 'aura_ascension_starcaller_event'),
(801155, 'aura_ascension_starcaller_event'),
(801231, 'aura_ascension_starcaller_event'),
(803887, 'aura_ascension_starcaller_event'),
(803888, 'aura_ascension_starcaller_event'),
(804733, 'aura_ascension_starcaller_event'),
(804735, 'aura_ascension_starcaller_event'),
(805356, 'aura_ascension_starcaller_event'),
(805439, 'aura_ascension_starcaller_event'),
(805505, 'aura_ascension_starcaller_event'),
(806155, 'aura_ascension_starcaller_event'),
(807659, 'aura_ascension_starcaller_event');

-- aura_ascension_starcaller_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_starcaller_lifecycle'
    AND `spell_id` IN (
        300256, 300773, 500206, 502295, 502296, 502297, 503780, 504630, 504631, 524781, 536217, 560634,
        561046, 572319, 574349, 574351, 680213, 680705, 680713, 680786, 680821, 680822, 680847, 704171,
        704772, 704785, 706301, 707425, 800386, 800393, 800394, 800505, 801123, 801148, 801243, 802681,
        802985, 803573, 803915, 803916, 803917, 804716, 804735, 805433, 805439, 805546, 807992, 954791
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300256, 'aura_ascension_starcaller_lifecycle'),
(300773, 'aura_ascension_starcaller_lifecycle'),
(500206, 'aura_ascension_starcaller_lifecycle'),
(502295, 'aura_ascension_starcaller_lifecycle'),
(502296, 'aura_ascension_starcaller_lifecycle'),
(502297, 'aura_ascension_starcaller_lifecycle'),
(503780, 'aura_ascension_starcaller_lifecycle'),
(504630, 'aura_ascension_starcaller_lifecycle'),
(504631, 'aura_ascension_starcaller_lifecycle'),
(524781, 'aura_ascension_starcaller_lifecycle'),
(536217, 'aura_ascension_starcaller_lifecycle'),
(560634, 'aura_ascension_starcaller_lifecycle'),
(561046, 'aura_ascension_starcaller_lifecycle'),
(572319, 'aura_ascension_starcaller_lifecycle'),
(574349, 'aura_ascension_starcaller_lifecycle'),
(574351, 'aura_ascension_starcaller_lifecycle'),
(680213, 'aura_ascension_starcaller_lifecycle'),
(680705, 'aura_ascension_starcaller_lifecycle'),
(680713, 'aura_ascension_starcaller_lifecycle'),
(680786, 'aura_ascension_starcaller_lifecycle'),
(680821, 'aura_ascension_starcaller_lifecycle'),
(680822, 'aura_ascension_starcaller_lifecycle'),
(680847, 'aura_ascension_starcaller_lifecycle'),
(704171, 'aura_ascension_starcaller_lifecycle'),
(704772, 'aura_ascension_starcaller_lifecycle'),
(704785, 'aura_ascension_starcaller_lifecycle'),
(706301, 'aura_ascension_starcaller_lifecycle'),
(707425, 'aura_ascension_starcaller_lifecycle'),
(800386, 'aura_ascension_starcaller_lifecycle'),
(800393, 'aura_ascension_starcaller_lifecycle'),
(800394, 'aura_ascension_starcaller_lifecycle'),
(800505, 'aura_ascension_starcaller_lifecycle'),
(801123, 'aura_ascension_starcaller_lifecycle'),
(801148, 'aura_ascension_starcaller_lifecycle'),
(801243, 'aura_ascension_starcaller_lifecycle'),
(802681, 'aura_ascension_starcaller_lifecycle'),
(802985, 'aura_ascension_starcaller_lifecycle'),
(803573, 'aura_ascension_starcaller_lifecycle'),
(803915, 'aura_ascension_starcaller_lifecycle'),
(803916, 'aura_ascension_starcaller_lifecycle'),
(803917, 'aura_ascension_starcaller_lifecycle'),
(804716, 'aura_ascension_starcaller_lifecycle'),
(804735, 'aura_ascension_starcaller_lifecycle'),
(805433, 'aura_ascension_starcaller_lifecycle'),
(805439, 'aura_ascension_starcaller_lifecycle'),
(805546, 'aura_ascension_starcaller_lifecycle'),
(807992, 'aura_ascension_starcaller_lifecycle'),
(954791, 'aura_ascension_starcaller_lifecycle');

-- aura_ascension_starcaller_shattered_stars
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_starcaller_shattered_stars'
    AND `spell_id` IN (
        801135
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801135, 'aura_ascension_starcaller_shattered_stars');

-- aura_ascension_stormcloak
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_stormcloak'
    AND `spell_id` IN (
        804833
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804833, 'aura_ascension_stormcloak');

-- aura_ascension_stormflow
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_stormflow'
    AND `spell_id` IN (
        567555, 572861, 572862, 572863, 572864, 572865, 572866, 572867
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(567555, 'aura_ascension_stormflow'),
(572861, 'aura_ascension_stormflow'),
(572862, 'aura_ascension_stormflow'),
(572863, 'aura_ascension_stormflow'),
(572864, 'aura_ascension_stormflow'),
(572865, 'aura_ascension_stormflow'),
(572866, 'aura_ascension_stormflow'),
(572867, 'aura_ascension_stormflow');

-- aura_ascension_sun_cleric_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_sun_cleric_event'
    AND `spell_id` IN (
        92137, 300336, 300339, 300349, 300355, 300369, 300371, 300943, 301239, 301266, 505342, 534267,
        547214, 560095, 560492, 560861, 561327, 572885, 582832, 680624, 680641, 680643, 680646, 680663,
        680888, 680911, 681252, 704563, 704903, 704920, 704928, 704934, 704936, 704941, 707077, 707629,
        800612, 802935, 803489, 803491, 803719, 804629, 804632, 805647, 806024, 806058, 806116, 806123,
        806699, 807343, 807435, 807547, 807749
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92137, 'aura_ascension_sun_cleric_event'),
(300336, 'aura_ascension_sun_cleric_event'),
(300339, 'aura_ascension_sun_cleric_event'),
(300349, 'aura_ascension_sun_cleric_event'),
(300355, 'aura_ascension_sun_cleric_event'),
(300369, 'aura_ascension_sun_cleric_event'),
(300371, 'aura_ascension_sun_cleric_event'),
(300943, 'aura_ascension_sun_cleric_event'),
(301239, 'aura_ascension_sun_cleric_event'),
(301266, 'aura_ascension_sun_cleric_event'),
(505342, 'aura_ascension_sun_cleric_event'),
(534267, 'aura_ascension_sun_cleric_event'),
(547214, 'aura_ascension_sun_cleric_event'),
(560095, 'aura_ascension_sun_cleric_event'),
(560492, 'aura_ascension_sun_cleric_event'),
(560861, 'aura_ascension_sun_cleric_event'),
(561327, 'aura_ascension_sun_cleric_event'),
(572885, 'aura_ascension_sun_cleric_event'),
(582832, 'aura_ascension_sun_cleric_event'),
(680624, 'aura_ascension_sun_cleric_event'),
(680641, 'aura_ascension_sun_cleric_event'),
(680643, 'aura_ascension_sun_cleric_event'),
(680646, 'aura_ascension_sun_cleric_event'),
(680663, 'aura_ascension_sun_cleric_event'),
(680888, 'aura_ascension_sun_cleric_event'),
(680911, 'aura_ascension_sun_cleric_event'),
(681252, 'aura_ascension_sun_cleric_event'),
(704563, 'aura_ascension_sun_cleric_event'),
(704903, 'aura_ascension_sun_cleric_event'),
(704920, 'aura_ascension_sun_cleric_event'),
(704928, 'aura_ascension_sun_cleric_event'),
(704934, 'aura_ascension_sun_cleric_event'),
(704936, 'aura_ascension_sun_cleric_event'),
(704941, 'aura_ascension_sun_cleric_event'),
(707077, 'aura_ascension_sun_cleric_event'),
(707629, 'aura_ascension_sun_cleric_event'),
(800612, 'aura_ascension_sun_cleric_event'),
(802935, 'aura_ascension_sun_cleric_event'),
(803489, 'aura_ascension_sun_cleric_event'),
(803491, 'aura_ascension_sun_cleric_event'),
(803719, 'aura_ascension_sun_cleric_event'),
(804629, 'aura_ascension_sun_cleric_event'),
(804632, 'aura_ascension_sun_cleric_event'),
(805647, 'aura_ascension_sun_cleric_event'),
(806024, 'aura_ascension_sun_cleric_event'),
(806058, 'aura_ascension_sun_cleric_event'),
(806116, 'aura_ascension_sun_cleric_event'),
(806123, 'aura_ascension_sun_cleric_event'),
(806699, 'aura_ascension_sun_cleric_event'),
(807343, 'aura_ascension_sun_cleric_event'),
(807435, 'aura_ascension_sun_cleric_event'),
(807547, 'aura_ascension_sun_cleric_event'),
(807749, 'aura_ascension_sun_cleric_event');

-- aura_ascension_sun_cleric_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_sun_cleric_lifecycle'
    AND `spell_id` IN (
        300314, 300334, 300351, 300354, 300361, 300363, 300621, 300626, 300858, 300859, 300862, 300863,
        300864, 300865, 300866, 301242, 301265, 301266, 301293, 301345, 301817, 500477, 500511, 503691,
        505340, 520647, 560095, 560123, 560347, 561023, 561328, 570125, 572384, 572385, 572386, 572387,
        572388, 572389, 572390, 572552, 572553, 572752, 572754, 575040, 575041, 575042, 575043, 575044,
        575045, 680624, 680639, 680642, 680911, 681160, 681254, 681506, 704585, 704930, 704935, 707078,
        800601, 800722, 800852, 802598, 803489, 803491, 803492, 803500, 803719, 804247, 804631, 805267,
        805301, 807059, 807061, 807077, 807080, 807240, 807299, 807435, 807440, 807446, 807523, 807547,
        807749, 807750, 807751, 807752
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300314, 'aura_ascension_sun_cleric_lifecycle'),
(300334, 'aura_ascension_sun_cleric_lifecycle'),
(300351, 'aura_ascension_sun_cleric_lifecycle'),
(300354, 'aura_ascension_sun_cleric_lifecycle'),
(300361, 'aura_ascension_sun_cleric_lifecycle'),
(300363, 'aura_ascension_sun_cleric_lifecycle'),
(300621, 'aura_ascension_sun_cleric_lifecycle'),
(300626, 'aura_ascension_sun_cleric_lifecycle'),
(300858, 'aura_ascension_sun_cleric_lifecycle'),
(300859, 'aura_ascension_sun_cleric_lifecycle'),
(300862, 'aura_ascension_sun_cleric_lifecycle'),
(300863, 'aura_ascension_sun_cleric_lifecycle'),
(300864, 'aura_ascension_sun_cleric_lifecycle'),
(300865, 'aura_ascension_sun_cleric_lifecycle'),
(300866, 'aura_ascension_sun_cleric_lifecycle'),
(301242, 'aura_ascension_sun_cleric_lifecycle'),
(301265, 'aura_ascension_sun_cleric_lifecycle'),
(301266, 'aura_ascension_sun_cleric_lifecycle'),
(301293, 'aura_ascension_sun_cleric_lifecycle'),
(301345, 'aura_ascension_sun_cleric_lifecycle'),
(301817, 'aura_ascension_sun_cleric_lifecycle'),
(500477, 'aura_ascension_sun_cleric_lifecycle'),
(500511, 'aura_ascension_sun_cleric_lifecycle'),
(503691, 'aura_ascension_sun_cleric_lifecycle'),
(505340, 'aura_ascension_sun_cleric_lifecycle'),
(520647, 'aura_ascension_sun_cleric_lifecycle'),
(560095, 'aura_ascension_sun_cleric_lifecycle'),
(560123, 'aura_ascension_sun_cleric_lifecycle'),
(560347, 'aura_ascension_sun_cleric_lifecycle'),
(561023, 'aura_ascension_sun_cleric_lifecycle'),
(561328, 'aura_ascension_sun_cleric_lifecycle'),
(570125, 'aura_ascension_sun_cleric_lifecycle'),
(572384, 'aura_ascension_sun_cleric_lifecycle'),
(572385, 'aura_ascension_sun_cleric_lifecycle'),
(572386, 'aura_ascension_sun_cleric_lifecycle'),
(572387, 'aura_ascension_sun_cleric_lifecycle'),
(572388, 'aura_ascension_sun_cleric_lifecycle'),
(572389, 'aura_ascension_sun_cleric_lifecycle'),
(572390, 'aura_ascension_sun_cleric_lifecycle'),
(572552, 'aura_ascension_sun_cleric_lifecycle'),
(572553, 'aura_ascension_sun_cleric_lifecycle'),
(572752, 'aura_ascension_sun_cleric_lifecycle'),
(572754, 'aura_ascension_sun_cleric_lifecycle'),
(575040, 'aura_ascension_sun_cleric_lifecycle'),
(575041, 'aura_ascension_sun_cleric_lifecycle'),
(575042, 'aura_ascension_sun_cleric_lifecycle'),
(575043, 'aura_ascension_sun_cleric_lifecycle'),
(575044, 'aura_ascension_sun_cleric_lifecycle'),
(575045, 'aura_ascension_sun_cleric_lifecycle'),
(680624, 'aura_ascension_sun_cleric_lifecycle'),
(680639, 'aura_ascension_sun_cleric_lifecycle'),
(680642, 'aura_ascension_sun_cleric_lifecycle'),
(680911, 'aura_ascension_sun_cleric_lifecycle'),
(681160, 'aura_ascension_sun_cleric_lifecycle'),
(681254, 'aura_ascension_sun_cleric_lifecycle'),
(681506, 'aura_ascension_sun_cleric_lifecycle'),
(704585, 'aura_ascension_sun_cleric_lifecycle'),
(704930, 'aura_ascension_sun_cleric_lifecycle'),
(704935, 'aura_ascension_sun_cleric_lifecycle'),
(707078, 'aura_ascension_sun_cleric_lifecycle'),
(800601, 'aura_ascension_sun_cleric_lifecycle'),
(800722, 'aura_ascension_sun_cleric_lifecycle'),
(800852, 'aura_ascension_sun_cleric_lifecycle'),
(802598, 'aura_ascension_sun_cleric_lifecycle'),
(803489, 'aura_ascension_sun_cleric_lifecycle'),
(803491, 'aura_ascension_sun_cleric_lifecycle'),
(803492, 'aura_ascension_sun_cleric_lifecycle'),
(803500, 'aura_ascension_sun_cleric_lifecycle'),
(803719, 'aura_ascension_sun_cleric_lifecycle'),
(804247, 'aura_ascension_sun_cleric_lifecycle'),
(804631, 'aura_ascension_sun_cleric_lifecycle'),
(805267, 'aura_ascension_sun_cleric_lifecycle'),
(805301, 'aura_ascension_sun_cleric_lifecycle'),
(807059, 'aura_ascension_sun_cleric_lifecycle'),
(807061, 'aura_ascension_sun_cleric_lifecycle'),
(807077, 'aura_ascension_sun_cleric_lifecycle'),
(807080, 'aura_ascension_sun_cleric_lifecycle'),
(807240, 'aura_ascension_sun_cleric_lifecycle'),
(807299, 'aura_ascension_sun_cleric_lifecycle'),
(807435, 'aura_ascension_sun_cleric_lifecycle'),
(807440, 'aura_ascension_sun_cleric_lifecycle'),
(807446, 'aura_ascension_sun_cleric_lifecycle'),
(807523, 'aura_ascension_sun_cleric_lifecycle'),
(807547, 'aura_ascension_sun_cleric_lifecycle'),
(807749, 'aura_ascension_sun_cleric_lifecycle'),
(807750, 'aura_ascension_sun_cleric_lifecycle'),
(807751, 'aura_ascension_sun_cleric_lifecycle'),
(807752, 'aura_ascension_sun_cleric_lifecycle');

-- aura_ascension_templar_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_templar_event'
    AND `spell_id` IN (
        92108, 92111, 300513, 520007, 524620, 560648, 680397, 704116, 705298, 705306, 706325, 706385,
        707391, 712346, 801441, 801457, 801463, 801466, 801482, 801483, 803158, 803890, 803891, 803892,
        803893, 804912, 804932, 805415, 806353, 806516
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92108, 'aura_ascension_templar_event'),
(92111, 'aura_ascension_templar_event'),
(300513, 'aura_ascension_templar_event'),
(520007, 'aura_ascension_templar_event'),
(524620, 'aura_ascension_templar_event'),
(560648, 'aura_ascension_templar_event'),
(680397, 'aura_ascension_templar_event'),
(704116, 'aura_ascension_templar_event'),
(705298, 'aura_ascension_templar_event'),
(705306, 'aura_ascension_templar_event'),
(706325, 'aura_ascension_templar_event'),
(706385, 'aura_ascension_templar_event'),
(707391, 'aura_ascension_templar_event'),
(712346, 'aura_ascension_templar_event'),
(801441, 'aura_ascension_templar_event'),
(801457, 'aura_ascension_templar_event'),
(801463, 'aura_ascension_templar_event'),
(801466, 'aura_ascension_templar_event'),
(801482, 'aura_ascension_templar_event'),
(801483, 'aura_ascension_templar_event'),
(803158, 'aura_ascension_templar_event'),
(803890, 'aura_ascension_templar_event'),
(803891, 'aura_ascension_templar_event'),
(803892, 'aura_ascension_templar_event'),
(803893, 'aura_ascension_templar_event'),
(804912, 'aura_ascension_templar_event'),
(804932, 'aura_ascension_templar_event'),
(805415, 'aura_ascension_templar_event'),
(806353, 'aura_ascension_templar_event'),
(806516, 'aura_ascension_templar_event');

-- aura_ascension_templar_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_templar_lifecycle'
    AND `spell_id` IN (
        92109, 300513, 301172, 301283, 301369, 524617, 524766, 527023, 527270, 527272, 561156, 563269,
        563270, 681136, 704576, 705299, 706426, 706583, 712378, 801202, 801205, 801409, 801482, 801483,
        803149, 803237, 804903, 804904, 804922, 804924, 805332, 805390, 805409, 805422, 806353, 806354,
        806523, 807004, 807269, 807270, 807271, 807272, 807273, 807274, 807648
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92109, 'aura_ascension_templar_lifecycle'),
(300513, 'aura_ascension_templar_lifecycle'),
(301172, 'aura_ascension_templar_lifecycle'),
(301283, 'aura_ascension_templar_lifecycle'),
(301369, 'aura_ascension_templar_lifecycle'),
(524617, 'aura_ascension_templar_lifecycle'),
(524766, 'aura_ascension_templar_lifecycle'),
(527023, 'aura_ascension_templar_lifecycle'),
(527270, 'aura_ascension_templar_lifecycle'),
(527272, 'aura_ascension_templar_lifecycle'),
(561156, 'aura_ascension_templar_lifecycle'),
(563269, 'aura_ascension_templar_lifecycle'),
(563270, 'aura_ascension_templar_lifecycle'),
(681136, 'aura_ascension_templar_lifecycle'),
(704576, 'aura_ascension_templar_lifecycle'),
(705299, 'aura_ascension_templar_lifecycle'),
(706426, 'aura_ascension_templar_lifecycle'),
(706583, 'aura_ascension_templar_lifecycle'),
(712378, 'aura_ascension_templar_lifecycle'),
(801202, 'aura_ascension_templar_lifecycle'),
(801205, 'aura_ascension_templar_lifecycle'),
(801409, 'aura_ascension_templar_lifecycle'),
(801482, 'aura_ascension_templar_lifecycle'),
(801483, 'aura_ascension_templar_lifecycle'),
(803149, 'aura_ascension_templar_lifecycle'),
(803237, 'aura_ascension_templar_lifecycle'),
(804903, 'aura_ascension_templar_lifecycle'),
(804904, 'aura_ascension_templar_lifecycle'),
(804922, 'aura_ascension_templar_lifecycle'),
(804924, 'aura_ascension_templar_lifecycle'),
(805332, 'aura_ascension_templar_lifecycle'),
(805390, 'aura_ascension_templar_lifecycle'),
(805409, 'aura_ascension_templar_lifecycle'),
(805422, 'aura_ascension_templar_lifecycle'),
(806353, 'aura_ascension_templar_lifecycle'),
(806354, 'aura_ascension_templar_lifecycle'),
(806523, 'aura_ascension_templar_lifecycle'),
(807004, 'aura_ascension_templar_lifecycle'),
(807269, 'aura_ascension_templar_lifecycle'),
(807270, 'aura_ascension_templar_lifecycle'),
(807271, 'aura_ascension_templar_lifecycle'),
(807272, 'aura_ascension_templar_lifecycle'),
(807273, 'aura_ascension_templar_lifecycle'),
(807274, 'aura_ascension_templar_lifecycle'),
(807648, 'aura_ascension_templar_lifecycle');

-- aura_ascension_templar_stagger
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_templar_stagger'
    AND `spell_id` IN (
        92109, 803149
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92109, 'aura_ascension_templar_stagger'),
(803149, 'aura_ascension_templar_stagger');

-- aura_ascension_temporal_anomaly
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_temporal_anomaly'
    AND `spell_id` IN (
        806315
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806315, 'aura_ascension_temporal_anomaly');

-- aura_ascension_thorims_gift
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_thorims_gift'
    AND `spell_id` IN (
        570173
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(570173, 'aura_ascension_thorims_gift');

-- aura_ascension_threat_redirect
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_threat_redirect'
    AND `spell_id` IN (
        534480, 534605, 574356
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(534480, 'aura_ascension_threat_redirect'),
(534605, 'aura_ascension_threat_redirect'),
(574356, 'aura_ascension_threat_redirect');

-- aura_ascension_threat_redirect_active
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_threat_redirect_active'
    AND `spell_id` IN (
        535097, 535214, 574357
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(535097, 'aura_ascension_threat_redirect_active'),
(535214, 'aura_ascension_threat_redirect_active'),
(574357, 'aura_ascension_threat_redirect_active');

-- aura_ascension_timeline_tether
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_timeline_tether'
    AND `spell_id` IN (
        804505
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804505, 'aura_ascension_timeline_tether');

-- aura_ascension_tinker_arcanoreflector
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_arcanoreflector'
    AND `spell_id` IN (
        578339, 653129
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(578339, 'aura_ascension_tinker_arcanoreflector'),
(653129, 'aura_ascension_tinker_arcanoreflector');

-- aura_ascension_tinker_augmentor
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_augmentor'
    AND `spell_id` IN (
        801821
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801821, 'aura_ascension_tinker_augmentor');

-- aura_ascension_tinker_combat_symbiosis
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_combat_symbiosis'
    AND `spell_id` IN (
        805305
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805305, 'aura_ascension_tinker_combat_symbiosis');

-- aura_ascension_tinker_cybernetic
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_cybernetic'
    AND `spell_id` IN (
        807748
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807748, 'aura_ascension_tinker_cybernetic');

-- aura_ascension_tinker_cybernetic_shield
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_cybernetic_shield'
    AND `spell_id` IN (
        653283
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653283, 'aura_ascension_tinker_cybernetic_shield');

-- aura_ascension_tinker_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_event'
    AND `spell_id` IN (
        92138, 300877, 503552, 504523, 504749, 560785, 572367, 573247, 680975, 681001, 704107, 704449,
        705810, 705815, 705817, 705820, 705846, 706379, 706680, 707239, 707698, 806627, 806629, 806758
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92138, 'aura_ascension_tinker_event'),
(300877, 'aura_ascension_tinker_event'),
(503552, 'aura_ascension_tinker_event'),
(504523, 'aura_ascension_tinker_event'),
(504749, 'aura_ascension_tinker_event'),
(560785, 'aura_ascension_tinker_event'),
(572367, 'aura_ascension_tinker_event'),
(573247, 'aura_ascension_tinker_event'),
(680975, 'aura_ascension_tinker_event'),
(681001, 'aura_ascension_tinker_event'),
(704107, 'aura_ascension_tinker_event'),
(704449, 'aura_ascension_tinker_event'),
(705810, 'aura_ascension_tinker_event'),
(705815, 'aura_ascension_tinker_event'),
(705817, 'aura_ascension_tinker_event'),
(705820, 'aura_ascension_tinker_event'),
(705846, 'aura_ascension_tinker_event'),
(706379, 'aura_ascension_tinker_event'),
(706680, 'aura_ascension_tinker_event'),
(707239, 'aura_ascension_tinker_event'),
(707698, 'aura_ascension_tinker_event'),
(806627, 'aura_ascension_tinker_event'),
(806629, 'aura_ascension_tinker_event'),
(806758, 'aura_ascension_tinker_event');

-- aura_ascension_tinker_extender
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_extender'
    AND `spell_id` IN (
        681003
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681003, 'aura_ascension_tinker_extender');

-- aura_ascension_tinker_hacking
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_hacking'
    AND `spell_id` IN (
        705796
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705796, 'aura_ascension_tinker_hacking');

-- aura_ascension_tinker_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_lifecycle'
    AND `spell_id` IN (
        500213, 500232, 500612, 502512, 502513, 502514, 502515, 502516, 502517, 502537, 502544, 502545,
        502546, 502547, 502548, 502549, 502550, 502551, 502552, 502553, 502554, 502555, 502556, 502557,
        502558, 502559, 502560, 502561, 502562, 502563, 502564, 503553, 504667, 520445, 537247, 560709,
        560742, 653273, 680315, 680998, 681245, 705792, 706692, 706742, 707250, 707261, 707272, 707278,
        707346, 707347, 707348, 707349, 707350, 707495, 707688, 707698, 712289, 801384, 801389, 801709,
        801808, 801809, 801816, 803445, 803446, 803447, 803448, 803449, 803450, 803451, 803552, 803658,
        803659, 803660, 803661, 803662, 803663, 803664, 803665, 805315, 805657, 806757, 807635, 808008
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500213, 'aura_ascension_tinker_lifecycle'),
(500232, 'aura_ascension_tinker_lifecycle'),
(500612, 'aura_ascension_tinker_lifecycle'),
(502512, 'aura_ascension_tinker_lifecycle'),
(502513, 'aura_ascension_tinker_lifecycle'),
(502514, 'aura_ascension_tinker_lifecycle'),
(502515, 'aura_ascension_tinker_lifecycle'),
(502516, 'aura_ascension_tinker_lifecycle'),
(502517, 'aura_ascension_tinker_lifecycle'),
(502537, 'aura_ascension_tinker_lifecycle'),
(502544, 'aura_ascension_tinker_lifecycle'),
(502545, 'aura_ascension_tinker_lifecycle'),
(502546, 'aura_ascension_tinker_lifecycle'),
(502547, 'aura_ascension_tinker_lifecycle'),
(502548, 'aura_ascension_tinker_lifecycle'),
(502549, 'aura_ascension_tinker_lifecycle'),
(502550, 'aura_ascension_tinker_lifecycle'),
(502551, 'aura_ascension_tinker_lifecycle'),
(502552, 'aura_ascension_tinker_lifecycle'),
(502553, 'aura_ascension_tinker_lifecycle'),
(502554, 'aura_ascension_tinker_lifecycle'),
(502555, 'aura_ascension_tinker_lifecycle'),
(502556, 'aura_ascension_tinker_lifecycle'),
(502557, 'aura_ascension_tinker_lifecycle'),
(502558, 'aura_ascension_tinker_lifecycle'),
(502559, 'aura_ascension_tinker_lifecycle'),
(502560, 'aura_ascension_tinker_lifecycle'),
(502561, 'aura_ascension_tinker_lifecycle'),
(502562, 'aura_ascension_tinker_lifecycle'),
(502563, 'aura_ascension_tinker_lifecycle'),
(502564, 'aura_ascension_tinker_lifecycle'),
(503553, 'aura_ascension_tinker_lifecycle'),
(504667, 'aura_ascension_tinker_lifecycle'),
(520445, 'aura_ascension_tinker_lifecycle'),
(537247, 'aura_ascension_tinker_lifecycle'),
(560709, 'aura_ascension_tinker_lifecycle'),
(560742, 'aura_ascension_tinker_lifecycle'),
(653273, 'aura_ascension_tinker_lifecycle'),
(680315, 'aura_ascension_tinker_lifecycle'),
(680998, 'aura_ascension_tinker_lifecycle'),
(681245, 'aura_ascension_tinker_lifecycle'),
(705792, 'aura_ascension_tinker_lifecycle'),
(706692, 'aura_ascension_tinker_lifecycle'),
(706742, 'aura_ascension_tinker_lifecycle'),
(707250, 'aura_ascension_tinker_lifecycle'),
(707261, 'aura_ascension_tinker_lifecycle'),
(707272, 'aura_ascension_tinker_lifecycle'),
(707278, 'aura_ascension_tinker_lifecycle'),
(707346, 'aura_ascension_tinker_lifecycle'),
(707347, 'aura_ascension_tinker_lifecycle'),
(707348, 'aura_ascension_tinker_lifecycle'),
(707349, 'aura_ascension_tinker_lifecycle'),
(707350, 'aura_ascension_tinker_lifecycle'),
(707495, 'aura_ascension_tinker_lifecycle'),
(707688, 'aura_ascension_tinker_lifecycle'),
(707698, 'aura_ascension_tinker_lifecycle'),
(712289, 'aura_ascension_tinker_lifecycle'),
(801384, 'aura_ascension_tinker_lifecycle'),
(801389, 'aura_ascension_tinker_lifecycle'),
(801709, 'aura_ascension_tinker_lifecycle'),
(801808, 'aura_ascension_tinker_lifecycle'),
(801809, 'aura_ascension_tinker_lifecycle'),
(801816, 'aura_ascension_tinker_lifecycle'),
(803445, 'aura_ascension_tinker_lifecycle'),
(803446, 'aura_ascension_tinker_lifecycle'),
(803447, 'aura_ascension_tinker_lifecycle'),
(803448, 'aura_ascension_tinker_lifecycle'),
(803449, 'aura_ascension_tinker_lifecycle'),
(803450, 'aura_ascension_tinker_lifecycle'),
(803451, 'aura_ascension_tinker_lifecycle'),
(803552, 'aura_ascension_tinker_lifecycle'),
(803658, 'aura_ascension_tinker_lifecycle'),
(803659, 'aura_ascension_tinker_lifecycle'),
(803660, 'aura_ascension_tinker_lifecycle'),
(803661, 'aura_ascension_tinker_lifecycle'),
(803662, 'aura_ascension_tinker_lifecycle'),
(803663, 'aura_ascension_tinker_lifecycle'),
(803664, 'aura_ascension_tinker_lifecycle'),
(803665, 'aura_ascension_tinker_lifecycle'),
(805315, 'aura_ascension_tinker_lifecycle'),
(805657, 'aura_ascension_tinker_lifecycle'),
(806757, 'aura_ascension_tinker_lifecycle'),
(807635, 'aura_ascension_tinker_lifecycle'),
(808008, 'aura_ascension_tinker_lifecycle');

-- aura_ascension_tinker_overload
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_overload'
    AND `spell_id` IN (
        707403
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707403, 'aura_ascension_tinker_overload');

-- aura_ascension_tinker_rockadier
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_rockadier'
    AND `spell_id` IN (
        801827
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801827, 'aura_ascension_tinker_rockadier');

-- aura_ascension_tinker_stim
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_stim'
    AND `spell_id` IN (
        653240
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653240, 'aura_ascension_tinker_stim');

-- aura_ascension_tinker_stim_pack
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_stim_pack'
    AND `spell_id` IN (
        807531
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807531, 'aura_ascension_tinker_stim_pack');

-- aura_ascension_tinker_tracer
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_tinker_tracer'
    AND `spell_id` IN (
        653247
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653247, 'aura_ascension_tinker_tracer');

-- aura_ascension_unstable
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_unstable'
    AND `spell_id` IN (
        707222
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707222, 'aura_ascension_unstable');

-- aura_ascension_venomancer_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_venomancer_event'
    AND `spell_id` IN (
        92142, 300855, 503812, 503851, 503854, 503856, 503919, 503960, 503976, 504352, 504355, 504361,
        504375, 504402, 504406, 504792, 560200, 560264, 560281, 573307, 574354, 680768, 680800, 704264,
        705959, 705961, 705969, 705980, 705982, 705993, 705998, 706001, 706016, 706018, 706021, 706030,
        706035, 706271, 706370, 706455, 706938, 707224, 707233, 707382, 707620, 707668, 800892, 803210,
        804963, 804981, 804987, 805098, 805884, 805933, 806449, 806603, 806604, 808082, 808083
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92142, 'aura_ascension_venomancer_event'),
(300855, 'aura_ascension_venomancer_event'),
(503812, 'aura_ascension_venomancer_event'),
(503851, 'aura_ascension_venomancer_event'),
(503854, 'aura_ascension_venomancer_event'),
(503856, 'aura_ascension_venomancer_event'),
(503919, 'aura_ascension_venomancer_event'),
(503960, 'aura_ascension_venomancer_event'),
(503976, 'aura_ascension_venomancer_event'),
(504352, 'aura_ascension_venomancer_event'),
(504355, 'aura_ascension_venomancer_event'),
(504361, 'aura_ascension_venomancer_event'),
(504375, 'aura_ascension_venomancer_event'),
(504402, 'aura_ascension_venomancer_event'),
(504406, 'aura_ascension_venomancer_event'),
(504792, 'aura_ascension_venomancer_event'),
(560200, 'aura_ascension_venomancer_event'),
(560264, 'aura_ascension_venomancer_event'),
(560281, 'aura_ascension_venomancer_event'),
(573307, 'aura_ascension_venomancer_event'),
(574354, 'aura_ascension_venomancer_event'),
(680768, 'aura_ascension_venomancer_event'),
(680800, 'aura_ascension_venomancer_event'),
(704264, 'aura_ascension_venomancer_event'),
(705959, 'aura_ascension_venomancer_event'),
(705961, 'aura_ascension_venomancer_event'),
(705969, 'aura_ascension_venomancer_event'),
(705980, 'aura_ascension_venomancer_event'),
(705982, 'aura_ascension_venomancer_event'),
(705993, 'aura_ascension_venomancer_event'),
(705998, 'aura_ascension_venomancer_event'),
(706001, 'aura_ascension_venomancer_event'),
(706016, 'aura_ascension_venomancer_event'),
(706018, 'aura_ascension_venomancer_event'),
(706021, 'aura_ascension_venomancer_event'),
(706030, 'aura_ascension_venomancer_event'),
(706035, 'aura_ascension_venomancer_event'),
(706271, 'aura_ascension_venomancer_event'),
(706370, 'aura_ascension_venomancer_event'),
(706455, 'aura_ascension_venomancer_event'),
(706938, 'aura_ascension_venomancer_event'),
(707224, 'aura_ascension_venomancer_event'),
(707233, 'aura_ascension_venomancer_event'),
(707382, 'aura_ascension_venomancer_event'),
(707620, 'aura_ascension_venomancer_event'),
(707668, 'aura_ascension_venomancer_event'),
(800892, 'aura_ascension_venomancer_event'),
(803210, 'aura_ascension_venomancer_event'),
(804963, 'aura_ascension_venomancer_event'),
(804981, 'aura_ascension_venomancer_event'),
(804987, 'aura_ascension_venomancer_event'),
(805098, 'aura_ascension_venomancer_event'),
(805884, 'aura_ascension_venomancer_event'),
(805933, 'aura_ascension_venomancer_event'),
(806449, 'aura_ascension_venomancer_event'),
(806603, 'aura_ascension_venomancer_event'),
(806604, 'aura_ascension_venomancer_event'),
(808082, 'aura_ascension_venomancer_event'),
(808083, 'aura_ascension_venomancer_event');

-- aura_ascension_venomancer_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_venomancer_lifecycle'
    AND `spell_id` IN (
        502877, 502878, 502879, 502880, 502939, 502940, 502941, 502942, 502943, 502944, 502945, 502946,
        502947, 502968, 502969, 502970, 502971, 502972, 502973, 502974, 502975, 502976, 502977, 502978,
        502979, 502980, 502981, 503983, 503984, 503985, 503986, 504211, 504341, 504737, 504798, 504867,
        505203, 560201, 560265, 570206, 572150, 572151, 572153, 572154, 572155, 572156, 572868, 572869,
        572900, 572901, 572902, 572903, 573355, 578342, 578343, 630932, 631226, 681291, 681321, 704235,
        704264, 705966, 705970, 706017, 706021, 706026, 706032, 706272, 706456, 706940, 706962, 707084,
        707085, 707086, 707087, 707088, 707089, 707090, 707097, 707234, 800293, 800389, 800841, 800843,
        800848, 800870, 800871, 800878, 800892, 800901, 800902, 800906, 800912, 800921, 800926, 800939,
        800959, 800960, 801110, 801115, 801152, 803183, 803210, 803211, 803216, 804962, 804971, 804977,
        804980, 804983, 804986, 805095, 805104, 805139, 805140, 805238, 805931, 806154, 806454, 806602,
        807152, 807153, 807244, 807602, 807603, 807604, 807605, 807606, 807607, 808082, 808083
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(502877, 'aura_ascension_venomancer_lifecycle'),
(502878, 'aura_ascension_venomancer_lifecycle'),
(502879, 'aura_ascension_venomancer_lifecycle'),
(502880, 'aura_ascension_venomancer_lifecycle'),
(502939, 'aura_ascension_venomancer_lifecycle'),
(502940, 'aura_ascension_venomancer_lifecycle'),
(502941, 'aura_ascension_venomancer_lifecycle'),
(502942, 'aura_ascension_venomancer_lifecycle'),
(502943, 'aura_ascension_venomancer_lifecycle'),
(502944, 'aura_ascension_venomancer_lifecycle'),
(502945, 'aura_ascension_venomancer_lifecycle'),
(502946, 'aura_ascension_venomancer_lifecycle'),
(502947, 'aura_ascension_venomancer_lifecycle'),
(502968, 'aura_ascension_venomancer_lifecycle'),
(502969, 'aura_ascension_venomancer_lifecycle'),
(502970, 'aura_ascension_venomancer_lifecycle'),
(502971, 'aura_ascension_venomancer_lifecycle'),
(502972, 'aura_ascension_venomancer_lifecycle'),
(502973, 'aura_ascension_venomancer_lifecycle'),
(502974, 'aura_ascension_venomancer_lifecycle'),
(502975, 'aura_ascension_venomancer_lifecycle'),
(502976, 'aura_ascension_venomancer_lifecycle'),
(502977, 'aura_ascension_venomancer_lifecycle'),
(502978, 'aura_ascension_venomancer_lifecycle'),
(502979, 'aura_ascension_venomancer_lifecycle'),
(502980, 'aura_ascension_venomancer_lifecycle'),
(502981, 'aura_ascension_venomancer_lifecycle'),
(503983, 'aura_ascension_venomancer_lifecycle'),
(503984, 'aura_ascension_venomancer_lifecycle'),
(503985, 'aura_ascension_venomancer_lifecycle'),
(503986, 'aura_ascension_venomancer_lifecycle'),
(504211, 'aura_ascension_venomancer_lifecycle'),
(504341, 'aura_ascension_venomancer_lifecycle'),
(504737, 'aura_ascension_venomancer_lifecycle'),
(504798, 'aura_ascension_venomancer_lifecycle'),
(504867, 'aura_ascension_venomancer_lifecycle'),
(505203, 'aura_ascension_venomancer_lifecycle'),
(560201, 'aura_ascension_venomancer_lifecycle'),
(560265, 'aura_ascension_venomancer_lifecycle'),
(570206, 'aura_ascension_venomancer_lifecycle'),
(572150, 'aura_ascension_venomancer_lifecycle'),
(572151, 'aura_ascension_venomancer_lifecycle'),
(572153, 'aura_ascension_venomancer_lifecycle'),
(572154, 'aura_ascension_venomancer_lifecycle'),
(572155, 'aura_ascension_venomancer_lifecycle'),
(572156, 'aura_ascension_venomancer_lifecycle'),
(572868, 'aura_ascension_venomancer_lifecycle'),
(572869, 'aura_ascension_venomancer_lifecycle'),
(572900, 'aura_ascension_venomancer_lifecycle'),
(572901, 'aura_ascension_venomancer_lifecycle'),
(572902, 'aura_ascension_venomancer_lifecycle'),
(572903, 'aura_ascension_venomancer_lifecycle'),
(573355, 'aura_ascension_venomancer_lifecycle'),
(578342, 'aura_ascension_venomancer_lifecycle'),
(578343, 'aura_ascension_venomancer_lifecycle'),
(630932, 'aura_ascension_venomancer_lifecycle'),
(631226, 'aura_ascension_venomancer_lifecycle'),
(681291, 'aura_ascension_venomancer_lifecycle'),
(681321, 'aura_ascension_venomancer_lifecycle'),
(704235, 'aura_ascension_venomancer_lifecycle'),
(704264, 'aura_ascension_venomancer_lifecycle'),
(705966, 'aura_ascension_venomancer_lifecycle'),
(705970, 'aura_ascension_venomancer_lifecycle'),
(706017, 'aura_ascension_venomancer_lifecycle'),
(706021, 'aura_ascension_venomancer_lifecycle'),
(706026, 'aura_ascension_venomancer_lifecycle'),
(706032, 'aura_ascension_venomancer_lifecycle'),
(706272, 'aura_ascension_venomancer_lifecycle'),
(706456, 'aura_ascension_venomancer_lifecycle'),
(706940, 'aura_ascension_venomancer_lifecycle'),
(706962, 'aura_ascension_venomancer_lifecycle'),
(707084, 'aura_ascension_venomancer_lifecycle'),
(707085, 'aura_ascension_venomancer_lifecycle'),
(707086, 'aura_ascension_venomancer_lifecycle'),
(707087, 'aura_ascension_venomancer_lifecycle'),
(707088, 'aura_ascension_venomancer_lifecycle'),
(707089, 'aura_ascension_venomancer_lifecycle'),
(707090, 'aura_ascension_venomancer_lifecycle'),
(707097, 'aura_ascension_venomancer_lifecycle'),
(707234, 'aura_ascension_venomancer_lifecycle'),
(800293, 'aura_ascension_venomancer_lifecycle'),
(800389, 'aura_ascension_venomancer_lifecycle'),
(800841, 'aura_ascension_venomancer_lifecycle'),
(800843, 'aura_ascension_venomancer_lifecycle'),
(800848, 'aura_ascension_venomancer_lifecycle'),
(800870, 'aura_ascension_venomancer_lifecycle'),
(800871, 'aura_ascension_venomancer_lifecycle'),
(800878, 'aura_ascension_venomancer_lifecycle'),
(800892, 'aura_ascension_venomancer_lifecycle'),
(800901, 'aura_ascension_venomancer_lifecycle'),
(800902, 'aura_ascension_venomancer_lifecycle'),
(800906, 'aura_ascension_venomancer_lifecycle'),
(800912, 'aura_ascension_venomancer_lifecycle'),
(800921, 'aura_ascension_venomancer_lifecycle'),
(800926, 'aura_ascension_venomancer_lifecycle'),
(800939, 'aura_ascension_venomancer_lifecycle'),
(800959, 'aura_ascension_venomancer_lifecycle'),
(800960, 'aura_ascension_venomancer_lifecycle'),
(801110, 'aura_ascension_venomancer_lifecycle'),
(801115, 'aura_ascension_venomancer_lifecycle'),
(801152, 'aura_ascension_venomancer_lifecycle'),
(803183, 'aura_ascension_venomancer_lifecycle'),
(803210, 'aura_ascension_venomancer_lifecycle'),
(803211, 'aura_ascension_venomancer_lifecycle'),
(803216, 'aura_ascension_venomancer_lifecycle'),
(804962, 'aura_ascension_venomancer_lifecycle'),
(804971, 'aura_ascension_venomancer_lifecycle'),
(804977, 'aura_ascension_venomancer_lifecycle'),
(804980, 'aura_ascension_venomancer_lifecycle'),
(804983, 'aura_ascension_venomancer_lifecycle'),
(804986, 'aura_ascension_venomancer_lifecycle'),
(805095, 'aura_ascension_venomancer_lifecycle'),
(805104, 'aura_ascension_venomancer_lifecycle'),
(805139, 'aura_ascension_venomancer_lifecycle'),
(805140, 'aura_ascension_venomancer_lifecycle'),
(805238, 'aura_ascension_venomancer_lifecycle'),
(805931, 'aura_ascension_venomancer_lifecycle'),
(806154, 'aura_ascension_venomancer_lifecycle'),
(806454, 'aura_ascension_venomancer_lifecycle'),
(806602, 'aura_ascension_venomancer_lifecycle'),
(807152, 'aura_ascension_venomancer_lifecycle'),
(807153, 'aura_ascension_venomancer_lifecycle'),
(807244, 'aura_ascension_venomancer_lifecycle'),
(807602, 'aura_ascension_venomancer_lifecycle'),
(807603, 'aura_ascension_venomancer_lifecycle'),
(807604, 'aura_ascension_venomancer_lifecycle'),
(807605, 'aura_ascension_venomancer_lifecycle'),
(807606, 'aura_ascension_venomancer_lifecycle'),
(807607, 'aura_ascension_venomancer_lifecycle'),
(808082, 'aura_ascension_venomancer_lifecycle'),
(808083, 'aura_ascension_venomancer_lifecycle');

-- aura_ascension_venomancer_venom_proc
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_venomancer_venom_proc'
    AND `spell_id` IN (
        630868, 805731, 805775, 805776, 805777, 805778
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(630868, 'aura_ascension_venomancer_venom_proc'),
(805731, 'aura_ascension_venomancer_venom_proc'),
(805775, 'aura_ascension_venomancer_venom_proc'),
(805776, 'aura_ascension_venomancer_venom_proc'),
(805777, 'aura_ascension_venomancer_venom_proc'),
(805778, 'aura_ascension_venomancer_venom_proc');

-- aura_ascension_venomancer_venom_selection
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_venomancer_venom_selection'
    AND `spell_id` IN (
        630868, 805731, 805775, 805776, 805777, 805778
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(630868, 'aura_ascension_venomancer_venom_selection'),
(805731, 'aura_ascension_venomancer_venom_selection'),
(805775, 'aura_ascension_venomancer_venom_selection'),
(805776, 'aura_ascension_venomancer_venom_selection'),
(805777, 'aura_ascension_venomancer_venom_selection'),
(805778, 'aura_ascension_venomancer_venom_selection');

-- aura_ascension_venomancer_wasp_form
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_venomancer_wasp_form'
    AND `spell_id` IN (
        805141
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805141, 'aura_ascension_venomancer_wasp_form');

-- aura_ascension_vindicator_vow_gate
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_vindicator_vow_gate'
    AND `spell_id` IN (
        704938, 707773, 807749
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704938, 'aura_ascension_vindicator_vow_gate'),
(707773, 'aura_ascension_vindicator_vow_gate'),
(807749, 'aura_ascension_vindicator_vow_gate');

-- aura_ascension_waves_of_blood
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_waves_of_blood'
    AND `spell_id` IN (
        681427
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681427, 'aura_ascension_waves_of_blood');

-- aura_ascension_witch_doctor_beam
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_witch_doctor_beam'
    AND `spell_id` IN (
        500950, 501114, 501115, 501116, 501117, 501118, 572577
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500950, 'aura_ascension_witch_doctor_beam'),
(501114, 'aura_ascension_witch_doctor_beam'),
(501115, 'aura_ascension_witch_doctor_beam'),
(501116, 'aura_ascension_witch_doctor_beam'),
(501117, 'aura_ascension_witch_doctor_beam'),
(501118, 'aura_ascension_witch_doctor_beam'),
(572577, 'aura_ascension_witch_doctor_beam');

-- aura_ascension_witch_doctor_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_witch_doctor_event'
    AND `spell_id` IN (
        92084, 500962, 503707, 503714, 560748, 681242, 704495, 704503, 705844, 705871, 705912, 705917,
        705925, 706551, 706557, 801716, 802092, 802756, 802975, 803271, 804620, 807450, 807904
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92084, 'aura_ascension_witch_doctor_event'),
(500962, 'aura_ascension_witch_doctor_event'),
(503707, 'aura_ascension_witch_doctor_event'),
(503714, 'aura_ascension_witch_doctor_event'),
(560748, 'aura_ascension_witch_doctor_event'),
(681242, 'aura_ascension_witch_doctor_event'),
(704495, 'aura_ascension_witch_doctor_event'),
(704503, 'aura_ascension_witch_doctor_event'),
(705844, 'aura_ascension_witch_doctor_event'),
(705871, 'aura_ascension_witch_doctor_event'),
(705912, 'aura_ascension_witch_doctor_event'),
(705917, 'aura_ascension_witch_doctor_event'),
(705925, 'aura_ascension_witch_doctor_event'),
(706551, 'aura_ascension_witch_doctor_event'),
(706557, 'aura_ascension_witch_doctor_event'),
(801716, 'aura_ascension_witch_doctor_event'),
(802092, 'aura_ascension_witch_doctor_event'),
(802756, 'aura_ascension_witch_doctor_event'),
(802975, 'aura_ascension_witch_doctor_event'),
(803271, 'aura_ascension_witch_doctor_event'),
(804620, 'aura_ascension_witch_doctor_event'),
(807450, 'aura_ascension_witch_doctor_event'),
(807904, 'aura_ascension_witch_doctor_event');

-- aura_ascension_witch_doctor_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_witch_doctor_lifecycle'
    AND `spell_id` IN (
        92086, 500015, 500947, 500962, 501080, 501081, 501082, 501083, 501084, 501085, 501086, 501087,
        501088, 501136, 501153, 501154, 501155, 501156, 501157, 501158, 504465, 504608, 547573, 560294,
        560748, 561017, 561067, 561136, 561137, 561140, 561141, 561142, 561143, 561299, 561361, 562715,
        562716, 562717, 562718, 562719, 570064, 572836, 578344, 680872, 680906, 704497, 705870, 705943,
        707650, 707671, 707672, 707673, 707674, 707675, 707676, 707677, 712458, 800195, 800330, 801607,
        801660, 801662, 801663, 801664, 801693, 801716, 801925, 802065, 802100, 802711, 802720, 803325,
        803387, 803678, 803732, 806285, 806289, 806346, 807040, 807057, 807214, 807829, 807830, 807831,
        807832, 807833, 811111, 811112, 811113, 811114, 811115, 811117
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92086, 'aura_ascension_witch_doctor_lifecycle'),
(500015, 'aura_ascension_witch_doctor_lifecycle'),
(500947, 'aura_ascension_witch_doctor_lifecycle'),
(500962, 'aura_ascension_witch_doctor_lifecycle'),
(501080, 'aura_ascension_witch_doctor_lifecycle'),
(501081, 'aura_ascension_witch_doctor_lifecycle'),
(501082, 'aura_ascension_witch_doctor_lifecycle'),
(501083, 'aura_ascension_witch_doctor_lifecycle'),
(501084, 'aura_ascension_witch_doctor_lifecycle'),
(501085, 'aura_ascension_witch_doctor_lifecycle'),
(501086, 'aura_ascension_witch_doctor_lifecycle'),
(501087, 'aura_ascension_witch_doctor_lifecycle'),
(501088, 'aura_ascension_witch_doctor_lifecycle'),
(501136, 'aura_ascension_witch_doctor_lifecycle'),
(501153, 'aura_ascension_witch_doctor_lifecycle'),
(501154, 'aura_ascension_witch_doctor_lifecycle'),
(501155, 'aura_ascension_witch_doctor_lifecycle'),
(501156, 'aura_ascension_witch_doctor_lifecycle'),
(501157, 'aura_ascension_witch_doctor_lifecycle'),
(501158, 'aura_ascension_witch_doctor_lifecycle'),
(504465, 'aura_ascension_witch_doctor_lifecycle'),
(504608, 'aura_ascension_witch_doctor_lifecycle'),
(547573, 'aura_ascension_witch_doctor_lifecycle'),
(560294, 'aura_ascension_witch_doctor_lifecycle'),
(560748, 'aura_ascension_witch_doctor_lifecycle'),
(561017, 'aura_ascension_witch_doctor_lifecycle'),
(561067, 'aura_ascension_witch_doctor_lifecycle'),
(561136, 'aura_ascension_witch_doctor_lifecycle'),
(561137, 'aura_ascension_witch_doctor_lifecycle'),
(561140, 'aura_ascension_witch_doctor_lifecycle'),
(561141, 'aura_ascension_witch_doctor_lifecycle'),
(561142, 'aura_ascension_witch_doctor_lifecycle'),
(561143, 'aura_ascension_witch_doctor_lifecycle'),
(561299, 'aura_ascension_witch_doctor_lifecycle'),
(561361, 'aura_ascension_witch_doctor_lifecycle'),
(562715, 'aura_ascension_witch_doctor_lifecycle'),
(562716, 'aura_ascension_witch_doctor_lifecycle'),
(562717, 'aura_ascension_witch_doctor_lifecycle'),
(562718, 'aura_ascension_witch_doctor_lifecycle'),
(562719, 'aura_ascension_witch_doctor_lifecycle'),
(570064, 'aura_ascension_witch_doctor_lifecycle'),
(572836, 'aura_ascension_witch_doctor_lifecycle'),
(578344, 'aura_ascension_witch_doctor_lifecycle'),
(680872, 'aura_ascension_witch_doctor_lifecycle'),
(680906, 'aura_ascension_witch_doctor_lifecycle'),
(704497, 'aura_ascension_witch_doctor_lifecycle'),
(705870, 'aura_ascension_witch_doctor_lifecycle'),
(705943, 'aura_ascension_witch_doctor_lifecycle'),
(707650, 'aura_ascension_witch_doctor_lifecycle'),
(707671, 'aura_ascension_witch_doctor_lifecycle'),
(707672, 'aura_ascension_witch_doctor_lifecycle'),
(707673, 'aura_ascension_witch_doctor_lifecycle'),
(707674, 'aura_ascension_witch_doctor_lifecycle'),
(707675, 'aura_ascension_witch_doctor_lifecycle'),
(707676, 'aura_ascension_witch_doctor_lifecycle'),
(707677, 'aura_ascension_witch_doctor_lifecycle'),
(712458, 'aura_ascension_witch_doctor_lifecycle'),
(800195, 'aura_ascension_witch_doctor_lifecycle'),
(800330, 'aura_ascension_witch_doctor_lifecycle'),
(801607, 'aura_ascension_witch_doctor_lifecycle'),
(801660, 'aura_ascension_witch_doctor_lifecycle'),
(801662, 'aura_ascension_witch_doctor_lifecycle'),
(801663, 'aura_ascension_witch_doctor_lifecycle'),
(801664, 'aura_ascension_witch_doctor_lifecycle'),
(801693, 'aura_ascension_witch_doctor_lifecycle'),
(801716, 'aura_ascension_witch_doctor_lifecycle'),
(801925, 'aura_ascension_witch_doctor_lifecycle'),
(802065, 'aura_ascension_witch_doctor_lifecycle'),
(802100, 'aura_ascension_witch_doctor_lifecycle'),
(802711, 'aura_ascension_witch_doctor_lifecycle'),
(802720, 'aura_ascension_witch_doctor_lifecycle'),
(803325, 'aura_ascension_witch_doctor_lifecycle'),
(803387, 'aura_ascension_witch_doctor_lifecycle'),
(803678, 'aura_ascension_witch_doctor_lifecycle'),
(803732, 'aura_ascension_witch_doctor_lifecycle'),
(806285, 'aura_ascension_witch_doctor_lifecycle'),
(806289, 'aura_ascension_witch_doctor_lifecycle'),
(806346, 'aura_ascension_witch_doctor_lifecycle'),
(807040, 'aura_ascension_witch_doctor_lifecycle'),
(807057, 'aura_ascension_witch_doctor_lifecycle'),
(807214, 'aura_ascension_witch_doctor_lifecycle'),
(807829, 'aura_ascension_witch_doctor_lifecycle'),
(807830, 'aura_ascension_witch_doctor_lifecycle'),
(807831, 'aura_ascension_witch_doctor_lifecycle'),
(807832, 'aura_ascension_witch_doctor_lifecycle'),
(807833, 'aura_ascension_witch_doctor_lifecycle'),
(811111, 'aura_ascension_witch_doctor_lifecycle'),
(811112, 'aura_ascension_witch_doctor_lifecycle'),
(811113, 'aura_ascension_witch_doctor_lifecycle'),
(811114, 'aura_ascension_witch_doctor_lifecycle'),
(811115, 'aura_ascension_witch_doctor_lifecycle'),
(811117, 'aura_ascension_witch_doctor_lifecycle');

-- aura_ascension_witch_hunter_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_witch_hunter_event'
    AND `spell_id` IN (
        92091, 92093, 139778, 300571, 503659, 503680, 503681, 504470, 504742, 520277, 524970, 560207,
        562027, 578336, 680275, 680497, 680504, 680516, 680528, 680530, 680538, 680544, 680599, 681092,
        681152, 681181, 681329, 681488, 705484, 705496, 705515, 705531, 705534, 706260, 707064, 804024,
        804192, 804404, 805346, 806188, 806195
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92091, 'aura_ascension_witch_hunter_event'),
(92093, 'aura_ascension_witch_hunter_event'),
(139778, 'aura_ascension_witch_hunter_event'),
(300571, 'aura_ascension_witch_hunter_event'),
(503659, 'aura_ascension_witch_hunter_event'),
(503680, 'aura_ascension_witch_hunter_event'),
(503681, 'aura_ascension_witch_hunter_event'),
(504470, 'aura_ascension_witch_hunter_event'),
(504742, 'aura_ascension_witch_hunter_event'),
(520277, 'aura_ascension_witch_hunter_event'),
(524970, 'aura_ascension_witch_hunter_event'),
(560207, 'aura_ascension_witch_hunter_event'),
(562027, 'aura_ascension_witch_hunter_event'),
(578336, 'aura_ascension_witch_hunter_event'),
(680275, 'aura_ascension_witch_hunter_event'),
(680497, 'aura_ascension_witch_hunter_event'),
(680504, 'aura_ascension_witch_hunter_event'),
(680516, 'aura_ascension_witch_hunter_event'),
(680528, 'aura_ascension_witch_hunter_event'),
(680530, 'aura_ascension_witch_hunter_event'),
(680538, 'aura_ascension_witch_hunter_event'),
(680544, 'aura_ascension_witch_hunter_event'),
(680599, 'aura_ascension_witch_hunter_event'),
(681092, 'aura_ascension_witch_hunter_event'),
(681152, 'aura_ascension_witch_hunter_event'),
(681181, 'aura_ascension_witch_hunter_event'),
(681329, 'aura_ascension_witch_hunter_event'),
(681488, 'aura_ascension_witch_hunter_event'),
(705484, 'aura_ascension_witch_hunter_event'),
(705496, 'aura_ascension_witch_hunter_event'),
(705515, 'aura_ascension_witch_hunter_event'),
(705531, 'aura_ascension_witch_hunter_event'),
(705534, 'aura_ascension_witch_hunter_event'),
(706260, 'aura_ascension_witch_hunter_event'),
(707064, 'aura_ascension_witch_hunter_event'),
(804024, 'aura_ascension_witch_hunter_event'),
(804192, 'aura_ascension_witch_hunter_event'),
(804404, 'aura_ascension_witch_hunter_event'),
(805346, 'aura_ascension_witch_hunter_event'),
(806188, 'aura_ascension_witch_hunter_event'),
(806195, 'aura_ascension_witch_hunter_event');

-- aura_ascension_witch_hunter_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_witch_hunter_lifecycle'
    AND `spell_id` IN (
        92091, 500567, 500569, 501380, 503658, 503664, 504713, 504790, 520211, 520212, 520213, 562225,
        562390, 562573, 574319, 574320, 578297, 680492, 680494, 680513, 681095, 681212, 681213, 681214,
        681215, 681216, 681217, 681218, 681219, 681220, 681221, 681453, 681499, 681540, 684330, 707230,
        800165, 802281, 804068, 804185, 805751, 805770, 807682, 807705, 807706, 807707, 807708, 807709,
        807710, 807733, 807797
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92091, 'aura_ascension_witch_hunter_lifecycle'),
(500567, 'aura_ascension_witch_hunter_lifecycle'),
(500569, 'aura_ascension_witch_hunter_lifecycle'),
(501380, 'aura_ascension_witch_hunter_lifecycle'),
(503658, 'aura_ascension_witch_hunter_lifecycle'),
(503664, 'aura_ascension_witch_hunter_lifecycle'),
(504713, 'aura_ascension_witch_hunter_lifecycle'),
(504790, 'aura_ascension_witch_hunter_lifecycle'),
(520211, 'aura_ascension_witch_hunter_lifecycle'),
(520212, 'aura_ascension_witch_hunter_lifecycle'),
(520213, 'aura_ascension_witch_hunter_lifecycle'),
(562225, 'aura_ascension_witch_hunter_lifecycle'),
(562390, 'aura_ascension_witch_hunter_lifecycle'),
(562573, 'aura_ascension_witch_hunter_lifecycle'),
(574319, 'aura_ascension_witch_hunter_lifecycle'),
(574320, 'aura_ascension_witch_hunter_lifecycle'),
(578297, 'aura_ascension_witch_hunter_lifecycle'),
(680492, 'aura_ascension_witch_hunter_lifecycle'),
(680494, 'aura_ascension_witch_hunter_lifecycle'),
(680513, 'aura_ascension_witch_hunter_lifecycle'),
(681095, 'aura_ascension_witch_hunter_lifecycle'),
(681212, 'aura_ascension_witch_hunter_lifecycle'),
(681213, 'aura_ascension_witch_hunter_lifecycle'),
(681214, 'aura_ascension_witch_hunter_lifecycle'),
(681215, 'aura_ascension_witch_hunter_lifecycle'),
(681216, 'aura_ascension_witch_hunter_lifecycle'),
(681217, 'aura_ascension_witch_hunter_lifecycle'),
(681218, 'aura_ascension_witch_hunter_lifecycle'),
(681219, 'aura_ascension_witch_hunter_lifecycle'),
(681220, 'aura_ascension_witch_hunter_lifecycle'),
(681221, 'aura_ascension_witch_hunter_lifecycle'),
(681453, 'aura_ascension_witch_hunter_lifecycle'),
(681499, 'aura_ascension_witch_hunter_lifecycle'),
(681540, 'aura_ascension_witch_hunter_lifecycle'),
(684330, 'aura_ascension_witch_hunter_lifecycle'),
(707230, 'aura_ascension_witch_hunter_lifecycle'),
(800165, 'aura_ascension_witch_hunter_lifecycle'),
(802281, 'aura_ascension_witch_hunter_lifecycle'),
(804068, 'aura_ascension_witch_hunter_lifecycle'),
(804185, 'aura_ascension_witch_hunter_lifecycle'),
(805751, 'aura_ascension_witch_hunter_lifecycle'),
(805770, 'aura_ascension_witch_hunter_lifecycle'),
(807682, 'aura_ascension_witch_hunter_lifecycle'),
(807705, 'aura_ascension_witch_hunter_lifecycle'),
(807706, 'aura_ascension_witch_hunter_lifecycle'),
(807707, 'aura_ascension_witch_hunter_lifecycle'),
(807708, 'aura_ascension_witch_hunter_lifecycle'),
(807709, 'aura_ascension_witch_hunter_lifecycle'),
(807710, 'aura_ascension_witch_hunter_lifecycle'),
(807733, 'aura_ascension_witch_hunter_lifecycle'),
(807797, 'aura_ascension_witch_hunter_lifecycle');

-- aura_ascension_witch_hunter_trap_launcher
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_witch_hunter_trap_launcher'
    AND `spell_id` IN (
        802272
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802272, 'aura_ascension_witch_hunter_trap_launcher');

-- aura_ascension_xoroth_block
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_xoroth_block'
    AND `spell_id` IN (
        706564
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706564, 'aura_ascension_xoroth_block');

-- aura_ascension_xoroth_event
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_xoroth_event'
    AND `spell_id` IN (
        92104, 300376, 302548, 520372, 520662, 524920, 560546, 560630, 562029, 573034, 681449, 704971,
        704972, 704979, 704991, 706502, 706590, 800443, 800702, 800997, 801065, 802602, 802603, 802604,
        802605, 804345
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92104, 'aura_ascension_xoroth_event'),
(300376, 'aura_ascension_xoroth_event'),
(302548, 'aura_ascension_xoroth_event'),
(520372, 'aura_ascension_xoroth_event'),
(520662, 'aura_ascension_xoroth_event'),
(524920, 'aura_ascension_xoroth_event'),
(560546, 'aura_ascension_xoroth_event'),
(560630, 'aura_ascension_xoroth_event'),
(562029, 'aura_ascension_xoroth_event'),
(573034, 'aura_ascension_xoroth_event'),
(681449, 'aura_ascension_xoroth_event'),
(704971, 'aura_ascension_xoroth_event'),
(704972, 'aura_ascension_xoroth_event'),
(704979, 'aura_ascension_xoroth_event'),
(704991, 'aura_ascension_xoroth_event'),
(706502, 'aura_ascension_xoroth_event'),
(706590, 'aura_ascension_xoroth_event'),
(800443, 'aura_ascension_xoroth_event'),
(800702, 'aura_ascension_xoroth_event'),
(800997, 'aura_ascension_xoroth_event'),
(801065, 'aura_ascension_xoroth_event'),
(802602, 'aura_ascension_xoroth_event'),
(802603, 'aura_ascension_xoroth_event'),
(802604, 'aura_ascension_xoroth_event'),
(802605, 'aura_ascension_xoroth_event'),
(804345, 'aura_ascension_xoroth_event');

-- aura_ascension_xoroth_lifecycle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'aura_ascension_xoroth_lifecycle'
    AND `spell_id` IN (
        92101, 92104, 301302, 302555, 500906, 520021, 520294, 520295, 520752, 524913, 524920, 560630,
        570727, 573035, 573075, 573336, 680197, 680203, 680300, 680729, 681184, 704993, 706589, 706755,
        707131, 707341, 707342, 707343, 707344, 707345, 707693, 707694, 707695, 707696, 712294, 712460,
        800710, 800999, 801017, 801019, 801053, 801054, 801063, 801064, 802344, 802345, 802602, 802617,
        802618, 803667, 803668, 803669, 803670, 803671, 803730, 803731, 803889, 804703, 804785, 804786,
        805680, 805746, 806965, 806966, 806967, 806968, 806969, 806970, 807248, 807587
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(92101, 'aura_ascension_xoroth_lifecycle'),
(92104, 'aura_ascension_xoroth_lifecycle'),
(301302, 'aura_ascension_xoroth_lifecycle'),
(302555, 'aura_ascension_xoroth_lifecycle'),
(500906, 'aura_ascension_xoroth_lifecycle'),
(520021, 'aura_ascension_xoroth_lifecycle'),
(520294, 'aura_ascension_xoroth_lifecycle'),
(520295, 'aura_ascension_xoroth_lifecycle'),
(520752, 'aura_ascension_xoroth_lifecycle'),
(524913, 'aura_ascension_xoroth_lifecycle'),
(524920, 'aura_ascension_xoroth_lifecycle'),
(560630, 'aura_ascension_xoroth_lifecycle'),
(570727, 'aura_ascension_xoroth_lifecycle'),
(573035, 'aura_ascension_xoroth_lifecycle'),
(573075, 'aura_ascension_xoroth_lifecycle'),
(573336, 'aura_ascension_xoroth_lifecycle'),
(680197, 'aura_ascension_xoroth_lifecycle'),
(680203, 'aura_ascension_xoroth_lifecycle'),
(680300, 'aura_ascension_xoroth_lifecycle'),
(680729, 'aura_ascension_xoroth_lifecycle'),
(681184, 'aura_ascension_xoroth_lifecycle'),
(704993, 'aura_ascension_xoroth_lifecycle'),
(706589, 'aura_ascension_xoroth_lifecycle'),
(706755, 'aura_ascension_xoroth_lifecycle'),
(707131, 'aura_ascension_xoroth_lifecycle'),
(707341, 'aura_ascension_xoroth_lifecycle'),
(707342, 'aura_ascension_xoroth_lifecycle'),
(707343, 'aura_ascension_xoroth_lifecycle'),
(707344, 'aura_ascension_xoroth_lifecycle'),
(707345, 'aura_ascension_xoroth_lifecycle'),
(707693, 'aura_ascension_xoroth_lifecycle'),
(707694, 'aura_ascension_xoroth_lifecycle'),
(707695, 'aura_ascension_xoroth_lifecycle'),
(707696, 'aura_ascension_xoroth_lifecycle'),
(712294, 'aura_ascension_xoroth_lifecycle'),
(712460, 'aura_ascension_xoroth_lifecycle'),
(800710, 'aura_ascension_xoroth_lifecycle'),
(800999, 'aura_ascension_xoroth_lifecycle'),
(801017, 'aura_ascension_xoroth_lifecycle'),
(801019, 'aura_ascension_xoroth_lifecycle'),
(801053, 'aura_ascension_xoroth_lifecycle'),
(801054, 'aura_ascension_xoroth_lifecycle'),
(801063, 'aura_ascension_xoroth_lifecycle'),
(801064, 'aura_ascension_xoroth_lifecycle'),
(802344, 'aura_ascension_xoroth_lifecycle'),
(802345, 'aura_ascension_xoroth_lifecycle'),
(802602, 'aura_ascension_xoroth_lifecycle'),
(802617, 'aura_ascension_xoroth_lifecycle'),
(802618, 'aura_ascension_xoroth_lifecycle'),
(803667, 'aura_ascension_xoroth_lifecycle'),
(803668, 'aura_ascension_xoroth_lifecycle'),
(803669, 'aura_ascension_xoroth_lifecycle'),
(803670, 'aura_ascension_xoroth_lifecycle'),
(803671, 'aura_ascension_xoroth_lifecycle'),
(803730, 'aura_ascension_xoroth_lifecycle'),
(803731, 'aura_ascension_xoroth_lifecycle'),
(803889, 'aura_ascension_xoroth_lifecycle'),
(804703, 'aura_ascension_xoroth_lifecycle'),
(804785, 'aura_ascension_xoroth_lifecycle'),
(804786, 'aura_ascension_xoroth_lifecycle'),
(805680, 'aura_ascension_xoroth_lifecycle'),
(805746, 'aura_ascension_xoroth_lifecycle'),
(806965, 'aura_ascension_xoroth_lifecycle'),
(806966, 'aura_ascension_xoroth_lifecycle'),
(806967, 'aura_ascension_xoroth_lifecycle'),
(806968, 'aura_ascension_xoroth_lifecycle'),
(806969, 'aura_ascension_xoroth_lifecycle'),
(806970, 'aura_ascension_xoroth_lifecycle'),
(807248, 'aura_ascension_xoroth_lifecycle'),
(807587, 'aura_ascension_xoroth_lifecycle');

-- spell_ascension_air_invigoration_duration
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_air_invigoration_duration'
    AND `spell_id` IN (
        680918
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680918, 'spell_ascension_air_invigoration_duration');

-- spell_ascension_animated_blood
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_animated_blood'
    AND `spell_id` IN (
        573299, 573356, 573357
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(573299, 'spell_ascension_animated_blood'),
(573356, 'spell_ascension_animated_blood'),
(573357, 'spell_ascension_animated_blood');

-- spell_ascension_barbarian_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_barbarian_ability'
    AND `spell_id` IN (
        500002, 500450, 500451, 500452, 500453, 500915, 500919, 500984, 501003, 501004, 501005, 501006,
        501007, 501008, 501009, 501010, 501011, 503088, 503089, 503090, 503091, 503092, 503093, 504912,
        504913, 504914, 504915, 504916, 572330, 572331, 573064, 573224, 573225, 805780, 805808, 806801,
        806802, 806803, 806804, 806805
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500002, 'spell_ascension_barbarian_ability'),
(500450, 'spell_ascension_barbarian_ability'),
(500451, 'spell_ascension_barbarian_ability'),
(500452, 'spell_ascension_barbarian_ability'),
(500453, 'spell_ascension_barbarian_ability'),
(500915, 'spell_ascension_barbarian_ability'),
(500919, 'spell_ascension_barbarian_ability'),
(500984, 'spell_ascension_barbarian_ability'),
(501003, 'spell_ascension_barbarian_ability'),
(501004, 'spell_ascension_barbarian_ability'),
(501005, 'spell_ascension_barbarian_ability'),
(501006, 'spell_ascension_barbarian_ability'),
(501007, 'spell_ascension_barbarian_ability'),
(501008, 'spell_ascension_barbarian_ability'),
(501009, 'spell_ascension_barbarian_ability'),
(501010, 'spell_ascension_barbarian_ability'),
(501011, 'spell_ascension_barbarian_ability'),
(503088, 'spell_ascension_barbarian_ability'),
(503089, 'spell_ascension_barbarian_ability'),
(503090, 'spell_ascension_barbarian_ability'),
(503091, 'spell_ascension_barbarian_ability'),
(503092, 'spell_ascension_barbarian_ability'),
(503093, 'spell_ascension_barbarian_ability'),
(504912, 'spell_ascension_barbarian_ability'),
(504913, 'spell_ascension_barbarian_ability'),
(504914, 'spell_ascension_barbarian_ability'),
(504915, 'spell_ascension_barbarian_ability'),
(504916, 'spell_ascension_barbarian_ability'),
(572330, 'spell_ascension_barbarian_ability'),
(572331, 'spell_ascension_barbarian_ability'),
(573064, 'spell_ascension_barbarian_ability'),
(573224, 'spell_ascension_barbarian_ability'),
(573225, 'spell_ascension_barbarian_ability'),
(805780, 'spell_ascension_barbarian_ability'),
(805808, 'spell_ascension_barbarian_ability'),
(806801, 'spell_ascension_barbarian_ability'),
(806802, 'spell_ascension_barbarian_ability'),
(806803, 'spell_ascension_barbarian_ability'),
(806804, 'spell_ascension_barbarian_ability'),
(806805, 'spell_ascension_barbarian_ability');

-- spell_ascension_barbarian_conversion
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_barbarian_conversion'
    AND `spell_id` IN (
        500534, 524675, 707660, 805785
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500534, 'spell_ascension_barbarian_conversion'),
(524675, 'spell_ascension_barbarian_conversion'),
(707660, 'spell_ascension_barbarian_conversion'),
(805785, 'spell_ascension_barbarian_conversion');

-- spell_ascension_blood_burst
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_blood_burst'
    AND `spell_id` IN (
        803326
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803326, 'spell_ascension_blood_burst');

-- spell_ascension_blood_feast_corpses
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_blood_feast_corpses'
    AND `spell_id` IN (
        706607
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706607, 'spell_ascension_blood_feast_corpses');

-- spell_ascension_blood_feast_drain
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_blood_feast_drain'
    AND `spell_id` IN (
        706606
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706606, 'spell_ascension_blood_feast_drain');

-- spell_ascension_blood_rituals_heal
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_blood_rituals_heal'
    AND `spell_id` IN (
        704119
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704119, 'spell_ascension_blood_rituals_heal');

-- spell_ascension_bloodmage_atheranns_anguish_explosion
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_atheranns_anguish_explosion'
    AND `spell_id` IN (
        680681
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680681, 'spell_ascension_bloodmage_atheranns_anguish_explosion');

-- spell_ascension_bloodmage_blood_craving
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_blood_craving'
    AND `spell_id` IN (
        805985
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805985, 'spell_ascension_bloodmage_blood_craving');

-- spell_ascension_bloodmage_blood_orb_pickup
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_blood_orb_pickup'
    AND `spell_id` IN (
        712419
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712419, 'spell_ascension_bloodmage_blood_orb_pickup');

-- spell_ascension_bloodmage_blood_orb_spawn
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_blood_orb_spawn'
    AND `spell_id` IN (
        707434
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707434, 'spell_ascension_bloodmage_blood_orb_spawn');

-- spell_ascension_bloodmage_empowered
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_empowered'
    AND `spell_id` IN (
        520837, 572896, 572897, 578304, 578305, 804685, 806928, 806929, 806930, 806931, 806932
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520837, 'spell_ascension_bloodmage_empowered'),
(572896, 'spell_ascension_bloodmage_empowered'),
(572897, 'spell_ascension_bloodmage_empowered'),
(578304, 'spell_ascension_bloodmage_empowered'),
(578305, 'spell_ascension_bloodmage_empowered'),
(804685, 'spell_ascension_bloodmage_empowered'),
(806928, 'spell_ascension_bloodmage_empowered'),
(806929, 'spell_ascension_bloodmage_empowered'),
(806930, 'spell_ascension_bloodmage_empowered'),
(806931, 'spell_ascension_bloodmage_empowered'),
(806932, 'spell_ascension_bloodmage_empowered');

-- spell_ascension_bloodmage_excision
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_excision'
    AND `spell_id` IN (
        803733
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803733, 'spell_ascension_bloodmage_excision');

-- spell_ascension_bloodmage_hemal_excision
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_hemal_excision'
    AND `spell_id` IN (
        803681
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803681, 'spell_ascension_bloodmage_hemal_excision');

-- spell_ascension_bloodmage_infuse_unleash
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_infuse_unleash'
    AND `spell_id` IN (
        681404
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681404, 'spell_ascension_bloodmage_infuse_unleash');

-- spell_ascension_bloodmage_lunge
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_lunge'
    AND `spell_id` IN (
        500126
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500126, 'spell_ascension_bloodmage_lunge');

-- spell_ascension_cultist_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_cultist_ability'
    AND `spell_id` IN (
        255282, 301184, 301988, 500704, 500707, 503652, 520348, 560301, 572103, 680573, 680576, 706932,
        801153, 802042, 802044, 804777, 804779, 805114, 807308, 807878, 808036, 808037, 808038
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(255282, 'spell_ascension_cultist_ability'),
(301184, 'spell_ascension_cultist_ability'),
(301988, 'spell_ascension_cultist_ability'),
(500704, 'spell_ascension_cultist_ability'),
(500707, 'spell_ascension_cultist_ability'),
(503652, 'spell_ascension_cultist_ability'),
(520348, 'spell_ascension_cultist_ability'),
(560301, 'spell_ascension_cultist_ability'),
(572103, 'spell_ascension_cultist_ability'),
(680573, 'spell_ascension_cultist_ability'),
(680576, 'spell_ascension_cultist_ability'),
(706932, 'spell_ascension_cultist_ability'),
(801153, 'spell_ascension_cultist_ability'),
(802042, 'spell_ascension_cultist_ability'),
(802044, 'spell_ascension_cultist_ability'),
(804777, 'spell_ascension_cultist_ability'),
(804779, 'spell_ascension_cultist_ability'),
(805114, 'spell_ascension_cultist_ability'),
(807308, 'spell_ascension_cultist_ability'),
(807878, 'spell_ascension_cultist_ability'),
(808036, 'spell_ascension_cultist_ability'),
(808037, 'spell_ascension_cultist_ability'),
(808038, 'spell_ascension_cultist_ability');

-- spell_ascension_cultist_resource
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_cultist_resource'
    AND `spell_id` IN (
        300177, 500728, 503695, 504852, 520439, 520775, 520790, 560015, 560716, 570188, 572857, 681103,
        704872, 706264, 706923, 706925, 707098, 801157, 804209, 804211, 804214, 804215, 804314, 805586,
        807847, 808024
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300177, 'spell_ascension_cultist_resource'),
(500728, 'spell_ascension_cultist_resource'),
(503695, 'spell_ascension_cultist_resource'),
(504852, 'spell_ascension_cultist_resource'),
(520439, 'spell_ascension_cultist_resource'),
(520775, 'spell_ascension_cultist_resource'),
(520790, 'spell_ascension_cultist_resource'),
(560015, 'spell_ascension_cultist_resource'),
(560716, 'spell_ascension_cultist_resource'),
(570188, 'spell_ascension_cultist_resource'),
(572857, 'spell_ascension_cultist_resource'),
(681103, 'spell_ascension_cultist_resource'),
(704872, 'spell_ascension_cultist_resource'),
(706264, 'spell_ascension_cultist_resource'),
(706923, 'spell_ascension_cultist_resource'),
(706925, 'spell_ascension_cultist_resource'),
(707098, 'spell_ascension_cultist_resource'),
(801157, 'spell_ascension_cultist_resource'),
(804209, 'spell_ascension_cultist_resource'),
(804211, 'spell_ascension_cultist_resource'),
(804214, 'spell_ascension_cultist_resource'),
(804215, 'spell_ascension_cultist_resource'),
(804314, 'spell_ascension_cultist_resource'),
(805586, 'spell_ascension_cultist_resource'),
(807847, 'spell_ascension_cultist_resource'),
(808024, 'spell_ascension_cultist_resource');

-- spell_ascension_cultist_sanity_tap
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_cultist_sanity_tap'
    AND `spell_id` IN (
        802575
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802575, 'spell_ascension_cultist_sanity_tap');

-- spell_ascension_cultist_shield
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_cultist_shield'
    AND `spell_id` IN (
        500715, 502244, 502245, 502246, 502247, 578114, 578115, 806745
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500715, 'spell_ascension_cultist_shield'),
(502244, 'spell_ascension_cultist_shield'),
(502245, 'spell_ascension_cultist_shield'),
(502246, 'spell_ascension_cultist_shield'),
(502247, 'spell_ascension_cultist_shield'),
(578114, 'spell_ascension_cultist_shield'),
(578115, 'spell_ascension_cultist_shield'),
(806745, 'spell_ascension_cultist_shield');

-- spell_ascension_cultist_worrysome_idol
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_cultist_worrysome_idol'
    AND `spell_id` IN (
        504829
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504829, 'spell_ascension_cultist_worrysome_idol');

-- spell_ascension_dark_essence
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_dark_essence'
    AND `spell_id` IN (
        681036
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681036, 'spell_ascension_dark_essence');

-- spell_ascension_decoy_strike
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_decoy_strike'
    AND `spell_id` IN (
        557328
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(557328, 'spell_ascension_decoy_strike');

-- spell_ascension_destabilize_time
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_destabilize_time'
    AND `spell_id` IN (
        680971
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680971, 'spell_ascension_destabilize_time');

-- spell_ascension_dimensional_divergence
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_dimensional_divergence'
    AND `spell_id` IN (
        802790
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802790, 'spell_ascension_dimensional_divergence');

-- spell_ascension_felsworn_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_felsworn_ability'
    AND `spell_id` IN (
        572163, 572183, 705121, 803089, 807942
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(572163, 'spell_ascension_felsworn_ability'),
(572183, 'spell_ascension_felsworn_ability'),
(705121, 'spell_ascension_felsworn_ability'),
(803089, 'spell_ascension_felsworn_ability'),
(807942, 'spell_ascension_felsworn_ability');

-- spell_ascension_guardian_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_guardian_ability'
    AND `spell_id` IN (
        500258, 500463, 500673, 501068, 501069, 501070, 501071, 501072, 501073, 501074, 503119, 503120,
        503121, 503122, 503123, 503124, 503125, 503126, 504177, 504178, 504179, 504180, 504181, 504182,
        572142, 572143, 572144, 572145, 572146, 572147, 573204, 573205, 573206, 573207, 573208, 573209,
        573210, 573211, 573286, 573292, 574340, 800311, 800316, 801776, 802284, 802439, 802440, 802441,
        802442, 802443, 802629, 802739, 802740, 802741, 802742, 802743, 802744, 802871, 803129, 803963,
        805150
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500258, 'spell_ascension_guardian_ability'),
(500463, 'spell_ascension_guardian_ability'),
(500673, 'spell_ascension_guardian_ability'),
(501068, 'spell_ascension_guardian_ability'),
(501069, 'spell_ascension_guardian_ability'),
(501070, 'spell_ascension_guardian_ability'),
(501071, 'spell_ascension_guardian_ability'),
(501072, 'spell_ascension_guardian_ability'),
(501073, 'spell_ascension_guardian_ability'),
(501074, 'spell_ascension_guardian_ability'),
(503119, 'spell_ascension_guardian_ability'),
(503120, 'spell_ascension_guardian_ability'),
(503121, 'spell_ascension_guardian_ability'),
(503122, 'spell_ascension_guardian_ability'),
(503123, 'spell_ascension_guardian_ability'),
(503124, 'spell_ascension_guardian_ability'),
(503125, 'spell_ascension_guardian_ability'),
(503126, 'spell_ascension_guardian_ability'),
(504177, 'spell_ascension_guardian_ability'),
(504178, 'spell_ascension_guardian_ability'),
(504179, 'spell_ascension_guardian_ability'),
(504180, 'spell_ascension_guardian_ability'),
(504181, 'spell_ascension_guardian_ability'),
(504182, 'spell_ascension_guardian_ability'),
(572142, 'spell_ascension_guardian_ability'),
(572143, 'spell_ascension_guardian_ability'),
(572144, 'spell_ascension_guardian_ability'),
(572145, 'spell_ascension_guardian_ability'),
(572146, 'spell_ascension_guardian_ability'),
(572147, 'spell_ascension_guardian_ability'),
(573204, 'spell_ascension_guardian_ability'),
(573205, 'spell_ascension_guardian_ability'),
(573206, 'spell_ascension_guardian_ability'),
(573207, 'spell_ascension_guardian_ability'),
(573208, 'spell_ascension_guardian_ability'),
(573209, 'spell_ascension_guardian_ability'),
(573210, 'spell_ascension_guardian_ability'),
(573211, 'spell_ascension_guardian_ability'),
(573286, 'spell_ascension_guardian_ability'),
(573292, 'spell_ascension_guardian_ability'),
(574340, 'spell_ascension_guardian_ability'),
(800311, 'spell_ascension_guardian_ability'),
(800316, 'spell_ascension_guardian_ability'),
(801776, 'spell_ascension_guardian_ability'),
(802284, 'spell_ascension_guardian_ability'),
(802439, 'spell_ascension_guardian_ability'),
(802440, 'spell_ascension_guardian_ability'),
(802441, 'spell_ascension_guardian_ability'),
(802442, 'spell_ascension_guardian_ability'),
(802443, 'spell_ascension_guardian_ability'),
(802629, 'spell_ascension_guardian_ability'),
(802739, 'spell_ascension_guardian_ability'),
(802740, 'spell_ascension_guardian_ability'),
(802741, 'spell_ascension_guardian_ability'),
(802742, 'spell_ascension_guardian_ability'),
(802743, 'spell_ascension_guardian_ability'),
(802744, 'spell_ascension_guardian_ability'),
(802871, 'spell_ascension_guardian_ability'),
(803129, 'spell_ascension_guardian_ability'),
(803963, 'spell_ascension_guardian_ability'),
(805150, 'spell_ascension_guardian_ability');

-- spell_ascension_guardian_converted_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_guardian_converted_damage'
    AND `spell_id` IN (
        524091, 573275, 575831
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(524091, 'spell_ascension_guardian_converted_damage'),
(573275, 'spell_ascension_guardian_converted_damage'),
(575831, 'spell_ascension_guardian_converted_damage');

-- spell_ascension_guardian_drums
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_guardian_drums'
    AND `spell_id` IN (
        803683
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803683, 'spell_ascension_guardian_drums');

-- spell_ascension_guardian_reclaim
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_guardian_reclaim'
    AND `spell_id` IN (
        574339, 801504
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(574339, 'spell_ascension_guardian_reclaim'),
(801504, 'spell_ascension_guardian_reclaim');

-- spell_ascension_guardian_standard
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_guardian_standard'
    AND `spell_id` IN (
        500260, 500263, 500547, 706805, 800319, 800346, 803931, 803932, 803933, 803934, 803935, 803936,
        803937, 803938
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500260, 'spell_ascension_guardian_standard'),
(500263, 'spell_ascension_guardian_standard'),
(500547, 'spell_ascension_guardian_standard'),
(706805, 'spell_ascension_guardian_standard'),
(800319, 'spell_ascension_guardian_standard'),
(800346, 'spell_ascension_guardian_standard'),
(803931, 'spell_ascension_guardian_standard'),
(803932, 'spell_ascension_guardian_standard'),
(803933, 'spell_ascension_guardian_standard'),
(803934, 'spell_ascension_guardian_standard'),
(803935, 'spell_ascension_guardian_standard'),
(803936, 'spell_ascension_guardian_standard'),
(803937, 'spell_ascension_guardian_standard'),
(803938, 'spell_ascension_guardian_standard');

-- spell_ascension_hurricane_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_hurricane_damage'
    AND `spell_id` IN (
        645437
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(645437, 'spell_ascension_hurricane_damage');

-- spell_ascension_melt_copy
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_melt_copy'
    AND `spell_id` IN (
        807570
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807570, 'spell_ascension_melt_copy');

-- spell_ascension_necromancer_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_necromancer_ability'
    AND `spell_id` IN (
        500443, 500991, 504020, 504021, 504050, 504052, 504316, 504318, 504319, 504334, 504489, 504860,
        504862, 504863, 504864, 504865, 504868, 504905, 504907, 504908, 525388, 533236, 533237, 533238,
        533239, 570132, 801545, 801938, 802121, 803767, 803773, 803781, 805027, 805871, 807098, 807938,
        807939, 807940, 807941
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500443, 'spell_ascension_necromancer_ability'),
(500991, 'spell_ascension_necromancer_ability'),
(504020, 'spell_ascension_necromancer_ability'),
(504021, 'spell_ascension_necromancer_ability'),
(504050, 'spell_ascension_necromancer_ability'),
(504052, 'spell_ascension_necromancer_ability'),
(504316, 'spell_ascension_necromancer_ability'),
(504318, 'spell_ascension_necromancer_ability'),
(504319, 'spell_ascension_necromancer_ability'),
(504334, 'spell_ascension_necromancer_ability'),
(504489, 'spell_ascension_necromancer_ability'),
(504860, 'spell_ascension_necromancer_ability'),
(504862, 'spell_ascension_necromancer_ability'),
(504863, 'spell_ascension_necromancer_ability'),
(504864, 'spell_ascension_necromancer_ability'),
(504865, 'spell_ascension_necromancer_ability'),
(504868, 'spell_ascension_necromancer_ability'),
(504905, 'spell_ascension_necromancer_ability'),
(504907, 'spell_ascension_necromancer_ability'),
(504908, 'spell_ascension_necromancer_ability'),
(525388, 'spell_ascension_necromancer_ability'),
(533236, 'spell_ascension_necromancer_ability'),
(533237, 'spell_ascension_necromancer_ability'),
(533238, 'spell_ascension_necromancer_ability'),
(533239, 'spell_ascension_necromancer_ability'),
(570132, 'spell_ascension_necromancer_ability'),
(801545, 'spell_ascension_necromancer_ability'),
(801938, 'spell_ascension_necromancer_ability'),
(802121, 'spell_ascension_necromancer_ability'),
(803767, 'spell_ascension_necromancer_ability'),
(803773, 'spell_ascension_necromancer_ability'),
(803781, 'spell_ascension_necromancer_ability'),
(805027, 'spell_ascension_necromancer_ability'),
(805871, 'spell_ascension_necromancer_ability'),
(807098, 'spell_ascension_necromancer_ability'),
(807938, 'spell_ascension_necromancer_ability'),
(807939, 'spell_ascension_necromancer_ability'),
(807940, 'spell_ascension_necromancer_ability'),
(807941, 'spell_ascension_necromancer_ability');

-- spell_ascension_necromancer_summon
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_necromancer_summon'
    AND `spell_id` IN (
        302586, 302913, 500329, 500330, 500335, 500365, 500933, 500969, 500970, 500971, 500989, 504313,
        504505, 504682, 504859, 504861, 504901, 520367, 525379, 525380, 531130, 561316, 600992, 704292,
        704722, 707007, 800936, 801941, 803139, 804681, 805032, 805038, 805044, 805048, 805049, 805252,
        805426, 805428, 805977, 806087, 807811, 807813, 899900, 899901
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(302586, 'spell_ascension_necromancer_summon'),
(302913, 'spell_ascension_necromancer_summon'),
(500329, 'spell_ascension_necromancer_summon'),
(500330, 'spell_ascension_necromancer_summon'),
(500335, 'spell_ascension_necromancer_summon'),
(500365, 'spell_ascension_necromancer_summon'),
(500933, 'spell_ascension_necromancer_summon'),
(500969, 'spell_ascension_necromancer_summon'),
(500970, 'spell_ascension_necromancer_summon'),
(500971, 'spell_ascension_necromancer_summon'),
(500989, 'spell_ascension_necromancer_summon'),
(504313, 'spell_ascension_necromancer_summon'),
(504505, 'spell_ascension_necromancer_summon'),
(504682, 'spell_ascension_necromancer_summon'),
(504859, 'spell_ascension_necromancer_summon'),
(504861, 'spell_ascension_necromancer_summon'),
(504901, 'spell_ascension_necromancer_summon'),
(520367, 'spell_ascension_necromancer_summon'),
(525379, 'spell_ascension_necromancer_summon'),
(525380, 'spell_ascension_necromancer_summon'),
(531130, 'spell_ascension_necromancer_summon'),
(561316, 'spell_ascension_necromancer_summon'),
(600992, 'spell_ascension_necromancer_summon'),
(704292, 'spell_ascension_necromancer_summon'),
(704722, 'spell_ascension_necromancer_summon'),
(707007, 'spell_ascension_necromancer_summon'),
(800936, 'spell_ascension_necromancer_summon'),
(801941, 'spell_ascension_necromancer_summon'),
(803139, 'spell_ascension_necromancer_summon'),
(804681, 'spell_ascension_necromancer_summon'),
(805032, 'spell_ascension_necromancer_summon'),
(805038, 'spell_ascension_necromancer_summon'),
(805044, 'spell_ascension_necromancer_summon'),
(805048, 'spell_ascension_necromancer_summon'),
(805049, 'spell_ascension_necromancer_summon'),
(805252, 'spell_ascension_necromancer_summon'),
(805426, 'spell_ascension_necromancer_summon'),
(805428, 'spell_ascension_necromancer_summon'),
(805977, 'spell_ascension_necromancer_summon'),
(806087, 'spell_ascension_necromancer_summon'),
(807811, 'spell_ascension_necromancer_summon'),
(807813, 'spell_ascension_necromancer_summon'),
(899900, 'spell_ascension_necromancer_summon'),
(899901, 'spell_ascension_necromancer_summon');

-- spell_ascension_outmaneuver
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_outmaneuver'
    AND `spell_id` IN (
        557325
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(557325, 'spell_ascension_outmaneuver');

-- spell_ascension_primalist_earthshaping
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_primalist_earthshaping'
    AND `spell_id` IN (
        680441
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680441, 'spell_ascension_primalist_earthshaping');

-- spell_ascension_primalist_earthshaping_gain
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_primalist_earthshaping_gain'
    AND `spell_id` IN (
        681072, 681264
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681072, 'spell_ascension_primalist_earthshaping_gain'),
(681264, 'spell_ascension_primalist_earthshaping_gain');

-- spell_ascension_pyromancer_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_pyromancer_ability'
    AND `spell_id` IN (
        520019, 520868, 704278, 706854, 800796, 800816, 801911, 802791
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520019, 'spell_ascension_pyromancer_ability'),
(520868, 'spell_ascension_pyromancer_ability'),
(704278, 'spell_ascension_pyromancer_ability'),
(706854, 'spell_ascension_pyromancer_ability'),
(800796, 'spell_ascension_pyromancer_ability'),
(800816, 'spell_ascension_pyromancer_ability'),
(801911, 'spell_ascension_pyromancer_ability'),
(802791, 'spell_ascension_pyromancer_ability');

-- spell_ascension_pyromancer_resource
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_pyromancer_resource'
    AND `spell_id` IN (
        521642, 572381, 572806, 680365, 804301, 807390, 807391, 807392, 807393, 807394, 807401, 807402,
        807412, 807533, 807535, 807536, 807613, 807768, 808064
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(521642, 'spell_ascension_pyromancer_resource'),
(572381, 'spell_ascension_pyromancer_resource'),
(572806, 'spell_ascension_pyromancer_resource'),
(680365, 'spell_ascension_pyromancer_resource'),
(804301, 'spell_ascension_pyromancer_resource'),
(807390, 'spell_ascension_pyromancer_resource'),
(807391, 'spell_ascension_pyromancer_resource'),
(807392, 'spell_ascension_pyromancer_resource'),
(807393, 'spell_ascension_pyromancer_resource'),
(807394, 'spell_ascension_pyromancer_resource'),
(807401, 'spell_ascension_pyromancer_resource'),
(807402, 'spell_ascension_pyromancer_resource'),
(807412, 'spell_ascension_pyromancer_resource'),
(807533, 'spell_ascension_pyromancer_resource'),
(807535, 'spell_ascension_pyromancer_resource'),
(807536, 'spell_ascension_pyromancer_resource'),
(807613, 'spell_ascension_pyromancer_resource'),
(807768, 'spell_ascension_pyromancer_resource'),
(808064, 'spell_ascension_pyromancer_resource');

-- spell_ascension_raging_zephyr
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_raging_zephyr'
    AND `spell_id` IN (
        704201
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704201, 'spell_ascension_raging_zephyr');

-- spell_ascension_raid_damage_aura
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_raid_damage_aura'
    AND `spell_id` IN (
        524600, 680679, 801130, 804737
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(524600, 'spell_ascension_raid_damage_aura'),
(680679, 'spell_ascension_raid_damage_aura'),
(801130, 'spell_ascension_raid_damage_aura'),
(804737, 'spell_ascension_raid_damage_aura');

-- spell_ascension_ranger_falconstrike
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_falconstrike'
    AND `spell_id` IN (
        806345, 806437, 806438, 806439, 806440, 806441, 806442, 806443
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806345, 'spell_ascension_ranger_falconstrike'),
(806437, 'spell_ascension_ranger_falconstrike'),
(806438, 'spell_ascension_ranger_falconstrike'),
(806439, 'spell_ascension_ranger_falconstrike'),
(806440, 'spell_ascension_ranger_falconstrike'),
(806441, 'spell_ascension_ranger_falconstrike'),
(806442, 'spell_ascension_ranger_falconstrike'),
(806443, 'spell_ascension_ranger_falconstrike');

-- spell_ascension_ranger_flower_pickup
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_flower_pickup'
    AND `spell_id` IN (
        561008
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(561008, 'spell_ascension_ranger_flower_pickup');

-- spell_ascension_ranger_frenzy
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_frenzy'
    AND `spell_id` IN (
        520492
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520492, 'spell_ascension_ranger_frenzy');

-- spell_ascension_ranger_green_flower
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_green_flower'
    AND `spell_id` IN (
        561005, 800246, 803507, 803508, 803510, 803720
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(561005, 'spell_ascension_ranger_green_flower'),
(800246, 'spell_ascension_ranger_green_flower'),
(803507, 'spell_ascension_ranger_green_flower'),
(803508, 'spell_ascension_ranger_green_flower'),
(803510, 'spell_ascension_ranger_green_flower'),
(803720, 'spell_ascension_ranger_green_flower');

-- spell_ascension_ranger_highlander
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_highlander'
    AND `spell_id` IN (
        806345, 806437, 806438, 806439, 806440, 806441, 806442, 806443
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806345, 'spell_ascension_ranger_highlander'),
(806437, 'spell_ascension_ranger_highlander'),
(806438, 'spell_ascension_ranger_highlander'),
(806439, 'spell_ascension_ranger_highlander'),
(806440, 'spell_ascension_ranger_highlander'),
(806441, 'spell_ascension_ranger_highlander'),
(806442, 'spell_ascension_ranger_highlander'),
(806443, 'spell_ascension_ranger_highlander');

-- spell_ascension_ranger_knockout
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_knockout'
    AND `spell_id` IN (
        801435
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801435, 'spell_ascension_ranger_knockout');

-- spell_ascension_ranger_light_arrows
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_light_arrows'
    AND `spell_id` IN (
        500075, 572108, 572109, 572110, 572111, 572112, 572113
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500075, 'spell_ascension_ranger_light_arrows'),
(572108, 'spell_ascension_ranger_light_arrows'),
(572109, 'spell_ascension_ranger_light_arrows'),
(572110, 'spell_ascension_ranger_light_arrows'),
(572111, 'spell_ascension_ranger_light_arrows'),
(572112, 'spell_ascension_ranger_light_arrows'),
(572113, 'spell_ascension_ranger_light_arrows');

-- spell_ascension_ranger_polearm_gate
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_polearm_gate'
    AND `spell_id` IN (
        707887, 712481, 803854
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707887, 'spell_ascension_ranger_polearm_gate'),
(712481, 'spell_ascension_ranger_polearm_gate'),
(803854, 'spell_ascension_ranger_polearm_gate');

-- spell_ascension_ranger_red_flower
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_red_flower'
    AND `spell_id` IN (
        521222
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(521222, 'spell_ascension_ranger_red_flower');

-- spell_ascension_ranger_rusty_shiv
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_rusty_shiv'
    AND `spell_id` IN (
        561315
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(561315, 'spell_ascension_ranger_rusty_shiv');

-- spell_ascension_ranger_rusty_shiv_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_rusty_shiv_damage'
    AND `spell_id` IN (
        681459
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(681459, 'spell_ascension_ranger_rusty_shiv_damage');

-- spell_ascension_ranger_whipvine_targets
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_ranger_whipvine_targets'
    AND `spell_id` IN (
        806342
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806342, 'spell_ascension_ranger_whipvine_targets');

-- spell_ascension_reaper_anima_ambusher
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_anima_ambusher'
    AND `spell_id` IN (
        803742
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803742, 'spell_ascension_reaper_anima_ambusher');

-- spell_ascension_reaper_blood_binding_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_blood_binding_damage'
    AND `spell_id` IN (
        801334
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801334, 'spell_ascension_reaper_blood_binding_damage');

-- spell_ascension_reaper_chasing_death_extender
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_chasing_death_extender'
    AND `spell_id` IN (
        807546
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807546, 'spell_ascension_reaper_chasing_death_extender');

-- spell_ascension_reaper_dirge_dagger
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_dirge_dagger'
    AND `spell_id` IN (
        801311
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801311, 'spell_ascension_reaper_dirge_dagger');

-- spell_ascension_reaper_dirge_weapons
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_dirge_weapons'
    AND `spell_id` IN (
        801328, 803834, 803835, 803836, 803837, 803838, 803839
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801328, 'spell_ascension_reaper_dirge_weapons'),
(803834, 'spell_ascension_reaper_dirge_weapons'),
(803835, 'spell_ascension_reaper_dirge_weapons'),
(803836, 'spell_ascension_reaper_dirge_weapons'),
(803837, 'spell_ascension_reaper_dirge_weapons'),
(803838, 'spell_ascension_reaper_dirge_weapons'),
(803839, 'spell_ascension_reaper_dirge_weapons');

-- spell_ascension_reaper_essence_invigoration_heal
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_essence_invigoration_heal'
    AND `spell_id` IN (
        805187
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805187, 'spell_ascension_reaper_essence_invigoration_heal');

-- spell_ascension_reaper_redshade_reap
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_redshade_reap'
    AND `spell_id` IN (
        354319, 500357, 504056, 504057, 504058, 504557, 505151, 573302, 573303
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(354319, 'spell_ascension_reaper_redshade_reap'),
(500357, 'spell_ascension_reaper_redshade_reap'),
(504056, 'spell_ascension_reaper_redshade_reap'),
(504057, 'spell_ascension_reaper_redshade_reap'),
(504058, 'spell_ascension_reaper_redshade_reap'),
(504557, 'spell_ascension_reaper_redshade_reap'),
(505151, 'spell_ascension_reaper_redshade_reap'),
(573302, 'spell_ascension_reaper_redshade_reap'),
(573303, 'spell_ascension_reaper_redshade_reap');

-- spell_ascension_reaper_ruin_mark
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_ruin_mark'
    AND `spell_id` IN (
        801322
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801322, 'spell_ascension_reaper_ruin_mark');

-- spell_ascension_reaper_talent_proc
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_talent_proc'
    AND `spell_id` IN (
        300565, 301193, 500286, 504309, 520056, 524939, 560412, 560478, 560487, 560919, 561127, 561170,
        561340, 680996, 704193, 704356, 704357, 704552, 704558, 705403, 705414, 705426, 705428, 705437,
        706792, 706795, 707707, 712484, 801325, 805196
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300565, 'spell_ascension_reaper_talent_proc'),
(301193, 'spell_ascension_reaper_talent_proc'),
(500286, 'spell_ascension_reaper_talent_proc'),
(504309, 'spell_ascension_reaper_talent_proc'),
(520056, 'spell_ascension_reaper_talent_proc'),
(524939, 'spell_ascension_reaper_talent_proc'),
(560412, 'spell_ascension_reaper_talent_proc'),
(560478, 'spell_ascension_reaper_talent_proc'),
(560487, 'spell_ascension_reaper_talent_proc'),
(560919, 'spell_ascension_reaper_talent_proc'),
(561127, 'spell_ascension_reaper_talent_proc'),
(561170, 'spell_ascension_reaper_talent_proc'),
(561340, 'spell_ascension_reaper_talent_proc'),
(680996, 'spell_ascension_reaper_talent_proc'),
(704193, 'spell_ascension_reaper_talent_proc'),
(704356, 'spell_ascension_reaper_talent_proc'),
(704357, 'spell_ascension_reaper_talent_proc'),
(704552, 'spell_ascension_reaper_talent_proc'),
(704558, 'spell_ascension_reaper_talent_proc'),
(705403, 'spell_ascension_reaper_talent_proc'),
(705414, 'spell_ascension_reaper_talent_proc'),
(705426, 'spell_ascension_reaper_talent_proc'),
(705428, 'spell_ascension_reaper_talent_proc'),
(705437, 'spell_ascension_reaper_talent_proc'),
(706792, 'spell_ascension_reaper_talent_proc'),
(706795, 'spell_ascension_reaper_talent_proc'),
(707707, 'spell_ascension_reaper_talent_proc'),
(712484, 'spell_ascension_reaper_talent_proc'),
(801325, 'spell_ascension_reaper_talent_proc'),
(805196, 'spell_ascension_reaper_talent_proc');

-- spell_ascension_reaper_tormented_souls
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_reaper_tormented_souls'
    AND `spell_id` IN (
        500483
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500483, 'spell_ascension_reaper_tormented_souls');

-- spell_ascension_rewind
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_rewind'
    AND `spell_id` IN (
        801294
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801294, 'spell_ascension_rewind');

-- spell_ascension_runemaster_alteration_trigger
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_alteration_trigger'
    AND `spell_id` IN (
        725391
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(725391, 'spell_ascension_runemaster_alteration_trigger');

-- spell_ascension_runemaster_ancient_warrior
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_ancient_warrior'
    AND `spell_id` IN (
        520757
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520757, 'spell_ascension_runemaster_ancient_warrior');

-- spell_ascension_runemaster_brand
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_brand'
    AND `spell_id` IN (
        712299, 712301, 712302, 712303, 712304, 712305, 712306, 712307
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712299, 'spell_ascension_runemaster_brand'),
(712301, 'spell_ascension_runemaster_brand'),
(712302, 'spell_ascension_runemaster_brand'),
(712303, 'spell_ascension_runemaster_brand'),
(712304, 'spell_ascension_runemaster_brand'),
(712305, 'spell_ascension_runemaster_brand'),
(712306, 'spell_ascension_runemaster_brand'),
(712307, 'spell_ascension_runemaster_brand');

-- spell_ascension_runemaster_brand_runeblade
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_brand_runeblade'
    AND `spell_id` IN (
        573444, 573445, 573446, 573447, 707141, 707143, 707144, 707145, 707146, 707147, 707148
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(573444, 'spell_ascension_runemaster_brand_runeblade'),
(573445, 'spell_ascension_runemaster_brand_runeblade'),
(573446, 'spell_ascension_runemaster_brand_runeblade'),
(573447, 'spell_ascension_runemaster_brand_runeblade'),
(707141, 'spell_ascension_runemaster_brand_runeblade'),
(707143, 'spell_ascension_runemaster_brand_runeblade'),
(707144, 'spell_ascension_runemaster_brand_runeblade'),
(707145, 'spell_ascension_runemaster_brand_runeblade'),
(707146, 'spell_ascension_runemaster_brand_runeblade'),
(707147, 'spell_ascension_runemaster_brand_runeblade'),
(707148, 'spell_ascension_runemaster_brand_runeblade');

-- spell_ascension_runemaster_brand_weapons
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_brand_weapons'
    AND `spell_id` IN (
        712299, 712301, 712302, 712303, 712304, 712305, 712306, 712307
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712299, 'spell_ascension_runemaster_brand_weapons'),
(712301, 'spell_ascension_runemaster_brand_weapons'),
(712302, 'spell_ascension_runemaster_brand_weapons'),
(712303, 'spell_ascension_runemaster_brand_weapons'),
(712304, 'spell_ascension_runemaster_brand_weapons'),
(712305, 'spell_ascension_runemaster_brand_weapons'),
(712306, 'spell_ascension_runemaster_brand_weapons'),
(712307, 'spell_ascension_runemaster_brand_weapons');

-- spell_ascension_runemaster_disappearance_window
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_disappearance_window'
    AND `spell_id` IN (
        561059
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(561059, 'spell_ascension_runemaster_disappearance_window');

-- spell_ascension_runemaster_earth_carving
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_earth_carving'
    AND `spell_id` IN (
        712356
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712356, 'spell_ascension_runemaster_earth_carving');

-- spell_ascension_runemaster_earth_wind_and_fire
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_earth_wind_and_fire'
    AND `spell_id` IN (
        712324
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712324, 'spell_ascension_runemaster_earth_wind_and_fire');

-- spell_ascension_runemaster_echoes
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_echoes'
    AND `spell_id` IN (
        712325, 712389
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712325, 'spell_ascension_runemaster_echoes'),
(712389, 'spell_ascension_runemaster_echoes');

-- spell_ascension_runemaster_genesis_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_genesis_damage'
    AND `spell_id` IN (
        500502
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500502, 'spell_ascension_runemaster_genesis_damage');

-- spell_ascension_runemaster_glyph_cast
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_glyph_cast'
    AND `spell_id` IN (
        502823, 502824, 502825, 502826, 502827, 502828, 502829, 502830, 502831, 502832, 502833, 502834,
        502835, 502836, 502837, 502838, 520067, 520068, 520069, 520070, 520071, 520072, 520073, 520074,
        520075, 520076, 520099, 572119, 572120, 572121, 572122, 800732, 801179, 802202, 804550
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(502823, 'spell_ascension_runemaster_glyph_cast'),
(502824, 'spell_ascension_runemaster_glyph_cast'),
(502825, 'spell_ascension_runemaster_glyph_cast'),
(502826, 'spell_ascension_runemaster_glyph_cast'),
(502827, 'spell_ascension_runemaster_glyph_cast'),
(502828, 'spell_ascension_runemaster_glyph_cast'),
(502829, 'spell_ascension_runemaster_glyph_cast'),
(502830, 'spell_ascension_runemaster_glyph_cast'),
(502831, 'spell_ascension_runemaster_glyph_cast'),
(502832, 'spell_ascension_runemaster_glyph_cast'),
(502833, 'spell_ascension_runemaster_glyph_cast'),
(502834, 'spell_ascension_runemaster_glyph_cast'),
(502835, 'spell_ascension_runemaster_glyph_cast'),
(502836, 'spell_ascension_runemaster_glyph_cast'),
(502837, 'spell_ascension_runemaster_glyph_cast'),
(502838, 'spell_ascension_runemaster_glyph_cast'),
(520067, 'spell_ascension_runemaster_glyph_cast'),
(520068, 'spell_ascension_runemaster_glyph_cast'),
(520069, 'spell_ascension_runemaster_glyph_cast'),
(520070, 'spell_ascension_runemaster_glyph_cast'),
(520071, 'spell_ascension_runemaster_glyph_cast'),
(520072, 'spell_ascension_runemaster_glyph_cast'),
(520073, 'spell_ascension_runemaster_glyph_cast'),
(520074, 'spell_ascension_runemaster_glyph_cast'),
(520075, 'spell_ascension_runemaster_glyph_cast'),
(520076, 'spell_ascension_runemaster_glyph_cast'),
(520099, 'spell_ascension_runemaster_glyph_cast'),
(572119, 'spell_ascension_runemaster_glyph_cast'),
(572120, 'spell_ascension_runemaster_glyph_cast'),
(572121, 'spell_ascension_runemaster_glyph_cast'),
(572122, 'spell_ascension_runemaster_glyph_cast'),
(800732, 'spell_ascension_runemaster_glyph_cast'),
(801179, 'spell_ascension_runemaster_glyph_cast'),
(802202, 'spell_ascension_runemaster_glyph_cast'),
(804550, 'spell_ascension_runemaster_glyph_cast');

-- spell_ascension_runemaster_glyph_payload
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_glyph_payload'
    AND `spell_id` IN (
        520096, 520097, 520098, 520107
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520096, 'spell_ascension_runemaster_glyph_payload'),
(520097, 'spell_ascension_runemaster_glyph_payload'),
(520098, 'spell_ascension_runemaster_glyph_payload'),
(520107, 'spell_ascension_runemaster_glyph_payload');

-- spell_ascension_runemaster_ley_power
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_ley_power'
    AND `spell_id` IN (
        801096
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801096, 'spell_ascension_runemaster_ley_power');

-- spell_ascension_runemaster_overloaded_frost
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_overloaded_frost'
    AND `spell_id` IN (
        520108
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520108, 'spell_ascension_runemaster_overloaded_frost');

-- spell_ascension_runemaster_phase_out
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_phase_out'
    AND `spell_id` IN (
        560269
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560269, 'spell_ascension_runemaster_phase_out');

-- spell_ascension_runemaster_power_overwhelming_reset
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_power_overwhelming_reset'
    AND `spell_id` IN (
        561055
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(561055, 'spell_ascension_runemaster_power_overwhelming_reset');

-- spell_ascension_runemaster_primeval_carving
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_primeval_carving'
    AND `spell_id` IN (
        712327
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712327, 'spell_ascension_runemaster_primeval_carving');

-- spell_ascension_runemaster_primordial_alteration_cast
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_primordial_alteration_cast'
    AND `spell_id` IN (
        712404, 712668, 712858, 713002, 805794
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712404, 'spell_ascension_runemaster_primordial_alteration_cast'),
(712668, 'spell_ascension_runemaster_primordial_alteration_cast'),
(712858, 'spell_ascension_runemaster_primordial_alteration_cast'),
(713002, 'spell_ascension_runemaster_primordial_alteration_cast'),
(805794, 'spell_ascension_runemaster_primordial_alteration_cast');

-- spell_ascension_runemaster_protective_warding
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_protective_warding'
    AND `spell_id` IN (
        800753
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800753, 'spell_ascension_runemaster_protective_warding');

-- spell_ascension_runemaster_return
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_return'
    AND `spell_id` IN (
        500272, 500587
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500272, 'spell_ascension_runemaster_return'),
(500587, 'spell_ascension_runemaster_return');

-- spell_ascension_runemaster_runelord_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_runelord_damage'
    AND `spell_id` IN (
        806997
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806997, 'spell_ascension_runemaster_runelord_damage');

-- spell_ascension_runemaster_runic_obliteration_glyph
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_runic_obliteration_glyph'
    AND `spell_id` IN (
        807014
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(807014, 'spell_ascension_runemaster_runic_obliteration_glyph');

-- spell_ascension_runemaster_runic_omen_empower
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_runic_omen_empower'
    AND `spell_id` IN (
        520285
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(520285, 'spell_ascension_runemaster_runic_omen_empower');

-- spell_ascension_runemaster_travel
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_travel'
    AND `spell_id` IN (
        500270, 500287
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500270, 'spell_ascension_runemaster_travel'),
(500287, 'spell_ascension_runemaster_travel');

-- spell_ascension_runemaster_zenith
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_runemaster_zenith'
    AND `spell_id` IN (
        712325, 712389
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(712325, 'spell_ascension_runemaster_zenith'),
(712389, 'spell_ascension_runemaster_zenith');

-- spell_ascension_soul_capture
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_soul_capture'
    AND `spell_id` IN (
        561289
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(561289, 'spell_ascension_soul_capture');

-- spell_ascension_starcaller_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_starcaller_ability'
    AND `spell_id` IN (
        502333, 502334, 502335, 502336, 502337, 502338, 502339, 502340, 570184, 572315, 680803, 801132,
        801401
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(502333, 'spell_ascension_starcaller_ability'),
(502334, 'spell_ascension_starcaller_ability'),
(502335, 'spell_ascension_starcaller_ability'),
(502336, 'spell_ascension_starcaller_ability'),
(502337, 'spell_ascension_starcaller_ability'),
(502338, 'spell_ascension_starcaller_ability'),
(502339, 'spell_ascension_starcaller_ability'),
(502340, 'spell_ascension_starcaller_ability'),
(570184, 'spell_ascension_starcaller_ability'),
(572315, 'spell_ascension_starcaller_ability'),
(680803, 'spell_ascension_starcaller_ability'),
(801132, 'spell_ascension_starcaller_ability'),
(801401, 'spell_ascension_starcaller_ability');

-- spell_ascension_stormbringer_fog
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_stormbringer_fog'
    AND `spell_id` IN (
        806100
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806100, 'spell_ascension_stormbringer_fog');

-- spell_ascension_summon_thunder_orb
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_summon_thunder_orb'
    AND `spell_id` IN (
        801802
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801802, 'spell_ascension_summon_thunder_orb');

-- spell_ascension_sun_cleric_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_sun_cleric_ability'
    AND `spell_id` IN (
        503498, 503499, 503500, 503501, 503502, 503503, 503504, 503505, 503506, 503507, 503508, 520024,
        520026, 520647, 570187, 680630, 800764, 802161, 804249, 804250, 804252, 804253, 804254, 804584,
        806121, 806477, 807064, 807367, 807368, 807369, 807370, 807371, 807372, 807441
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503498, 'spell_ascension_sun_cleric_ability'),
(503499, 'spell_ascension_sun_cleric_ability'),
(503500, 'spell_ascension_sun_cleric_ability'),
(503501, 'spell_ascension_sun_cleric_ability'),
(503502, 'spell_ascension_sun_cleric_ability'),
(503503, 'spell_ascension_sun_cleric_ability'),
(503504, 'spell_ascension_sun_cleric_ability'),
(503505, 'spell_ascension_sun_cleric_ability'),
(503506, 'spell_ascension_sun_cleric_ability'),
(503507, 'spell_ascension_sun_cleric_ability'),
(503508, 'spell_ascension_sun_cleric_ability'),
(520024, 'spell_ascension_sun_cleric_ability'),
(520026, 'spell_ascension_sun_cleric_ability'),
(520647, 'spell_ascension_sun_cleric_ability'),
(570187, 'spell_ascension_sun_cleric_ability'),
(680630, 'spell_ascension_sun_cleric_ability'),
(800764, 'spell_ascension_sun_cleric_ability'),
(802161, 'spell_ascension_sun_cleric_ability'),
(804249, 'spell_ascension_sun_cleric_ability'),
(804250, 'spell_ascension_sun_cleric_ability'),
(804252, 'spell_ascension_sun_cleric_ability'),
(804253, 'spell_ascension_sun_cleric_ability'),
(804254, 'spell_ascension_sun_cleric_ability'),
(804584, 'spell_ascension_sun_cleric_ability'),
(806121, 'spell_ascension_sun_cleric_ability'),
(806477, 'spell_ascension_sun_cleric_ability'),
(807064, 'spell_ascension_sun_cleric_ability'),
(807367, 'spell_ascension_sun_cleric_ability'),
(807368, 'spell_ascension_sun_cleric_ability'),
(807369, 'spell_ascension_sun_cleric_ability'),
(807370, 'spell_ascension_sun_cleric_ability'),
(807371, 'spell_ascension_sun_cleric_ability'),
(807372, 'spell_ascension_sun_cleric_ability'),
(807441, 'spell_ascension_sun_cleric_ability');

-- spell_ascension_sun_cleric_resource
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_sun_cleric_resource'
    AND `spell_id` IN (
        800764, 804097, 804098, 807436
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800764, 'spell_ascension_sun_cleric_resource'),
(804097, 'spell_ascension_sun_cleric_resource'),
(804098, 'spell_ascension_sun_cleric_resource'),
(807436, 'spell_ascension_sun_cleric_resource');

-- spell_ascension_templar_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_templar_ability'
    AND `spell_id` IN (
        560097, 578276, 680953, 800424, 801448, 803373, 803374, 803375, 803376, 803377, 803378, 804918
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560097, 'spell_ascension_templar_ability'),
(578276, 'spell_ascension_templar_ability'),
(680953, 'spell_ascension_templar_ability'),
(800424, 'spell_ascension_templar_ability'),
(801448, 'spell_ascension_templar_ability'),
(803373, 'spell_ascension_templar_ability'),
(803374, 'spell_ascension_templar_ability'),
(803375, 'spell_ascension_templar_ability'),
(803376, 'spell_ascension_templar_ability'),
(803377, 'spell_ascension_templar_ability'),
(803378, 'spell_ascension_templar_ability'),
(804918, 'spell_ascension_templar_ability');

-- spell_ascension_templar_temporary_libram
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_templar_temporary_libram'
    AND `spell_id` IN (
        705274, 705290
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(705274, 'spell_ascension_templar_temporary_libram'),
(705290, 'spell_ascension_templar_temporary_libram');

-- spell_ascension_templar_tithe
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_templar_tithe'
    AND `spell_id` IN (
        804781
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804781, 'spell_ascension_templar_tithe');

-- spell_ascension_the_bieko_effect
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_the_bieko_effect'
    AND `spell_id` IN (
        503946, 707312, 807529, 807746, 807991
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503946, 'spell_ascension_the_bieko_effect'),
(707312, 'spell_ascension_the_bieko_effect'),
(807529, 'spell_ascension_the_bieko_effect'),
(807746, 'spell_ascension_the_bieko_effect'),
(807991, 'spell_ascension_the_bieko_effect');

-- spell_ascension_the_vast_infinite
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_the_vast_infinite'
    AND `spell_id` IN (
        706083
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706083, 'spell_ascension_the_vast_infinite');

-- spell_ascension_timeguard
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_timeguard'
    AND `spell_id` IN (
        804441
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804441, 'spell_ascension_timeguard');

-- spell_ascension_tinker_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_tinker_ability'
    AND `spell_id` IN (
        500220, 500232, 500236, 500239, 500470, 500535, 500549, 500556, 500557, 500558, 500559, 500560,
        500561, 500600, 500612, 502510, 502511, 502512, 502513, 502514, 502515, 502516, 502517, 502552,
        502553, 502554, 502555, 502556, 502557, 502558, 502559, 502560, 502561, 502562, 502563, 502564,
        504519, 504594, 504667, 504678, 504680, 505160, 524835, 547209, 560600, 560601, 560602, 560603,
        560744, 560750, 560754, 706647, 706904, 707290, 800349, 801005, 801009, 801390, 801718, 801744,
        801745, 801798, 801799, 801801, 801809, 801982, 802052, 802176, 802236, 802477, 803799, 803800,
        803801, 803802, 803803, 804673, 804707, 805308, 805351, 805372, 805651, 805652, 805653, 805654,
        805655, 805656, 806074, 806760, 807287, 807288, 807289, 807290, 807291, 807723, 850020
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500220, 'spell_ascension_tinker_ability'),
(500232, 'spell_ascension_tinker_ability'),
(500236, 'spell_ascension_tinker_ability'),
(500239, 'spell_ascension_tinker_ability'),
(500470, 'spell_ascension_tinker_ability'),
(500535, 'spell_ascension_tinker_ability'),
(500549, 'spell_ascension_tinker_ability'),
(500556, 'spell_ascension_tinker_ability'),
(500557, 'spell_ascension_tinker_ability'),
(500558, 'spell_ascension_tinker_ability'),
(500559, 'spell_ascension_tinker_ability'),
(500560, 'spell_ascension_tinker_ability'),
(500561, 'spell_ascension_tinker_ability'),
(500600, 'spell_ascension_tinker_ability'),
(500612, 'spell_ascension_tinker_ability'),
(502510, 'spell_ascension_tinker_ability'),
(502511, 'spell_ascension_tinker_ability'),
(502512, 'spell_ascension_tinker_ability'),
(502513, 'spell_ascension_tinker_ability'),
(502514, 'spell_ascension_tinker_ability'),
(502515, 'spell_ascension_tinker_ability'),
(502516, 'spell_ascension_tinker_ability'),
(502517, 'spell_ascension_tinker_ability'),
(502552, 'spell_ascension_tinker_ability'),
(502553, 'spell_ascension_tinker_ability'),
(502554, 'spell_ascension_tinker_ability'),
(502555, 'spell_ascension_tinker_ability'),
(502556, 'spell_ascension_tinker_ability'),
(502557, 'spell_ascension_tinker_ability'),
(502558, 'spell_ascension_tinker_ability'),
(502559, 'spell_ascension_tinker_ability'),
(502560, 'spell_ascension_tinker_ability'),
(502561, 'spell_ascension_tinker_ability'),
(502562, 'spell_ascension_tinker_ability'),
(502563, 'spell_ascension_tinker_ability'),
(502564, 'spell_ascension_tinker_ability'),
(504519, 'spell_ascension_tinker_ability'),
(504594, 'spell_ascension_tinker_ability'),
(504667, 'spell_ascension_tinker_ability'),
(504678, 'spell_ascension_tinker_ability'),
(504680, 'spell_ascension_tinker_ability'),
(505160, 'spell_ascension_tinker_ability'),
(524835, 'spell_ascension_tinker_ability'),
(547209, 'spell_ascension_tinker_ability'),
(560600, 'spell_ascension_tinker_ability'),
(560601, 'spell_ascension_tinker_ability'),
(560602, 'spell_ascension_tinker_ability'),
(560603, 'spell_ascension_tinker_ability'),
(560744, 'spell_ascension_tinker_ability'),
(560750, 'spell_ascension_tinker_ability'),
(560754, 'spell_ascension_tinker_ability'),
(706647, 'spell_ascension_tinker_ability'),
(706904, 'spell_ascension_tinker_ability'),
(707290, 'spell_ascension_tinker_ability'),
(800349, 'spell_ascension_tinker_ability'),
(801005, 'spell_ascension_tinker_ability'),
(801009, 'spell_ascension_tinker_ability'),
(801390, 'spell_ascension_tinker_ability'),
(801718, 'spell_ascension_tinker_ability'),
(801744, 'spell_ascension_tinker_ability'),
(801745, 'spell_ascension_tinker_ability'),
(801798, 'spell_ascension_tinker_ability'),
(801799, 'spell_ascension_tinker_ability'),
(801801, 'spell_ascension_tinker_ability'),
(801809, 'spell_ascension_tinker_ability'),
(801982, 'spell_ascension_tinker_ability'),
(802052, 'spell_ascension_tinker_ability'),
(802176, 'spell_ascension_tinker_ability'),
(802236, 'spell_ascension_tinker_ability'),
(802477, 'spell_ascension_tinker_ability'),
(803799, 'spell_ascension_tinker_ability'),
(803800, 'spell_ascension_tinker_ability'),
(803801, 'spell_ascension_tinker_ability'),
(803802, 'spell_ascension_tinker_ability'),
(803803, 'spell_ascension_tinker_ability'),
(804673, 'spell_ascension_tinker_ability'),
(804707, 'spell_ascension_tinker_ability'),
(805308, 'spell_ascension_tinker_ability'),
(805351, 'spell_ascension_tinker_ability'),
(805372, 'spell_ascension_tinker_ability'),
(805651, 'spell_ascension_tinker_ability'),
(805652, 'spell_ascension_tinker_ability'),
(805653, 'spell_ascension_tinker_ability'),
(805654, 'spell_ascension_tinker_ability'),
(805655, 'spell_ascension_tinker_ability'),
(805656, 'spell_ascension_tinker_ability'),
(806074, 'spell_ascension_tinker_ability'),
(806760, 'spell_ascension_tinker_ability'),
(807287, 'spell_ascension_tinker_ability'),
(807288, 'spell_ascension_tinker_ability'),
(807289, 'spell_ascension_tinker_ability'),
(807290, 'spell_ascension_tinker_ability'),
(807291, 'spell_ascension_tinker_ability'),
(807723, 'spell_ascension_tinker_ability'),
(850020, 'spell_ascension_tinker_ability');

-- spell_ascension_tinker_augmentation
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_tinker_augmentation'
    AND `spell_id` IN (
        653130, 653234, 653236, 653239, 653242, 653245
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653130, 'spell_ascension_tinker_augmentation'),
(653234, 'spell_ascension_tinker_augmentation'),
(653236, 'spell_ascension_tinker_augmentation'),
(653239, 'spell_ascension_tinker_augmentation'),
(653242, 'spell_ascension_tinker_augmentation'),
(653245, 'spell_ascension_tinker_augmentation');

-- spell_ascension_tinker_augmentation_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_tinker_augmentation_damage'
    AND `spell_id` IN (
        653238, 653268, 653274, 653276
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653238, 'spell_ascension_tinker_augmentation_damage'),
(653268, 'spell_ascension_tinker_augmentation_damage'),
(653274, 'spell_ascension_tinker_augmentation_damage'),
(653276, 'spell_ascension_tinker_augmentation_damage');

-- spell_ascension_tinker_stim_cooldown
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_tinker_stim_cooldown'
    AND `spell_id` IN (
        653255
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653255, 'spell_ascension_tinker_stim_cooldown');

-- spell_ascension_tinker_tracer
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_tinker_tracer'
    AND `spell_id` IN (
        653247
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(653247, 'spell_ascension_tinker_tracer');

-- spell_ascension_unmaker_of_realities
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_unmaker_of_realities'
    AND `spell_id` IN (
        801304
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801304, 'spell_ascension_unmaker_of_realities');

-- spell_ascension_venomancer_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_venomancer_ability'
    AND `spell_id` IN (
        502877, 502878, 502879, 502880, 502896, 502897, 502898, 502899, 502900, 502901, 502902, 502903,
        502904, 502974, 502975, 502976, 502977, 502978, 502979, 502980, 502981, 503931, 503932, 503933,
        503934, 503935, 504342, 504344, 504705, 504714, 504715, 504716, 504717, 504718, 504735, 552781,
        552783, 560989, 572900, 572901, 572902, 572903, 573341, 573342, 578310, 578342, 578343, 680764,
        680767, 681056, 681291, 681417, 704235, 706021, 706453, 706962, 707084, 707085, 707086, 707087,
        707088, 707089, 707090, 707191, 707658, 712357, 800848, 800871, 800880, 800892, 800902, 800910,
        800921, 800946, 803196, 803197, 803206, 803207, 803208, 803525, 803537, 804961, 804977, 805094,
        805097, 805102, 805513, 805514, 805515, 805516, 805517, 805518, 805774, 806154, 806217, 807244,
        807342, 807591, 807592, 807593, 807594, 807595, 807596, 807597, 807598, 807599, 807602, 807603,
        807604, 807605, 807606, 807607, 807611, 807702, 807759
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(502877, 'spell_ascension_venomancer_ability'),
(502878, 'spell_ascension_venomancer_ability'),
(502879, 'spell_ascension_venomancer_ability'),
(502880, 'spell_ascension_venomancer_ability'),
(502896, 'spell_ascension_venomancer_ability'),
(502897, 'spell_ascension_venomancer_ability'),
(502898, 'spell_ascension_venomancer_ability'),
(502899, 'spell_ascension_venomancer_ability'),
(502900, 'spell_ascension_venomancer_ability'),
(502901, 'spell_ascension_venomancer_ability'),
(502902, 'spell_ascension_venomancer_ability'),
(502903, 'spell_ascension_venomancer_ability'),
(502904, 'spell_ascension_venomancer_ability'),
(502974, 'spell_ascension_venomancer_ability'),
(502975, 'spell_ascension_venomancer_ability'),
(502976, 'spell_ascension_venomancer_ability'),
(502977, 'spell_ascension_venomancer_ability'),
(502978, 'spell_ascension_venomancer_ability'),
(502979, 'spell_ascension_venomancer_ability'),
(502980, 'spell_ascension_venomancer_ability'),
(502981, 'spell_ascension_venomancer_ability'),
(503931, 'spell_ascension_venomancer_ability'),
(503932, 'spell_ascension_venomancer_ability'),
(503933, 'spell_ascension_venomancer_ability'),
(503934, 'spell_ascension_venomancer_ability'),
(503935, 'spell_ascension_venomancer_ability'),
(504342, 'spell_ascension_venomancer_ability'),
(504344, 'spell_ascension_venomancer_ability'),
(504705, 'spell_ascension_venomancer_ability'),
(504714, 'spell_ascension_venomancer_ability'),
(504715, 'spell_ascension_venomancer_ability'),
(504716, 'spell_ascension_venomancer_ability'),
(504717, 'spell_ascension_venomancer_ability'),
(504718, 'spell_ascension_venomancer_ability'),
(504735, 'spell_ascension_venomancer_ability'),
(552781, 'spell_ascension_venomancer_ability'),
(552783, 'spell_ascension_venomancer_ability'),
(560989, 'spell_ascension_venomancer_ability'),
(572900, 'spell_ascension_venomancer_ability'),
(572901, 'spell_ascension_venomancer_ability'),
(572902, 'spell_ascension_venomancer_ability'),
(572903, 'spell_ascension_venomancer_ability'),
(573341, 'spell_ascension_venomancer_ability'),
(573342, 'spell_ascension_venomancer_ability'),
(578310, 'spell_ascension_venomancer_ability'),
(578342, 'spell_ascension_venomancer_ability'),
(578343, 'spell_ascension_venomancer_ability'),
(680764, 'spell_ascension_venomancer_ability'),
(680767, 'spell_ascension_venomancer_ability'),
(681056, 'spell_ascension_venomancer_ability'),
(681291, 'spell_ascension_venomancer_ability'),
(681417, 'spell_ascension_venomancer_ability'),
(704235, 'spell_ascension_venomancer_ability'),
(706021, 'spell_ascension_venomancer_ability'),
(706453, 'spell_ascension_venomancer_ability'),
(706962, 'spell_ascension_venomancer_ability'),
(707084, 'spell_ascension_venomancer_ability'),
(707085, 'spell_ascension_venomancer_ability'),
(707086, 'spell_ascension_venomancer_ability'),
(707087, 'spell_ascension_venomancer_ability'),
(707088, 'spell_ascension_venomancer_ability'),
(707089, 'spell_ascension_venomancer_ability'),
(707090, 'spell_ascension_venomancer_ability'),
(707191, 'spell_ascension_venomancer_ability'),
(707658, 'spell_ascension_venomancer_ability'),
(712357, 'spell_ascension_venomancer_ability'),
(800848, 'spell_ascension_venomancer_ability'),
(800871, 'spell_ascension_venomancer_ability'),
(800880, 'spell_ascension_venomancer_ability'),
(800892, 'spell_ascension_venomancer_ability'),
(800902, 'spell_ascension_venomancer_ability'),
(800910, 'spell_ascension_venomancer_ability'),
(800921, 'spell_ascension_venomancer_ability'),
(800946, 'spell_ascension_venomancer_ability'),
(803196, 'spell_ascension_venomancer_ability'),
(803197, 'spell_ascension_venomancer_ability'),
(803206, 'spell_ascension_venomancer_ability'),
(803207, 'spell_ascension_venomancer_ability'),
(803208, 'spell_ascension_venomancer_ability'),
(803525, 'spell_ascension_venomancer_ability'),
(803537, 'spell_ascension_venomancer_ability'),
(804961, 'spell_ascension_venomancer_ability'),
(804977, 'spell_ascension_venomancer_ability'),
(805094, 'spell_ascension_venomancer_ability'),
(805097, 'spell_ascension_venomancer_ability'),
(805102, 'spell_ascension_venomancer_ability'),
(805513, 'spell_ascension_venomancer_ability'),
(805514, 'spell_ascension_venomancer_ability'),
(805515, 'spell_ascension_venomancer_ability'),
(805516, 'spell_ascension_venomancer_ability'),
(805517, 'spell_ascension_venomancer_ability'),
(805518, 'spell_ascension_venomancer_ability'),
(805774, 'spell_ascension_venomancer_ability'),
(806154, 'spell_ascension_venomancer_ability'),
(806217, 'spell_ascension_venomancer_ability'),
(807244, 'spell_ascension_venomancer_ability'),
(807342, 'spell_ascension_venomancer_ability'),
(807591, 'spell_ascension_venomancer_ability'),
(807592, 'spell_ascension_venomancer_ability'),
(807593, 'spell_ascension_venomancer_ability'),
(807594, 'spell_ascension_venomancer_ability'),
(807595, 'spell_ascension_venomancer_ability'),
(807596, 'spell_ascension_venomancer_ability'),
(807597, 'spell_ascension_venomancer_ability'),
(807598, 'spell_ascension_venomancer_ability'),
(807599, 'spell_ascension_venomancer_ability'),
(807602, 'spell_ascension_venomancer_ability'),
(807603, 'spell_ascension_venomancer_ability'),
(807604, 'spell_ascension_venomancer_ability'),
(807605, 'spell_ascension_venomancer_ability'),
(807606, 'spell_ascension_venomancer_ability'),
(807607, 'spell_ascension_venomancer_ability'),
(807611, 'spell_ascension_venomancer_ability'),
(807702, 'spell_ascension_venomancer_ability'),
(807759, 'spell_ascension_venomancer_ability');

-- spell_ascension_venomancer_catalyst
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_venomancer_catalyst'
    AND `spell_id` IN (
        800895
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800895, 'spell_ascension_venomancer_catalyst');

-- spell_ascension_venomancer_intoxicating_extension
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_venomancer_intoxicating_extension'
    AND `spell_id` IN (
        706454
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(706454, 'spell_ascension_venomancer_intoxicating_extension');

-- spell_ascension_venomancer_intoxicating_mycosis
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_venomancer_intoxicating_mycosis'
    AND `spell_id` IN (
        572150, 572151, 572153, 572154, 572155, 572156, 573355, 804986
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(572150, 'spell_ascension_venomancer_intoxicating_mycosis'),
(572151, 'spell_ascension_venomancer_intoxicating_mycosis'),
(572153, 'spell_ascension_venomancer_intoxicating_mycosis'),
(572154, 'spell_ascension_venomancer_intoxicating_mycosis'),
(572155, 'spell_ascension_venomancer_intoxicating_mycosis'),
(572156, 'spell_ascension_venomancer_intoxicating_mycosis'),
(573355, 'spell_ascension_venomancer_intoxicating_mycosis'),
(804986, 'spell_ascension_venomancer_intoxicating_mycosis');

-- spell_ascension_venomancer_remove_venoms
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_venomancer_remove_venoms'
    AND `spell_id` IN (
        630872
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(630872, 'spell_ascension_venomancer_remove_venoms');

-- spell_ascension_venomancer_venom_selection
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_venomancer_venom_selection'
    AND `spell_id` IN (
        630868, 805731, 805775, 805776, 805777, 805778
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(630868, 'spell_ascension_venomancer_venom_selection'),
(805731, 'spell_ascension_venomancer_venom_selection'),
(805775, 'spell_ascension_venomancer_venom_selection'),
(805776, 'spell_ascension_venomancer_venom_selection'),
(805777, 'spell_ascension_venomancer_venom_selection'),
(805778, 'spell_ascension_venomancer_venom_selection');

-- spell_ascension_waves_of_time
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_waves_of_time'
    AND `spell_id` IN (
        801277
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801277, 'spell_ascension_waves_of_time');

-- spell_ascension_wind_gate
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_wind_gate'
    AND `spell_id` IN (
        504401
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504401, 'spell_ascension_wind_gate');

-- spell_ascension_wind_gate_evacuate
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_wind_gate_evacuate'
    AND `spell_id` IN (
        504643
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504643, 'spell_ascension_wind_gate_evacuate');

-- spell_ascension_witch_doctor_spiritual_recall
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_doctor_spiritual_recall'
    AND `spell_id` IN (
        583092
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(583092, 'spell_ascension_witch_doctor_spiritual_recall');

-- spell_ascension_witch_doctor_summon
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_doctor_summon'
    AND `spell_id` IN (
        500957, 500960, 500961, 501136, 504759, 504777, 504840, 505339, 506634, 506635, 507082, 507084,
        561068, 572899, 674303, 681007, 706369, 706542, 707162, 712373, 800330, 801678, 802719, 804226,
        804684, 808004
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500957, 'spell_ascension_witch_doctor_summon'),
(500960, 'spell_ascension_witch_doctor_summon'),
(500961, 'spell_ascension_witch_doctor_summon'),
(501136, 'spell_ascension_witch_doctor_summon'),
(504759, 'spell_ascension_witch_doctor_summon'),
(504777, 'spell_ascension_witch_doctor_summon'),
(504840, 'spell_ascension_witch_doctor_summon'),
(505339, 'spell_ascension_witch_doctor_summon'),
(506634, 'spell_ascension_witch_doctor_summon'),
(506635, 'spell_ascension_witch_doctor_summon'),
(507082, 'spell_ascension_witch_doctor_summon'),
(507084, 'spell_ascension_witch_doctor_summon'),
(561068, 'spell_ascension_witch_doctor_summon'),
(572899, 'spell_ascension_witch_doctor_summon'),
(674303, 'spell_ascension_witch_doctor_summon'),
(681007, 'spell_ascension_witch_doctor_summon'),
(706369, 'spell_ascension_witch_doctor_summon'),
(706542, 'spell_ascension_witch_doctor_summon'),
(707162, 'spell_ascension_witch_doctor_summon'),
(712373, 'spell_ascension_witch_doctor_summon'),
(800330, 'spell_ascension_witch_doctor_summon'),
(801678, 'spell_ascension_witch_doctor_summon'),
(802719, 'spell_ascension_witch_doctor_summon'),
(804226, 'spell_ascension_witch_doctor_summon'),
(804684, 'spell_ascension_witch_doctor_summon'),
(808004, 'spell_ascension_witch_doctor_summon');

-- spell_ascension_witch_hunter_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_ability'
    AND `spell_id` IN (
        300792, 300793, 500082, 500085, 500086, 500093, 501337, 501338, 501339, 501340, 501341, 501342,
        501343, 501344, 501345, 501346, 501347, 501348, 501349, 501350, 501351, 501352, 501353, 501354,
        501355, 501384, 501385, 501386, 501387, 503662, 520062, 520197, 520198, 520199, 520201, 520202,
        520203, 520206, 520207, 520208, 520209, 520210, 520211, 520212, 520213, 520214, 520215, 520216,
        520217, 520270, 520271, 520708, 520709, 523485, 523486, 523487, 523488, 560048, 561146, 561147,
        561148, 561149, 561153, 562024, 562025, 572295, 572296, 572297, 572298, 574319, 574320, 574342,
        574343, 578297, 680236, 680256, 680257, 680258, 680259, 680260, 680261, 680262, 680264, 680265,
        680266, 680267, 680268, 680269, 680270, 680271, 680272, 680273, 680491, 680494, 680498, 680515,
        680518, 680537, 680612, 680613, 680614, 680615, 681095, 681203, 681207, 681208, 681209, 681210,
        681211, 681212, 681213, 681214, 681215, 681216, 681217, 681218, 681219, 681220, 681221, 681347,
        681348, 681349, 681350, 681351, 681352, 681415, 681524, 681540, 684330, 704342, 706741, 707351,
        707352, 707353, 707354, 707355, 707678, 707679, 707680, 707681, 707682, 707683, 707684, 707685,
        707686, 707687, 800162, 800163, 800165, 802004, 802006, 802013, 802019, 802020, 802024, 802139,
        802140, 802248, 802249, 802250, 802251, 802252, 802253, 802254, 802255, 802256, 802257, 802258,
        802273, 802276, 802277, 802278, 802279, 802280, 802281, 802308, 802429, 802430, 802431, 802432,
        802433, 802434, 802754, 802755, 802826, 803359, 803360, 803361, 803362, 803363, 803364, 803366,
        803367, 803368, 803369, 803502, 804179, 804184, 804191, 804193, 805738, 805754, 805770, 806846,
        806847, 806848, 806849, 806850, 806851, 806852, 806853, 806854, 806855, 806856, 807279, 807280,
        807281, 807282, 807283, 807284, 807364, 807527, 807682, 807705, 807706, 807707, 807708, 807709,
        807710, 807918, 807933
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300792, 'spell_ascension_witch_hunter_ability'),
(300793, 'spell_ascension_witch_hunter_ability'),
(500082, 'spell_ascension_witch_hunter_ability'),
(500085, 'spell_ascension_witch_hunter_ability'),
(500086, 'spell_ascension_witch_hunter_ability'),
(500093, 'spell_ascension_witch_hunter_ability'),
(501337, 'spell_ascension_witch_hunter_ability'),
(501338, 'spell_ascension_witch_hunter_ability'),
(501339, 'spell_ascension_witch_hunter_ability'),
(501340, 'spell_ascension_witch_hunter_ability'),
(501341, 'spell_ascension_witch_hunter_ability'),
(501342, 'spell_ascension_witch_hunter_ability'),
(501343, 'spell_ascension_witch_hunter_ability'),
(501344, 'spell_ascension_witch_hunter_ability'),
(501345, 'spell_ascension_witch_hunter_ability'),
(501346, 'spell_ascension_witch_hunter_ability'),
(501347, 'spell_ascension_witch_hunter_ability'),
(501348, 'spell_ascension_witch_hunter_ability'),
(501349, 'spell_ascension_witch_hunter_ability'),
(501350, 'spell_ascension_witch_hunter_ability'),
(501351, 'spell_ascension_witch_hunter_ability'),
(501352, 'spell_ascension_witch_hunter_ability'),
(501353, 'spell_ascension_witch_hunter_ability'),
(501354, 'spell_ascension_witch_hunter_ability'),
(501355, 'spell_ascension_witch_hunter_ability'),
(501384, 'spell_ascension_witch_hunter_ability'),
(501385, 'spell_ascension_witch_hunter_ability'),
(501386, 'spell_ascension_witch_hunter_ability'),
(501387, 'spell_ascension_witch_hunter_ability'),
(503662, 'spell_ascension_witch_hunter_ability'),
(520062, 'spell_ascension_witch_hunter_ability'),
(520197, 'spell_ascension_witch_hunter_ability'),
(520198, 'spell_ascension_witch_hunter_ability'),
(520199, 'spell_ascension_witch_hunter_ability'),
(520201, 'spell_ascension_witch_hunter_ability'),
(520202, 'spell_ascension_witch_hunter_ability'),
(520203, 'spell_ascension_witch_hunter_ability'),
(520206, 'spell_ascension_witch_hunter_ability'),
(520207, 'spell_ascension_witch_hunter_ability'),
(520208, 'spell_ascension_witch_hunter_ability'),
(520209, 'spell_ascension_witch_hunter_ability'),
(520210, 'spell_ascension_witch_hunter_ability'),
(520211, 'spell_ascension_witch_hunter_ability'),
(520212, 'spell_ascension_witch_hunter_ability'),
(520213, 'spell_ascension_witch_hunter_ability'),
(520214, 'spell_ascension_witch_hunter_ability'),
(520215, 'spell_ascension_witch_hunter_ability'),
(520216, 'spell_ascension_witch_hunter_ability'),
(520217, 'spell_ascension_witch_hunter_ability'),
(520270, 'spell_ascension_witch_hunter_ability'),
(520271, 'spell_ascension_witch_hunter_ability'),
(520708, 'spell_ascension_witch_hunter_ability'),
(520709, 'spell_ascension_witch_hunter_ability'),
(523485, 'spell_ascension_witch_hunter_ability'),
(523486, 'spell_ascension_witch_hunter_ability'),
(523487, 'spell_ascension_witch_hunter_ability'),
(523488, 'spell_ascension_witch_hunter_ability'),
(560048, 'spell_ascension_witch_hunter_ability'),
(561146, 'spell_ascension_witch_hunter_ability'),
(561147, 'spell_ascension_witch_hunter_ability'),
(561148, 'spell_ascension_witch_hunter_ability'),
(561149, 'spell_ascension_witch_hunter_ability'),
(561153, 'spell_ascension_witch_hunter_ability'),
(562024, 'spell_ascension_witch_hunter_ability'),
(562025, 'spell_ascension_witch_hunter_ability'),
(572295, 'spell_ascension_witch_hunter_ability'),
(572296, 'spell_ascension_witch_hunter_ability'),
(572297, 'spell_ascension_witch_hunter_ability'),
(572298, 'spell_ascension_witch_hunter_ability'),
(574319, 'spell_ascension_witch_hunter_ability'),
(574320, 'spell_ascension_witch_hunter_ability'),
(574342, 'spell_ascension_witch_hunter_ability'),
(574343, 'spell_ascension_witch_hunter_ability'),
(578297, 'spell_ascension_witch_hunter_ability'),
(680236, 'spell_ascension_witch_hunter_ability'),
(680256, 'spell_ascension_witch_hunter_ability'),
(680257, 'spell_ascension_witch_hunter_ability'),
(680258, 'spell_ascension_witch_hunter_ability'),
(680259, 'spell_ascension_witch_hunter_ability'),
(680260, 'spell_ascension_witch_hunter_ability'),
(680261, 'spell_ascension_witch_hunter_ability'),
(680262, 'spell_ascension_witch_hunter_ability'),
(680264, 'spell_ascension_witch_hunter_ability'),
(680265, 'spell_ascension_witch_hunter_ability'),
(680266, 'spell_ascension_witch_hunter_ability'),
(680267, 'spell_ascension_witch_hunter_ability'),
(680268, 'spell_ascension_witch_hunter_ability'),
(680269, 'spell_ascension_witch_hunter_ability'),
(680270, 'spell_ascension_witch_hunter_ability'),
(680271, 'spell_ascension_witch_hunter_ability'),
(680272, 'spell_ascension_witch_hunter_ability'),
(680273, 'spell_ascension_witch_hunter_ability'),
(680491, 'spell_ascension_witch_hunter_ability'),
(680494, 'spell_ascension_witch_hunter_ability'),
(680498, 'spell_ascension_witch_hunter_ability'),
(680515, 'spell_ascension_witch_hunter_ability'),
(680518, 'spell_ascension_witch_hunter_ability'),
(680537, 'spell_ascension_witch_hunter_ability'),
(680612, 'spell_ascension_witch_hunter_ability'),
(680613, 'spell_ascension_witch_hunter_ability'),
(680614, 'spell_ascension_witch_hunter_ability'),
(680615, 'spell_ascension_witch_hunter_ability'),
(681095, 'spell_ascension_witch_hunter_ability'),
(681203, 'spell_ascension_witch_hunter_ability'),
(681207, 'spell_ascension_witch_hunter_ability'),
(681208, 'spell_ascension_witch_hunter_ability'),
(681209, 'spell_ascension_witch_hunter_ability'),
(681210, 'spell_ascension_witch_hunter_ability'),
(681211, 'spell_ascension_witch_hunter_ability'),
(681212, 'spell_ascension_witch_hunter_ability'),
(681213, 'spell_ascension_witch_hunter_ability'),
(681214, 'spell_ascension_witch_hunter_ability'),
(681215, 'spell_ascension_witch_hunter_ability'),
(681216, 'spell_ascension_witch_hunter_ability'),
(681217, 'spell_ascension_witch_hunter_ability'),
(681218, 'spell_ascension_witch_hunter_ability'),
(681219, 'spell_ascension_witch_hunter_ability'),
(681220, 'spell_ascension_witch_hunter_ability'),
(681221, 'spell_ascension_witch_hunter_ability'),
(681347, 'spell_ascension_witch_hunter_ability'),
(681348, 'spell_ascension_witch_hunter_ability'),
(681349, 'spell_ascension_witch_hunter_ability'),
(681350, 'spell_ascension_witch_hunter_ability'),
(681351, 'spell_ascension_witch_hunter_ability'),
(681352, 'spell_ascension_witch_hunter_ability'),
(681415, 'spell_ascension_witch_hunter_ability'),
(681524, 'spell_ascension_witch_hunter_ability'),
(681540, 'spell_ascension_witch_hunter_ability'),
(684330, 'spell_ascension_witch_hunter_ability'),
(704342, 'spell_ascension_witch_hunter_ability'),
(706741, 'spell_ascension_witch_hunter_ability'),
(707351, 'spell_ascension_witch_hunter_ability'),
(707352, 'spell_ascension_witch_hunter_ability'),
(707353, 'spell_ascension_witch_hunter_ability'),
(707354, 'spell_ascension_witch_hunter_ability'),
(707355, 'spell_ascension_witch_hunter_ability'),
(707678, 'spell_ascension_witch_hunter_ability'),
(707679, 'spell_ascension_witch_hunter_ability'),
(707680, 'spell_ascension_witch_hunter_ability'),
(707681, 'spell_ascension_witch_hunter_ability'),
(707682, 'spell_ascension_witch_hunter_ability'),
(707683, 'spell_ascension_witch_hunter_ability'),
(707684, 'spell_ascension_witch_hunter_ability'),
(707685, 'spell_ascension_witch_hunter_ability'),
(707686, 'spell_ascension_witch_hunter_ability'),
(707687, 'spell_ascension_witch_hunter_ability'),
(800162, 'spell_ascension_witch_hunter_ability'),
(800163, 'spell_ascension_witch_hunter_ability'),
(800165, 'spell_ascension_witch_hunter_ability'),
(802004, 'spell_ascension_witch_hunter_ability'),
(802006, 'spell_ascension_witch_hunter_ability'),
(802013, 'spell_ascension_witch_hunter_ability'),
(802019, 'spell_ascension_witch_hunter_ability'),
(802020, 'spell_ascension_witch_hunter_ability'),
(802024, 'spell_ascension_witch_hunter_ability'),
(802139, 'spell_ascension_witch_hunter_ability'),
(802140, 'spell_ascension_witch_hunter_ability'),
(802248, 'spell_ascension_witch_hunter_ability'),
(802249, 'spell_ascension_witch_hunter_ability'),
(802250, 'spell_ascension_witch_hunter_ability'),
(802251, 'spell_ascension_witch_hunter_ability'),
(802252, 'spell_ascension_witch_hunter_ability'),
(802253, 'spell_ascension_witch_hunter_ability'),
(802254, 'spell_ascension_witch_hunter_ability'),
(802255, 'spell_ascension_witch_hunter_ability'),
(802256, 'spell_ascension_witch_hunter_ability'),
(802257, 'spell_ascension_witch_hunter_ability'),
(802258, 'spell_ascension_witch_hunter_ability'),
(802273, 'spell_ascension_witch_hunter_ability'),
(802276, 'spell_ascension_witch_hunter_ability'),
(802277, 'spell_ascension_witch_hunter_ability'),
(802278, 'spell_ascension_witch_hunter_ability'),
(802279, 'spell_ascension_witch_hunter_ability'),
(802280, 'spell_ascension_witch_hunter_ability'),
(802281, 'spell_ascension_witch_hunter_ability'),
(802308, 'spell_ascension_witch_hunter_ability'),
(802429, 'spell_ascension_witch_hunter_ability'),
(802430, 'spell_ascension_witch_hunter_ability'),
(802431, 'spell_ascension_witch_hunter_ability'),
(802432, 'spell_ascension_witch_hunter_ability'),
(802433, 'spell_ascension_witch_hunter_ability'),
(802434, 'spell_ascension_witch_hunter_ability'),
(802754, 'spell_ascension_witch_hunter_ability'),
(802755, 'spell_ascension_witch_hunter_ability'),
(802826, 'spell_ascension_witch_hunter_ability'),
(803359, 'spell_ascension_witch_hunter_ability'),
(803360, 'spell_ascension_witch_hunter_ability'),
(803361, 'spell_ascension_witch_hunter_ability'),
(803362, 'spell_ascension_witch_hunter_ability'),
(803363, 'spell_ascension_witch_hunter_ability'),
(803364, 'spell_ascension_witch_hunter_ability'),
(803366, 'spell_ascension_witch_hunter_ability'),
(803367, 'spell_ascension_witch_hunter_ability'),
(803368, 'spell_ascension_witch_hunter_ability'),
(803369, 'spell_ascension_witch_hunter_ability'),
(803502, 'spell_ascension_witch_hunter_ability'),
(804179, 'spell_ascension_witch_hunter_ability'),
(804184, 'spell_ascension_witch_hunter_ability'),
(804191, 'spell_ascension_witch_hunter_ability'),
(804193, 'spell_ascension_witch_hunter_ability'),
(805738, 'spell_ascension_witch_hunter_ability'),
(805754, 'spell_ascension_witch_hunter_ability'),
(805770, 'spell_ascension_witch_hunter_ability'),
(806846, 'spell_ascension_witch_hunter_ability'),
(806847, 'spell_ascension_witch_hunter_ability'),
(806848, 'spell_ascension_witch_hunter_ability'),
(806849, 'spell_ascension_witch_hunter_ability'),
(806850, 'spell_ascension_witch_hunter_ability'),
(806851, 'spell_ascension_witch_hunter_ability'),
(806852, 'spell_ascension_witch_hunter_ability'),
(806853, 'spell_ascension_witch_hunter_ability'),
(806854, 'spell_ascension_witch_hunter_ability'),
(806855, 'spell_ascension_witch_hunter_ability'),
(806856, 'spell_ascension_witch_hunter_ability'),
(807279, 'spell_ascension_witch_hunter_ability'),
(807280, 'spell_ascension_witch_hunter_ability'),
(807281, 'spell_ascension_witch_hunter_ability'),
(807282, 'spell_ascension_witch_hunter_ability'),
(807283, 'spell_ascension_witch_hunter_ability'),
(807284, 'spell_ascension_witch_hunter_ability'),
(807364, 'spell_ascension_witch_hunter_ability'),
(807527, 'spell_ascension_witch_hunter_ability'),
(807682, 'spell_ascension_witch_hunter_ability'),
(807705, 'spell_ascension_witch_hunter_ability'),
(807706, 'spell_ascension_witch_hunter_ability'),
(807707, 'spell_ascension_witch_hunter_ability'),
(807708, 'spell_ascension_witch_hunter_ability'),
(807709, 'spell_ascension_witch_hunter_ability'),
(807710, 'spell_ascension_witch_hunter_ability'),
(807918, 'spell_ascension_witch_hunter_ability'),
(807933, 'spell_ascension_witch_hunter_ability');

-- spell_ascension_witch_hunter_copy
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_copy'
    AND `spell_id` IN (
        567570, 574335, 574337, 681270
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(567570, 'spell_ascension_witch_hunter_copy'),
(574335, 'spell_ascension_witch_hunter_copy'),
(574337, 'spell_ascension_witch_hunter_copy'),
(681270, 'spell_ascension_witch_hunter_copy');

-- spell_ascension_witch_hunter_flame_damage
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_flame_damage'
    AND `spell_id` IN (
        802850
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802850, 'spell_ascension_witch_hunter_flame_damage');

-- spell_ascension_witch_hunter_flame_duration
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_flame_duration'
    AND `spell_id` IN (
        504779, 802845, 803503, 803710, 805365
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504779, 'spell_ascension_witch_hunter_flame_duration'),
(802845, 'spell_ascension_witch_hunter_flame_duration'),
(803503, 'spell_ascension_witch_hunter_flame_duration'),
(803710, 'spell_ascension_witch_hunter_flame_duration'),
(805365, 'spell_ascension_witch_hunter_flame_duration');

-- spell_ascension_witch_hunter_flame_modifier_update
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_flame_modifier_update'
    AND `spell_id` IN (
        503655, 504890, 802277
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503655, 'spell_ascension_witch_hunter_flame_modifier_update'),
(504890, 'spell_ascension_witch_hunter_flame_modifier_update'),
(802277, 'spell_ascension_witch_hunter_flame_modifier_update');

-- spell_ascension_witch_hunter_flames_of_sin
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_flames_of_sin'
    AND `spell_id` IN (
        803422
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(803422, 'spell_ascension_witch_hunter_flames_of_sin');

-- spell_ascension_witch_hunter_holy_water_tonic
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_holy_water_tonic'
    AND `spell_id` IN (
        802826
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802826, 'spell_ascension_witch_hunter_holy_water_tonic');

-- spell_ascension_witch_hunter_pyro_torchlight
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_pyro_torchlight'
    AND `spell_id` IN (
        802277
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802277, 'spell_ascension_witch_hunter_pyro_torchlight');

-- spell_ascension_witch_hunter_smoke
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_smoke'
    AND `spell_id` IN (
        805756
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805756, 'spell_ascension_witch_hunter_smoke');

-- spell_ascension_witch_hunter_summon
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_summon'
    AND `spell_id` IN (
        503679, 520865, 525054, 680238, 680376, 681172, 681445, 681450, 681455, 681562, 681563, 681564,
        707890, 803886, 804051, 807918, 807933
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503679, 'spell_ascension_witch_hunter_summon'),
(520865, 'spell_ascension_witch_hunter_summon'),
(525054, 'spell_ascension_witch_hunter_summon'),
(680238, 'spell_ascension_witch_hunter_summon'),
(680376, 'spell_ascension_witch_hunter_summon'),
(681172, 'spell_ascension_witch_hunter_summon'),
(681445, 'spell_ascension_witch_hunter_summon'),
(681450, 'spell_ascension_witch_hunter_summon'),
(681455, 'spell_ascension_witch_hunter_summon'),
(681562, 'spell_ascension_witch_hunter_summon'),
(681563, 'spell_ascension_witch_hunter_summon'),
(681564, 'spell_ascension_witch_hunter_summon'),
(707890, 'spell_ascension_witch_hunter_summon'),
(803886, 'spell_ascension_witch_hunter_summon'),
(804051, 'spell_ascension_witch_hunter_summon'),
(807918, 'spell_ascension_witch_hunter_summon'),
(807933, 'spell_ascension_witch_hunter_summon');

-- spell_ascension_witch_hunter_tonic_supply
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_tonic_supply'
    AND `spell_id` IN (
        802276, 802277, 802278, 802826
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802276, 'spell_ascension_witch_hunter_tonic_supply'),
(802277, 'spell_ascension_witch_hunter_tonic_supply'),
(802278, 'spell_ascension_witch_hunter_tonic_supply'),
(802826, 'spell_ascension_witch_hunter_tonic_supply');

-- spell_ascension_witch_hunter_torch_stacks
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_torch_stacks'
    AND `spell_id` IN (
        560226
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560226, 'spell_ascension_witch_hunter_torch_stacks');

-- spell_ascension_witch_hunter_torchlight_mark
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_torchlight_mark'
    AND `spell_id` IN (
        503662
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503662, 'spell_ascension_witch_hunter_torchlight_mark');

-- spell_ascension_witch_hunter_vampiric_tonic
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_witch_hunter_vampiric_tonic'
    AND `spell_id` IN (
        802276
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802276, 'spell_ascension_witch_hunter_vampiric_tonic');

-- spell_ascension_xoroth_ability
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_xoroth_ability'
    AND `spell_id` IN (
        500904, 501499, 501500, 501501, 501502, 501503, 501504, 501505, 501506, 501507, 524897, 704247,
        706756, 801042, 804774, 805966, 807699
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500904, 'spell_ascension_xoroth_ability'),
(501499, 'spell_ascension_xoroth_ability'),
(501500, 'spell_ascension_xoroth_ability'),
(501501, 'spell_ascension_xoroth_ability'),
(501502, 'spell_ascension_xoroth_ability'),
(501503, 'spell_ascension_xoroth_ability'),
(501504, 'spell_ascension_xoroth_ability'),
(501505, 'spell_ascension_xoroth_ability'),
(501506, 'spell_ascension_xoroth_ability'),
(501507, 'spell_ascension_xoroth_ability'),
(524897, 'spell_ascension_xoroth_ability'),
(704247, 'spell_ascension_xoroth_ability'),
(706756, 'spell_ascension_xoroth_ability'),
(801042, 'spell_ascension_xoroth_ability'),
(804774, 'spell_ascension_xoroth_ability'),
(805966, 'spell_ascension_xoroth_ability'),
(807699, 'spell_ascension_xoroth_ability');

-- spell_ascension_xoroth_hellfire_advance
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_xoroth_hellfire_advance'
    AND `spell_id` IN (
        804788
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804788, 'spell_ascension_xoroth_hellfire_advance');

-- spell_ascension_xoroth_sacrificial_circle
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_xoroth_sacrificial_circle'
    AND `spell_id` IN (
        805677
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805677, 'spell_ascension_xoroth_sacrificial_circle');

-- spell_ascension_zephyr_pull
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_zephyr_pull'
    AND `spell_id` IN (
        704210
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(704210, 'spell_ascension_zephyr_pull');

-- spell_reaper_beyond_death_bolt
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_reaper_beyond_death_bolt'
    AND `spell_id` IN (
        500618
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500618, 'spell_reaper_beyond_death_bolt');

-- spell_reaper_reliquary_of_the_lost
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_reaper_reliquary_of_the_lost'
    AND `spell_id` IN (
        500631
);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500631, 'spell_reaper_reliquary_of_the_lost');
