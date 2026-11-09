/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of Bring Me Their Bones and its pet listener.

#include "CoAPort.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellInfo.h"
#include "Unit.h"

namespace
{
enum BonesSpells : uint32
{
    BonesMark = 806552,
    BonesDamage = 806553,
    BonesStacks = 806554,
    BonesListener = 806378
};

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

Player* GetCurrentPrimalistPetOwner(Unit* unit)
{
    Pet* pet = unit ? unit->ToPet() : nullptr;
    Player* owner = pet ? GetPrimalistHero(pet->GetOwner()) : nullptr;
    return owner && owner->GetPet() == pet ? owner : nullptr;
}

class spell_ascension_bring_their_bones : public SpellScript
{
    PrepareSpellScript(spell_ascension_bring_their_bones);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({BonesStacks, BonesListener}); }
    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    SpellCastResult CheckPet()
    {
        Player* owner = GetPrimalistHero(GetCaster());
        Pet* pet = owner ? owner->GetPet() : nullptr;
        return pet && pet->IsAlive() ? SPELL_CAST_OK : SPELL_FAILED_NO_PET;
    }

    void SkipInitialStack(SpellEffIndex index)
    {
        PreventHitDefaultEffect(index);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_ascension_bring_their_bones::CheckPet);
        OnEffectLaunchTarget += SpellEffectFn(spell_ascension_bring_their_bones::SkipInitialStack,
            EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
    }
};

class aura_ascension_bones_mark : public AuraScript
{
    PrepareAuraScript(aura_ascension_bones_mark);

    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    void RemoveStacks(AuraEffect const*, AuraEffectHandleModes)
    {
        GetTarget()->RemoveAurasDueToSpell(BonesStacks, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_bones_mark::RemoveStacks,
            EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class aura_ascension_bones_listener : public AuraScript
{
    PrepareAuraScript(aura_ascension_bones_listener);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({BonesMark, BonesStacks, BonesDamage}); }

    bool CheckProc(ProcEventInfo& event)
    {
        Unit* pet = GetTarget();
        Player* owner = GetCurrentPrimalistPetOwner(pet);
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        SpellInfo const* info = damage ? damage->GetSpellInfo() : nullptr;
        return owner && owner->IsAlive() && pet->IsAlive() && event.GetActor() == pet &&
            GetCasterGUID() == owner->GetGUID() && victim && victim->IsAlive() &&
            damage && damage->GetDamage() && info && info->Id != BonesDamage &&
            victim->HasAura(BonesMark, owner->GetGUID()) && !pet->IsFriendlyTo(victim);
    }

    void Stack(AuraEffect const* effect, ProcEventInfo& event)
    {
        PreventDefaultAction();
        if (!CheckProc(event))
            return;
        Unit* pet = GetTarget();
        Player* owner = GetCurrentPrimalistPetOwner(pet);
        Unit* victim = event.GetActionTarget();
        Aura* mark = victim->GetAura(BonesMark, owner->GetGUID());
        Aura* stacks = owner->AddAura(BonesStacks, victim);
        if (!stacks || !mark)
            return;
        stacks->SetDuration(mark->GetDuration());
        if (stacks->GetStackAmount() < 5)
            return;
        stacks->Remove();
        pet->CastSpell(victim, BonesDamage, true, nullptr, effect);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_bones_listener::CheckProc);
        OnEffectProc += AuraEffectProcFn(aura_ascension_bones_listener::Stack,
            EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_ascension_bones_damage : public SpellScript
{
    PrepareSpellScript(spell_ascension_bones_damage);

    bool Load() override { return GetCurrentPrimalistPetOwner(GetCaster()) != nullptr; }

    void PreserveOtherMarks(SpellEffIndex index)
    {
        PreventHitDefaultEffect(index);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ascension_bones_damage::PreserveOtherMarks,
            EFFECT_1, SPELL_EFFECT_REMOVE_AURA);
    }
};
}

void AddSC_AscensionPrimalistBones()
{
    RegisterSpellScript(spell_ascension_bring_their_bones);
    RegisterSpellScript(aura_ascension_bones_mark);
    RegisterSpellScript(aura_ascension_bones_listener);
    RegisterSpellScript(spell_ascension_bones_damage);
}
