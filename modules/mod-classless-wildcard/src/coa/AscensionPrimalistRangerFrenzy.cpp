/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "SpellMgr.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "Spell.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
constexpr uint32 Frenzy = 520492;
constexpr uint32 WornOut = 804457;

class spell_ascension_ranger_frenzy_hero : public SpellScript
{
    PrepareSpellScript(spell_ascension_ranger_frenzy_hero);

    bool Validate(SpellInfo const* spellInfo) override
    {
        SpellEffectInfo const& wornOut = spellInfo->Effects[EFFECT_2];
        return spellInfo->Id == Frenzy && wornOut.Effect == SPELL_EFFECT_TRIGGER_SPELL &&
            wornOut.TriggerSpell == WornOut && ValidateSpellInfo({WornOut});
    }

    void SkipWornOut(std::list<WorldObject*>& targets)
    {
        Player* player = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        if (!player || !HasCoAKit(player, CLASS_RANGER))
            return;

        targets.remove_if([](WorldObject* target)
        {
            Unit* unit = target ? target->ToUnit() : nullptr;
            return !unit || unit->HasAura(WornOut);
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(
            spell_ascension_ranger_frenzy_hero::SkipWornOut, EFFECT_0, TARGET_UNIT_CASTER_AREA_RAID);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(
            spell_ascension_ranger_frenzy_hero::SkipWornOut, EFFECT_1, TARGET_UNIT_CASTER_AREA_RAID);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(
            spell_ascension_ranger_frenzy_hero::SkipWornOut, EFFECT_2, TARGET_UNIT_CASTER_AREA_RAID);
    }
};
}

void AddSC_AscensionPrimalistRangerFrenzy()
{
    RegisterSpellScript(spell_ascension_ranger_frenzy_hero);
}
