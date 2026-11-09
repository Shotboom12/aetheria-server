-- Journey to the Core: delayed ground burst and proc, gated to Hero Primalists.
DELETE FROM `spell_proc` WHERE `SpellId` = 560510;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(560510, 0, 37, 64, 0, 0, 332116, 1, 2, 3, 2, 0, 0, 20, 0, 0);

DELETE FROM `spell_script_names` WHERE (`spell_id` = 560510 AND `ScriptName` = 'aura_ascension_journey_damage') OR (`spell_id` = 302534 AND `ScriptName` IN ('spell_ascension_journey_ground', 'aura_ascension_journey_ground'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(560510, 'aura_ascension_journey_damage'),
(302534, 'spell_ascension_journey_ground'),
(302534, 'aura_ascension_journey_ground');

DELETE FROM `spell_bonus_data` WHERE `entry` = 302590;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(302590, 1, 0, 0, 0, 'Hero Primalist - Journey to the Core: Crag uses 100% Nature spell power');
