/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

#include "CoAPort.h"
#include "SpellAuras.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
enum DreamslipSpells : uint32
{
    Dreamslip = 805867,
    RapidRegeneration = 804315
};

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class aura_ascension_dreamslip : public AuraScript
{
    PrepareAuraScript(aura_ascension_dreamslip);

    bool Load() override
    {
        Player* owner = GetPrimalistHero(GetTarget());
        return owner && GetCasterGUID() == owner->GetGUID();
    }

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({RapidRegeneration}); }

    void Periodic(AuraEffect const*, bool& periodic, int32& amplitude)
    {
        periodic = true;
        amplitude = GetSpellInfo()->Effects[EFFECT_1].Amplitude;
    }

    void Recover(AuraEffect const* effect)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), RapidRegeneration, TRIGGERED_FULL_MASK, nullptr, effect);
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(aura_ascension_dreamslip::Periodic,
            EFFECT_1, SPELL_AURA_MOD_PACIFY_SILENCE);
        OnEffectPeriodic += AuraEffectPeriodicFn(aura_ascension_dreamslip::Recover,
            EFFECT_1, SPELL_AURA_MOD_PACIFY_SILENCE);
    }
};
}

void AddSC_AscensionPrimalistDreamslip()
{
    RegisterSpellScript(aura_ascension_dreamslip);
}
