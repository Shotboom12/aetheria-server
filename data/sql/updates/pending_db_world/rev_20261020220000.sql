-- Native Vrykul needs the player character component, as do Kyrian and Venthyr.
UPDATE `creaturemodeldata_dbc` SET `Flags` = `Flags` | 4 WHERE `ID` = 42112;
