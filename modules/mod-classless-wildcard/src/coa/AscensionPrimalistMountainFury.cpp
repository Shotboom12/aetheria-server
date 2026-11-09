/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "DBCStores.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>
#include <limits>

namespace
{
enum MountainSpells : uint32
{
    MountainFury = 806185,
    MountainFuryCone = 807724,
    MountainFuryHit = 806186,
    MountainFuryDefense = 807434
};

bool IsEnabledPrimalist(Player const* player)
{
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

class primalist_mountain_metadata : public GlobalScript
{
public:
    primalist_mountain_metadata() : GlobalScript("primalist_mountain_metadata",
        {GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR}) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (!sClasslessMgr->cfg.enabled || !sClasslessMgr->cfg.coaEnable || !info || info->SpellFamilyName != 37)
            return;

        if (info->Id == MountainFuryCone && info->Effects[EFFECT_0].Effect == SPELL_EFFECT_TRIGGER_SPELL &&
            info->Effects[EFFECT_0].TargetA.GetTarget() == TARGET_UNIT_CONE_ENEMY_54 &&
            info->Effects[EFFECT_0].TargetB.GetTarget() == Targets(0) &&
            info->Effects[EFFECT_0].TriggerSpell == MountainFuryHit && !info->Effects[EFFECT_0].RadiusEntry &&
            sSpellRadiusStore.LookupEntry(13) &&
            info->Effects[EFFECT_1].Effect == 0 && info->Effects[EFFECT_2].Effect == 0)
            info->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(13);

        if (info->Id == MountainFury && info->Effects[EFFECT_0].Effect == SPELL_EFFECT_TRIGGER_SPELL &&
            info->Effects[EFFECT_0].TriggerSpell == MountainFuryCone &&
            info->Effects[EFFECT_1].Effect == SPELL_EFFECT_TRIGGER_SPELL &&
            info->Effects[EFFECT_1].TriggerSpell == MountainFuryDefense &&
            info->Effects[EFFECT_0].TargetA.GetTarget() == Targets(1) &&
            info->Effects[EFFECT_1].TargetA.GetTarget() == Targets(1) &&
            info->Effects[EFFECT_0].TargetB.GetTarget() == Targets(0) &&
            info->Effects[EFFECT_1].TargetB.GetTarget() == Targets(0) &&
            info->Effects[EFFECT_2].Effect == 0)
        {
            info->Effects[EFFECT_1].Effect = 0;
            info->_InitializeExplicitTargetMask();
        }
    }
};

class primalist_mountain_scaling : public UnitScript
{
public:
    primalist_mountain_scaling() : UnitScript("primalist_mountain_scaling", true,
        {UNITHOOK_MODIFY_SPELL_EFFECT_BASE_VALUE}) { }

    void ModifySpellEffectBaseValue(Unit const* caster, SpellInfo const* info, uint8 index, float& value) override
    {
        Player const* player = caster ? caster->ToPlayer() : nullptr;
        if (!IsEnabledPrimalist(player) || !info || info->SpellFamilyName != 37 ||
            info->Id != MountainFuryHit || index != EFFECT_1 || info->Effects[index].Effect != SPELL_EFFECT_SCHOOL_DAMAGE)
            return;

        value = std::clamp(value + player->GetStat(STAT_STAMINA) * 1.25f,
            -float(std::numeric_limits<int32>::max() / 2), float(std::numeric_limits<int32>::max() / 2));
    }
};

class spell_ascension_mountain_fury_pull : public SpellScript
{
    PrepareSpellScript(spell_ascension_mountain_fury_pull);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({MountainFuryDefense}); }

    bool Load() override { return IsEnabledPrimalist(GetCaster() ? GetCaster()->ToPlayer() : nullptr); }

    void Defend(SpellEffIndex)
    {
        Unit* owner = GetCaster();
        Unit* target = GetHitUnit();
        if (owner && owner->IsAlive() && target && target->IsAlive() && GetExplTargetDest() &&
            owner->IsValidAttackTarget(target))
            owner->CastSpell(owner, MountainFuryDefense, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ascension_mountain_fury_pull::Defend,
            EFFECT_0, SPELL_EFFECT_PULL_TOWARDS_DEST);
    }
};
}

void AddSC_AscensionPrimalistMountainFury()
{
    new primalist_mountain_metadata();
    new primalist_mountain_scaling();
    RegisterSpellScript(spell_ascension_mountain_fury_pull);
}