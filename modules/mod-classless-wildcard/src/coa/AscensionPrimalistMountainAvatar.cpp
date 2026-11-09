/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Unit.h"

#include <algorithm>

namespace
{
enum MountainAvatarSpells : uint32
{
    MountainAvatar = 707616,
    EarthenAvatar = 680421,
    AvatarImmunity = 680427,
    AvatarCleanse = 680673
};

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class aura_ascension_mountain_avatar : public AuraScript
{
    PrepareAuraScript(aura_ascension_mountain_avatar);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({EarthenAvatar}); }

    bool Check(ProcEventInfo& event)
    {
        Unit* owner = GetTarget();
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        return GetPrimalistHero(owner) && owner->IsAlive() &&
            GetCasterGUID() == owner->GetGUID() && event.GetActor() == owner && victim && victim != owner &&
            !owner->IsFriendlyTo(victim) && damage && damage->GetDamage();
    }

    void Proc(AuraEffect const*, ProcEventInfo&)
    {
        PreventDefaultAction();
        Unit* owner = GetTarget();
        if (Aura* avatar = owner->GetAura(EarthenAvatar, owner->GetGUID()))
        {
            int32 duration = avatar->GetDuration() + 5000;
            avatar->SetMaxDuration(std::max(avatar->GetMaxDuration(), duration));
            avatar->SetDuration(duration);
        }
        else
        {
            owner->CastSpell(owner, EarthenAvatar, TRIGGERED_FULL_MASK);
            if (Aura* avatar = owner->GetAura(EarthenAvatar, owner->GetGUID()))
            {
                avatar->SetMaxDuration(5000);
                avatar->SetDuration(5000);
            }
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_mountain_avatar::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_mountain_avatar::Proc,
            EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class aura_ascension_earthen_avatar : public AuraScript
{
    PrepareAuraScript(aura_ascension_earthen_avatar);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({AvatarImmunity, AvatarCleanse}); }

    bool Load() override
    {
        Player* owner = GetPrimalistHero(GetUnitOwner());
        return owner && GetCasterGUID() == owner->GetGUID();
    }

    void Apply(AuraEffect const*, AuraEffectHandleModes)
    {
        Unit* owner = GetTarget();
        owner->CastSpell(owner, AvatarCleanse, TRIGGERED_FULL_MASK);
        if (Aura* immunity = owner->AddAura(AvatarImmunity, owner))
        {
            immunity->SetMaxDuration(-1);
            immunity->SetDuration(-1);
        }
    }

    void Remove(AuraEffect const*, AuraEffectHandleModes)
    {
        GetTarget()->RemoveAurasDueToSpell(AvatarImmunity, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_earthen_avatar::Apply,
            EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_earthen_avatar::Remove,
            EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL);
    }
};

}

void AddSC_AscensionPrimalistMountainAvatar()
{
    RegisterSpellScript(aura_ascension_mountain_avatar);
    RegisterSpellScript(aura_ascension_earthen_avatar);
}
