/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of Rylaks Blessing and its pet-only area aura.

#include "CoAPort.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Unit.h"

namespace
{
constexpr uint32 RylaksBlessingBuff = 802596;

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class aura_ascension_rylaks_blessing : public AuraScript
{
    PrepareAuraScript(aura_ascension_rylaks_blessing);

    bool Load() override
    {
        Player* owner = GetPrimalistHero(GetUnitOwner());
        return owner && GetCasterGUID() == owner->GetGUID();
    }

    bool Check(ProcEventInfo& event)
    {
        Player* owner = GetPrimalistHero(GetTarget());
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        Pet* pet = owner ? owner->GetPet() : nullptr;
        return owner && owner->IsAlive() && pet && pet->IsAlive() && event.GetActor() == owner &&
            victim && victim != owner && !owner->IsFriendlyTo(victim) && damage && damage->GetDamage();
    }

    void Remove(AuraEffect const*, AuraEffectHandleModes)
    {
        Player* owner = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        if (owner && owner->getClass() == CLASS_HERO)
            owner->RemoveAurasDueToSpell(RylaksBlessingBuff, GetCasterGUID());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_rylaks_blessing::Check);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_rylaks_blessing::Remove,
            EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class aura_ascension_rylaks_blessing_pet : public AuraScript
{
    PrepareAuraScript(aura_ascension_rylaks_blessing_pet);

    bool Check(Unit* target)
    {
        Player* owner = GetPrimalistHero(GetCaster());
        return owner && target == owner->GetPet();
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(aura_ascension_rylaks_blessing_pet::Check);
    }
};
}

void AddSC_AscensionPrimalistRylaksBlessing()
{
    RegisterSpellScript(aura_ascension_rylaks_blessing);
    RegisterSpellScript(aura_ascension_rylaks_blessing_pet);
}
