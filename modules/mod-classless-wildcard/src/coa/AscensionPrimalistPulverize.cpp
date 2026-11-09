/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
enum PulverizeSpells : uint32
{
    TotemicSmash = 800178,
    Pulverize = 301087,
    SmashArea = 500945
};

bool IsEnabledPrimalist(Player const* player)
{
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

class primalist_pulverize_metadata : public GlobalScript
{
public:
    primalist_pulverize_metadata() : GlobalScript("primalist_pulverize_metadata",
        {GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR}) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (!sClasslessMgr->cfg.enabled || !sClasslessMgr->cfg.coaEnable || !info || info->Id != SmashArea ||
            info->SpellFamilyName != 37 || info->Effects[EFFECT_0].Effect != SPELL_EFFECT_SCHOOL_DAMAGE ||
            info->Effects[EFFECT_0].TargetA.GetTarget() != TARGET_DEST_DEST ||
            info->Effects[EFFECT_0].TargetB.GetTarget() != Targets(0) ||
            info->Effects[EFFECT_0].RadiusEntry == nullptr || info->Effects[EFFECT_1].Effect != 0 ||
            info->Effects[EFFECT_2].Effect != 0)
            return;

        info->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        info->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENEMY);
        info->_InitializeExplicitTargetMask();
    }
};

class primalist_pulverize : public AllSpellScript
{
public:
    primalist_pulverize() : AllSpellScript("primalist_pulverize", {ALLSPELLHOOK_ON_HIT_RESULT}) { }

    void OnSpellHitResult(Spell* spell, Unit* target, uint8 miss, uint32 damage, uint32, bool critical) override
    {
        if (!spell || !target)
            return;
        Unit* caster = spell->GetCaster()->ToUnit();
        Player* player = caster ? caster->ToPlayer() : nullptr;
        SpellInfo const* info = spell->GetSpellInfo();
        if (!IsEnabledPrimalist(player) || !player->IsAlive() || !info || info->SpellFamilyName != 37 ||
            sSpellMgr->GetFirstSpellInChain(info->Id) != TotemicSmash || miss != SPELL_MISS_NONE || !damage ||
            !critical || target != spell->m_targets.GetUnitTarget() ||
            !player->HasAura(Pulverize, player->GetGUID()) || spell->GetScriptValue(Pulverize))
            return;

        spell->SetScriptValue(Pulverize, 1);
        int32 base = spell->CalculateSpellDamage(EFFECT_1, target);
        CustomSpellValues values;
        values.AddSpellMod(SPELLVALUE_BASE_POINT0, base);
        SpellCastTargets targets;
        targets.SetDst(target->GetPosition());
        player->CastSpell(targets, sSpellMgr->GetSpellInfo(SmashArea), &values, TRIGGERED_FULL_MASK);
    }
};
}

void AddSC_AscensionPrimalistPulverize()
{
    new primalist_pulverize_metadata();
    new primalist_pulverize();
}