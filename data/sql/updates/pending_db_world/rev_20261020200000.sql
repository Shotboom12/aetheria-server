-- Native player bodies require the character-component flag for appearance textures and equipment.
UPDATE `creaturemodeldata_dbc` SET `Flags` = `Flags` | 4 WHERE `ID` IN (121060, 121061, 121062, 121063);
