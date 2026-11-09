/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>
#include <array>
#include <limits>

namespace
{
enum SacredGroveSpells : uint32
{
    SacredGrove = 800180,
    GroveRecovery = 800179
};

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

bool HasSacredGroveRow(SpellInfo const* info)
{
    if (!info || info->Id != SacredGrove || info->SpellFamilyName != 37)
        return false;

    SpellEffectInfo const& heal = info->Effects[EFFECT_0];
    SpellEffectInfo const& periodic = info->Effects[EFFECT_1];
    SpellEffectInfo const& empty = info->Effects[EFFECT_2];
    // The shipped row heals with SPELL_EFFECT_HEAL (10, 2001-2100 plus 100% AP); HEAL_PCT is kept for forward compatibility.
    return (heal.Effect == SPELL_EFFECT_HEAL || heal.Effect == SPELL_EFFECT_HEAL_PCT) && heal.BasePoints == 2001 && heal.DieSides == 100 &&
        heal.TargetA.GetTarget() == Targets(22) && heal.TargetB.GetTarget() == Targets(56) &&
        (heal.RadiusEntry && heal.RadiusEntry->ID == 18) && periodic.Effect == SPELL_EFFECT_PERSISTENT_AREA_AURA &&
        periodic.ApplyAuraName == SPELL_AURA_DUMMY && periodic.BasePoints == -1 &&
        periodic.DieSides == 1 && periodic.TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ALLY &&
        periodic.TargetB.GetTarget() == Targets(0) && (periodic.RadiusEntry && periodic.RadiusEntry->ID == 18) && empty.Effect == 0;
}

bool HasGroveRecoveryRow(SpellInfo const* info)
{
    if (!info || info->Id != GroveRecovery || info->SpellFamilyName != 37 || info->AttributesEx2 != 524289)
        return false;

    std::array<uint32, MAX_SPELL_EFFECTS> const effects =
        {SPELL_EFFECT_HEAL_PCT, SPELL_EFFECT_ENERGIZE_PCT, SPELL_EFFECT_ENERGIZE_PCT};
    std::array<int32, MAX_SPELL_EFFECTS> const basePoints = {2, 2, 2};
    std::array<uint32, MAX_SPELL_EFFECTS> const targetA = {TARGET_UNIT_TARGET_ALLY, TARGET_UNIT_TARGET_ALLY, 0};
    std::array<int32, MAX_SPELL_EFFECTS> const miscValues = {26125, 0, 1};
    std::array<int32, MAX_SPELL_EFFECTS> const miscValuesB = {1, 0, 1};
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (info->Effects[i].Effect != effects[i] || info->Effects[i].BasePoints != basePoints[i] ||
            info->Effects[i].DieSides != 1 || info->Effects[i].TargetA.GetTarget() != targetA[i] ||
            info->Effects[i].TargetB.GetTarget() != Targets(0) || info->Effects[i].MiscValue != miscValues[i] ||
            info->Effects[i].MiscValueB != miscValuesB[i])
            return false;
    return (info->Effects[EFFECT_0].RadiusEntry && info->Effects[EFFECT_0].RadiusEntry->ID == 36) && (!info->Effects[EFFECT_1].RadiusEntry) &&
        (!info->Effects[EFFECT_2].RadiusEntry);
}

class primalist_sacred_grove_metadata : public GlobalScript
{
public:
    primalist_sacred_grove_metadata() : GlobalScript("primalist_sacred_grove_metadata",
        {GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR}) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (HasSacredGroveRow(info))
        {
            SpellEffectInfo& periodic = info->Effects[EFFECT_1];
            periodic.ApplyAuraName = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
            periodic.TriggerSpell = GroveRecovery;
            periodic.Amplitude = 2000;
            periodic.TargetB = SpellImplicitTargetInfo(TARGET_DEST_DYNOBJ_ALLY);
            SpellEffectInfo& healing = info->Effects[EFFECT_2];
            healing.Effect = SPELL_EFFECT_PERSISTENT_AREA_AURA;
            healing.ApplyAuraName = SPELL_AURA_MOD_HEALING_PCT;
            healing.BasePoints = 24;
            healing.DieSides = 1;
            healing.TargetA = periodic.TargetA;
            healing.TargetB = periodic.TargetB;
            healing.RadiusEntry = periodic.RadiusEntry;
            healing.MiscValue = SPELL_SCHOOL_MASK_ALL;
        }
        else if (HasGroveRecoveryRow(info))
        {
            for (SpellEffectInfo& effect : info->Effects)
            {
                if (effect.Effect == SPELL_EFFECT_HEAL_PCT)
                    effect.Effect = SPELL_EFFECT_HEAL;
                else if (effect.Effect == SPELL_EFFECT_ENERGIZE_PCT)
                    effect.Effect = SPELL_EFFECT_ENERGIZE;
                effect.TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ALLY);
            }
            info->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
        }
    }
};

class aura_ascension_sacred_grove : public AuraScript
{
    PrepareAuraScript(aura_ascension_sacred_grove);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({GroveRecovery}); }
    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    bool Check(Unit* target)
    {
        if (!target)
            return false;
        return GetAura()->GetApplicationOfTarget(target->GetGUID()) ||
            GetAura()->GetApplicationMap().size() < GetSpellInfo()->MaxAffectedTargets;
    }

    void Recover(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster(); GetPrimalistHero(caster))
            caster->CastSpell(GetTarget(), GroveRecovery, TRIGGERED_FULL_MASK, nullptr, effect);
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(aura_ascension_sacred_grove::Check);
        OnEffectPeriodic += AuraEffectPeriodicFn(aura_ascension_sacred_grove::Recover,
            EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_ascension_sacred_grove_recovery : public SpellScript
{
    PrepareSpellScript(spell_ascension_sacred_grove_recovery);

    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    void Amount(SpellEffIndex index)
    {
        Unit* target = GetHitUnit();
        if (!target)
            return;
        bool health = index == EFFECT_0;
        Powers power = index == EFFECT_1 ? POWER_MANA : POWER_RAGE;
        uint64 maximum = health ? target->GetMaxHealth() : target->GetMaxPower(power);
        uint64 current = health ? target->GetHealth() : target->GetPower(power);
        uint64 amount = (maximum - std::min(current, maximum)) * std::clamp(GetEffectValue(), 0, 100) / 100;
        SetEffectValue(int32(std::min<uint64>(amount, std::numeric_limits<int32>::max())));
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_ascension_sacred_grove_recovery::Amount,
            EFFECT_0, SPELL_EFFECT_HEAL);
        OnEffectHitTarget += SpellEffectFn(spell_ascension_sacred_grove_recovery::Amount,
            EFFECT_1, SPELL_EFFECT_ENERGIZE);
        OnEffectHitTarget += SpellEffectFn(spell_ascension_sacred_grove_recovery::Amount,
            EFFECT_2, SPELL_EFFECT_ENERGIZE);
    }
};
}

void AddSC_AscensionPrimalistSacredGrove()
{
    new primalist_sacred_grove_metadata();
    RegisterSpellScript(aura_ascension_sacred_grove);
    RegisterSpellScript(spell_ascension_sacred_grove_recovery);
}
