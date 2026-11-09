-- REVIEW ONLY: CoA spell-proc conditions for selected Hero catalog spells.
-- Rows are limited to custom CoA spell entries; source stock/noncatalog conditions are excluded.
-- Source: pinned CoA SQL update tree; pending and unapplied.
START TRANSACTION;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 24 AND `SourceEntry` IN (520464, 520917, 704692, 807569);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(24, 0, 520464, 0, 0, 38, 0, 35, 4, 0, 0, 0, 0, '', 'Mineralization: caster health at or below 35 percent'),
(24, 0, 520917, 0, 0, 1, 0, 806982, 0, 0, 0, 0, 0, '', 'Stone Savant only procs while Earthen Fists is active'),
(24, 0, 704692, 0, 0, 24, 1, 7, 0, 0, 0, 0, 0, '', 'Corrupted Blood only corrupts a Humanoid target'),
(24, 0, 704692, 0, 1, 24, 1, 1, 0, 0, 0, 0, 0, '', 'Corrupted Blood only corrupts a Beast target'),
(24, 0, 807569, 0, 0, 1, 0, 570067, 0, 0, 0, 0, 0, '', 'Pure Chaos only procs while Incarnation of Chaos is active');
COMMIT;
