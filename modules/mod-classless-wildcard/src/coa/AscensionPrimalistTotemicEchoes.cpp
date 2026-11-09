/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "ScriptMgr.h"
#include "Unit.h"

namespace
{
enum TotemicEchoesSpells : uint32
{
    TotemicEchoes = 500937,
    TotemicSmash = 800178
};

bool IsEnabledPrimalist(Player const* player)
{
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

class aura_ascension_totemic_echoes : public AuraScript
{
    PrepareAuraScript(aura_ascension_totemic_echoes);

    bool Load() override
    {
        Player* caster = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        return IsEnabledPrimalist(caster) && GetCasterGUID() == caster->GetGUID();
    }

    void Tick(AuraEffect const*) { PreventDefaultAction(); }

    void Expire(AuraEffect const*, AuraEffectHandleModes)
    {
        Player* caster = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        Unit* target = GetTarget();
        if (!GetTargetApplication() || GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE ||
            !IsEnabledPrimalist(caster) || !caster->IsAlive() || !target || !target->IsAlive() ||
            !caster->HasAura(TotemicEchoes, caster->GetGUID()) || !caster->IsWithinDistInMap(target, 5.0f) ||
            !caster->IsValidAttackTarget(target))
            return;

        uint32 highest = 0;
        for (uint32 rank = TotemicSmash; rank; rank = sSpellMgr->GetNextSpellInChain(rank))
            if (caster->HasSpell(rank))
                highest = rank;
        if (highest)
            caster->CastSpell(target, highest, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(aura_ascension_totemic_echoes::Tick,
            EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_totemic_echoes::Expire,
            EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};
}

void AddSC_AscensionPrimalistTotemicEchoes()
{
    RegisterSpellScript(aura_ascension_totemic_echoes);
}