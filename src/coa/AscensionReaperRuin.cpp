/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Hero-only adaptation from STRHercules/EsteriaWoW commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream commit author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
bool IsEnabledHero(Unit const* unit)
{
    return HasCoAKit(unit, CLASS_REAPER);
}

constexpr uint32 SPELL_RUIN_TALENT = 805198;
constexpr uint32 SPELL_RUIN = 805199;

class spell_ascension_reaper_ruin_mark : public SpellScript
{
    PrepareSpellScript(spell_ascension_reaper_ruin_mark);

    void MarkTarget(SpellEffIndex)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!IsEnabledHero(caster) || !target || !caster->HasAura(SPELL_RUIN_TALENT))
            return;

        caster->CastSpell(target, SPELL_RUIN, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ascension_reaper_ruin_mark::MarkTarget,
            EFFECT_0, SPELL_EFFECT_ANY);
    }
};
}

void AddSC_AscensionReaperRuin()
{
    RegisterSpellScript(spell_ascension_reaper_ruin_mark);
}
