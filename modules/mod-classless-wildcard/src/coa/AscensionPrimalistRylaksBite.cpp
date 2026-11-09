/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream commit author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"

namespace
{
enum RylaksBiteSpells : uint32
{
    RylaksBiteCharge = 707293
};

class spell_ascension_rylaks_bite : public SpellScript
{
    PrepareSpellScript(spell_ascension_rylaks_bite);

    void Rush()
    {
        Unit* caster = GetCaster();
        Player* player = caster ? caster->ToPlayer() : nullptr;
        Unit* target = GetExplTargetUnit();
        if (!player || player->getClass() != CLASS_HERO || !target || !sClasslessMgr->cfg.enabled ||
            !sClasslessMgr->cfg.coaEnable || !HasCoAKit(player, CLASS_WILDWALKER))
            return;

        caster->CastSpell(target, RylaksBiteCharge, true);
        if (Pet* pet = player->GetPet(); pet && pet->IsAlive())
            pet->CastSpell(target, RylaksBiteCharge, true);
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_ascension_rylaks_bite::Rush);
    }
};
}

void AddSC_AscensionPrimalistRylaksBite()
{
    RegisterSpellScript(spell_ascension_rylaks_bite);
}
