/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>
#include <limits>

namespace
{
enum EarthmotherRoarSpells : uint32
{
    EarthmotherRoar = 301306,
    EarthmotherHeal = 301307
};

bool IsEnabledPrimalist(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

class spell_ascension_earthmother_roar : public SpellScript
{
    PrepareSpellScript(spell_ascension_earthmother_roar);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({EarthmotherHeal}); }

    bool Load() override { return IsEnabledPrimalist(GetCaster()); }

    void Heal()
    {
        Unit* caster = GetCaster();
        if (IsEnabledPrimalist(caster) && caster->HasAura(EarthmotherRoar, caster->GetGUID()))
            caster->CastSpell(caster, EarthmotherHeal, TRIGGERED_FULL_MASK);
    }

    void Register() override { AfterCast += SpellCastFn(spell_ascension_earthmother_roar::Heal); }
};

class spell_ascension_earthmother_missing_health : public SpellScript
{
    PrepareSpellScript(spell_ascension_earthmother_missing_health);

    bool Load() override { return IsEnabledPrimalist(GetCaster()) && GetSpellInfo()->Id == EarthmotherHeal; }

    void Amount(SpellEffIndex)
    {
        Unit* target = GetHitUnit();
        if (!target)
            return;
        uint64 missing = target->GetMaxHealth() - std::min(target->GetHealth(), target->GetMaxHealth());
        uint64 amount = missing * std::clamp(GetEffectValue(), 0, 100) / 100;
        SetEffectValue(int32(std::min<uint64>(amount, std::numeric_limits<int32>::max())));
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_ascension_earthmother_missing_health::Amount,
            EFFECT_0, SPELL_EFFECT_HEAL);
    }
};

class primalist_earthmother_roar_metadata : public GlobalScript
{
public:
    primalist_earthmother_roar_metadata() : GlobalScript("primalist_earthmother_roar_metadata",
        {GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR}) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (sClasslessMgr->cfg.enabled && sClasslessMgr->cfg.coaEnable && info && info->Id == EarthmotherHeal &&
            info->SpellFamilyName == 37 && info->Effects[EFFECT_0].Effect == SPELL_EFFECT_HEAL_PCT &&
            info->Effects[EFFECT_0].BasePoints == 19 && info->Effects[EFFECT_0].TargetA.GetTarget() == Targets(56) &&
            info->Effects[EFFECT_0].TargetB.GetTarget() == Targets(0) && info->Effects[EFFECT_0].MiscValueB == 1)
            info->Effects[EFFECT_0].Effect = SPELL_EFFECT_HEAL;
    }
};
}

void AddSC_AscensionPrimalistEarthmotherRoar()
{
    new primalist_earthmother_roar_metadata();
    RegisterSpellScript(spell_ascension_earthmother_roar);
    RegisterSpellScript(spell_ascension_earthmother_missing_health);
}