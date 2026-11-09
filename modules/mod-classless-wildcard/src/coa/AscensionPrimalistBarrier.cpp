/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of Rock Barrier and Earthmother's Protection.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>

namespace
{
enum BarrierSpells : uint32
{
    RockBarrier = 503630,
    BarrierModifiers = 504853,
    EarthmotherProtection = 560298
};

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class aura_ascension_earthmother_protection_link : public AuraScript
{
    PrepareAuraScript(aura_ascension_earthmother_protection_link);

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({RockBarrier, BarrierModifiers, EarthmotherProtection});
    }

    bool Load() override
    {
        return GetPrimalistHero(GetUnitOwner()) != nullptr;
    }

    void Applied(AuraEffect const*, AuraEffectHandleModes)
    {
        Unit* owner = GetTarget();
        Aura* barrier = owner->GetAura(RockBarrier, owner->GetGUID());
        AuraEffect const* talent = owner->GetAuraEffect(EarthmotherProtection, EFFECT_0, owner->GetGUID());
        if (!barrier || !talent)
            return;
        if (Aura* helper = owner->AddAura(BarrierModifiers, owner))
        {
            if (AuraEffect* discount = helper->GetEffect(EFFECT_2))
                discount->ChangeAmount(talent->GetAmount());
            helper->SetMaxDuration(barrier->GetMaxDuration());
            helper->SetDuration(barrier->GetDuration());
        }
    }

    void Removed(AuraEffect const*, AuraEffectHandleModes)
    {
        Player* owner = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        if (owner && owner->getClass() == CLASS_HERO)
            owner->RemoveAurasDueToSpell(BarrierModifiers, owner->GetGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_earthmother_protection_link::Applied,
            EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_earthmother_protection_link::Removed,
            EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
    }
};

class primalist_barrier_scaling : public UnitScript
{
public:
    primalist_barrier_scaling() : UnitScript("primalist_barrier_scaling", true,
        {UNITHOOK_MODIFY_SPELL_EFFECT_BASE_VALUE}) { }

    void ModifySpellEffectBaseValue(Unit const* caster, SpellInfo const* info, uint8 index, float& value) override
    {
        Player const* player = caster ? caster->ToPlayer() : nullptr;
        if (!player || player->getClass() != CLASS_HERO || !HasCoAKit(player, CLASS_WILDWALKER) ||
            !info || info->SpellFamilyName != 37 || info->Id != RockBarrier || index != EFFECT_0 ||
            !info->Effects[index].IsAura(SPELL_AURA_MOD_RESISTANCE))
            return;
        value += caster->GetStat(STAT_STAMINA) * 3.0f;
    }
};

class aura_ascension_fury_of_earthmother : public AuraScript
{
    PrepareAuraScript(aura_ascension_fury_of_earthmother);

    bool Check(ProcEventInfo& event)
    {
        Player* owner = GetPrimalistHero(GetTarget());
        DamageInfo const* damage = event.GetDamageInfo();
        return owner && owner->IsAlive() && event.GetActor() == owner && damage && damage->GetDamage() &&
            owner->HasAura(RockBarrier, owner->GetGUID());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_fury_of_earthmother::Check);
    }
};

class spell_ascension_fury_of_earthmother_charge : public SpellScript
{
    PrepareSpellScript(spell_ascension_fury_of_earthmother_charge);

    bool Load() override
    {
        return GetPrimalistHero(GetCaster()) != nullptr;
    }

    void Restore()
    {
        Unit* owner = GetHitUnit();
        if (!owner || owner != GetCaster())
            return;
        Aura* barrier = owner->GetAura(RockBarrier, owner->GetGUID());
        if (!barrier)
            return;
        if (barrier->GetCharges() < 255)
            barrier->SetCharges(barrier->GetCharges() + 1);
        if (Aura* helper = owner->GetAura(BarrierModifiers, owner->GetGUID()))
        {
            helper->SetMaxDuration(std::max(helper->GetMaxDuration(), barrier->GetDuration()));
            helper->SetDuration(barrier->GetDuration());
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_ascension_fury_of_earthmother_charge::Restore);
    }
};
}

void AddSC_AscensionPrimalistBarrier()
{
    RegisterSpellScript(aura_ascension_earthmother_protection_link);
    RegisterSpellScript(aura_ascension_fury_of_earthmother);
    RegisterSpellScript(spell_ascension_fury_of_earthmother_charge);
    new primalist_barrier_scaling();
}
