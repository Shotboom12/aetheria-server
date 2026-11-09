-- Hero-only adaptations of CoA Primalist cooldown guidance scripts.
-- Source bindings and proc contracts: CoA pending_db_world revisions
-- rev_1789885429491261000.sql, rev_1789891613771936000.sql,
-- rev_1789898498446307500.sql, and rev_1789904511457546500.sql.
-- Preview migration only; inspect live rows before applying.

START TRANSACTION;

DELETE FROM `spell_proc` WHERE `SpellId` IN (504198, 680410, 681364, 706208, 707228);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
    `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
    `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(504198, 0, 0, 0, 0, 0, 69972, 1, 2, 3, 2, 0, 0, 100, 0, 0),
(680410, 0, 0, 0, 0, 0, 4, 0, 0, 3, 0, 0, 0, 100, 0, 0),
(681364, 0, 0, 0, 0, 0, 680, 0, 0, 52, 2, 0, 0, 100, 0, 0),
(706208, 0, 37, 16, 4194304, 0, 327680, 1, 2, 3, 2, 4, 0, 100, 0, 0),
(707228, 0, 37, 16, 4194304, 0, 327680, 1, 2, 2, 2, 4, 0, 100, 0, 0);

DELETE FROM `spell_linked_spell`
WHERE `spell_trigger` = 706208 AND `spell_effect` = 707228 AND `type` = 2;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(706208, 707228, 2, 'Rupturer - extra critical-strike resource stacks');

DELETE FROM `spell_script_names`
WHERE (`spell_id` = 504198 AND `ScriptName` = 'aura_ascension_primalist_direct_damage')
    OR (`spell_id` = 504199 AND `ScriptName` = 'spell_ascension_protector_of_the_grove')
    OR (`spell_id` = 680411 AND `ScriptName` = 'spell_ascension_thanes_guidance')
    OR (`spell_id` = 681354 AND `ScriptName` = 'spell_ascension_rupturer_lance')
    OR (`spell_id` = 681365 AND `ScriptName` = 'spell_ascension_spiritbound_cooldowns');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504198, 'aura_ascension_primalist_direct_damage'),
(504199, 'spell_ascension_protector_of_the_grove'),
(680411, 'spell_ascension_thanes_guidance'),
(681354, 'spell_ascension_rupturer_lance'),
(681365, 'spell_ascension_spiritbound_cooldowns');

COMMIT;
