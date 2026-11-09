/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream commit author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"
#include <algorithm>
#include <cstdint>

namespace
{
constexpr uint32 AnimaAmbusher = 705424;
constexpr uint32 AnimaAmbush = 705425;

bool IsEnabledHero(Unit const* unit)
{
    return HasCoAKit(unit, CLASS_REAPER);
}

class spell_ascension_reaper_anima_ambusher : public SpellScript
{
    PrepareSpellScript(spell_ascension_reaper_anima_ambusher);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({AnimaAmbusher, AnimaAmbush}); }

    void Ambush()
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        int32 const damage = GetHitDamage();
        if (!IsEnabledHero(caster) || !target || damage <= 0 || !target->IsAlive() ||
            !caster->HasAura(AnimaAmbusher))
            return;

        int32 const tickPercent = sSpellMgr->AssertSpellInfo(AnimaAmbusher)->Effects[EFFECT_0].CalcValue(caster);
        int64 const tickDamage = int64(damage) * tickPercent / 100;
        if (tickDamage <= 0)
            return;

        caster->CastCustomSpell(AnimaAmbush, SPELLVALUE_BASE_POINT0,
            int32(std::min<int64>(tickDamage, INT32_MAX)), target, true);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_ascension_reaper_anima_ambusher::Ambush);
    }
};
}

void AddSC_AscensionReaperAnimaAmbusher()
{
    RegisterSpellScript(spell_ascension_reaper_anima_ambusher);
}
