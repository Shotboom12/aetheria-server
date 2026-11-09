-- CoA linked-spell relations triggered by selected paired CoA catalog spells.
-- Source: Conquest-of-AzerothCore/azerothcore-wotlk-coa @ 2f823e28dff86e3c1affb435b3a7f88607e9f01e.
-- Rows with stock spell triggers are excluded so classic spell behavior is not widened.
-- CoA custom spell access remains governed by Hero class 10 and the selected class/kit gates.
START TRANSACTION;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -803897 AND `spell_effect` = -802228 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -803896 AND `spell_effect` = -802228 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -802229 AND `spell_effect` = -802228 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 500288 AND `spell_effect` = 808090 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 503784 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 503785 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 503786 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 503787 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 503788 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 503789 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 503790 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 504574 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 561083 AND `spell_effect` = 561087 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 562572 AND `spell_effect` = 562722 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 562720 AND `spell_effect` = 563124 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 570183 AND `spell_effect` = 570270 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 573071 AND `spell_effect` = 573076 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 574344 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 574345 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 653214 AND `spell_effect` = 653216 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 653223 AND `spell_effect` = 653225 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 653232 AND `spell_effect` = 653275 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 681110 AND `spell_effect` = 681187 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 800184 AND `spell_effect` = 560971 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 800184 AND `spell_effect` = 560972 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 801345 AND `spell_effect` = 524969 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 802039 AND `spell_effect` = 803335 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 804418 AND `spell_effect` = 807310 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 804591 AND `spell_effect` = 800046 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 804833 AND `spell_effect` = 805161 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 805335 AND `spell_effect` = 504635 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 805335 AND `spell_effect` = 801615 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 805365 AND `spell_effect` = 807637 AND `type` = 2;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 807357 AND `spell_effect` = 807358 AND `type` = 0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 807555 AND `spell_effect` = 807464 AND `type` = 2;

INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
    (-803897, -802228, 0, 'Time Out! rank 3 - remove stasis when the parent aura is removed'),
    (-803896, -802228, 0, 'Time Out! rank 2 - remove stasis when the parent aura is removed'),
    (-802229, -802228, 0, 'Time Out! rank 1 - remove stasis when the parent aura is removed'),
    (500288, 808090, 2, 'CoA Runeshroud - movement speed reduction'),
    (503784, 807310, 0, 'Unmake rank 2 - remove Buy Time stasis from the target'),
    (503785, 807310, 0, 'Unmake rank 3 - remove Buy Time stasis from the target'),
    (503786, 807310, 0, 'Unmake rank 4 - remove Buy Time stasis from the target'),
    (503787, 807310, 0, 'Unmake rank 5 - remove Buy Time stasis from the target'),
    (503788, 807310, 0, 'Unmake rank 6 - remove Buy Time stasis from the target'),
    (503789, 807310, 0, 'Unmake rank 7 - remove Buy Time stasis from the target'),
    (503790, 807310, 0, 'Unmake rank 8 - remove Buy Time stasis from the target'),
    (504574, 807310, 0, 'Unmake rank 9 - remove Buy Time stasis from the target'),
    (561083, 561087, 2, 'CoA Ghost Form - feather fall helper so the form does not take falling damage'),
    (562572, 562722, 2, 'CoA Accursed Form - gargoyle transform and Polymorph immunity helper'),
    (562720, 563124, 2, 'CoA Blood Curse - worgen transform helper'),
    (570183, 570270, 2, 'Local Primalist: King of the Mountain Stamina attack power'),
    (573071, 573076, 2, 'CoA Withering Touch - magic vulnerability follows the armor debuff'),
    (574344, 807310, 0, 'Unmake rank 10 - remove Buy Time stasis from the target'),
    (574345, 807310, 0, 'Unmake rank 11 - remove Buy Time stasis from the target'),
    (653214, 653216, 2, 'CoA Water Engraving - Weapon Engraving: Water proc aura'),
    (653223, 653225, 2, 'CoA Air Engraving - direct damage copies and casting haste'),
    (653232, 653275, 2, 'Local CoA Aether Augmentation: magic damage reduction while equipped'),
    (681110, 681187, 2, 'CoA Storm Ascendance: companion transform and magic damage taken reduction'),
    (800184, 560971, 2, 'Legacy of Rexxar: Huffer critical-strike listener'),
    (800184, 560972, 2, 'Legacy of Rexxar: Leokk critical-strike listener'),
    (801345, 524969, 2, 'Ranger Elude - Elude SLS3 (Pathfinder Adrenaline Rush cooldown)'),
    (802039, 803335, 2, 'Ranger Skirmish - Skirmish SLS (Brutal Shot guaranteed critical strike)'),
    (804418, 807310, 0, 'Unmake rank 1 - remove Buy Time stasis from the target'),
    (804591, 800046, 2, 'CoA Thunder King: companion movement speed'),
    (804833, 805161, 2, 'CoA Stormcloak: companion dispel resistance'),
    (805335, 504635, 2, 'Primalist Golem Form - damaging spells while moving'),
    (805335, 801615, 2, 'Primalist Golem Form - 20 percent melee and spell haste'),
    (805365, 807637, 2, 'Local CoA Flourish: owned periodic aura follows the main buff'),
    (807357, 807358, 0, 'Relentless - cast the orphaned Aortic Assault cooldown reduction with the buff'),
    (807555, 807464, 2, 'CoA Flurry: companion resistance and damage-taken debuff');

COMMIT;
