#include "Config.h"
#include "Creature.h"
#include "Group.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "SpellInfo.h"
#include "Unit.h"
#include "UnitScript.h"
#include "WorldScript.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <limits>
#include <string>

namespace Acore::OpenWorldPartyScaling
{
namespace
{
    constexpr uint32 PARTY_SIZE_MIN = 2;
    constexpr uint32 PARTY_SIZE_MAX = 5;
    constexpr float MIN_OUTPUT_MULTIPLIER = 0.10f;
    constexpr float MIN_INCOMING_MULTIPLIER = 1.0f;
    constexpr float MAX_INCOMING_MULTIPLIER = 10.0f;

    struct PartySizeMultipliers
    {
        float damage = 1.0f;
        float healing = 1.0f;
        float incomingDamage = 1.0f;
    };

    constexpr auto DEFAULT_PARTY_SIZE_MULTIPLIERS = std::to_array<PartySizeMultipliers>({
        PartySizeMultipliers{ 0.90f, 0.90f, 1.10f },
        PartySizeMultipliers{ 0.80f, 0.80f, 1.20f },
        PartySizeMultipliers{ 0.70f, 0.70f, 1.30f },
        PartySizeMultipliers{ 0.60f, 0.60f, 1.40f }
    });

    bool enabled = true;
    bool requireSameMapAndZone = true;
    std::array<PartySizeMultipliers, PARTY_SIZE_MAX - PARTY_SIZE_MIN + 1> partySizeMultipliers =
        DEFAULT_PARTY_SIZE_MULTIPLIERS;

    float LoadOutputMultiplier(std::string const& key, float defaultValue)
    {
        float value = sConfigMgr->GetOption<float>(key, defaultValue);
        if (!std::isfinite(value))
            return defaultValue;

        return std::clamp(value, MIN_OUTPUT_MULTIPLIER, 1.0f);
    }

    float LoadIncomingMultiplier(std::string const& key, float defaultValue)
    {
        float value = sConfigMgr->GetOption<float>(key, defaultValue);
        if (!std::isfinite(value))
            return defaultValue;

        return std::clamp(value, MIN_INCOMING_MULTIPLIER, MAX_INCOMING_MULTIPLIER);
    }

    void LoadConfig()
    {
        // Load module settings after worldserver options are available. Enable = 0 disables unit scaling.
        enabled = sConfigMgr->GetOption<bool>("OpenWorldPartyScaling.Enable", true);
        requireSameMapAndZone = sConfigMgr->GetOption<bool>(
            "OpenWorldPartyScaling.RequireSameMapAndZone", true);

        for (uint32 partySize = PARTY_SIZE_MIN; partySize <= PARTY_SIZE_MAX; ++partySize)
        {
            PartySizeMultipliers& multipliers = partySizeMultipliers[partySize - PARTY_SIZE_MIN];
            std::string const prefix = "OpenWorldPartyScaling.PartySize" + std::to_string(partySize);

            // Party output is always kept between 10% and 100% of its normal value.
            multipliers.damage = LoadOutputMultiplier(
                prefix + ".DamageMultiplier", DEFAULT_PARTY_SIZE_MULTIPLIERS[partySize - PARTY_SIZE_MIN].damage);
            multipliers.healing = LoadOutputMultiplier(
                prefix + ".HealingMultiplier", DEFAULT_PARTY_SIZE_MULTIPLIERS[partySize - PARTY_SIZE_MIN].healing);

            // Incoming damage is limited to between 100% and 1000% of its normal value.
            multipliers.incomingDamage = LoadIncomingMultiplier(
                prefix + ".IncomingDamageMultiplier",
                DEFAULT_PARTY_SIZE_MULTIPLIERS[partySize - PARTY_SIZE_MIN].incomingDamage);
        }
    }

    Player* GetOwnerPlayer(Unit* unit)
    {
        // Players resolve to themselves; pets and guardians resolve to their controlling player.
        return unit ? unit->GetCharmerOrOwnerPlayerOrPlayerItself() : nullptr;
    }

    bool IsPvPInteraction(Unit* first, Unit* second)
    {
        // Owner resolution also covers a player's pets and guardians in PvP interactions.
        Player* firstPlayer = GetOwnerPlayer(first);
        Player* secondPlayer = GetOwnerPlayer(second);
        if (!firstPlayer || !secondPlayer || firstPlayer == secondPlayer)
            return false;

        // Duel opponents remain excluded even when they are members of the same party.
        if ((firstPlayer->duel && firstPlayer->duel->Opponent == secondPlayer)
            || (secondPlayer->duel && secondPlayer->duel->Opponent == firstPlayer))
            return true;

        // Hostile player relationships are excluded; a PvP flag alone is not sufficient.
        return firstPlayer->IsHostileTo(secondPlayer) || secondPlayer->IsHostileTo(firstPlayer);
    }

    uint32 GetEligibleMemberCount(Unit* unit)
    {
        Player* player = GetOwnerPlayer(unit);

        // Offline or removed players cannot contribute to the local party count.
        if (!player || !player->IsInWorld())
            return 0;

        Map* map = player->GetMap();

        // Scaling applies only to actors on open-world maps. Actors in dungeons, raids, arenas, and
        // battlegrounds are not scaled.
        if (!map || !map->IsWorldMap())
            return 0;

        Group* group = player->GetGroup();

        // Raid groups are deliberately excluded, even when their members are in the open world.
        if (!group || group->isRaidGroup())
            return 0;

        // Recalculate the count for each event so movement, logout, and map changes take effect immediately.
        // Locality can optionally restrict online, in-world members to this map and zone.
        uint32 eligibleMembers = 0;
        for (Group::MemberSlot const& memberSlot : group->GetMemberSlots())
        {
            Player* member = ObjectAccessor::FindPlayer(memberSlot.guid);
            if (!member || !member->IsInWorld())
                continue;

            if (requireSameMapAndZone && (member->GetMap() != map || member->GetZoneId() != player->GetZoneId()))
                continue;

            ++eligibleMembers;
        }

        return eligibleMembers;
    }

    PartySizeMultipliers const* GetPartySizeMultipliers(Unit* unit)
    {
        uint32 eligibleMembers = GetEligibleMemberCount(unit);
        if (eligibleMembers < PARTY_SIZE_MIN)
            return nullptr;

        // Use the size-five settings defensively if an unexpected larger party count is provided.
        uint32 partySize = std::min(eligibleMembers, PARTY_SIZE_MAX);
        return &partySizeMultipliers[partySize - PARTY_SIZE_MIN];
    }

    uint32 ApplyMultiplier(uint32 value, float multiplier)
    {
        // Clamp the result to uint32 and keep positive values at least 1 after module scaling.
        double result = double(value) * double(multiplier);
        uint32 scaledValue = static_cast<uint32>(
            std::clamp(result, 0.0, double(std::numeric_limits<uint32>::max())));

        if (value > 0 && scaledValue == 0)
            return 1;

        return scaledValue;
    }

    bool IsUnownedCreature(Unit* unit)
    {
        Creature* creature = unit ? unit->ToCreature() : nullptr;
        return creature && !GetOwnerPlayer(creature);
    }

    enum class DamageDirection : uint8
    {
        None,
        Outgoing,
        Incoming
    };

    DamageDirection GetDamageDirection(Unit* attacker, Unit* victim)
    {
        // Classify the interaction once so owner resolution is not repeated during one event.
        if (IsUnownedCreature(victim))
            return DamageDirection::Outgoing;

        if (IsUnownedCreature(attacker))
            return DamageDirection::Incoming;

        return DamageDirection::None;
    }

    void ApplyDamageScaling(Unit* attacker, Unit* victim, uint32& damage)
    {
        if (!damage)
            return;

        DamageDirection direction = GetDamageDirection(attacker, victim);
        if (direction == DamageDirection::None)
            return;

        Unit* partyUnit = direction == DamageDirection::Outgoing ? attacker : victim;
        PartySizeMultipliers const* multipliers = GetPartySizeMultipliers(partyUnit);
        if (!multipliers)
            return;

        float multiplier = direction == DamageDirection::Outgoing ? multipliers->damage
                                                                  : multipliers->incomingDamage;
        damage = ApplyMultiplier(damage, multiplier);
    }

    void ApplyDamageScaling(Unit* attacker, Unit* victim, int32& damage)
    {
        if (damage <= 0)
            return;

        uint32 scaledDamage = static_cast<uint32>(damage);
        ApplyDamageScaling(attacker, victim, scaledDamage);
        damage = static_cast<int32>(std::min<uint32>(scaledDamage, std::numeric_limits<int32>::max()));
    }

    bool IsPeriodicHealingSpell(SpellInfo const* spellInfo)
    {
        return spellInfo && spellInfo->HasAura(SPELL_AURA_PERIODIC_HEAL);
    }
}

class OpenWorldPartyScalingWorldScript final : public WorldScript
{
public:
    OpenWorldPartyScalingWorldScript() : WorldScript("OpenWorldPartyScalingWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD }) { }

    void OnAfterConfigLoad(bool) override
    {
        // Registering this world hook keeps configuration reloads consistent with AzerothCore settings.
        LoadConfig();
    }
};

class OpenWorldPartyScalingUnitScript final : public UnitScript
{
public:
    OpenWorldPartyScalingUnitScript() : UnitScript("OpenWorldPartyScalingUnitScript", true,
        { UNITHOOK_MODIFY_PERIODIC_DAMAGE_AURAS_TICK, UNITHOOK_MODIFY_MELEE_DAMAGE,
            UNITHOOK_MODIFY_SPELL_DAMAGE_TAKEN, UNITHOOK_MODIFY_HEAL_RECEIVED }) { }

    void ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage) override
    {
        if (!enabled)
            return;

        // Modify melee damage before AzerothCore applies the result to the victim.
        ApplyDamageScaling(attacker, target, damage);
    }

    void ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage, SpellInfo const*) override
    {
        if (!enabled)
            return;

        // Direct spells, ranged weapon attacks, and wands use this spell-damage path.
        ApplyDamageScaling(attacker, target, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage,
        SpellInfo const* spellInfo) override
    {
        if (!enabled || IsPeriodicHealingSpell(spellInfo))
            return;

        // Modify damage-over-time and leech ticks before AzerothCore applies their results.
        ApplyDamageScaling(attacker, target, damage);
    }

    void ModifyHealReceived(Unit* target, Unit* healer, uint32& heal, SpellInfo const* /*spellInfo*/) override
    {
        if (!enabled || !heal)
            return;

        // Do not scale PvP healing. Check both units symmetrically because direct healing may pass them
        // in either order.
        if (IsPvPInteraction(target, healer))
            return;

        // Modify healing before it changes the recipient's health.
        // Use the stricter multiplier when both healer and recipient have eligible parties.
        PartySizeMultipliers const* firstMultipliers = GetPartySizeMultipliers(target);
        PartySizeMultipliers const* secondMultipliers = GetPartySizeMultipliers(healer);
        PartySizeMultipliers const* multipliers = firstMultipliers;
        if (!multipliers || (secondMultipliers && secondMultipliers->healing < multipliers->healing))
            multipliers = secondMultipliers;

        if (multipliers)
            heal = ApplyMultiplier(heal, multipliers->healing);
    }
};
}

void AddSC_OpenWorldPartyScaling()
{
    // Register configuration loading and the unit hooks used by the module.
    new Acore::OpenWorldPartyScaling::OpenWorldPartyScalingWorldScript();
    new Acore::OpenWorldPartyScaling::OpenWorldPartyScalingUnitScript();
}



