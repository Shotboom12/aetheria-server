-- Hero-only Stormbringer Surge of Might proc and forwarded-damage coefficient.
-- Inspect the matching target-world rows before applying.
START TRANSACTION;

DELETE FROM `spell_proc` WHERE `SpellId` = 520084;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
`SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
`DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(520084, 0, 0, 0, 0, 0, 69972, 1, 2, 3, 2, 0, 0, 100, 0, 0);

DELETE FROM `spell_script_names` WHERE `spell_id` = 520084 AND `ScriptName` = 'aura_ascension_surge_of_might';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES (520084, 'aura_ascension_surge_of_might');

DELETE FROM `spell_bonus_data` WHERE `entry` = 573254;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`)
VALUES (573254, 0, 0, 0, 0, 'Surge of Might: forwarded caster SP, no second coefficient');

COMMIT;
