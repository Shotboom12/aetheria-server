# Hero and CoA Classless integration analysis

Date: 2026-11-05

## Owner's target

Add one selectable `Hero` class using Kalibros' classless/Conquest of Azeroth (CoA) ability system, while retaining every existing Wrath class and its normal spells, talents, trainers, gear rules, and progression. Do not enable classless behavior for the existing classes.

## Local evidence

- The server defines class IDs 1–9 and 11, with ID 10 commented as unknown; `MAX_CLASSES` is 12 (array slots 0–11). ID 10 therefore fits the current class-array bounds and is a stronger Hero candidate than ID 12. ID 12 remains out of bounds. `CLASSMASK_ALL_PLAYABLE` currently excludes ID 10, so class legality/item/quest/talent policies would still need a deliberate Hero-aware update.
- `ObjectMgr` validates `playercreateinfo` classes against both the class ceiling and `sChrClassesStore`. Player creation, initial skills/spells, stats, talents, expertise, dodge, equipment policy, and class/race start data depend on class-specific DBC/database rows.
- No `mod-classless-wildcard`, `CLASS_HERO`, or server classless implementation was found in the active server source/modules. The only local Hero-related hit is a comment in staged client creator Lua and does not implement class support.
- The authoritative live server DBCs are at `C:\Acore2\Server\Data\dbc`; the user identified Acore2 as the realm server. `ChrClasses.dbc` is valid WDBC with 10 rows, IDs `[1,2,3,4,5,6,7,8,9,11]`; ID 10 is absent. Its SHA-256 is `5b2bfc7dab577f48cafe86db1d6148515569507b273f0c95b5ae86713ff5b3e2`, identical to `Data\dbc-clean-backup\ChrClasses.dbc`. `TalentTab.dbc` has no class-mask bit 9 (the bit for class ID 10); `SkillLineAbility.dbc` likewise has no class-mask bit 9. Live hashes: Talent `23ae9642add151bf504c4d0bab247e2e622f9cf29a473d091cb9f11127d99d68`, TalentTab `b9249642e06b2baa17793e50e6719f33b1f89729f6c31ea623d4a39e84660e31`, SkillLineAbility `2d94c97a4c9efe25812beee8d17507ee34896532240b26f1bc9fbac233916316`, and gtOCTClassCombatRatingScalar `7a4f0d2bdf163ab83f7e9260d6f4c577477053847e5df3fc14df9e4248b680fa`. The active test client DBC was read from its MPQ archives without modifying them. `Data\enUS\patch-enus-3.mpq` contains `DBFilesClient\ChrClasses.dbc` with the same `5b2bfc7dab577f48cafe86db1d6148515569507b273f0c95b5ae86713ff5b3e2` SHA-256 as the live server table. Across all three client archive overrides containing ChrClasses, none includes ID 10. All three TalentTab and all seven SkillLineAbility overrides scanned also have zero class-bit-9 rows. Client/server ChrClasses are therefore paired at this baseline, and both omit Hero ID 10. The isolated-test DBC copy remains unsuitable as a release baseline.

## Upstream commit scope

Kalibros' `9f914baff448e635cfe0469e12e957a2a165e5e3` is titled “Port Conquest of Azeroth class kits into classless.” Its commit message describes core additions for spell effects 165–198, aura types, script hooks, charges, damage/caster seams and two client opcodes; a `mod-classless-wildcard` module carrying CoA class kits, resources, talent replacement, automatic entries, rifts, and configurable CoA class spell baselines; plus spell catalog SQL and client data-generation/package tooling. The commit message says its CoA port does not alter existing Esteria spells, auras, creatures or items. This commit is a dependency map, not a safe cherry-pick into Aetheria's distinct and heavily modified source.

Primary source: https://github.com/STRHercules/EsteriaWoW/commit/9f914baff448e635cfe0469e12e957a2a165e5e3

## Safe integration sequence

1. **Freeze authoritative class data inputs.** Identify exact client/server DBC baselines, custom spell ID allocations, source commit identities and pending migrations. Do not infer a Hero class row from an isolated-test DBC copy.
2. **Define Hero class data.** Prefer evaluating vacant ID 10 first: it is inside existing server arrays and is absent from the matched live client/server `ChrClasses.dbc` baseline. Confirm the client archive patch path, class power, armor/weapons, starting spells/skills/items, stats at every level, expertise/dodge/combat scalars, and create/login semantics. Add the missing matched class row and required world DB rows as a paired data change. Use ID 12 only if there is a documented reason ID 10 cannot satisfy the design, and raise bounds only alongside complete array and row coverage.
3. **Gate classless behavior.** Establish one server predicate based on the new Hero class ID. Existing classes must retain current class spells/talent grants and class restrictions. Hero creation/login must not be accepted unless the classless module/data baseline is enabled and complete.
4. **Port CoA in dependency order.** Port shared core spell/aura/hooks and required client opcode handling first; then module service and a small spell-family slice; then generated spell catalog and full abilities. Keep each feature/data change paired and provenance-tracked. Preserve each upstream author's credit in commits.
5. **Creator and acceptance.** Add a Hero-only class card/selection rule and verify all supported races. Keep the existing faction-restricted starting-zone filter. Require server authority for class legality and test both Hero and all normal classes.

## Stop conditions

- Do not change `MAX_CLASSES` or admit class ID 12 before authoritative class/level/creation data is staged.
- Do not import CoA catalog SQL or client patches independently of the core/module version they target.
- Do not mark the existing classes as classless to avoid building the Hero seam.
- No build, tests, database operation, installation, or publication was performed for this analysis.


## Continuation input audit (2026-11-05)

A follow-up filename scan of the approved ClientBuild and ServerBuild trees found compiled `.obj` products for generated DB2 record types, but no authoritative class/gameplay DBC set or Classless/CoA source/data. Object files are not usable source data. No class ID or class-table bound was changed. The exact blocker remains the paired authoritative `ChrClasses`, race/class eligibility, level stat/class progression and CoA spell catalog/data baseline, with provenance/version matching the intended client/server release. Once provided, first compare hashes/build IDs and the current custom spell ID allocation before choosing the Hero ID or applying any catalog data.


## Acore2 live DBC read-only verification (2026-11-05)

The Acore2 live server DBC directory and its clean backup were inspected read-only after the owner clarified that Acore2 is the realm server. The class table confirms ID 10 is vacant but within the existing `MAX_CLASSES=12` array; no need to raise that ceiling if ID 10 is chosen. The live and clean-backup `ChrClasses.dbc` hashes match. No Hero row exists. Class-mask scans found zero TalentTab and SkillLineAbility rows using class bit 9. This narrows the candidate but does not establish the Hero row, race eligibility, level progression, or classless spell behavior. Do not implement ID 10 until the paired client record and world DB progression/create rows are reviewed.

Verified live DBC SHA-256 values:
- `ChrClasses.dbc`: `5b2bfc7dab577f48cafe86db1d6148515569507b273f0c95b5ae86713ff5b3e2`
- `ChrRaces.dbc`: `9c98a9a83c1f937a835c928d5c41820ce01cc5bb38bbf3f9ab4f57486883b6a4`
- `Talent.dbc`: `23ae9642add151bf504c4d0bab247e2e622f9cf29a473d091cb9f11127d99d68`
- `TalentTab.dbc`: `b9249642e06b2baa17793e50e6719f33b1f89729f6c31ea623d4a39e84660e31`
- `SkillLineAbility.dbc`: `2d94c97a4c9efe25812beee8d17507ee34896532240b26f1bc9fbac233916316`
- `gtOCTClassCombatRatingScalar.dbc`: `7a4f0d2bdf163ab83f7e9260d6f4c577477053847e5df3fc14df9e4248b680fa`


### Client archive match

The current test client at `E:\Aetheria-Staging\clean-client-20261023\Data` was read-only scanned with StormLib. `enUS\patch-enus-3.mpq`'s `DBFilesClient\ChrClasses.dbc` is byte-for-byte hash-identical to Acore2's live server `ChrClasses.dbc`. The other two client archive overrides also have ten class rows and omit ID 10. Every scanned client TalentTab/SkillLineAbility version has zero entries with bit 9 set. This closes the DBC pairing question for the current test client; it does not supply the missing Hero class definition or world DB progression/create data.


### World-data source baseline

Read-only parsing of the checked-in SQL base seeds found no class 10 rows in `player_class_stats` (746 rows total across classes 1–9 and 11) or `playercreateinfo` (62 rows across classes 1–9 and 11). No live world database query was performed. Before Hero creation, inspect the current Acore2 world DB read-only with explicit scoped access, then prepare an additive pending migration for class 10 stats at every configured player level and the supported race/class starting locations, plus the classless initialization path (spells, skills, actions/items as designed). Do not assume the checked-in base seed exactly matches the live world DB.


#### Acore2 world backup snapshot (read-only)

The available `acore_world-pre-open-azeroth.sql` snapshot in `C:\Acore2\Server\backups\open-azeroth-20261031-pre` is 338,109,708 bytes (SHA-256 `e8e32fa02285273f147f04ae73e45ad76445c5db908ff6db9c226493595ec3a6`). Scoped streaming inspection found no class 10 rows in `player_class_stats` (746 rows; classes 1–9 and 11), `playercreateinfo` (516), `playercreateinfo_action` (2,605), or `playercreateinfo_item` (one DK-specific row). `playercreateinfo_skills` has 118 mask rows and `playercreateinfo_spell_custom` has 5,273; neither has a class-mask bit-9 row. This snapshot predates the Open Azeroth operation and is not treated as proof of current live DB contents. `mysqld`, authserver and worldserver were not running when checked; the service manager query was unavailable under current permissions. I did not start services or query live DB files.


## Upstream module behavior review (2026-11-05)

The upstream `mod-classless-wildcard` README explicitly describes a total class-system replacement: every character is Hero, on one shared chassis, with a required client patch. Its install also writes core world tables and DBC override tables. The PlayerScript applies classless behavior from the module-wide `cfg.enabled` switch; inspected hooks include create/login conversion to the chassis, spell/talent handling, universal resources, class-context overrides, stats, pets, and progression. There is no Hero-only selector in this path. Importing the module and enabling it would convert existing Aetheria classes, conflicting with the requirement to keep their normal play intact.

Primary upstream references at the pinned CoA commit:
- `README.md`: https://github.com/STRHercules/EsteriaWoW/blob/9f914baff448e635cfe0469e12e957a2a165e5e3/modules/mod-classless-wildcard/README.md
- `ClasslessPlayerScript.cpp`: https://github.com/STRHercules/EsteriaWoW/blob/9f914baff448e635cfe0469e12e957a2a165e5e3/modules/mod-classless-wildcard/src/ClasslessPlayerScript.cpp
- Integration commit: https://github.com/STRHercules/EsteriaWoW/commit/9f914baff448e635cfe0469e12e957a2a165e5e3

Before any port, the core needs one centralized `IsHero(Player const*)` gate and each hook must be classified as Hero-only, shared protocol/data prerequisite, or intentionally unchanged stock behavior. Creation/login conversion and spell/talent/resource/stat/gear policies must be explicitly Hero-only. Global SQL and DBC overrides in upstream install scripts cannot be applied wholesale; they need additive, class-10-scoped equivalents and a paired client data patch whose version matches the server catalog. The module README also states that the client patch carries spell data consumed by the server, so a server-only subset would not be a safe usable release.

This review covers the pinned README and the first 600 lines of `ClasslessPlayerScript.cpp`; it is not a complete audit of every module hook, query, SQL statement, or client addon behavior. No source implementation was changed in this continuation.

## Client creator integration risk (2026-11-05 continuation)

The class-10 DBC addition exposes another required creator change: the current Aetheria GlueXML sets `MAX_CLASSES_PER_RACE = 10`, so any race already offering the ten stock classes will exceed the declared capacity after Hero is added. `CharacterCreateEnumerateClasses` rejects that count before building the picker. Simply raising the constant is unsafe: it directly dereferences `CharacterCreateClassButtonN` textures and the staged creator skin only repositions existing button frames; the stock GlueXML frame declarations have not yet been inspected for an eleventh button. The staged button art path is derived from the DBC filename (`AetheriaCreatorClass-v1-HERO`) and no Hero art asset currently exists. The class details pane also has no `HERO` entry in `CLASS_ICON_TCOORDS` or `CLASS_INFO_HERO*` text.

Before client Hero data can be handed out, inspect the exact active client GlueXML templates and implement a real eleventh button (or a deliberate compact layout) plus Hero artwork/details. The current staged MPQ contains only DBC overrides and does not solve the creator presentation. No creator files changed in this continuation.

## Active client GlueXML verification (2026-11-05 continuation)

Read-only extraction from the active test client's mounted archive precedence found `Interface\\GlueXML\\CharacterCreate.xml` in `Data\\Patch-ZP.mpq` (SHA-256 `921224fd248fa434fa5cc1810e3bce7def8a4020516f1a85f26f8a7ae53dd28e`, 93,146 bytes) and `CharacterCreate.lua` in `Data\\Patch-ZZ.mpq` (SHA-256 `2055676cc46853e0ca98bbb9d0b28f5c8ee7c48702304c9a89ad2c22ca45adae`, 220,951 bytes). The XML already defines class buttons 1 through 11; button 11 is hidden initially. This corrects the earlier note that the XML frame had not been inspected / might be missing. It remains true that the staged Lua sets `MAX_CLASSES_PER_RACE = 10`, rejects more than ten, the current creator layout needs an 11-item arrangement, and the `HERO` class-card asset / details do not exist. Exact extracted files and receipt: `work/hero-classless-20261105/client-gluexml-baseline/`.

No active client files were modified. The generated DBC MPQ currently has only DBC entries. PatchFiles precedence was confirmed in client source: archives are opened so the later lexically ordered patch has higher priority, while `custom.MPQ` is specially prioritized; the new long-z `Patch-...` name sorts after existing regular root/locale patches but still below an existing `custom.MPQ`. Future installation must retain that precedence check.

## Hero-only port gate refinement (2026-11-05 continuation)

The pinned module's `ClasslessMgr::IsExempt(Player*)` is not a class check; it returns persisted state `GetState(player).exempt` and is used for bot/system-account exceptions. Preserve that meaning. A safe Aetheria adaptation should introduce a separate participation predicate (conceptually `IsHeroParticipant(player) = config-enabled && player && player->GetClass() == CLASS_HERO && !IsExempt(player)`) and classify every side effect through it.

The upstream `ClasslessPlayerScript` registers create, first-login, login/logout/delete, level, talent, learn-spell, money, power, class-context, guardian, and update hooks. Most gameplay hooks combine the module-wide config with the persisted exemption; create/first-login and money-change paths have direct global-config branches and need explicit review. The other module scripts also need scope checks: NPC, commands, addon messages, loot/world drops, and CoA aura/spell hooks. CoA data-loading changes that run without a Player must be restricted to identified CoA spell IDs/families and must leave existing stock SpellInfo entries unchanged. `cfg.enabled` defaults true upstream, so retaining the module default without complete Hero-participation gating would alter normal classes.

This turns the port requirement into a reviewable invariant: every runtime player behavior must either pass the Hero participation predicate or be explicitly justified as a shared, side-effect-free protocol prerequisite. Keep account exemptions separate. The active Acore2 modules tree does not contain this upstream module, and the pinned integration also includes core spell/aura/opcode changes; no partial module copy was added.

### Acore2 script-hook compatibility audit (2026-11-05 continuation)

Targeted inspection of the active Acore2 `server/src` confirms the local core already exposes the principal `PlayerScript` hooks used by the pinned upstream classless script, so these hooks do not by themselves require core API patches:

- `PLAYERHOOK_ON_MONEY_CHANGED` / `OnPlayerMoneyChanged(Player*, int32&)`
- `PLAYERHOOK_ON_AFTER_UPDATE_MAX_POWER` / `OnPlayerAfterUpdateMaxPower(Player*, Powers&, float&)`
- `PLAYERHOOK_ON_BEFORE_GUARDIAN_INIT_STATS_FOR_LEVEL` / matching guardian setup callback
- `PLAYERHOOK_ON_PLAYER_IS_CLASS` / `OnPlayerIsClass(Player const*, Classes, ClassContext)`
- `PLAYERHOOK_ON_PLAYER_HAS_ACTIVE_POWER_TYPE` / matching active power callback
- Existing `ClassContext` values include reactive abilities, relics, shields, class abilities, pets/charm, stats, quests, taxi and class trainer.

The implementations are wired through `ScriptMgr` and exercised by `Player::IsClass`, `Player::HasActivePowerType`, money changes, max-power updates and guardian initialization. This supports a module-first Hero-only port for these behaviors. It does **not** establish that every upstream dependency is present: spell/aura/core patches, custom client opcodes, SQL schemas/catalogs, and any other hook/API referenced by the complete module still need a complete dependency diff. Before importing the module, enumerate its registered hooks and direct core symbols against Acore2, then add Hero-participant guards while preserving `IsExempt` for bot/system accounts.

### Extended upstream-to-Acore2 hook audit (2026-11-05 continuation)

Pinned source registration review covered `ClasslessPlayerScript.cpp`, `ClasslessAddon.cpp`, `ClasslessLoot.cpp`, `ClasslessForgedScripts.cpp`, and `ClasslessCoAScripts.cpp`, plus the module loader and the smaller CoA script file. The active Acore2 source already exposes the additional referenced hooks examined here: private chat use; direct and pet creature kills; talent learning and spell learning; unit spell-effect base-value modification; pet default spell learning and pet stat initialization. ScriptMgr dispatch points were found for the player hooks, and PetScript/UnitScript declarations exist locally. This makes a safe module port more plausible than the initial API audit alone suggested; it is still only a targeted compatibility pass, not proof that every manager symbol compiles.

Runtime scope requirements identified from the pinned source:

- Player lifecycle/progression hooks must return immediately for non-Hero characters, except shared database/schema bootstrap that has no player side effects.
- Classless chat commands must reject non-Hero players before any `GetState`, spell, talent, money, or stat operation; the upstream `CheckEnabled` only checks a global config switch.
- Advancement NPC gossip and vendor actions must be Hero-only before reading state or mutating inventory/builds.
- Addon chat protocol parsing must ignore or explicitly reject non-Hero clients. Spell-correction output must not be broadcast as a classless state update to normal classes.
- World-drop handlers must require a Hero killer/owner so classless gear does not enter ordinary-class gameplay.
- Forged spell scripts are identified by custom spell IDs and may be globally registered, but their player/unit callbacks still need ownership/class or Hero checks before modifying other players, pets, or units. Do not assume “custom spell ID” alone scopes effects to Hero casters.
- CoA scaling has no direct player parameter on the UnitScript hook. Its effect must remain restricted to generated CoA scaling IDs/effect masks, and apply the scaling only when the caster or owner is a participating Hero; stock spell data/effects must remain unchanged.

All named hook declarations checked above are present in local Acore2. The unverified portion is now the rest of the integration surface: manager and addon APIs, exact DB prepared statements/schema, spell/aura APIs and custom opcode/client bridge versions, plus every individual command/NPC/unit callback branch. Next safe implementation step is to stage the pinned module in isolation, adapt its namespace/style/dependencies, and add a reviewed participant gate at every entry point before enabling module registration. Do not activate upstream module defaults globally.

### CoA source and data boundary (2026-11-05 continuation)

The pinned repository includes a nested `reference/azerothcore-wotlk-coa` source tree with a substantial CoA server implementation (`src/server/coa`, hundreds of class/mechanic files) that is not present in Aetheria's active `src/server/scripts` tree. A local scan found no `aura_ascension_*` or `spell_ascension_*` script registrations. The Wildcard module's generated `cw_coa_scripts.sql` binds many such names, so bringing only that SQL would create bindings without implementations.

Pinned package inventory at `9f914baff448e635cfe0469e12e957a2a165e5e3`:

- CoA spell SQL: 12,317,356 bytes (`cw_spells_coa.sql`), generated and dependent on the matching CoA data version.
- CoA script-binding SQL: 942,534 bytes (`cw_coa_scripts.sql`).
- Elemental spell SQL: 1,278,885 bytes; forged spell SQL: 280,749 bytes.
- CoA client manifest: 405,089 bytes; elemental manifest: 1,908,703 bytes; forged manifest: 676,076 bytes.
- Additional classless tables include player character-state/ability/talent persistence, world NPC/vendor/item/spell overrides, and a broad skill/class eligibility override. These cannot be transplanted as-is: the broad world rows require Aetheria-specific scoping and existing table ownership checks.

Therefore the feature separates into (A) Hero classless progression/manager and UI protocol, (B) CoA spell data + exact paired script source + client spell patch, and (C) Aetheria-specific class-10/create/eligibility and SQL. The current Hero DBC/UI staging only covers part of (C); it does not provide a playable Hero. Safe next implementation work must choose a CoA source baseline and map only the requested spell implementation/data surface into the active Acore2 fork before generating paired payloads. Do not apply generated SQL or expose the current client MPQ as a release candidate.

### Nested CoA source comparison against active Acore2 (2026-11-05 continuation)

Compared GitHub blob SHAs in the pinned nested `reference/azerothcore-wotlk-coa` snapshot with `git hash-object` for the actual active working files (not just HEAD). The reference has 567 files directly under `src/server/coa` and a dedicated `src/server/coa/CMakeLists.txt` that builds a separate `coa` static library, linked from the server build. Aetheria has no corresponding `server/src/server/coa` directory or CoA registrations under `src/server/scripts`.

Targeted overlapping core-directory byte-match counts (reference files / identical / different / absent locally):

| Area | Result |
| --- | --- |
| `src/server/game/Spells` | 13 / 0 / 11 / 2 |
| `src/server/game/Entities/Player` | 23 / 9 / 12 / 2 |
| `src/server/game/Scripting` | 9 / 5 / 4 / 0 |
| `src/server/game/Entities/Unit` | 11 / 2 / 6 / 3 |
| `src/server/game/Entities/Pet` | 3 / 0 / 3 / 0 |

These are byte-level comparison results, not semantic diffs. The active working tree already has many modifications in these overlapping files, including several class/packet/spell systems, so replacing them with nested-reference versions would erase Aetheria work. The nested CoA target is a broad, specialized Acore fork with a standalone library; it is not a drop-in module against the active Oct 9 Acore baseline. The next port boundary is to identify and transplant the minimal CoA-specific patches/API seams into the existing modified core, then add selected `coa` source files and generated data in dependency order while preserving every dirty Aetheria change.

### Correction: CoA implementation is inside the pinned module (2026-11-05)

The actual integration target is `modules/mod-classless-wildcard/src/coa`, not the nested `reference/azerothcore-wotlk-coa/src/server/coa` snapshot. The latter is a broad reference/test checkout and its 567-file count does not mean all 567 files must be transplanted into Aetheria. The pinned module's own `src/coa` contains 377 files (289 `.cpp`, 88 `.h`, 2,804,714 bytes), including the CoA class spell mechanics it registers. Aetheria currently lacks the module entirely. The module is therefore the correct port unit; its CoA data and generated client manifests still must be version-paired.

The pinned top-level core at `9f914baff448e635cfe0469e12e957a2a165e5e3` already has several CoA compatibility additions in `SpellDefines.h` and `SpellInfo.h` (Aura stack modifier, melee attack type override, CoA absorb/scaling flags and max-aura-stack calculation), while its own `SpellMgr.h` still uses the 200000 linked-spell stride. The active Aetheria working tree has its own extra spell APIs/fields, so merge additive CoA definitions into the current files and preserve the existing Aetheria CastSpellTargetArg/charge code. A local additive stride fix is now staged in `src/server/game/Spells/SpellMgr.h`: `SPELL_LINKED_MAX_SPELLS` is 100,000,000 and both offsets reference the named constant. This keeps the 32-bit encoded key within range for linked spell types 0–2 and avoids overlap with multi-million spell IDs. Full CPP codestyle passed after this edit. No compile/test was run.

The previous source-boundary notes about the 567-file nested reference are retained as historical investigation but superseded for port scope by this correction.

### First additive CoA spell API slice (2026-11-05)

Merged the server-only `SPELLMOD_MAX_AURA_STACKS` modifier (slot 31 within `MAX_SPELLMOD=32`), explicit client-side spell-mod limits, and `SPELLVALUE_MELEE_ATTACK_TYPE` into the existing Aetheria `SpellDefines.h` without touching its custom cast-target structs. Added `SpellInfo::CalcMaxAuraStacks(Unit*)`, which preserves nonstacking auras at zero, applies the caster's spell modifier only to an already stackable aura, and clamps to the client/server uint8 cap. The method uses local `GetSpellModOwner` / `ApplySpellMod` APIs. The global C++ style checker passed after both this slice and the linked-spell stride change. No compile or gameplay test was run.

Source files now changed in this CoA port slice: `src/server/game/Spells/SpellMgr.h`, `SpellDefines.h`, `SpellInfo.h`, and `SpellInfo.cpp`. This is additive groundwork only; CoA spell execution paths, remaining SpellInfo fields, module source, client patch and generated SQL remain unported.

### SpellInfo compatibility surface identified (2026-11-05)

The latest pinned Aetheria commit (`bdad58028fb6847b9d9a4fd8cf990bd662c9fc62`) confirms the CoA module's remaining core surface includes runtime SpellInfo flags for ranged-AP source, inherited resolved damage, max-mana percentage cost, absorb/resistance behavior and spell-level penalty; charge recovery metadata; 64-bit stance/form masks; and several `WorldObject*` to `Unit*` signature changes. These are not yet merged because the active Aetheria SpellInfo layout and call sites differ and already carry independent custom work. The newly implemented max-stack API is one compatible isolated part of that surface. Next compare and port each field with its actual consumer and lifecycle, especially initialization/copying of dynamically corrected SpellInfo and client/server charge-data handling; do not apply a broad header replacement.

### Max-mana cost behavior slice (2026-11-05)

Added default-false `SpellInfo::UsesMaxManaForCost` beside the mana cost metadata. `SpellInfo::CalcPowerCost` now uses `Unit::GetMaxPower(POWER_MANA)` for percentage mana costs only when the flag is set; otherwise it retains the existing `GetCreateMana()` calculation. This matches the pinned CoA contract and leaves current spells unchanged until their CoA correction/contract code opts in. It is a local Acore implementation using the existing `WorldObject`→`Unit` conversion and preserves downstream cost modifiers. C++ codestyle and whitespace checks passed after the change; no build or gameplay test.

### Hero multi-resource design constraint (owner clarification, 2026-11-05)

The Hero chassis must support every relevant CoA/classless energy source, with each spell retaining its authored source and cost (mana, rage, energy, focus, runic power, and class-specific CoA resources). Do not collapse all costs into the currently displayed resource bar or rewrite every spell to one generic type.

Pinned module source splits this into distinct mechanisms:

- Universal native pools: the chassis supplies mana; classless code adds configurable rage/energy maxima and answers `OnPlayerHasActivePowerType` for mana/rage/energy, with runic power only when the character owns rune-enabled abilities.
- CoA kit-specific native pools: separate player hooks enable focus for the Ranger kit, runic power for the runic kit, and Starcaller mana/energy behavior only for characters with that kit. Those must remain ownership-gated and compose with (not replace) the universal classless hook.
- CoA custom resources such as Heat, Static and souls are aura/resource-service data, not additional core `Powers` enum slots. They require the matching resource scripts and spell/catalog rows.
- Each spell's `SpellInfo::PowerType`, base cost, percentage cost and modifiers remain authoritative. `UsesMaxManaForCost` is a per-spell opt-in and does not change the other resource calculations.

Aetheria has seven native power slots (`MAX_POWERS=7`) including mana/rage/focus/energy/happiness/runes/runic power. Existing PlayerScript hooks cover active-power acceptance and max-power recalculation. The custom resource service and every class-kit hook are still absent until the module is ported. This clarification is incorporated into the Hero acceptance/design requirements.

## Spell charge integration dependency (2026-11-05 correction)

Pinned upstream `9f914baff448e635cfe0469e12e957a2a165e5e3` charge behavior spans more than `SpellInfo` metadata and `SpellChargeState`: PlayerSettings-backed persistence keyed by recovery key, Player charge APIs, charge-aware cooldown checks/setup, consume/restore paths, spell-learn/send-state hooks, custom server opcodes and packet serialization, and client decoding/UI. Local `character_spell_cooldown` only represents ordinary cooldown rows; upstream uses the generic character-settings map for charge pools. Local scaffold now includes the upstream value type and defaulted metadata fields, but has no behavior until the paired seams above land. Preserve local dirty Player/protocol files when integrating.

Additional local dependency: Aetheria's `EnablePlayerSettings` defaults to 0, and the current generic settings load/save path is gated by that switch. Enabling it globally may activate unrelated player-setting behavior. Before relying on upstream's `core.spell_charge.*` persistence, either add a narrowly scoped always-persist path for those keys or use a dedicated charge store; do not silently flip the global setting. This is now an explicit integration decision in the charge dependency audit.

## Hero charge persistence slice (2026-11-05)

`PlayerSettings.cpp` now reads/writes the reserved `core.spell_charge.*` character-setting namespace even with `EnablePlayerSettings=0`, while unrelated settings remain disabled. The existing load query and transaction save are already wired. This is storage groundwork only; no charge code writes the values yet. Upcoming APIs must gate by Hero class ID, and charge metadata, cooldown/cast logic, custom protocol, and client handling remain required.

## Max aura-stack modifier call site (2026-11-05)

`Aura::ModStackAmount` now applies `SpellInfo::CalcMaxAuraStacks(GetCaster())` when increasing stacks and in its unique-aura refresh decision. Default spell data preserves the existing cap, nonstacking auras remain at one on increment, and explicit `SetStackAmount` and decrement behavior were not changed. This is an uncompiled source slice; style/whitespace passed, gameplay remains unverified.

## Off-hand spell-value consumer (2026-11-05)

`SPELLVALUE_MELEE_ATTACK_TYPE` is wired through `Spell::SetSpellValue` to a guarded setter. The override is accepted only before prepare, on melee-damage spells, and only for base/off-hand attack types. This sets the core attack context prior to hit/proc calculation. It is dormant until an authorized script supplies the value; no CoA scripts are imported. Style/whitespace checks passed, no build.

## Charge client source port note (2026-11-05)

Active x64 client now contains the spell-charge-only port of wowdecomp commit `4f9141071a865fe7837e917d65682c57eae89e21` in `client/WoW/Source/Magic/MagicClient/SpellCharges.cpp` plus Spell_C, Client idle/startup, and action bar integrations. It handles server opcodes 0x531–0x534 and requires paired `SpellCharges.dbc` / `SpellChargesCategory.dbc` plus generated CoA spell data. That commit's aura amount and visual override features were intentionally not included in this slice. The charge tables were not found locally; no build/runtime check. Client-side source being present does not mean Hero charge casting or protocol is ready for install.

## Server charge opcode reservation (2026-11-05)

Reserved `0x531`–`0x534` in the active server opcode enum and registered all four as outbound-only to match the paired client source. The opcode table bound is now `0x535`. This is protocol bookkeeping only: no server packet serializer, charge pool logic, cast consumption, or CoA metadata has landed. Do not activate charges until the paired charge catalog and Hero-only Player implementation are reviewed together.

## Hero-only charge runtime source slice (2026-11-05)

Fetched Kalibros' pinned generated charge catalog (162 spell records) into `Spells/CoASpellChargesData.h` and apply its charge maximum, recovery interval, recovery root, and source category during `SpellMgr` custom SpellInfo initialization. The client DBC generator reads that same file. Its `SpellCharges.dbc` maps spell IDs to the recovery root, and `SpellChargesCategory.dbc` maps those 55 roots to maximum/recovery values, matching the packet key in the pinned client pipeline.

Added Hero-gated Player APIs for settings-backed state validation/persistence, sequential recharge, cast consumption, empty-pool cooldown checks/delay, client state serialization, category restore, and restore-all after cooldown reset. Initial login spell state and learning send charge state. Every runtime method gates on `CLASS_HERO`, preserving classic classes' cooldown behavior. The global `EnablePlayerSettings` option remains unchanged; the previously staged reserved-prefix path persists these keys when it is false.

Added the paired CoA custom effect 187 (`SPELL_EFFECT_ASCENSION_RESTORE_SPELL_CHARGES`) through the server's effect enum, static target data, dispatch table and handler. The handler resolves a player target and uses the Hero-gated source-category restore API; conventional classes therefore cannot have CoA charges restored by it. Slots 165–186 remain explicit no-op dispatch/static-data entries. Still required: any other `Set/Remove/Clear` script surfaces called by the full module, full module/spell acquisition gates, and full server/client builds and gameplay validation. This is source-only for executables; a paired Hero DBC/UI MPQ has since been staged, not installed/published. `codestyle-cpp.py` and server `git diff --check` passed.

## Owner invariant and paired staged package (2026-11-05)

The user's explicit scope is that **the classless/CoA module applies only to Hero class ID 10**. Each module-facing player lifecycle/resource callback, spell acquisition or eligibility path, command, NPC and addon protocol handler, world-drop, pet, and effect must reject/ignore non-Hero players before any state change. A global module enable switch is not sufficient. Classic classes and their existing behavior remain supported.

Generated `SpellCharges.dbc` (162 links to shared roots) and `SpellChargesCategory.dbc` (55 recovery-root rows) from the pinned catalog, preserving the already prepared Hero DBC directory. Packaged those tables with the existing Hero DBC/UI payload into a staged 15-entry MPQ at `work/hero-classless-20261105/client-hero-charge-ui-mpq-v1/`; archive SHA-256 is `40f7600fc8ac5a8ef881b886bc29848434d6ffef6142bde2d2f00b25b0335bca`. StormLib readback matched all manifest entries. It remains uninstalled/unpublished. The package grants no CoA spells itself; the full module's Hero-only spell-grant path is still a prerequisite. No executable build or gameplay test.

### Pinned module source correction and Hero-only audit (2026-11-05)

The upstream module source is available at commit `9f914baff448e635cfe0469e12e957a2a165e5e3` in `STRHercules/EsteriaWoW/modules/mod-classless-wildcard/`; the earlier connector 404 resulted from using the wrong path/ref. Confirmed primary files include `README.md`, `PLAN.md`, `src/ClasslessPlayerScript.cpp`, `src/ClasslessMgr.cpp`, `src/ClasslessMgr.h`, `src/ClasslessNpc.cpp`, `src/ClasslessCommands.cpp`, `src/ClasslessWildcard.h`, and `src/cw_loader.cpp`.

The pinned README explicitly calls it a total server overhaul: every character can learn every class's abilities/talents, and it replaces class progression, resources, stats, gear, and quest access. The PlayerScript gates reviewed so far use the global `cfg.enabled` switch and `IsExempt` (bots/system accounts), not class ID. For Aetheria, this means simply adding the module and enabling its config would affect conventional classes, contrary to the owner's requirement. Every player lifecycle, progression, spell/talent acquisition, resource/class-context hook, command, NPC interaction, addon protocol, and CoA effect needs a Hero ID 10 participant check before side effects. The module's global SQL/DBC transformations and required client patch also need additive Aetheria-specific scoping; they cannot be installed wholesale.

This corrects the prior note that the upstream source itself could not be fetched; it still is not present in the active local server tree. No source code or data was changed by this audit. Next implementation work is to stage the exact pinned module source locally in an isolated review area, map its complete entrypoint and SQL/data surface against Aetheria, then adapt/gate before registering or enabling it. Do not enable the upstream module defaults.

### Staged pinned module reference and complete Hero-only boundary audit (2026-11-05)

A selected 29-file reference set from upstream commit `9f914baff448e635cfe0469e12e957a2a165e5e3` is now staged under `work/hero-classless-20261105/upstream-reference-9f914baff448e635cfe0469e12e957a2a165e5e3/`. Each file's Git blob SHA was checked against the GitHub API and matched. This is a partial review copy, not an installable module; the upstream root `CMakeLists.txt` path returned 404 and the CoA script subtree/client patch/data inventory is not fully staged.

New `HERO-ONLY-PORT-AUDIT.md` maps the class conversion, lifecycle, player hooks, manager API, commands/NPC/addon, world loot, forged/CoA scripts, class-context/resource overrides, and global SQL/DBC/client-patch risks. It flags `EnforceChassis` in both create and login as directly incompatible with Aetheria's real Hero class unless removed/redesigned. No active source/data was edited; next is inventory of remaining module/CoA entrypoints and dependencies, then a separately reviewed Hero-only adaptation. Do not register or enable the upstream module as-is.
