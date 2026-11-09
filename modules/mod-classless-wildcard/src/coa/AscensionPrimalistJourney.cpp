/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

#include "CoAPort.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>

namespace
{
enum JourneySpells : uint32
{
    JourneyGround = 302534,
    CragDamage = 302590
};

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class aura_ascension_journey_damage : public AuraScript
{
    PrepareAuraScript(aura_ascension_journey_damage);

    bool Check(ProcEventInfo& event)
    {
        Unit* owner = GetTarget();
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        return GetPrimalistHero(owner) && owner->IsAlive() && GetCaster() == owner &&
            event.GetActor() == owner && victim && victim != owner &&
            !owner->IsFriendlyTo(victim) && damage && damage->GetDamage();
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_journey_damage::Check);
    }
};

class spell_ascension_journey_ground : public SpellScript
{
    PrepareSpellScript(spell_ascension_journey_ground);

    bool Load() override
    {
        return GetPrimalistHero(GetCaster()) != nullptr;
    }

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({JourneyGround, CragDamage}); }

    void ScheduleBurst()
    {
        WorldLocation const* destination = GetExplTargetDest();
        if (!destination)
            return;
        Unit* caster = GetCaster();
        ObjectGuid owner = caster->GetGUID();
        WorldLocation location = *destination;
        uint32 map = caster->GetMapId();
        uint32 instance = caster->GetInstanceId();
        uint32 phase = caster->GetPhaseMask();
        caster->m_Events.AddEventAtOffset([owner, location, map, instance, phase]()
        {
            Player* player = ObjectAccessor::FindPlayer(owner);
            if (!GetPrimalistHero(player) || !player->IsInWorld() || !player->IsAlive() ||
                player->GetMapId() != map || player->GetInstanceId() != instance || player->GetPhaseMask() != phase)
                return;
            player->CastSpell(location.GetPositionX(), location.GetPositionY(), location.GetPositionZ(),
                CragDamage, true);
        }, Milliseconds(std::max(1, GetSpellInfo()->GetDuration())));
    }

    void Register() override { AfterCast += SpellCastFn(spell_ascension_journey_ground::ScheduleBurst); }
};

class aura_ascension_journey_ground : public AuraScript
{
    PrepareAuraScript(aura_ascension_journey_ground);

    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    void SuppressPerVictimBurst(AuraEffect const*) { PreventDefaultAction(); }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(aura_ascension_journey_ground::SuppressPerVictimBurst,
            EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};
}

void AddSC_AscensionPrimalistJourney()
{
    RegisterSpellScript(aura_ascension_journey_damage);
    RegisterSpellScript(spell_ascension_journey_ground);
    RegisterSpellScript(aura_ascension_journey_ground);
}
