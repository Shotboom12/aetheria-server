# Hozen (race 112) and Sylvari (race 110): world database rows

Credit: the Hozen and Sylvari races come from **Ilusixn** (Custom-Race-3.3.5a), used with his permission.

Server data for Release 1a, as applied to the owner's realm on 2026-11-10 after a world backup and a collision check:

- `sql/hozen-sylvari-release1a-world.sql`: one transaction with the playercreateinfo, actions, race stats, chrraces_dbc, outfit, display, model and racial spell rows for both races (racials 14001121-14001124 Hozen, 14001141-14001144 Sylvari; Nimble Escape and Verdant Renewal are deferred). The header says "review candidate"; it was reviewed and applied. It refuses existing IDs; read it before applying to another database and back up first.
- `sql/hero-tab-skillraceclassinfo.sql`: the 31 SkillRaceClassInfo rows for the Hero spellbook tab skill lines (2001-2009, 2011-2032). Apply with the worldserver stopped.

The server code for the races is in `src/server` (race_racials, the racial script data, SharedDefines). The client side is in aetheria-client. Status: installed and tested by the owner; nothing here was rebuilt from the published tree.
