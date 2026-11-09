# Current-world overlay evidence needed for racial catalog

The file-only reports are not the effective server store. Verified local flow:
`DBCStores.cpp::LoadDBC` loads the file and then calls `LoadFromDB`;
`DBCDatabaseLoader.cpp::Load` replaces indexed rows after reading the world table.
`skilllineability_dbc` has ID as primary key and the 14 file-layout columns.

Use a read-only connection to the configured current world database. Export the
following complete results with column names, database identity, export time,
and file hashes. Do not include connection credentials in evidence.

```sql
SELECT ID, SkillLine, Spell, RaceMask, ClassMask, ExcludeRace, ExcludeClass,
       MinSkillLineRank, SupercededBySpell, AcquireMethod,
       TrivialSkillLineRankHigh, TrivialSkillLineRankLow,
       CharacterPoints_1, CharacterPoints_2
FROM skilllineability_dbc ORDER BY ID;

SELECT * FROM skillline_dbc ORDER BY ID;
```

Do not filter either export by race or category. An unrestricted DB row can
replace a race-restricted file row; a skill-line category override can change
catalog admission. Preserve the signed database values in the export; the
projection must reproduce the loader's field conversions when resolving masks.

The future projection must apply all DB rows after the last-record file index,
then evaluate race/class masks and effective skill categories. Spell roots,
trigger/teach chains, spell existence and client pairing require separate
verification. Native player-create and custom racial grants are another source;
SkillLineAbility alone is not an exhaustive racial inventory.

No database query has been run for this export plan. No grant list or migration
can be approved from the existing file-only reports.
