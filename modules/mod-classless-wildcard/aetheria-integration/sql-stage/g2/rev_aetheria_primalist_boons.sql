-- Fury of the Wild Boon copies, gated in source to Hero characters with the Primalist kit.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('aura_ascension_primalist_boon', 'aura_ascension_primal_convergence', 'aura_ascension_fury_of_the_wild', 'spell_ascension_pet_hawk_heal', 'aura_ascension_lion_boon_periodic');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(500935, 'aura_ascension_primalist_boon'),
(500939, 'aura_ascension_primalist_boon'),
(500943, 'aura_ascension_primalist_boon'),
(800137, 'aura_ascension_primalist_boon'),
(504856, 'aura_ascension_primalist_boon'),
(800181, 'aura_ascension_primal_convergence'),
(801234, 'aura_ascension_fury_of_the_wild'),
(997800, 'spell_ascension_pet_hawk_heal'),
(505217, 'aura_ascension_lion_boon_periodic');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 504856 AND `spell_effect` = 505217 AND `type` = 2;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(504856, 505217, 2, 'Hero Primalist Boon of the Lion - companion aura');
