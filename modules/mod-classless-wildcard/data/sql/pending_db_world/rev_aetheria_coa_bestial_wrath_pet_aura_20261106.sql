-- REVIEW ONLY: CoA Bestial Wrath pet-aura helper and its exact proc row.
-- Both spell IDs are present in the paired Hero/CoA catalog; no target rows existed in checked-in SQL.
-- Source: pinned CoA SQL update rev_1789887120667418500.sql; unapplied.
START TRANSACTION;
DELETE FROM `spell_pet_auras` WHERE `spell` = 803347 AND `effectId` = 1 AND `pet` = 0;
INSERT INTO `spell_pet_auras` (`spell`, `effectId`, `pet`, `aura`) VALUES
(803347, 1, 0, 803349);
DELETE FROM `spell_proc` WHERE `SpellId` = 803349;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(803349, 0, 0, 0, 0, 0, 332116, 1, 2, 2, 2, 4, 0, 100, 0, 0);
COMMIT;
