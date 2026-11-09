/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of the general Primalist talent event hooks.

#include "CoAPort.h"
#include "SpellScript.h"
#include "SpellMgr.h"
#include "SpellInfo.h"
#include "SpellAuraEffects.h"
#include "Spell.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "Unit.h"

namespace
{
constexpr uint32 SurvivalTalent = 560157;
constexpr uint32 SurvivalEffect = 560179;
constexpr uint32 AuraRemovalTalent = 300728;
constexpr uint32 AuraRemovalEffect = 503716;

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO &&
        HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class primalist_talent_events : public UnitScript
{
public:
    primalist_talent_events() : UnitScript("primalist_talent_events", true,
        {UNITHOOK_ON_DAMAGE, UNITHOOK_ON_AURA_REMOVE}) { }

    void OnDamage(Unit*, Unit* victim, uint32& damage) override
    {
        Player* player = GetPrimalistHero(victim);
        if (!player || !player->IsAlive() || !damage || damage < player->GetHealth() ||
            !player->HasAura(SurvivalTalent, player->GetGUID()) || player->HasSpellCooldown(SurvivalTalent))
            return;

        player->AddSpellCooldown(SurvivalTalent, 0, 120000);
        damage = 0;
        player->CastSpell(player, SurvivalEffect, TRIGGERED_FULL_MASK);
    }

    void OnAuraRemove(Unit* unit, AuraApplication* application, AuraRemoveMode mode) override
    {
        Player* player = GetPrimalistHero(unit);
        if (!player || !player->IsAlive() || !player->IsInWorld() || !application ||
            mode == AURA_REMOVE_BY_DEATH || !player->HasAura(AuraRemovalTalent, player->GetGUID()))
            return;

        Aura* aura = application->GetBase();
        if (!aura || aura->GetCasterGUID() != player->GetGUID())
            return;

        if (aura->GetId() == 680421 || aura->GetId() == 800094 || aura->GetId() == 503630)
            player->CastSpell(player, AuraRemovalEffect, TRIGGERED_FULL_MASK);
    }
};
}

void AddSC_AscensionPrimalistTalentEvents()
{
    new primalist_talent_events();
}
