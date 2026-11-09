/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of CoA's Primalist Druid Training damage-heal proc.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>
#include <limits>

namespace
{
constexpr uint32 DruidTrainingHeal = 712433;

class aura_ascension_druid_training : public AuraScript
{
    PrepareAuraScript(aura_ascension_druid_training);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({DruidTrainingHeal}); }

    bool Check(ProcEventInfo& event)
    {
        Player* player = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) &&
            player->IsAlive() && GetCaster() == player && event.GetActor() == player && victim &&
            victim != player && !player->IsFriendlyTo(victim) && damage && damage->GetDamage();
    }

    void Heal(AuraEffect const* effect, ProcEventInfo& event)
    {
        PreventDefaultAction();
        uint64 amount = uint64(event.GetDamageInfo()->GetDamage()) * std::clamp(effect->GetAmount(), 0, 100) / 100;
        if (amount)
            GetTarget()->CastCustomSpell(DruidTrainingHeal, SPELLVALUE_BASE_POINT0,
                int32(std::min<uint64>(amount, std::numeric_limits<int32>::max())),
                GetTarget(), TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_druid_training::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_druid_training::Heal, EFFECT_2, AuraType(354));
    }
};
}

void AddSC_AscensionPrimalistDruidTraining()
{
    RegisterSpellScript(aura_ascension_druid_training);
}
