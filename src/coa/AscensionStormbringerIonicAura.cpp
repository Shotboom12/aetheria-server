/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, pinned commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream file: modules/mod-classless-wildcard/src/coa/AscensionStormbringerIonicAura.cpp
// Upstream Git blob: e94f051097e5adac3b98f2832a53df04609bda93.
#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "Unit.h"
#include "Util.h"

namespace
{
enum IonicAuraSpells : uint32
{
    IonicAura = 707652
};

bool IsEnabledHeroSource(Unit const* source)
{
    if (!source || !sClasslessMgr->cfg.enabled || !sClasslessMgr->cfg.coaEnable)
        return false;

    Player* owner = source->GetCharmerOrOwnerPlayerOrPlayerItself();
    return owner && sClasslessMgr->IsParticipant(owner) && !sClasslessMgr->IsExempt(owner) &&
        HasCoAKit(owner, CLASS_STORMBRINGER);
}

class aura_ascension_ionic_aura : public AuraScript
{
    PrepareAuraScript(aura_ascension_ionic_aura);

    bool _heroSourceApplied = false;

    void Apply(AuraEffect const* effect, AuraEffectHandleModes)
    {
        _heroSourceApplied = IsEnabledHeroSource(GetCaster());
        if (!_heroSourceApplied)
            return;

        Unit* target = GetTarget();
        for (Powers power : {POWER_FOCUS, POWER_ENERGY, POWER_RUNIC_POWER})
            target->ApplyStatPctModifier(UnitMods(static_cast<uint16>(UNIT_MOD_POWER_START) + power),
                TOTAL_PCT, float(effect->GetAmount()));
    }

    void Remove(AuraEffect const* effect, AuraEffectHandleModes)
    {
        if (!_heroSourceApplied)
            return;

        Unit* target = GetTarget();
        for (Powers power : {POWER_FOCUS, POWER_ENERGY, POWER_RUNIC_POWER})
        {
            float multiplier = target->GetTotalAuraMultiplierByMiscValue(SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT, power);
            for (AuraEffect const* applied : target->GetAuraEffectsByType(SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT))
                if (applied != effect && applied->GetId() == IonicAura && applied->GetMiscValue() == POWER_MANA)
                    AddPct(multiplier, applied->GetAmount());

            target->SetStatPctModifier(UnitMods(static_cast<uint16>(UNIT_MOD_POWER_START) + power),
                TOTAL_PCT, multiplier);
        }
        _heroSourceApplied = false;
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_ionic_aura::Apply,
            EFFECT_0, SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_ionic_aura::Remove,
            EFFECT_0, SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT, AURA_EFFECT_HANDLE_REAL);
    }
};
}

void AddSC_AscensionStormbringerIonicAura()
{
    RegisterSpellScript(aura_ascension_ionic_aura);
}
