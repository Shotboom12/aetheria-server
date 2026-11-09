/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "Unit.h"

namespace
{
enum SeismicResourceSpells : uint32
{
    SeismicCrash = 803981,
    SeismicSpike = 804433,
    CrashRage = 681355,
    SpikeRage = 681356
};

Player* PrimalistCaster(Spell* spell)
{
    if (!spell || spell->IsTriggered() || !spell->GetSpellInfo() || spell->GetSpellInfo()->SpellFamilyName != 37)
        return nullptr;

    Unit* caster = spell->GetCaster()->ToUnit();
    Player* player = caster ? caster->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER) && player->IsAlive() ? player : nullptr;
}

class primalist_seismic_resources : public AllSpellScript
{
public:
    primalist_seismic_resources() : AllSpellScript("primalist_seismic_resources",
        {ALLSPELLHOOK_ON_CAST, ALLSPELLHOOK_ON_HIT_RESULT}) { }

    void OnSpellCast(Spell* spell, Unit*, SpellInfo const* info, bool) override
    {
        Player* player = PrimalistCaster(spell);
        SpellInfo const* firstRank = info ? info->GetFirstRankSpell() : nullptr;
        if (player && firstRank && firstRank->Id == SeismicCrash)
            player->CastSpell(player, CrashRage, true);
    }

    void OnSpellHitResult(Spell* spell, Unit* target, uint8 miss, uint32, uint32, bool) override
    {
        Player* player = PrimalistCaster(spell);
        SpellInfo const* info = spell ? spell->GetSpellInfo() : nullptr;
        SpellInfo const* firstRank = info ? info->GetFirstRankSpell() : nullptr;
        if (!player || !target || target == player || player->IsFriendlyTo(target) || miss != SPELL_MISS_NONE ||
            !firstRank || firstRank->Id != SeismicSpike)
            return;

        player->CastSpell(player, SpikeRage, true);
    }
};
}

void AddSC_AscensionPrimalistSeismicResources()
{
    new primalist_seismic_resources();
}
