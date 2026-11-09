/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Hero-only adaptation of the Primalist talent handlers not split into
// focused source files. Talent Events and Natural Efficiency are registered
// by their own adapters to avoid duplicate global scripts.

#include "CoAPort.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>

namespace
{
constexpr uint32 GeodeBarrageDamage = 803138;
constexpr uint32 GeodeBarrageRage = 802885;
constexpr uint32 ThroatClampHelper = 500811;

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class primalist_talent_casts : public AllSpellScript
{
public:
    primalist_talent_casts() : AllSpellScript("primalist_talent_casts",
        { ALLSPELLHOOK_ON_CRIT_CHANCE, ALLSPELLHOOK_ON_HIT_RESULT }) { }

    void OnSpellHitResult(Spell* spell, Unit* target, uint8 miss, uint32, uint32, bool) override
    {
        Player* player = GetPrimalistHero(spell ? spell->GetCaster()->ToUnit() : nullptr);
        SpellInfo const* info = spell ? spell->GetSpellInfo() : nullptr;
        if (!player || !target || target == player || player->IsFriendlyTo(target) || miss != SPELL_MISS_NONE ||
            !info || info->SpellFamilyName != 37 || info->Id != GeodeBarrageDamage ||
            spell->GetScriptValue(GeodeBarrageRage))
            return;

        spell->SetScriptValue(GeodeBarrageRage, 1);
        player->CastSpell(player, GeodeBarrageRage, true);
    }

    void OnSpellCritChance(Spell* spell, Unit* target, float& chance) override
    {
        Player* player = GetPrimalistHero(spell ? spell->GetCaster()->ToUnit() : nullptr);
        SpellInfo const* info = spell ? spell->GetSpellInfo() : nullptr;
        if (!player || !target || !player->HasAura(805336) || !info || info->SpellFamilyName != 37 ||
            !(info->SpellFamilyFlags[0] & 8))
            return;

        for (AuraEffect const* effect : target->GetAuraEffectsByType(SPELL_AURA_PERIODIC_DAMAGE))
            if (effect->GetCasterGUID() == player->GetGUID() && effect->GetSpellInfo()->SpellFamilyName == 37 &&
                (effect->GetSpellInfo()->SpellFamilyFlags[0] & 64))
            {
                chance = 100.0f;
                break;
            }
    }
};

SpellCastResult CheckThroatClamp(Player* player, Unit* target)
{
    Pet* pet = player ? player->GetPet() : nullptr;
    if (!pet || !pet->IsAlive() || pet->GetOwnerGUID() != player->GetGUID())
        return SPELL_FAILED_NO_PET;
    if (!target || !pet->IsInMap(target) || !pet->InSamePhase(target) || !pet->IsValidAttackTarget(target))
        return SPELL_FAILED_BAD_TARGETS;
    if (pet->HasUnitState(UNIT_STATE_NOT_MOVE | UNIT_STATE_LOST_CONTROL))
        return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

    SpellInfo const* helper = sSpellMgr->GetSpellInfo(ThroatClampHelper);
    if (!helper || !pet->IsWithinDistInMap(target, helper->GetMaxRange(false, pet)))
        return SPELL_FAILED_OUT_OF_RANGE;
    if (!pet->IsWithinLOSInMap(target))
        return SPELL_FAILED_LINE_OF_SIGHT;
    return SPELL_CAST_OK;
}

class spell_ascension_throat_clamp : public SpellScript
{
    PrepareSpellScript(spell_ascension_throat_clamp);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({ ThroatClampHelper }); }
    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    SpellCastResult CheckCast() { return CheckThroatClamp(GetPrimalistHero(GetCaster()), GetExplTargetUnit()); }

    void Handle(SpellEffIndex)
    {
        Player* player = GetPrimalistHero(GetCaster());
        Unit* target = GetHitUnit();
        if (player && CheckThroatClamp(player, target) == SPELL_CAST_OK)
            player->GetPet()->CastSpell(target, ThroatClampHelper, false);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_ascension_throat_clamp::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_ascension_throat_clamp::Handle, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class aura_ascension_earthmaker : public AuraScript
{
    PrepareAuraScript(aura_ascension_earthmaker);

    bool Check(ProcEventInfo& event)
    {
        Player* owner = GetPrimalistHero(GetTarget());
        DamageInfo const* damage = event.GetDamageInfo();
        Unit* target = event.GetActionTarget();
        return owner && owner->IsAlive() && event.GetActor() == owner && damage && damage->GetDamage() &&
            target && !owner->IsFriendlyTo(target);
    }

    void Register() override { DoCheckProc += AuraCheckProcFn(aura_ascension_earthmaker::Check); }
};

class aura_ascension_primal_shred_critical : public AuraScript
{
    PrepareAuraScript(aura_ascension_primal_shred_critical);

    bool Load() override
    {
        Pet* pet = GetCaster() ? GetCaster()->ToPet() : nullptr;
        Player* owner = pet ? GetPrimalistHero(pet->GetOwner()) : nullptr;
        SpellInfo const* info = GetSpellInfo();
        return owner && HasCoAKit(owner, CLASS_WILDWALKER) && info && info->SpellFamilyName == 37 &&
            info->SpellFamilyFlags == flag96(0, 0, 32) && info->DmgClass == SPELL_DAMAGE_CLASS_MELEE;
    }

    void Snapshot(AuraEffect const*, AuraEffectHandleModes)
    {
        Unit* pet = GetCaster();
        if (!pet)
            return;
        SpellInfo const* info = GetSpellInfo();
        float chance = pet->SpellDoneCritChance(GetTarget(), info, info->GetSchoolMask(), BASE_ATTACK, true);
        chance = GetTarget()->SpellTakenCritChance(pet, info, info->GetSchoolMask(), chance, BASE_ATTACK, true);
        GetEffect(EFFECT_0)->SetCritChance(std::max(0.0f, chance));
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_primal_shred_critical::Snapshot,
            EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};
}

void AddSC_AscensionPrimalistTalents()
{
    new primalist_talent_casts();
    RegisterSpellScript(spell_ascension_throat_clamp);
    RegisterSpellScript(aura_ascension_earthmaker);
    RegisterSpellScript(aura_ascension_primal_shred_critical);
}
