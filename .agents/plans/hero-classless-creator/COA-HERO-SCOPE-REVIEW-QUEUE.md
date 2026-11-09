# CoA Hero-only source review queue

Pinned upstream: `STRHercules/EsteriaWoW` commit `9f914baff448e635cfe0469e12e957a2a165e5e3`.

## Inventory pass

Forged aura evidence: pinned generator blob `23d5208827caa06cea7d2c750ff57e20432c0bcc` defines Repertoire and Ward Off as self-range/T_SELF auras. Combined preview now checks caster GUID against the eligible Hero holder for custom effects, and Repertoire removal clears only its matching spell-ID cache record. Same-ID overlapping instances still need core aura-lifecycle review; exact generated IDs remain data-blocked. CPP codestyle passes.

Forged pet/sentry continuation: prepared `ClasslessForgedScripts.pet-boundaries.patch`, checked against the pinned source with `git apply --recount --check`. It requires a participating Hero owner before pet-speed changes, talent-spell synchronization, pet-model changes, and sentry attacks. The exported pet-sync entrypoint is guarded too. Keep this patch unapplied until combined review: Quickening still directly spends both rage and energy without eligibility checks, and Repertoire modifies state/amounts without a source boundary. These remain outstanding; this is not a complete forged-script adaptation.

Forged continuation: prepared `ClasslessForgedScripts.hero-boundaries.patch` for the shared talent lookup, damage/healing bonus helper, cast watcher, and Weave refund. The watcher now requires Hero participation before cache mutation; the delayed refund stores a GUID and resolves/rechecks participation at execution. `git apply --recount --check` against the pinned reference passed. This patch is deliberately unapplied and incomplete: direct spell callbacks, pet models, sentry AI, aura cleanup, and recipient semantics still need review. Apply with `--recount` when composing the complete adaptation.

Module-boundary follow-up: `ClasslessLoot.cpp` now requires `IsParticipant(killer)` before pool access, RNG, or corpse-loot mutation in the isolated preview. This covers player and pet-owner kill entrypoints. Because corpse loot can be shared with conventional group members, do not activate custom world drops until group recipient policy and reserved item-ID ownership are verified. Upstream blob: `ef386fa8b5574a042801d59b574c97dd51a268db`.

`ClasslessForgedScripts.cpp` remains unadapted. Initial review found its cast watcher records every player's damaging casts, its talent-bonus helper lacks participant eligibility, and Weave schedules a refund using a retained raw player pointer. Full callback, summon, recipient, and delayed-event review is required; a single watcher gate would not contain this file.

The GitHub compare from `e6dcea5b0a81` to the pinned revision exposes 263 changed C++/header paths under `modules/mod-classless-wildcard/src/coa/` (209 `.cpp`, 54 `.h`). A content scan retrieved all 263 files. 175 contain a SpellScript/AuraScript/PlayerScript/UnitScript marker. A heuristic found 46 of those with no textual `HasCoAKit`, `IsParticipant`, `IsHero`, or `CLASS_HERO` marker. It counted 427 callback-shaped methods across all 263 files.

This is a review queue, not a verdict: helper calls, script registration scope, and spell ID ownership may affect the actual behavior. Follow-up resolved one common false positive: 27 of the 46 files call a CoA `Owner()` helper; all seven matching helper definitions checked here delegate eligibility to `HasCoAKit`. The preview's `HasCoAKit` now rejects non-Hero players. The remaining scripts still need callback-level review. A guard in one method does not prove the other callbacks in that file are gated. Classless acquisition is Hero-only, but CoA handlers may also target existing Classic spell IDs, so per-player gating is required to preserve normal classes.

One concrete cross-class path was confirmed and fixed in the preview: `AscensionSummonAvoidance.cpp` applied avoidance auras to listed creature entries for any player's guardian/summon. Its guardian hook and ordinary player-summon hook now verify the owning player is an enabled Hero. This specific file is no longer pending for that behavior, but source review is still needed for any other side effects in its callback paths.

## Candidate files with no obvious Hero gate

```text
AscensionBarbarianAbilities.cpp
AscensionBloodmageProcs.cpp
AscensionChronomancerRenewal.cpp
AscensionCultistAbilities.cpp
AscensionCultistAuras.cpp
AscensionCultistContracts.cpp
AscensionCultistEvents.cpp
AscensionCultistSummons.cpp
AscensionFelswornAbilities.cpp
AscensionFelswornAuras.cpp
AscensionFelswornContracts.cpp
AscensionFelswornEvents.cpp
AscensionGuardianEvents.cpp
AscensionNecromancerAbilities.cpp
AscensionNecromancerAuras.cpp
AscensionNecromancerContracts.cpp
AscensionNecromancerEvents.cpp
AscensionPrimalistAncientWar.cpp
AscensionPrimalistBramblepatch.cpp
AscensionPrimalistDreamslip.cpp
AscensionPrimalistRylaksBite.cpp
AscensionPrimalistSacredGrove.cpp
AscensionPyromancerAbilities.cpp
AscensionPyromancerAuras.cpp
AscensionPyromancerContracts.cpp
AscensionPyromancerEvents.cpp
AscensionRaidDamageAuras.cpp
AscensionReaperAnimaAmbusher.cpp
AscensionReaperMindScreech.cpp
AscensionReaperReliquary.cpp
AscensionReaperRuin.cpp
AscensionReaperTormentedSouls.cpp
AscensionRunemasterRunicTalents.cpp
AscensionStarcallerAuras.cpp
AscensionStarcallerContracts.cpp
AscensionStarcallerEvents.cpp
AscensionStarcallerMechanics.cpp
AscensionStormbringerFog.cpp
AscensionStormbringerIonicAura.cpp
AscensionStormbringerMysticThunder.cpp
AscensionSummonAvoidance.cpp
AscensionSunClericAbilities.cpp
AscensionSunClericAuras.cpp
AscensionSunClericContracts.cpp
AscensionSunClericDevotion.cpp
AscensionSunClericEvents.cpp
```

## Limits and next review

The compare exposes changed files only. The upstream module has 377 files under `src/coa`; its remaining unchanged files are not represented in this 263-file candidate set. The local pinned-reference excerpt has 34 files total, only two under `src/coa`, so none of the candidate callback bodies have been adapted or verified in the port preview.

Next, stage the complete module source at the pinned revision, then review each registered callback for its actor/target and side effect. Add the Hero predicate at callback entrypoints that can affect players, player-owned pets, resources, spell ownership, or shared Classic spell behavior. Separately review load-time SpellInfo mutations and generated SQL bindings: static spell metadata is global and can affect normal classes even when class acquisition is gated. Do not register or install the module until the complete source and data surfaces pass this review.

## Callback spot review (2026-11-05 continuation)

Read eight representative candidates from the pinned GitHub revision (source paths and revision above):

- `AscensionBarbarianAbilities.cpp`: player-side effects go through `Owner(GetCaster())`; after the established helper audit, these callbacks inherit the central Hero gate. No extra patch staged.
- `AscensionCultistSummons.cpp`: summon state and damage hooks use `Owner(...)` / `State(player)` paths; summon lifecycle cleanup is keyed to custom entries and recorded owner GUID. Full behavior still requires review with the complete supporting module.
- `AscensionPrimalistDreamslip.cpp`: **confirmed global-data hazard.** Its `GlobalScript::OnLoadSpellCustomAttr` modifies `SpellInfo` for matching ID/family/effect with no player context. It cannot be made Hero-only by a runtime player predicate. Before inclusion, verify the exact local SpellInfo row and ID collision against paired client/server/world baselines; if it collides with a Classic spell, the implementation is incompatible with the Hero-only requirement and needs a data-aware redesign.
- `AscensionStormbringerIonicAura.cpp`: aura apply/remove directly changes focus, energy, and runic-power modifiers on any aura target. Validate the intended Hero eligibility at the aura boundary, while preserving effects of a Hero-cast aura on intended targets only if that is explicitly part of the design. Spell data/caster ownership needs review before porting.
- `AscensionRaidDamageAuras.cpp`: recalculates from caster ownership and modifies proc behavior on the affected ally. Verify custom IDs and recipient semantics; a target-only guard could break a Hero's intended party effect, while lack of a caster eligibility check could activate behavior for Classic characters.
- `AscensionChronomancerRenewal.cpp` and `AscensionReaperTormentedSouls.cpp`: upstream callbacks attach by spell/aura ID without an explicit class predicate. Source eligibility is now staged for both in the isolated preview, but exact local spell data and collisions must be checked before registration.
- `AscensionSunClericDevotion.cpp`: scaling goes through `Owner(caster)` and the helper-gated eligibility path; supporting `Derived` and coefficient data still need review.

This bounded spot review is not approval of the candidate files. Missing paired spell-data baselines prevent proving custom-ID exclusivity. No source adaptation or module registration was made from these observations.

## Additional callback spot review (2026-11-05 continuation)

Eight more candidate sources from the same pinned revision were read:

- `AscensionBloodmageProcs.cpp`: four AuraScripts check proc conditions without a player eligibility test in the upstream callback. Hero-source checks are now staged in the isolated preview; verify those aura bindings/IDs and shared spell rows before registration.
- `AscensionNecromancerEvents.cpp`, `AscensionPyromancerAuras.cpp`, `AscensionFelswornEvents.cpp`, and `AscensionStarcallerMechanics.cpp`: the reviewed paths route player behavior through `Owner(...)`; they inherit the central Hero check where used. Audit every callback in these larger files and verify the helper's owner semantics for pets/charms.
- `AscensionPrimalistSacredGrove.cpp`: **second confirmed global-data hazard.** Its `OnLoadSpellCustomAttr` rewrites target/effect types for exact IDs 800180, 800186, and 800179 (within spell family 37). It has no player context, so verify all three local SpellInfo rows and collision status before porting; a class-specific runtime gate cannot contain these changes.
- `AscensionRunemasterRunicTalents.cpp`: `ReduceGuardingRuneCooldown` changed cooldowns on any player hit by its scripted effect, and three periodic aura handlers had no source-class check. Hero-source guards are now staged before side effects/default suppression; an enabled Hero's ability may still affect its intended target. Verify exact bindings and intended target semantics.
- `AscensionGuardianEvents.cpp`: proc logic operates on its aura holder and surrounding actor/target, without an obvious Hero check at the shown proc boundary. Determine whether each aura can target a non-Hero through Hero party abilities, then gate the module-originating behavior by the eligible Hero source while preserving any explicitly intended group effect.

These findings expand the review queue; they do not justify importing partial files. Paired spell DBCs/bindings remain the evidence needed to distinguish newly introduced IDs from shared Classic spell IDs and to decide the correct actor-versus-target guard.

## Global metadata scan follow-up (2026-11-05 continuation)

Eight further candidates were scanned; three more contain global metadata or all-spell hooks:

- `AscensionPrimalistAncientWar.cpp`: global SpellInfo mutation changes the aura type for exact ID 504222 (family 37). Verify the local row/ID before porting; no player context exists at load time.
- `AscensionPrimalistBramblepatch.cpp`: global SpellInfo rewrites effect types for IDs 807859 and 807120 (family 37). Its `AllSpellScript` also blocks leap/jump/charge casts from any caster carrying aura 807859. Verify the IDs and constrain the runtime all-spell hook to the intended Hero-originating aura before inclusion.
- `AscensionPrimalistRylaksBite.cpp` had no helper or Hero markers in the quick scan; its callback is now staged with a Hero participant gate.
- `AscensionPyromancerContracts.cpp`, `AscensionStarcallerAuras.cpp`, and `AscensionSunClericEvents.cpp`: player-affecting paths use `Owner(...)`, subject to the central helper gate and full callback review.
- `AscensionStormbringerMysticThunder.cpp`: no class/helper markers found; callback-body and binding review remains open.

Four standalone global SpellInfo-mutating files are explicitly identified here (Dreamslip, Sacred Grove, Ancient War, Bramblepatch). The class glue also applies many load-time SpellInfo contracts, including the Primalist contracts recorded below. Their IDs/layouts are not proven collision-free in Aetheria because paired data is unavailable. None should be enabled until that verification and any required redesign are complete.

`AscensionStormbringerFog.cpp` applies an all-spell check against tracked fog areas. On review, a fog field restricting hostile spells regardless of the field owner's class may be the intended combat mechanic. Do not narrow it to the casting Hero's own fog without confirming target semantics; the earlier owner-only adaptation was removed from the preview. Keep this file unresolved pending design and spell-binding evidence.

`AscensionStormbringerMysticThunder.cpp` was also adapted in the isolated preview. Its all-spell callback sees the marked target as the casting unit, which can be a non-Hero enemy by design. The gate therefore checks the mark's caster (the Hero source) rather than the marked unit, preserving the intended next-cast silence only for marks applied by enabled Heroes. The exact spell bindings still need baseline verification; the source is not registered or compiled.

`AscensionPrimalistRylaksBite.cpp` is staged with a participant/config gate before its extra charge cast and pet duplicate. The gate applies only to a Hero player; other classes and non-player casters retain the bound spell's normal default behavior. Verify spell 707293's binding and collision status before registration. Not compiled.

`AscensionReaperAnimaAmbusher.cpp` now gates its bonus hit on an enabled Hero-owned caster. `AscensionReaperMindScreech.cpp` gates on the aura's source caster before suppressing the default proc, so an unrelated/non-Hero aura keeps its normal default behavior. These are isolated source adaptations only; verify exact spell bindings and test player, pet, and non-Hero targets before registering.

## Additional global-hook candidates (2026-11-05 continuation)

- `AscensionGuardianEvents.cpp` includes an `AllSpellScript` that consumes aura 801778 from an untriggered caster. A Hero-source gate is now staged around its proc, converted damage/bleed, and Echo paths; confirm bindings before porting.
- `AscensionStormbringerMysticThunder.cpp` is another `AllSpellScript`: a cast by any character holding mark 505214 consumes it and applies silence 505347. Verify the spell data/binding and constrain it to eligible Hero-originating marks/casts.
- `AscensionReaperAnimaAmbusher.cpp` and `AscensionReaperMindScreech.cpp` have Hero-source gates staged; verify spell bindings and ID collisions before registration.
- `AscensionPrimalistRylaksBite.cpp` now gates the charge and pet duplicate on an enabled Hero player; verify the exact spell binding and ID collision before registration.
- `AscensionNecromancerAuras.cpp` and `AscensionCultistAuras.cpp` route reviewed player behavior through `Owner(GetCaster())`; retain the central eligibility check for each such entrypoint and inspect unguarded callbacks individually.
- `AscensionCultistContracts.cpp` similarly routes observed paths through `Owner(...)`; each `UnitScript` hook still needs ownership and source-spell review.

These are source-level risk findings, not proof that each custom ID collides. The data baseline is needed to establish whether a missing runtime class check is merely scoped by a new ID or can change existing spells.

`AscensionGuardianEvents.cpp` is staged in the isolated preview with eligibility checks on its aura-source proc, converted damage and bleed handlers, and Guardian Echo before custom behavior is consumed. The check follows the Hero source, allowing that Hero's intended effects to resolve on other targets. Exact DB spell bindings and shared-ID collisions still need verification. The source is not registered or compiled.

`AscensionReaperRuin.cpp` now applies the Ruin mark only for enabled Hero casters. `AscensionReaperReliquary.cpp` gates its bolts and triggered soul behavior on enabled Hero sources and replaces its delayed event's retained `Unit*` with a player GUID resolved at execution. Verify exact bindings and test logout/death during the delayed sequence before registration. Both files are preview-only and uncompiled.

`AscensionRunemasterRunicTalents.cpp` now checks the aura/spell source for enabled Hero participation before changing periodic defaults or target cooldowns. The guard leaves non-Hero-sourced behavior on the normal core path and permits a Hero-sourced effect to reach its intended recipient. Bindings and recipient design still require spell-data verification; this is preview-only.

`AscensionBloodmageProcs.cpp` has four proc-condition callbacks that inspect victim mechanics, spell-family flags, or aura actor identity. The preview now checks that the aura source is an enabled Hero before those checks can activate CoA proc behavior. Since two callbacks inspect broad spell-family flags, confirm exact aura bindings and whether any local shared spell rows can reach them before registration. This is an isolated, uncompiled adaptation.

`AscensionStormbringerIonicAura.cpp` remains intentionally unadapted: its apply and remove callbacks mutate target power modifiers, and a naïve source check on removal could skip cleanup when a Hero caster is unavailable. Decide source-versus-target semantics and cleanup ownership, then verify the aura binding and shared spell rows before changing it.

`AscensionRaidDamageAuras.cpp` confirms an intended group-recipient path: it scales aura damage from the aura caster, while each ally holding the aura is the proc actor and can damage a hostile target. A target-only Hero gate would break Hero-granted party effects; a robust port needs source ownership retained through scaling/proc plus confirmation that the aura IDs are CoA-only. No adaptation staged pending exact spell bindings and recipient design.

`AscensionChronomancerRenewal.cpp` now caches enabled-Hero source eligibility when the aura applies and only uses custom contribution scheduling for those auras. Other sources leave default periodic-heal behavior unsuppressed. Hero-source eligibility persists for later ticks even if the caster is unavailable. Its pinned upstream `AscensionRenewalContributions.h` helper is now staged alongside it; verify aura bindings and shared IDs before porting.

`AscensionReaperTormentedSouls.cpp` now gates soul counting, delayed-effect suppression, and the custom proc on enabled-Hero source eligibility. The aura caches whether it is Hero-sourced so its companion ward is removed during aura cleanup even if its caster becomes unavailable; non-Hero aura instances retain the core path. Verify all spell bindings and shared IDs before registration.

## Helper-path continuation (2026-11-05)

Reviewed eight more candidates: `AscensionCultistEvents.cpp`, `AscensionFelswornAbilities.cpp`, `AscensionFelswornAuras.cpp`, `AscensionNecromancerContracts.cpp`, `AscensionPyromancerEvents.cpp`, `AscensionStarcallerEvents.cpp`, `AscensionSunClericAuras.cpp`, and `AscensionSunClericContracts.cpp`. The player-facing paths observed in these sources use `Owner(...)`; those inherit the central Hero/kit checks where the helper is used. Felsworn's all-spell callbacks also use `Owner(...)` before their player-specific state and modifications. This is a spot review, not a full per-callback certification; spell bindings, unguarded utility paths, and intended party effects still require the complete data/source context.

Further pinned-source spot review covered `AscensionSunClericAbilities.cpp` (484 lines), `AscensionFelswornAuras.cpp` (336 lines), and `AscensionNecromancerAbilities.cpp` (492 lines). All observed player-facing callbacks route through `Owner(...)`, so their player-specific state/effects inherit the central Hero eligibility check. No duplicate per-file guard was staged. This remains a bounded source review; helper semantics, exact bindings, and any unobserved paths still require full integration context.

`AscensionCultistAbilities.cpp` and `AscensionPyromancerAbilities.cpp` had area-target filters with no caster eligibility check. The Cultist filter removes companions and adds chain-jump candidates; the Pyromancer filter removes the selected primary target from a secondary area effect. Both filters now return without modifying targets unless `Owner(GetCaster())` resolves an eligible Hero, preserving the core target list for other casters. Exact script bindings still need verification.

`CoAGlueCultist.cpp` had a cross-class cleanup path: its player update called `RemoveThresholds` for every player not recognized as Cultist. The helper now returns unless the player is class ID 10, protecting conventional-class auras while preserving cleanup for Hero characters without an active Cultist kit. The resource gain path itself uses `HasCoAKit`; verify the corresponding module gate/registration before integration.

`CoAGluePrimalist.cpp` had similar lifecycle cleanup: logout/death/reconciliation could remove Primalist helper auras and pet state without a class check, and update processing scanned those IDs for every player. `RemovePrimalistHelpers`, `ReconcilePrimalistWeapon`, and the update hook now return for non-Hero players. The actual resource and combat effects route through `PrimalistEnabled`/`HasCoAKit`; verify kit bindings and module registration before integration.

`CoAGluePrimalist.cpp` also contributes global SpellInfo contracts through `OnLoadSpellCustomAttr`: six Earthquake ranks, Harness Animal Spirit/tame-helper layouts, Animal Spirit visual data, and Primal Weapons (ID 537218, family 37). These are exact-ID/layout mutations with no player context. Validate all affected rows against the paired client/server/world baselines before inclusion; the four separately listed global metadata scripts are not the only global spell-data surface.

The Cultist bridge also calls `AscensionCultist::ApplyContracts(info)` from the global SpellInfo loader for spell family 31, normalizing proc flags, aura/effect types, target selectors, and Ascension behavior by spell ID. This is a separate load-time metadata surface from the four standalone mutators and Primalist contracts. Its full ID lists and every changed row require collision review against Aetheria's paired baselines before binding/registration.

**Ionic Aura Hero boundary:** Adapted the pinned `AscensionStormbringerIonicAura.cpp` in the isolated preview. Its custom focus/energy/runic-power stat modifiers now apply only when the aura source resolves to an enabled, non-exempt Hero, including a Hero-owned unit. The aura instance caches whether it applied those modifiers, so removal restores them even if the original caster is gone; unrelated/non-Hero aura instances do not run the custom removal recalculation. Original Git blob identity is recorded in `source-provenance.json`. CPP codestyle passes. Spell 707652 binding/collision and aura lifecycle remain unverified; not compiled or registered.

**Ionic Aura Hero boundary:** Adapted the pinned `AscensionStormbringerIonicAura.cpp` in the isolated preview. Its custom focus/energy/runic-power stat modifiers now apply only when the aura source resolves to an enabled, non-exempt Hero, including a Hero-owned unit. The aura instance caches whether it applied those modifiers, so removal restores them even if the original caster is gone; unrelated/non-Hero aura instances do not run the custom removal recalculation. Original Git blob identity is recorded in `source-provenance.json`. CPP codestyle passes. Spell 707652 binding/collision and aura lifecycle remain unverified; not compiled or registered.

**Raid Damage Aura Hero boundary:** Adapted pinned `AscensionRaidDamageAuras.cpp`. Area targeting now applies Exhaustion filtering only for enabled, non-exempt Hero sources. Custom aura scaling records Hero-source eligibility and retains that state if the caster later disappears. Hero auras still scale from their source and proc through intended group recipients; non-Hero aura instances leave core amount/proc behavior in place. Original blob recorded in provenance. CPP codestyle passes; bindings, data collisions, and in-game party behavior remain unverified. Not compiled or registered.


**File-only exact-ID baseline (2026-11-05):** Read `C:\Acore2\Server\Data\dbc\Spell.dbc` and extracted `DBFilesClient\Spell.dbc` from the installed client `Data\Patch-ZP.mpq` without writing to either. Checked fourteen exact IDs already named for Dreamslip, Sacred Grove, Ancient War, Bramblepatch, Raid Damage Auras, and Ionic Aura. All fourteen are absent from both inspected files; hashes/layout are recorded in `server/work/hero-classless-20261105/aetheria-port-preview/checks/global-spell-id-file-baseline-20261105.json`. This is only a file-level diagnostic. `spell_dbc` world overrides can add rows, and Patch-ZP has not been proven to be the winning client DBC across all mounted patches; therefore it does not clear any global contract for registration.


**Client direct-patch scan correction (2026-11-05):** The earlier Patch-ZP-only note is superseded by a scan of all 70 installed client MPQs. Fourteen direct archives contain `DBFilesClient\Spell.dbc`; all fourteen snapshots lack the fourteen listed exact IDs. Active client `PatchFiles.cpp` sorts patch paths descending, and `Client.cpp::OpenArchives` opens them in reverse while increasing priority; `Patch-ZY.mpq` is the highest-name direct Spell.dbc patch found. The same scan checked the three nested archive names used by `OpenArchives` (`alternate`, `expansion`, `lichking`) in all 70 archives and found no derived archive entries. Full evidence is in `global-spell-id-file-baseline-20261105-v2.json`. This substantially closes the client file-side exact-ID question; current server world `spell_dbc` rows remain unqueried, and family-based contracts still need review.


**Selected spell-family file baseline (2026-11-05):** Using `SpellEntry::SpellFamilyName` field 208 from the local DBC structure, inspected Acore2 `Spell.dbc` and the highest-name direct client patch DBC (`Patch-ZY`). Spell families 19, 22, 31, 34, and 37 have zero rows in both snapshots; all fourteen explicit IDs above are also absent. Evidence: `server/work/hero-classless-20261105/aetheria-port-preview/checks/global-spell-id-file-baseline-20261105-v3.json`. Family-based contract collisions remain unproven against the live world `spell_dbc` overlay, which was not queried; do not activate global contracts from this file-only result.


**Primalist/Cultist global-contract refinement (2026-11-05):** Pinned source confirms Primalist global contracts are exact and family-bound: Earthquake family 37 IDs 520412/520741-745 plus effect-layout checks; Spirit Beast family 37 IDs 574301/574304/574306 with strict layouts; Primal Weapons family 37 ID 537218; Earthshaping family 37 IDs 680846, 532562, 680450, 803140, and 802335 with field-specific guards. Cultist `ApplyContracts` returns unless SpellFamilyName is 31. These exact IDs are absent from Acore2 Spell.dbc and the highest direct client Patch-ZY Spell.dbc; selected family rows 31 and 37 are zero in both. Expanded evidence: `server/work/hero-classless-20261105/aetheria-port-preview/checks/global-spell-id-file-baseline-20261105-v4.json`. This still does not cover the world spell_dbc overlay, which can add rows. Keep all global contracts disabled until that overlay and remaining global contract surfaces are resolved.

**Master-switch containment for global metadata:** `cw_coa_spell_data::OnLoadSpellCustomAttr` previously invoked its entire metadata correction chain without checking the module master flag. Since `ClasslessWildcard.Enable` defaults false while `ClasslessWildcard.CoA.Enable` defaults true, the CoA-specific gates alone did not preserve the intended disabled state for all contracts. The isolated preview now returns before any metadata mutation unless `Enabled()` (master Hero/Classless + CoA switches) is true and the SpellInfo pointer is valid. The preview codestyle linter passed. When enabled, these remain global SpellInfo mutations; the 29-ID/family file baseline and missing world `spell_dbc` overlay still block claiming Hero-only behavior or registering the chain.

**Chronomancer global contract audit (2026-11-05):** Pinned `AscensionClassMechanics19To25.cpp` adds four load-time corrections for IDs 520457, 806203, 806728, and 680947. Each is exact-ID/family-28/effect-layout guarded. A reusable DBC/MPQ scan now checks these alongside the previously reviewed contracts: all 33 IDs are absent from Acore2 `Spell.dbc` and the embedded DBC in highest-name direct patch `Patch-ZY`; families 19, 22, 28, 31, 34, and 37 have zero rows in both. The current report and reproducible tool are `checks/global-spell-id-file-baseline-20261105-v5.json` and `tools/check_global_spell_contracts.py`; raw scan: `checks/contract-scan-20261105.json`. World `spell_dbc` remains unqueried. The upstream source does not apply the master module gate itself; the preview hook-level `Enabled()` guard added above contains these edits when Hero/Classless or CoA is disabled. Enabled-mode global behavior still needs source/data review.

**Global metadata audit expansion (2026-11-05):** Reviewed five more pinned contract groups: Conditional Combat (34 rules/30 unique IDs across families 18-38), Healing Stat Selectors (9 exact full-record contracts), Sun Cleric Radiance (3 exact-ID mutations), Tinker Combustion (1 strict family/data contract), and Venomancer Catalyst (1 exact helper contract). The scan now covers 77 exact IDs and all SpellFamilyName values 18-38; no target IDs or family rows appear in either inspected DBC. Sun Cleric's three ID-only rewrites lack family/original-layout checks and remain a priority for paired-data contract hardening. Evidence: `checks/global-spell-id-file-baseline-20261105-v6.json`; reproducible raw scan: `checks/contract-scan-20261105.json`. This remains selected review; the rest of the `OnLoadSpellCustomAttr` call chain and world `spell_dbc` overlay remain outstanding.

**Global metadata audit expansion (2026-11-05, continued):** Reviewed five more pinned groups: Templar Librams (one strict full-record contract), Runemaster Glyphs (3 IDs), Brand (7), Scaling (20), and Tinker Overload (2 strict ID/family/layout contracts). The selected audit now covers 110 exact IDs; none occur in the inspected server or client DBC, and every family 18-38 has zero rows there. Latest evidence: `checks/global-spell-id-file-baseline-20261105-v7.json`; scanner/raw inputs: `tools/check_global_spell_contracts.py` and `checks/contract-scan-20261105.json`. Sun Cleric Radiance remains weaker: its three exact-ID mutations lack family/original-layout checks. This is still not a complete review of the global hook call chain; the live world spell_dbc overlay remains unqueried.

**Pinned helper source staged:** Added `AscensionClassMechanics19To25.cpp/.h` from pinned EsteriaWoW commit `9f914baff448e635cfe0469e12e957a2a165e5e3` to satisfy the existing CoAGlue dependency. Both local git-blob hashes match upstream exactly and provenance is recorded. The metadata hook is master/CoA-gated; runtime class callbacks pass through the Hero-only `HasCoAKit` helper. Preview C++ codestyle passes. This source is not compiled, built into the module, or registered for gameplay. Snapshot evidence: `checks/global-spell-id-file-baseline-20261105-v8.json`.

**Global metadata audit expansion (2026-11-05, continued):** Reviewed Runemaster Damage Modifiers (5 IDs), Zenith (1), Talent metadata (5), Reaper Deathwind (7 ranks), Reaper Scythe Rush (1), and Bloodmage Hemoglobe (1). The selected scan now covers 130 IDs, all absent from inspected server/client DBCs; family values 18-38 remain empty. Runemaster Talent has three weaker guards: Permafrost 804060 has no family/layout check, marker 808089 checks its aura but not family, and 712310 writes effect 1 after only ID/family checks. Evidence: `checks/global-spell-id-file-baseline-20261105-v9.json`. World `spell_dbc` and the remaining global hook methods are still open.

**Global metadata audit expansion (2026-11-05, continued):** Added CoA spell-charge override table (162 exact IDs), Guardian (2 direct contracts), Tinker Scrap (2), Additional Targets (8), and Runemaster Manuscription (5) to the checked set. The report now covers 298 IDs, all absent from both inspected DBCs; families 18-38 remain empty. The charge table and Manuscription contracts use exact IDs but lack record-layout predicates, making paired spell-data ownership especially important. Ranger contracts and other global methods remain open. Evidence: `checks/global-spell-id-file-baseline-20261105-v10.json`; raw scan: `checks/contract-scan-20261105.json`.

**Ranger metadata audit (2026-11-05):** Reviewed the pinned Ranger global contract path plus linked Ranger damage/talent contracts. Added 40 exact/rank/helper IDs, including seven Falconstrike ranks; the selected scan now covers 338 IDs. None occur in the inspected server/client DBC, and families 18-38 remain empty. Most Ranger rewrites check family and expected effect shape; Serrations uses narrower ID plus aura/base-point predicates. Evidence: `checks/global-spell-id-file-baseline-20261105-v11.json`. Remaining global hook methods and world spell_dbc are still unreviewed.
