/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of Crushing Earth armor-penetration scaling.

#include "CoAPort.h"
#include "SpellScript.h"
#include "SpellInfo.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "Unit.h"

namespace
{
enum CrushingEarthSpells : uint32
{
    CrushingEarth = 300697,
    CrushingEarthPower = 301353
};

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class aura_ascension_crushing_earth : public AuraScript
{
    PrepareAuraScript(aura_ascension_crushing_earth);

    bool Validate(SpellInfo const* info) override
    {
        return info->Id == CrushingEarth && ValidateSpellInfo({CrushingEarthPower});
    }

    bool Load() override
    {
        Unit* owner = GetUnitOwner();
        Player* player = GetPrimalistHero(owner);
        return player && GetCasterGUID() == player->GetGUID();
    }

    void Update(AuraEffect const* effect)
    {
        Player* player = GetTarget()->ToPlayer();
        if (!player || !player->IsInWorld() || !player->IsAlive())
            return;
        int32 amount = int32(player->GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_ARMOR_PENETRATION) / 2);
        player->CastCustomSpell(CrushingEarthPower, SPELLVALUE_BASE_POINT0, amount, player,
            TRIGGERED_FULL_MASK, nullptr, effect);
    }

    void Apply(AuraEffect const* effect, AuraEffectHandleModes)
    {
        Update(effect);
    }

    void Tick(AuraEffect const* effect)
    {
        PreventDefaultAction();
        Update(effect);
    }

    void Remove(AuraEffect const*, AuraEffectHandleModes)
    {
        GetTarget()->RemoveAurasDueToSpell(CrushingEarthPower, GetTarget()->GetGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_crushing_earth::Apply,
            EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(aura_ascension_crushing_earth::Tick,
            EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_crushing_earth::Remove,
            EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};
}

void AddSC_AscensionPrimalistCrushingEarth()
{
    RegisterSpellScript(aura_ascension_crushing_earth);
}
