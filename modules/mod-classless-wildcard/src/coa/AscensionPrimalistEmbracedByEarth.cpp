/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused adaptation of the Secondary package's Earth's Embrace expiration hook.

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
constexpr uint32 EarthsEmbrace = 806143;
constexpr uint32 EmbracedByEarth = 561037;
constexpr uint32 EmbraceDisorient = 706200;

class primalist_earths_embrace_expiration : public UnitScript
{
public:
    primalist_earths_embrace_expiration() : UnitScript("primalist_earths_embrace_expiration", true,
        {UNITHOOK_ON_AURA_REMOVE}) { }

    void OnAuraRemove(Unit* unit, AuraApplication* application, AuraRemoveMode mode) override
    {
        Player* player = unit ? unit->ToPlayer() : nullptr;
        if (!player || player->getClass() != CLASS_HERO || !HasCoAKit(player, CLASS_WILDWALKER) ||
            !application || mode != AURA_REMOVE_BY_EXPIRE)
            return;

        Aura* aura = application->GetBase();
        if (!aura || aura->GetId() != EarthsEmbrace || aura->GetCasterGUID() != player->GetGUID() ||
            !player->IsAlive() || !player->IsInWorld() ||
            !player->HasAura(EmbracedByEarth, player->GetGUID()))
            return;

        player->CastSpell(player, EmbraceDisorient, true);
    }
};
}

void AddSC_AscensionPrimalistEmbracedByEarth()
{
    new primalist_earths_embrace_expiration();
}
