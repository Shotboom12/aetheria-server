/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of the Primalist Ancient of War transform helper.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"

namespace
{
constexpr uint32 AncientMovement = 504369;

class aura_ascension_ancient_war : public AuraScript
{
    PrepareAuraScript(aura_ascension_ancient_war);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({AncientMovement}); }

    void Apply(AuraEffect const* effect, AuraEffectHandleModes)
    {
        Player* player = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        if (player && player->getClass() == CLASS_HERO && GetCaster() == player &&
            HasCoAKit(player, CLASS_WILDWALKER))
            player->CastSpell(player, AncientMovement, TRIGGERED_FULL_MASK, nullptr, effect);
    }

    void Remove(AuraEffect const*, AuraEffectHandleModes)
    {
        Player* player = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        if (player && player->getClass() == CLASS_HERO)
            player->RemoveAurasDueToSpell(AncientMovement, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_ancient_war::Apply,
            EFFECT_2, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_ancient_war::Remove,
            EFFECT_2, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
    }
};
}

void AddSC_AscensionPrimalistAncientWar()
{
    RegisterSpellScript(aura_ascension_ancient_war);
}
