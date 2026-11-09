# Character hot-swap integration analysis

Date: 2026-11-05

## Owner's target

Port Kalibros' character hot-swap to Aetheria, with character selection and the client-side hot-swap UI. The phase-1 upstream behavior is an instant, guarded logout followed by an ordinary login request for the selected character; it is not a seamless in-place world handoff.

## Local compatibility evidence

- The active server already has `TC9Sidecar`, `WorldSessionMgr::FindOfflineSessionForCharacterGUID`, `WorldSession::IsLegitCharacterForAccount`, `PlayerLogout`, the logout response flow, and `CharacterDatabase.WorkerThreads` config defaulting to 1. These align with several upstream server-handler dependencies.
- No Esteria swap opcodes or handler exist in the active server protocol registry. The registry is a dense enum/table with existing Aetheria custom opcodes, so reserve IDs only after reviewing the full registry and matching client values.
- No `CharacterSwap` extension or `EsteriaSwap` addon was found in the active client source. The upstream client compare adds a 445-line native extension, 474-line addon, race metadata, world/loading/selection hooks, and patch tooling. This must be integrated as a paired client/server slice.
- The local source and runtime configs have extensive unrelated changes. The checked-in worker-thread default is 1, but the live config and deployment mode were not queried; upstream's safety gate must stay opt-in and must refuse multi-worker/cluster configurations unless a save-order mechanism is implemented.

## Upstream server behavior reviewed

The upstream `CharacterSwapHandler.cpp` phase-1 request validates ownership, self-targeting, cooldown, combat/casting/death/instance/queue/flight/vehicle/fall/duel/trade/loot/bind/raid state, and duplicate/offline session ownership. It stamps the swap target and requests the normal instant logout. The roster query is asynchronous and returns character identity, location, active/dead flags, and current unsafe/cooldown state. Swap defaults disabled in config. Upstream restricts operation to non-cluster mode and at most one character DB worker because logout-save and next-login load ordering otherwise can race.

The client compare adds multiple lifecycle hooks and a dedicated addon. Review all of these together; do not port only the server request handler or invoke normal logout without the saved-target login suppression/marker path.

Primary sources: [server compare](https://github.com/STRHercules/EsteriaWoW/compare/e6dcea5b0a81...82dce95c6aa0), [client compare](https://github.com/STRHercules/wowdecomp/compare/dae8a4fb34b8...fcceaeaabdef), [server swap handler at upstream head](https://github.com/STRHercules/EsteriaWoW/blob/82dce95c6aa0/src/server/game/Handlers/CharacterSwapHandler.cpp).

## Safe integration sequence

1. Read the upstream `docs/character-hot-swap-plan.md` and local logout, character-login, async database, opcode, addon lifecycle and client extension docs/code. Confirm current Aetheria opcode allocations on both sides.
2. Port the opt-in server handler, config defaults, result/roster protocol, cooldown and target marker. Preserve normal logout/login behavior and Aetheria's account ownership/cluster checks.
3. Port the client native extension and addon as a complete paired protocol consumer. Keep normal character-selection flow intact when the feature/config is unavailable.
4. Establish ordering for pending character DB saves. Either preserve the upstream worker-count gate exactly, or add and review a per-character save/login barrier before allowing more than one worker.
5. Build and test only through the owner's guarded workflow when explicitly requested; perform offline/character-state review before install. Do not start the game/server or publish as part of source work.

No code, build, tests, database operation, install, or publication was performed for this analysis.


## Continuation implementation status (2026-11-05)

Phase 1 is now staged in Aetheria source: server request/result/roster handlers, opcodes `0x527–0x52A`, an opt-in config defaulting off, guarded logout and normal login marker; client native roster/request/result bridge and selection auto-enter; plus a minimal `/swap` addon. Server guards include account ownership, self-target, cooldown, combat/casting/death/instance/queue/movement/duel/trade/loot/bind/raid, target online ownership, cluster mode and character DB worker count. The roster uses prepared statement `CHAR_SEL_SWAP_ROSTER`. Server C++ codestyle passes.

This is logout/relogin only. It does not implement persistent visible shadows or in-place transfer. Source has not been built or run. Deployment config has not been inspected, so keep the gate off until the paired client addon is packaged and the live topology is verified.
