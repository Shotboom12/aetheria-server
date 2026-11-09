/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of Natural Efficiency from the Primalist Talents package.

#include "CoAPort.h"
#include "SpellMgr.h"
#include "SpellAuraEffects.h"
#include "Spell.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
constexpr uint32 NaturalEfficiencyHelper = 707806;

class aura_ascension_natural_efficiency : public AuraScript
{
    PrepareAuraScript(aura_ascension_natural_efficiency);

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({NaturalEfficiencyHelper});
    }

    bool Load() override
    {
        Unit* owner = GetUnitOwner();
        return owner && owner->IsPlayer() && HasCoAKit(owner, CLASS_WILDWALKER);
    }

    bool Check(ProcEventInfo& event)
    {
        Unit* attacker = event.GetActor();
        SpellInfo const* info = event.GetSpellInfo();
        Unit* owner = GetTarget();
        if (!owner || !attacker || attacker == owner || !info || !owner->IsAlive() ||
            !(event.GetHitMask() & (PROC_HIT_NORMAL | PROC_HIT_CRITICAL)))
            return false;

        AuraApplication const* application = owner->GetAuraApplication(info->Id, attacker->GetGUID());
        if (!application || application->GetRemoveMode() || application->IsPositive())
            return false;

        Aura* aura = application->GetBase();
        if (!aura)
            return false;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (application->GetEffectMask() & (1 << i))
                if (AuraEffect const* effect = aura->GetEffect(i))
                    if (effect->GetAuraType() == SPELL_AURA_MOD_ROOT ||
                        effect->GetAuraType() == SPELL_AURA_MOD_STUN ||
                        effect->GetAuraType() == SPELL_AURA_MOD_CONFUSE)
                        return true;
        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_natural_efficiency::Check);
    }
};
}

void AddSC_AscensionPrimalistNaturalEfficiency()
{
    RegisterSpellScript(aura_ascension_natural_efficiency);
}
