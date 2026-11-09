/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of Boulder Dash's cast lock.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "Unit.h"

namespace
{
enum BoulderSpells : uint32
{
    BoulderDash = 500692
};

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class primalist_boulder_cast_lock : public AllSpellScript
{
public:
    primalist_boulder_cast_lock() : AllSpellScript("primalist_boulder_cast_lock",
        {ALLSPELLHOOK_ON_SPELL_CHECK_CAST}) { }

    void OnSpellCheckCast(Spell* spell, bool, SpellCastResult& result) override
    {
        Unit* caster = spell->GetCaster()->ToUnit();
        Player* player = GetPrimalistHero(caster);
        if (player && !spell->IsTriggered() && player->HasAura(BoulderDash, player->GetGUID()))
            result = SPELL_FAILED_SPELL_IN_PROGRESS;
    }
};
}

void AddSC_AscensionPrimalistBoulder()
{
    new primalist_boulder_cast_lock();
}
