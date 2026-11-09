-- Hero-only adaptation of CoA Ranger Rapid Strikes (560341).
-- The client tooltip defines melee/ranged autoattacks, a 50% damage echo, and a 1s cooldown.
-- Chance 0 preserves the spell record's authored $h proc chance; family/type/phase constrain this to
-- completed direct damage autoattacks. The AuraScript further requires the Hero-owned Ranger kit.
DELETE FROM `spell_proc` WHERE `SpellId` = 560341;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(560341, 0, 0, 0, 0, 0, 12, 1, 2, 0, 0, 0, 0, 0, 1000, 0);

DELETE FROM `spell_script_names` WHERE (`spell_id` = 560341 AND `ScriptName` = 'aura_ascension_ranger_rapid_strikes');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560341, 'aura_ascension_ranger_rapid_strikes');
