/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Hero-only adaptation of Stormbringer Surge of Might.

#include "CoAPort.h"
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
constexpr uint32 SurgeOfMight = 520083;
constexpr uint32 SurgeOfMightAura = 520084;
constexpr uint32 SurgeOfMightDamage = 573254;

Player const* GetStormbringerHero(Unit const* unit)
{
    Player const* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_STORMBRINGER) ? player : nullptr;
}

class stormbringer_surge_of_might_scaling : public UnitScript
{
public:
    stormbringer_surge_of_might_scaling() : UnitScript("stormbringer_surge_of_might_scaling", true,
        { UNITHOOK_MODIFY_SPELL_EFFECT_BASE_VALUE }) { }

    void ModifySpellEffectBaseValue(Unit const* caster, SpellInfo const* info, uint8 index,
        float& value) override
    {
        if (GetStormbringerHero(caster) && info && info->Id == SurgeOfMight && index == EFFECT_0)
            value += 0.7f * float(std::max(0,
                const_cast<Unit*>(caster)->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_NATURE)));
    }
};

class aura_ascension_surge_of_might : public AuraScript
{
    PrepareAuraScript(aura_ascension_surge_of_might);

    bool Validate(SpellInfo const* info) override
    {
        return info && info->Id == SurgeOfMightAura && ValidateSpellInfo({ SurgeOfMightDamage });
    }

    bool Load() override
    {
        return GetStormbringerHero(GetTarget()) != nullptr;
    }

    bool Check(ProcEventInfo& event)
    {
        Player const* owner = GetStormbringerHero(GetTarget());
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        SpellInfo const* spell = event.GetSpellInfo();
        return owner && owner->IsAlive() && event.GetActor() == owner && victim && victim != owner &&
            !owner->IsFriendlyTo(victim) && damage && damage->GetDamage() &&
            !(event.GetTypeMask() & PROC_FLAG_DONE_PERIODIC) && (!spell || spell->Id != SurgeOfMightDamage);
    }

    void Register() override { DoCheckProc += AuraCheckProcFn(aura_ascension_surge_of_might::Check); }
};
}

void AddSC_AscensionStormbringerSurge()
{
    new stormbringer_surge_of_might_scaling();
    RegisterSpellScript(aura_ascension_surge_of_might);
}
