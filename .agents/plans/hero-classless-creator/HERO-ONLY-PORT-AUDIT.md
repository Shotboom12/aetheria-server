# Hero-only port audit — pinned Classless Wildcard module

Date: 2026-11-05  
Upstream: `STRHercules/EsteriaWoW` commit `9f914baff448e635cfe0469e12e957a2a165e5e3`  
Reference files: `work/hero-classless-20261105/upstream-reference-9f914baff448e635cfe0469e12e957a2a165e5e3/`  
Provenance: `provenance.json`; it lists 37 pinned upstream files, with blob IDs matching GitHub.

## Owner requirement

The Classless/CoA system is for **Hero class ID 10 only**. All other classes must retain their current spells, talents, resources, stats, gear restrictions, progression, quests, and character-creation behavior. This is an implementation invariant. A module-wide enable setting or bot/system-account exemption does not satisfy it.

## Confirmed global behavior to remove or scope

- `ClasslessPlayerScript::OnPlayerCreate` calls `EnforceChassis`, which rewrites a newly created character to the module's chosen chassis, then grants module starter gear. This must never run for a conventional class. For Aetheria Hero, the class-10 DBC and create rows establish the actual class; the upstream chassis conversion must be removed or redesigned.
- `OnPlayerLogin` also calls `EnforceChassis`, then loads classless state, synchronizes CoA automatic grants, sets native talent points to zero, enables DK pet display, and restores the display-power choice. Every one of those effects must be conditional on Hero ID 10.
- The remaining player callbacks implement module-wide spell suppression/ownership, talent economy, universal mana/rage/energy, class-context overrides, guardian/pet behavior, level progression, update-time addon/resource packets, and persistence. Each player callback needs a fast Hero check before state lookup, mutation, message, or packet send.
- `ClasslessMgr` exposes many stateful operations (grant/remove abilities, talents, archetypes, rebirth, display power, starter kit, riding/runeforging, proficiencies, state persistence). Public player-taking methods need their own Hero guard so NPCs, commands, addon handlers, or later scripts cannot bypass the callback gate.
- `ClasslessCommands`, `ClasslessNpc`, and `ClasslessAddon` are separate entry points. Gate the selected player before parsing a mutating operation or calling manager methods; prevent conventional characters from opening or using the classless protocol.
- `ClasslessLoot`, `ClasslessForgedScripts`, `ClasslessCoAScripts`, and `src/coa/*` include world-drop, spell, pet, and resource effects. Registration may be global, but any player caster/owner/recipient side effect must be conditional on Hero participation. Non-player environmental behavior may remain only when it cannot confer or alter classless state for conventional characters.
- `OnPlayerIsClass` and `OnPlayerHasActivePowerType` must return the core's normal answer for every non-Hero. For Hero, answer only the contexts and resource pools needed by owned abilities, retaining the existing runes and CoA ownership safeguards.
- SQL/data are not harmless defaults. Upstream explicitly modifies core item class masks, class quests, character creation/actions, NPCs/vendors, DBC override tables, and adds module persistence. The item-mask and quest changes would affect all classes. Recreate only Hero-scoped behavior using Aetheria's class-10 rows and explicit narrow data; do not apply upstream global rewrites or item-unlock SQL wholesale.
- The upstream client patch removes the normal class picker and assumes every character is Hero. Aetheria must retain its class picker and expose Hero as one extra option, with faction-restricted starting zones and matching server validation. Only paired CoA spell/UI/DBC payloads that do not rewrite normal class presentation can be considered.

## Integration order

1. Retain the 37-file pinned reference copy and its blob-hash provenance. It is a review input, not a complete or installable module.
2. Inventory the remaining upstream C++/SQL/client files and the CoA script/data dependencies; map each player-facing entrypoint to a Hero check and each global SQL/DBC mutation to a scoped alternative.
3. Port/adapt against the active Acore2 APIs while preserving Aetheria's existing dirty source files. Establish one cheap Hero predicate for module boundaries, but keep checks at public manager/service APIs too.
4. Add only the Hero-scoped module and paired data/client payload after the full call/data surface is reviewed. Never enable upstream defaults against the realm.
5. Follow repository build/SQL/install rules only after the user explicitly authorizes a build or release operation.

No active source, database, build, game client, server, or release files were changed by this audit. No build, tests, database access, installation, launch, or publication occurred.


## Loader and CoA script follow-up

The pinned core's `modules/CMakeLists.txt` uses `GetModuleSourceList` and recursively `CollectSourceFiles` for enabled modules; a module-specific `CMakeLists.txt` is not required in this layout. The reference copy includes that core loader and the generated loader templates under `upstream-core/` so source registration can be compared. The generated function `Addmod_classless_wildcardScripts` registers eight groups: Player, NPC, commands, addon, loot, forged, CoA support, and CoA class mechanics. Therefore a partial CMake exclusion is not a reliable Hero-safety boundary; the loader groups and individual callbacks/managers must be scoped or deliberately omitted with complete dependency review.

A concrete CoA gap exists in the pinned `ClasslessCoAScripts.cpp`: the global effect-base-value hook checks the imported spell's CoA scaling mask and resolves a player or pet owner, then scales by that player's level without a Hero-class check. `CoAGlue.cpp`'s `HasCoAKit` reads the module's owned-kit mask without an explicit Hero class check; its CoA learn/forget hooks also grant/remove taught spells based on the global `coaEnable` setting. Those paths need a Hero check before modifying players or pet-owned effects. The generated CoA script SQL and spell data remain coupled to these registrations and the matching client payload.

The attempt to obtain a full sparse clone by direct GitHub network access failed because this environment cannot resolve `github.com`; the temporary empty checkout directory was removed. Connector-fetched files remain pinned/hash-verified. No build/source integration was attempted.

## Default-enable and registration hazard

The pinned `ClasslessMgr::LoadConfig` defaults `ClasslessWildcard.Enable` to `true`; the distributed config also sets it to `1`. So adding/registering this module without an explicit Aetheria-specific gate is unsafe even if the module config file is absent. CoA registration is dispatched from the same module loader; per-CoA booleans do not replace a Hero-class check. A safe port must default off until the Hero-only path and paired data are ready, and its participant predicate must be `enabled && player && player->getClass() == CLASS_HERO` (plus any intentional exemption), applied before state lookup or effect. That is an adaptation requirement, not a change made to upstream files.

## Implemented Hero-only class-access slice (2026-11-05)

To avoid upstream's global item/quest SQL rewrites, active Aetheria core now grants only Hero ID 10 these two classless access behaviors:

- `Player::SatisfyQuestClass` accepts class-restricted quests for Hero. Race, level, reputation, prerequisites and all other quest checks are untouched.
- The database `AllowableClass` mask is bypassed only for Hero in `Player::CanUseItem`, LFG need-roll eligibility, bind-on-pickup vendor purchase/list filtering, and auction-house usable-item filtering. Race masks and skill, spell, level, faction, armor-proficiency, shield, and relic checks remain active. Item-query responses send the all-playable class mask only to a Hero client; other classes receive the original database mask. The remaining class-context and proficiency checks still need the Hero-only module hooks before every class of equipment is usable.

Touched active files: `src/server/game/Entities/Player/PlayerQuest.cpp`, `PlayerStorage.cpp`, `Player.cpp`, `src/server/game/Handlers/ItemHandler.cpp`, and `AuctionHouseHandler.cpp`. These files already contained unrelated Aetheria work; edits were limited to the class-mask predicates and item-query response. Server CPP codestyle and `git diff --check` passed. No build, test, database operation, install or gameplay check was run. This slice is intentionally independent of the unported module and is dormant unless a character has Hero class ID 10. It bypasses only the database class mask; it does not yet provide every armor proficiency or class-context item permission.

## CoA generated spell/client data pipeline

The 37-file pinned reference subset now includes the CoA SQL generator, SQL slicer, client MPQ builder, and pipeline scripts; all 37 file blob IDs match GitHub. The generated payloads (`cw_spells_coa.sql`, `cw_coa_scripts.sql`, `client-patch/coa_manifest.json`, and generated headers in `src/coa`) are not committed as ready-to-use files; they are derived from external CoA client/core inputs.

`gen_coa_import.py` requires the CoA client archives, CoA server source, the target client baseline, the active server `Spell.dbc`, and a current world-spell-ID list. It writes a coverage report and selects only entries whose spell IDs do not collide with the target client, server DBC, or world DB and whose mechanics/scripts are supported. It then emits the server spell/catalog SQL and a client manifest. The SQL imports spell definitions globally (required so the client/server can resolve the spells), but classless ownership/grants are manager state and must be Hero-only. The generator also deletes/recreates its module-owned tables and reserved synthetic talent ranges; range ownership still needs an Aetheria collision check.

`coa_sql_slice.py` replays CoA world updates into a disposable scratch schema, then exports only selected imported spell IDs and only bindings whose script names are present in the ported CoA source. It filters `spell_script_names`, `spell_proc`, `spell_bonus_data`, `spell_custom_attr`, `spell_linked_spell`, and `spell_target_position`; these rows remain spell-global definitions, while player effects and spell acquisition still need Hero checks. It requires Docker, a configured `ac-database` container, and the external CoA core checkout, so it was not run here.

`build_coa_patch.py` reads the generated client manifest and appends the selected CoA spell rows plus required icon, visual, model, sound, charge, and spell-affect data. If `coa_costs.json` exists, it also restores cost columns in baseline client spell rows outside the imported spell set. Its default output is under the target client's `Data`; use a separate staged `--out` path for any future generation. No generated SQL or MPQ was produced in this step because the matching CoA client/core inputs and current live-world spell ID list are not staged, and no client/database target was modified.

## Hero-only implementation boundary for imported CoA data

The global Spell.dbc definitions, client DBC additions, and spell-script bindings are shared metadata; they do not by themselves grant characters the spells. Hero-only enforcement belongs in ClasslessMgr acquisition/progression/state paths and each player-facing CoA script/effect. Before any SQL or package is prepared, compare all generated spell IDs against the active server DBC/world DB and client baseline; verify the exact generator revision and corresponding client manifest hash; keep normal classes' native spell/talent learning unchanged.

### Generator disposition details (2026-11-05)

The generator asserts that the pinned CoA input contains exactly 3,616 advancement entries. It classifies each as `support`, `id-collision`, `blocked`, or `candidate` (then `enabled`), and propagates `needs-prerequisite` when a required entry is not enabled or usable support. It also withholds entries with overlapping rank roots as `shared-root`. Thus “all CoA spells” cannot be claimed from upstream source presence alone: the generated coverage file is the per-entry acceptance record, and its actual counts depend on Aetheria's client/server/world ID baselines and the exact CoA client/core inputs.

The current generator pins two pilot entry IDs (34268 and 34277) and aborts unless both remain collision-free and unblocked. It checks the entire rank/trigger closure against three separate occupied-ID inputs: target client archives, active server Spell.dbc, and world spell IDs. It rejects effects/auras outside the handlers this core supports, unsupported script dependencies, malformed rows, and missing prerequisite chains. No baseline inputs were found staged for a genuine CoA generation run; the matching external CoA client/core and current world ID export are still required. Therefore no coverage counts or import-ready data exist yet.

Global spell definitions and script bindings need to load for Hero spells, but trainer and generic spell-learning paths have their own class filters. `Player::IsSpellFitByClassAndRace` checks `SkillLineAbility.ClassMask` and `SkillRaceClassInfo` and is used by creature trainer list/learn paths. A blanket Hero bypass there would expose conventional class trainer spells and is not approved by the Hero-only CoA progression design. The future integration should grant CoA spells through its Hero-scoped progression manager and leave ordinary trainer/native learning unchanged unless a narrowly defined Hero-only trainer rule is separately designed.

### Hero equipment context seam (2026-11-05)

`Player::IsClass` now treats Hero ID 10 as eligible only for `CLASS_CONTEXT_EQUIP_RELIC`, `CLASS_CONTEXT_EQUIP_SHIELDS`, and `CLASS_CONTEXT_EQUIP_ARMOR_CLASS`, after an explicit script override. This feeds existing relic equip-slot selection, shield/relic checks, armor subtype limits, and the corresponding LFG item checks. Every other context and all conventional classes retain the old result. This deliberately does not waive weapon/armor proficiency skills, item required skills/spells/level, faction, race, or reputation; the Hero progression must teach relevant proficiencies. CPP codestyle and `git diff --check` passed; no build or gameplay test.

### Posted CoA spell data available in EsteriaWoW (2026-11-05)

The user's observation was correct. The public EsteriaWoW tree embeds the CoA core under `reference/azerothcore-wotlk-coa/`; the pinned 9f914baff448e635cfe0469e12e957a2a165e5e3 revision contains machine-readable class spell data: 2,710 rank/level tuples (`AscensionSpellProgressionData.h`), 847 class baseline rows (`AscensionCustomClassData.h`), 21 taught-ability links (`AscensionTaughtAbilityData.h`), 454 scaling rows (`AscensionScalingBaseData.h`), and 1,354 stock-coefficient spell IDs (`AscensionStockCoefficientData.h`). This is enough to supply the matching CoA source-core tree to the import/slicing pipeline when staged from that repository.

It does not include the raw CoA client DBCs. The pinned `reference/azerothcore-wotlk-coa/apps/coa-dbc/README.md` explicitly says game data is not committed or uploaded and that the actual client extraction must be supplied. The import generator reads `CharacterAdvancement`, its class/tab/spec catalogs, `Spell`, `SpellAffect`, and `SpellIcon` from those client archives; it expects 3,616 advancement entries. Thus the posted source lists help reconstruct ranks and scripts, but cannot replace the acquisition catalog or full localized/visual Spell.dbc rows. Current Aetheria client/server/world collision inputs remain a separate requirement. No missing raw DBCs were fabricated.

### Hero spell-and-talent interface scope (2026-11-05)

The requested Hero feature includes both catalogs in one Hero-only Character Advancement interface:

- Classic class spells and talents from Aetheria's existing `SkillLineAbility.dbc` and `Talent.dbc` / `TalentTab.dbc` data. Kalibros' `ClasslessMgr::BuildLibrary` already builds the classic ability pool from SkillLineAbility and the talent pool from Talent data; imported spells are learned only when the user buys them through its Classless manager.
- Supported CoA class spell and talent entries from `CharacterAdvancement.dbc`, `ChrSpecs.dbc`, CoA class/tab catalogs and the matching spell definitions. The upstream generator expects 21 CoA classes, 70 specs and 3,616 advancement entries; its coverage report records anything it must withhold.
- Aetheria-specific race/class abilities that are not represented in those inputs need a supplemental catalog and exact paired DBC/world rows, so they can be presented and purchased by Hero without altering their normal race/class behavior for other characters.

The client UI is the upstream `ClasslessWildcard` Character Advancement addon using the `CWCL` self-whisper addon channel. The upstream client installer cannot be used as-is: it rewrites the global class picker/creation UI and other client-wide class/talent data. Aetheria must carry the addon panel and only its necessary additive spell/talent data; normal class creation and native talent UI stay in place. The addon should bind its panel only for class ID 10, and the server bridge must reject every `CWCL` request from a non-Hero before parsing, looking up state, replying or mutating it. The pinned upstream bridge currently checks only `cfg.enabled` before accepting the channel, so that Hero gate is required.

Racial-spell caveat: upstream `BuildLibrary` defaults `ClasslessWildcard.IncludeRacials=false`, and its SkillLineAbility pass still filters for class-category skill lines. Enabling that setting alone therefore does not prove that every Aetheria or CoA race-specific ability appears. The port needs an explicit inventory of those spell rows, a Hero-facing source/category in the catalog/UI, and a proof that normal characters retain their present race restrictions.

This is a scope/port boundary, not a complete implementation. No Classless addon or manager has been copied into active client/server paths yet; no generated SQL/DBC data, build, install or gameplay check was performed.

### Prepared Hero-only addon bridge gate (2026-11-05)

Prepared `ClasslessAddon.hero-gate.patch` against the pinned `ClasslessAddon.cpp` callback. It first identifies a `CWCL` self-whisper, then consumes it without calling `HandleRequest` when the feature is disabled, the player is null, or `player->getClass() != CLASS_HERO`. This order prevents non-Hero requests from reaching parsing, manager state access, replies, or mutation. Non-CWCL addon traffic remains untouched.

This patch is intentionally not applied to the pinned reference or active server source: the full module and its dependencies are not yet present under `server/modules`, and its other player entrypoints also require Hero gates. Therefore this is a prepared bridge change, not an active safeguard or completed feature. No build or test was run.

### Isolated Classless player-hook adaptation (2026-11-05)

Created `server/work/hero-classless-20261105/aetheria-port-preview/src/ClasslessPlayerScript.cpp` from the pinned PlayerScript file (original SHA-256 `614E9BF425FE7FF24AA172C4C0D8AF048D341F56F47CBBCF481B59B5BC443F8F`). This preview adds a class-ID-10 predicate ahead of player-facing lifecycle, level, native talent, spell-learning, resource, guardian, class-context and update behavior. It removes both upstream chassis-conversion calls so the character remains Aetheria's actual Hero class. The shared resource helper retains the core's displayed-power behavior for non-Hero players.

`git diff --no-index --check` found no whitespace errors for the preview diff, and the repository CPP codestyle check passed. The preview is not integrated or built; commands, NPCs, manager methods, CoA scripts/resources, addon UI, module registration and paired data remain separate gates. `OnPlayerDeleteFromDB` keeps GUID-scoped cleanup of module-owned rows because the delete callback provides no Player class object. See the preview README and the pinned-reference provenance.

### Central CoA callback gates in isolated preview (2026-11-05)

Adapted `ClasslessCoAScripts.cpp` and `CoAGlue.cpp` in the preview only. CoA level scaling checks Hero ownership, including owned pets. Class-kit checks require classless participation; central spell, aura, player-learning/forgetting, attack-power, casting permission, movement speed, and scripted pet-AI hooks are limited to enabled Hero characters and their owned pets where relevant. CoA switches also respect the main module enable.

Whitespace checks against the pinned originals passed. No compile/test was run. This does not cover every individual script in the 377-file `src/coa` tree or prove that global spell metadata/bindings have no effects outside Hero; full callback-by-callback audit remains a blocker before registration. Preview README and hub handoff carry the current coverage and prerequisites.

### Confirmed summon-avoidance scope fix in preview (2026-11-05)

Pinned-source review confirmed that `AscensionSummonAvoidance.cpp` applied CoA avoidance auras to matching guardian and non-guardian player summons without checking the player class. The preview copy now checks `IsParticipant(player)` in the guardian PlayerScript and resolves the owner of ordinary summons before applying the CoA aura. This is an isolated preview change only; the module remains incomplete and unregistered.

The initial 46-file no-marker list was refined: 27 files call an `Owner()` helper, and the seven helper definitions checked all require `HasCoAKit`. Since the preview centralizes Hero eligibility in `HasCoAKit`, those paths are indirectly gated. Remaining marker-absent callbacks still need manual review, including script-specific spell IDs and shared Classic spell interactions. See `COA-HERO-SCOPE-REVIEW-QUEUE.md`.

### Hero-only Classless client addon preview (2026-11-05 continuation)

Staged the pinned 3.3.5 `ClasslessWildcard.lua`, TOC, `Bindings.xml`, and `esteria_style.lua` under `work/hero-classless-20261105/client-addon-preview/`. The Lua preview checks actual player class ID 10 before CWCL sending/receiving, panel and resource-bar commands, stat/tooltip overlays, spellbook expansion, and the stock talent-window redirect. It restores the stock spellbook tab layout when leaving Hero, including deferring protected overlay cleanup until combat ends. It hides the minimap button and Hero panels for other classes. Removed the upstream global rewrite of localized class-name tables and disabled its Help micro-button takeover, preserving Aetheria's stock class labels/help button.

The addon is not installed or packaged. Its referenced texture assets are not yet staged; the Lua hook surface needs more review against the running Aetheria addon environment. No Lua test/parser, client build, install, or gameplay check was run. See the preview README.

### CoA baseline spell setting required by owner scope (2026-11-05)

The pinned module config defaults `ClasslessWildcard.CoA.ClassSpells = 0`. Kalibros documents this as the CoA class baseline abilities (847 rows in the posted `AscensionCustomClassData.h`), granted with a CoA class kit but not sold in the browser. Because the owner explicitly wants the CoA class spells on Hero, the eventual Aetheria Hero config must enable `CoA.ClassSpells` and retain `CoA.AutomaticEntries = 1` for signatures, milestones, and prerequisite entries. Leaving the upstream default would silently omit the requested class-baseline spells. Do not apply a config while the module/data port is incomplete.
