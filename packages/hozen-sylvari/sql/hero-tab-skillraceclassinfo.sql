-- Server-side SkillRaceClassInfo rows for the 31 Hero spellbook tab skill lines (2001-2009, 2011-2032).
-- The client archive AetheriaClassTabs already has them (same IDs). Without them the server's skill loader logs
-- "has skill (200x) that is invalid for the race/class combination ... Will be deleted" for every Hero at every login.
-- Apply to acore_world ONLY after the worldserver is closed normally; DBC overlay tables load at startup.
-- Back up first (this makes an in-database copy; also dump the table with mysqldump per the install guard).
START TRANSACTION;
DROP TABLE IF EXISTS skillraceclassinfo_dbc_bak_20261111;
CREATE TABLE skillraceclassinfo_dbc_bak_20261111 AS SELECT * FROM skillraceclassinfo_dbc;
DELETE FROM skillraceclassinfo_dbc WHERE ID IN (990501,990502,990503,990504,990505,990506,990507,990508,990509,990510,990511,990512,990513,990514,990515,990516,990517,990518,990519,990520,990521,990522,990523,990524,990525,990526,990527,990528,990529,990530,990531);
INSERT INTO skillraceclassinfo_dbc (ID,SkillID,RaceMask,ClassMask,Flags,MinLevel,SkillTierID,SkillCostIndex) VALUES
  (990501,2012,0,0,1040,0,0,0),
  (990502,2013,0,0,1040,0,0,0),
  (990503,2014,0,0,1040,0,0,0),
  (990504,2015,0,0,1040,0,0,0),
  (990505,2016,0,0,1040,0,0,0),
  (990506,2017,0,0,1040,0,0,0),
  (990507,2018,0,0,1040,0,0,0),
  (990508,2019,0,0,1040,0,0,0),
  (990509,2020,0,0,1040,0,0,0),
  (990510,2021,0,0,1040,0,0,0),
  (990511,2022,0,0,1040,0,0,0),
  (990512,2023,0,0,1040,0,0,0),
  (990513,2024,0,0,1040,0,0,0),
  (990514,2025,0,0,1040,0,0,0),
  (990515,2026,0,0,1040,0,0,0),
  (990516,2027,0,0,1040,0,0,0),
  (990517,2028,0,0,1040,0,0,0),
  (990518,2029,0,0,1040,0,0,0),
  (990519,2030,0,0,1040,0,0,0),
  (990520,2031,0,0,1040,0,0,0),
  (990521,2032,0,0,1040,0,0,0),
  (990522,2001,0,0,1040,0,0,0),
  (990523,2002,0,0,1040,0,0,0),
  (990524,2003,0,0,1040,0,0,0),
  (990525,2004,0,0,1040,0,0,0),
  (990526,2005,0,0,1040,0,0,0),
  (990527,2006,0,0,1040,0,0,0),
  (990528,2007,0,0,1040,0,0,0),
  (990529,2008,0,0,1040,0,0,0),
  (990530,2009,0,0,1040,0,0,0),
  (990531,2011,0,0,1040,0,0,0);
-- readback: expect 31
SELECT COUNT(*) AS tab_rows FROM skillraceclassinfo_dbc WHERE SkillID BETWEEN 2001 AND 2032;
COMMIT;
-- rollback: DELETE FROM skillraceclassinfo_dbc WHERE ID IN (990501,990502,990503,990504,990505,990506,990507,990508,990509,990510,990511,990512,990513,990514,990515,990516,990517,990518,990519,990520,990521,990522,990523,990524,990525,990526,990527,990528,990529,990530,990531); (then restart worldserver)
