# mod-open-world-party-scaling

An [AzerothCore](https://github.com/azerothcore/azerothcore-wotlk) module that increases open-world combat difficulty
for parties. It is especially useful for making open-world leveling more challenging when
playing in groups or with playerbots.

## Features

- Solo players and one-member parties are unaffected.
- Designed for harder open-world leveling with player groups and playerbots.
- Party sizes 2–5 use independent damage, healing, and incoming-damage multipliers.
- Party-owned damage and healing can be configured separately. Healing uses the stricter
  eligible multiplier from the healer or recipient when both qualify.
- Damage from creatures attacking party players, pets, and guardians has its own
  multiplier.
- Party-owned outgoing damage to creatures is reduced according to the local party size.
- Damage from creatures attacking the party is increased according to the local
  party size.
- Covers melee, ranged auto-attacks, direct spell damage, damage-over-time, pets,
  guardians, and healing.
- Raid groups and player-versus-player combat are unaffected.

## Installation

1. Clone the module into the AzerothCore `modules/` directory:

   ```bash
   cd /path/to/azerothcore/modules
   git clone https://github.com/Stefan2102/mod-open-world-party-scaling
   ```

2. Re-run CMake and build AzerothCore.
3. Copy `mod_open_world_party_scaling.conf.dist` and rename the copy to `mod_open_world_party_scaling.conf`.

## Configuration

The module uses direct decimal multipliers for party sizes 2, 3, 4, and 5. Raid groups are
excluded.

```ini
OpenWorldPartyScaling.Enable = 1
OpenWorldPartyScaling.RequireSameMapAndZone = 1

OpenWorldPartyScaling.PartySize2.DamageMultiplier         = 0.90
OpenWorldPartyScaling.PartySize2.HealingMultiplier        = 0.90
OpenWorldPartyScaling.PartySize2.IncomingDamageMultiplier = 1.10

OpenWorldPartyScaling.PartySize3.DamageMultiplier         = 0.80
OpenWorldPartyScaling.PartySize3.HealingMultiplier        = 0.80
OpenWorldPartyScaling.PartySize3.IncomingDamageMultiplier = 1.20

OpenWorldPartyScaling.PartySize4.DamageMultiplier         = 0.70
OpenWorldPartyScaling.PartySize4.HealingMultiplier        = 0.70
OpenWorldPartyScaling.PartySize4.IncomingDamageMultiplier = 1.30

OpenWorldPartyScaling.PartySize5.DamageMultiplier         = 0.60
OpenWorldPartyScaling.PartySize5.HealingMultiplier        = 0.60
OpenWorldPartyScaling.PartySize5.IncomingDamageMultiplier = 1.40
```

### Multiplier limits

Damage and healing multipliers accept values from `0.10` to `1.00`:

- `0.10` = 10% of normal damage or healing.
- `0.60` = 60% of normal damage or healing.
- `1.00` = 100% of normal damage or healing.
- Values below `0.10` are clamped to `0.10`.
- Values above `1.00` are clamped to `1.00`.

Incoming-damage multipliers accept values from `1.00` to `10.00`:

- `1.00` = 100% of normal incoming damage.
- `1.40` = 140% of normal incoming damage.
- `5.00` = 500% of normal incoming damage.
- `10.00` = 1000% of normal incoming damage.
- Values below `1.00` are clamped to `1.00`.
- Values above `10.00` are clamped to `10.00`.

For example, with five eligible members:

```ini
OpenWorldPartyScaling.PartySize5.DamageMultiplier         = 0.10
OpenWorldPartyScaling.PartySize5.HealingMultiplier        = 0.25
OpenWorldPartyScaling.PartySize5.IncomingDamageMultiplier = 5.00
```

A 1,000-damage player attack becomes 100 damage, a 1,000-point heal becomes 250 healing,
and a 1,000-damage creature attack becomes 5,000 damage.

## License

GPLv3-or-later. See [LICENSE](LICENSE).
