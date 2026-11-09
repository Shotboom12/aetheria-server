/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, pinned commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream file: modules/mod-classless-wildcard/src/coa/AscensionRaidDamageAuras.cpp
// Upstream Git blob: 34dd891c42744c37111b25a8b4fd351a9a07a582.
#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>
#include <limits>

namespace
{
enum RaidDamageAuraSpells : uint32
{
    Exhaustion = 573255
};

enum class RaidAuraScaling
{
    AttackPower,
    RangedAttackPower,
    ShadowSpellPower,
    ArcaneSpellPower
};

struct RaidDamageAura
{
    uint32 Aura;
    uint8 CoAClass;
    RaidAuraScaling Scaling;
    float Coefficient;
};

constexpr RaidDamageAura RaidDamageAuras[] =
{
    {560530, CLASS_BARBARIAN, RaidAuraScaling::AttackPower, 0.35f},
    {537248, CLASS_RANGER, RaidAuraScaling::RangedAttackPower, 0.35f},
    {520839, CLASS_SON_OF_ARUGAL, RaidAuraScaling::ShadowSpellPower, 0.6f},
    {520929, CLASS_STARCALLER, RaidAuraScaling::ArcaneSpellPower, 0.7f}
};

bool IsEnabledHeroSource(Unit const* source)
{
    if (!source || !sClasslessMgr->cfg.enabled || !sClasslessMgr->cfg.coaEnable)
        return false;

    Player* owner = source->GetCharmerOrOwnerPlayerOrPlayerItself();
    return owner && sClasslessMgr->IsParticipant(owner) && !sClasslessMgr->IsExempt(owner);
}

RaidDamageAura const* FindRaidDamageAura(uint32 aura)
{
    auto itr = std::find_if(std::begin(RaidDamageAuras), std::end(RaidDamageAuras),
        [aura](RaidDamageAura const& entry) { return entry.Aura == aura; });
    return itr == std::end(RaidDamageAuras) ? nullptr : &*itr;
}

float ScalingValue(Unit* source, RaidAuraScaling scaling)
{
    switch (scaling)
    {
        case RaidAuraScaling::AttackPower: return source->GetTotalAttackPowerValue(BASE_ATTACK);
        case RaidAuraScaling::RangedAttackPower: return source->GetTotalAttackPowerValue(RANGED_ATTACK);
        case RaidAuraScaling::ShadowSpellPower:
            return float(source->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_SHADOW));
        case RaidAuraScaling::ArcaneSpellPower:
            return float(source->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_ARCANE));
    }
    return 0.0f;
}

class spell_ascension_raid_damage_aura : public SpellScript
{
    PrepareSpellScript(spell_ascension_raid_damage_aura);

    void SkipExhausted(std::list<WorldObject*>& targets)
    {
        if (!IsEnabledHeroSource(GetCaster()))
            return;

        targets.remove_if([](WorldObject* target)
        {
            Player* player = target->ToPlayer();
            return !player || player->HasAura(Exhaustion);
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_ascension_raid_damage_aura::SkipExhausted,
            EFFECT_ALL, TARGET_UNIT_CASTER_AREA_RAID);
    }
};

class aura_ascension_raid_damage_aura : public AuraScript
{
    PrepareAuraScript(aura_ascension_raid_damage_aura);

    bool _heroSource = false;

    void Amount(AuraEffect const*, int32& amount, bool&)
    {
        RaidDamageAura const* entry = FindRaidDamageAura(GetId());
        Unit* caster = GetCaster();
        _heroSource = _heroSource || (entry && IsEnabledHeroSource(caster) &&
            HasCoAKit(caster, entry->CoAClass));
        if (_heroSource && entry && caster)
            amount = int32(std::clamp(
                ScalingValue(caster->GetCharmerOrOwnerOrSelf(), entry->Scaling) * entry->Coefficient,
                0.0f, float(std::numeric_limits<int32>::max() / 2)));
    }

    bool Check(ProcEventInfo& event)
    {
        if (!_heroSource)
            return true; // leave a non-Hero aura on the core proc path

        Unit* ally = GetTarget();
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        AuraEffect const* effect = GetEffect(EFFECT_0);
        return ally->IsAlive() && event.GetActor() == ally && victim && victim != ally &&
            !ally->IsFriendlyTo(victim) && damage && damage->GetDamage() &&
            !(event.GetTypeMask() & PROC_FLAG_DONE_PERIODIC) && effect && effect->GetAmount() > 0;
    }

    void Proc(AuraEffect const* effect, ProcEventInfo& event)
    {
        if (!_heroSource)
            return; // without PreventDefaultAction, the configured core effect runs

        PreventDefaultAction();
        Unit* ally = GetTarget();
        ally->CastCustomSpell(effect->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, SPELLVALUE_BASE_POINT0,
            effect->GetAmount(), event.GetActionTarget(), TRIGGERED_FULL_MASK, nullptr, effect, ally->GetGUID());
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(aura_ascension_raid_damage_aura::Amount, EFFECT_0,
            SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE);
        DoCheckProc += AuraCheckProcFn(aura_ascension_raid_damage_aura::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_raid_damage_aura::Proc, EFFECT_0,
            SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE);
    }
};
}

void AddSC_AscensionRaidDamageAuras()
{
    RegisterSpellScript(spell_ascension_raid_damage_aura);
    RegisterSpellScript(aura_ascension_raid_damage_aura);
}
