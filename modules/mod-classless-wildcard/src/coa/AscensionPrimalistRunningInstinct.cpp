/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
enum RunningInstinctSpells : uint32
{
    RunningInstinct = 300744,
    RunningInstinctHeal = 301203,
    RunningInstinctDamage = 572029
};

bool IsEnabledPrimalist(Player const* player)
{
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

class spell_ascension_running_instinct : public SpellScript
{
    PrepareSpellScript(spell_ascension_running_instinct);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({RunningInstinctHeal}); }

    bool Load() override { return IsEnabledPrimalist(GetCaster() ? GetCaster()->ToPlayer() : nullptr); }

    void Heal()
    {
        Unit* caster = GetCaster();
        if (IsEnabledPrimalist(caster ? caster->ToPlayer() : nullptr) &&
            caster->HasAura(RunningInstinct, caster->GetGUID()))
            caster->CastSpell(caster, RunningInstinctHeal, TRIGGERED_FULL_MASK);
    }

    void Register() override { OnCast += SpellCastFn(spell_ascension_running_instinct::Heal); }
};

class spell_ascension_running_instinct_heal : public SpellScript
{
    PrepareSpellScript(spell_ascension_running_instinct_heal);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({RunningInstinctDamage}); }

    bool Load() override
    {
        return GetSpellInfo() && GetSpellInfo()->Id == RunningInstinctHeal &&
            IsEnabledPrimalist(GetCaster() ? GetCaster()->ToPlayer() : nullptr);
    }

    void Filter(std::list<WorldObject*>& targets)
    {
        targets.remove(GetCaster());
    }

    void Stack(SpellEffIndex)
    {
        Unit* caster = GetCaster();
        if (GetHitUnit() && IsEnabledPrimalist(caster ? caster->ToPlayer() : nullptr) &&
            caster->HasAura(RunningInstinct, caster->GetGUID()))
            caster->CastSpell(caster, RunningInstinctDamage, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_ascension_running_instinct_heal::Filter,
            EFFECT_0, TARGET_UNIT_CONE_ALLY);
        OnEffectHitTarget += SpellEffectFn(spell_ascension_running_instinct_heal::Stack,
            EFFECT_0, SPELL_EFFECT_HEAL);
    }
};

class primalist_running_instinct_metadata : public GlobalScript
{
public:
    primalist_running_instinct_metadata() : GlobalScript("primalist_running_instinct_metadata",
        {GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR}) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (!sClasslessMgr->cfg.enabled || !sClasslessMgr->cfg.coaEnable || !info || info->SpellFamilyName != 37)
            return;

        if (info->Id == RunningInstinctHeal && info->Effects[EFFECT_0].Effect == SPELL_EFFECT_HEAL &&
            info->Effects[EFFECT_0].TargetA.GetTarget() == TARGET_UNIT_CONE_ALLY &&
            info->Effects[EFFECT_0].TargetB.GetTarget() == Targets(0) &&
            info->Effects[EFFECT_0].DieSides == 6 && info->Effects[EFFECT_0].BasePoints == 49 &&
            info->Effects[EFFECT_0].RadiusEntry && info->Effects[EFFECT_0].SpellClassMask == flag96(0, 0, 0))
            info->AttributesCu |= SPELL_ATTR0_CU_CONE_LINE;
        else if (info->Id == RunningInstinctDamage &&
            info->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
            info->Effects[EFFECT_0].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) &&
            info->Effects[EFFECT_0].SpellClassMask == flag96(524304, 258, 0) &&
            info->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
            info->Effects[EFFECT_1].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) &&
            info->Effects[EFFECT_1].SpellClassMask == flag96(0, 4194304, 0) &&
            info->Effects[EFFECT_2].Effect == 0)
        {
            info->Effects[EFFECT_0].SpellClassMask[0] |= 65;
            info->Effects[EFFECT_0].SpellClassMask[2] |= 263168;
            info->Effects[EFFECT_1].SpellClassMask[0] |= 64;
            info->Effects[EFFECT_1].SpellClassMask[2] |= 256;
        }
    }
};
}

void AddSC_AscensionPrimalistRunningInstinct()
{
    new primalist_running_instinct_metadata();
    RegisterSpellScript(spell_ascension_running_instinct);
    RegisterSpellScript(spell_ascension_running_instinct_heal);
}