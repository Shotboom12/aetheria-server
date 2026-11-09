-- Exact CoA script bindings/proc rows from upstream pending updates at
-- Conquest-of-AzerothCore/azerothcore-wotlk-coa commit 2f823e28dff86e3c1affb435b3a7f88607e9f01e.
-- Hero-only behavior remains enforced by the selected runtime owner/kit gates.

-- Bloodmage Transgression Vampiric Feast: upstream rev_20261006_95.
DELETE FROM `spell_proc` WHERE `SpellId` = 801076;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(801076, 0, 0, 0, 0, 0, 69904, 1, 2, 0, 0, 3, 0, 100, 0, 0);
DELETE FROM `spell_script_names` WHERE `spell_id` = 801076 AND `ScriptName` = 'aura_ascension_bloodmage_transgression';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(801076, 'aura_ascension_bloodmage_transgression');

-- Ranger Dirty Blades: upstream rev_20261007_05. Retire the older Pilfering
-- script/proc binding; the selected Dirty Blades script reads its talent aura.
DELETE FROM `spell_script_names` WHERE `spell_id` = 705087 AND `ScriptName` = 'aura_ascension_ranger_pilfering';
DELETE FROM `spell_script_names` WHERE `spell_id` = 680276 AND `ScriptName` = 'aura_ascension_ranger_dirty_blades';
DELETE FROM `spell_script_names` WHERE `spell_id` = 520571 AND `ScriptName` = 'spell_ascension_ranger_dirty_blades';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(680276, 'aura_ascension_ranger_dirty_blades'),
(520571, 'spell_ascension_ranger_dirty_blades');
DELETE FROM `spell_proc` WHERE `SpellId` IN (680276, 705087);
INSERT INTO `spell_proc` (`SpellId`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `Chance`) VALUES
(680276, 4, 0, 0, 0, 0, 0);

-- Bloodmage Sanguine Mend ranks: upstream rev_20261005_51. Only the nine ranks
-- covered by the instant-cast modifier consume Crimson Scion's next-cast aura.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_bloodmage_sanguine_mend';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802310, 'spell_ascension_bloodmage_sanguine_mend'),
(504079, 'spell_ascension_bloodmage_sanguine_mend'),
(504080, 'spell_ascension_bloodmage_sanguine_mend'),
(504081, 'spell_ascension_bloodmage_sanguine_mend'),
(504082, 'spell_ascension_bloodmage_sanguine_mend'),
(504083, 'spell_ascension_bloodmage_sanguine_mend'),
(504084, 'spell_ascension_bloodmage_sanguine_mend'),
(504085, 'spell_ascension_bloodmage_sanguine_mend'),
(504086, 'spell_ascension_bloodmage_sanguine_mend');

-- Pyromancer Draconic Aspect: upstream rev_20261010_98. Keep the existing
-- proc script; spell_script_names allows both scripts on the same aura.
DELETE FROM `spell_script_names` WHERE `spell_id` = 802117 AND `ScriptName` = 'aura_ascension_pyromancer_draconic_form';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802117, 'aura_ascension_pyromancer_draconic_form');

-- Xoroth Hellknight movement aura: upstream rev_20261007_01.
DELETE FROM `spell_script_names` WHERE `spell_id` = 800703 AND `ScriptName` = 'aura_ascension_xoroth_hellknight';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(800703, 'aura_ascension_xoroth_hellknight');

-- Necromancer Skeletal Warrior Strike: upstream rev_20261007_11.
DELETE FROM `spell_script_names` WHERE `spell_id` = 570042
    AND `ScriptName` = 'spell_ascension_necromancer_warrior_strike';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(570042, 'spell_ascension_necromancer_warrior_strike');

-- Ranger weapon coatings: upstream rev_20261011_02 and rev_20261011_03.
DELETE FROM `spell_script_names` WHERE `spell_id` = 570244
    AND `ScriptName` = 'spell_ascension_ranger_nerve_venom';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(570244, 'spell_ascension_ranger_nerve_venom');
DELETE FROM `spell_script_names` WHERE `spell_id` = 570245
    AND `ScriptName` = 'spell_ascension_ranger_burning_toxin';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(570245, 'spell_ascension_ranger_burning_toxin');

-- Runemaster Harnessed Leylines: upstream rev_20261007_54.
DELETE FROM `spell_script_names` WHERE `spell_id` = 804316
    AND `ScriptName` = 'spell_ascension_runemaster_harnessed_leylines';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(804316, 'spell_ascension_runemaster_harnessed_leylines');

-- Chronomancer Displacement: exact spell ID from the selected/upstream
-- AscensionChronomancerMovement source constant and matching CoA spell record.
DELETE FROM `spell_script_names` WHERE `spell_id` = 806727
    AND `ScriptName` = 'spell_ascension_displacement';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(806727, 'spell_ascension_displacement');

-- Stormbringer Ionic Aura: upstream rev_20260922_29. This script supplies the
-- energy, focus and runic-power portions of the Hero Stormbringer raid aura.
DELETE FROM `spell_script_names` WHERE `spell_id` = 707652 AND `ScriptName` = 'aura_ascension_ionic_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(707652, 'aura_ascension_ionic_aura');

-- Primalist Thorns: upstream rev_1789936968546876500, including both proc rows.
DELETE FROM `spell_proc` WHERE `SpellId` = 504732;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
    `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
    `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(504732, 1, 0, 0, 0, 0, 996348, 1, 2, 3, 2, 0, 0, 10, 0, 0);
DELETE FROM `spell_script_names` WHERE `spell_id` = 504732 AND `ScriptName` = 'aura_ascension_primalist_thorns';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504732, 'aura_ascension_primalist_thorns');
DELETE FROM `spell_proc` WHERE `SpellId` = 504784;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
    `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
    `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(504784, 0, 0, 0, 0, 0, 139944, 1, 2, 3, 2, 0, 0, 40, 0, 0);

-- Primalist Vitality Surge ranks: three upstream updates, with exact proc masks
-- and haste exclusivity groups retained from CoA.
DELETE FROM `spell_proc` WHERE `SpellId` = 300733;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
    `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
    `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(300733, 0, 0, 0, 0, 0, 278528, 2, 2, 3, 0, 0, 0, 100, 0, 0);
DELETE FROM `spell_script_names` WHERE `spell_id` = 300733 AND `ScriptName` = 'aura_ascension_vitality_surge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300733, 'aura_ascension_vitality_surge');
DELETE FROM `spell_proc` WHERE `SpellId` = 504214;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
    `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
    `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(504214, 0, 0, 0, 0, 0, 279552, 2, 2, 3, 2, 0, 0, 25, 0, 0);
DELETE FROM `spell_script_names` WHERE `spell_id` = 504214 AND `ScriptName` = 'aura_ascension_vitality_surge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(504214, 'aura_ascension_vitality_surge');
DELETE FROM `spell_group` WHERE `id` = 2000182 AND `spell_id` = 504215;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES (2000182, 504215);
DELETE FROM `spell_proc` WHERE `SpellId` = 503718;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`,
    `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`,
    `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(503718, 0, 37, 0, 8, 1048576, 16384, 2, 2, 3, 2, 0, 0, 20, 0, 0);
DELETE FROM `spell_script_names` WHERE `spell_id` = 503718 AND `ScriptName` = 'aura_ascension_vitality_surge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(503718, 'aura_ascension_vitality_surge');
DELETE FROM `spell_group` WHERE `id` = 2000181 AND `spell_id` = 503719;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES (2000181, 503719);

-- Earthmother's Roar: upstream rev_1789928212865596000. Preserve the scripted
-- missing-health amount without an extra SP/AP coefficient on its heal spell.
DELETE FROM `spell_script_names` WHERE `spell_id` = 802782 AND `ScriptName` = 'spell_ascension_earthmother_roar';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802782, 'spell_ascension_earthmother_roar');
DELETE FROM `spell_bonus_data` WHERE `entry` = 301307;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`)
VALUES (301307, 0, 0, 0, 0, 'Earthmother Roar: missing-health base, without an additional SP or AP coefficient');

-- Stormbringer cooldown reduction rank chains: upstream rev_20260922_15.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (300828, 680878, 801854)
    AND `ScriptName` = 'spell_ascension_stormbringer_cooldown_reduction';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(300828, 'spell_ascension_stormbringer_cooldown_reduction'),
(680878, 'spell_ascension_stormbringer_cooldown_reduction'),
(801854, 'spell_ascension_stormbringer_cooldown_reduction');

-- Cultist Gaze of C'Thun companion filtering: upstream rev_20261029_261.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_cultist_gaze_of_cthun_jump'
    AND `spell_id` IN (500110, 502135, 502136, 502137, 502138, 502139, 502140, 502141, 502142, 502143);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500110, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502135, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502136, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502137, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502138, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502139, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502140, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502141, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502142, 'spell_ascension_cultist_gaze_of_cthun_jump'),
(502143, 'spell_ascension_cultist_gaze_of_cthun_jump');

-- Pyromancer Pillar of Flame primary-target filtering: upstream rev_20261016_02.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ascension_pyromancer_pillar_of_flame'
    AND `spell_id` IN (805496, 807406, 807407, 807408, 807409, 807410);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(805496, 'spell_ascension_pyromancer_pillar_of_flame'),
(807406, 'spell_ascension_pyromancer_pillar_of_flame'),
(807407, 'spell_ascension_pyromancer_pillar_of_flame'),
(807408, 'spell_ascension_pyromancer_pillar_of_flame'),
(807409, 'spell_ascension_pyromancer_pillar_of_flame'),
(807410, 'spell_ascension_pyromancer_pillar_of_flame');
