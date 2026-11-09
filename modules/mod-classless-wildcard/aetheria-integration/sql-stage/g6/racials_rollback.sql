-- Rollback for racials_slime_centaur.sql and engraving_helper_spells.sql (all IDs are new rows).
DELETE FROM spell_dbc WHERE ID IN (111000,111001,111002,111003,111010,111011,111012,111013,111014,111020,111021,111022,111023,111024,111025,111026,111027,712492,712493);
DELETE FROM spell_script_names WHERE spell_id BETWEEN 111000 AND 111027;
DELETE FROM custom_race_start_spell WHERE spell BETWEEN 111010 AND 111027 AND race IN (74,75,76);
DELETE FROM creature_template WHERE entry = 900720;
DELETE FROM creature_template_model WHERE CreatureID = 900720;
DELETE FROM creature_model_info WHERE DisplayID = 60094;
DELETE FROM vehicle_dbc WHERE ID IN (900306,900307);
DELETE FROM vehicleseat_dbc WHERE ID IN (900408,900409);
DELETE FROM creaturemodeldata_dbc WHERE ID = 130104;
DELETE FROM creaturedisplayinfo_dbc WHERE ID = 60094;
DELETE FROM player_shapeshift_model WHERE RaceID = 74 AND ShapeshiftID IN (27,29) AND CustomizationID = 255;
