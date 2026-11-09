/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, pinned commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream author: Zachary Kaiser.

#include "AscensionCustomResourceData.h"
#include "AscensionPrimalistEarthquake.h"
#include "AscensionPrimalistEarthshaping.h"
#include "AscensionPrimalistSpiritBeast.h"
#include "AscensionPrimalistWeapons.h"
#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Creature.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Unit.h"

void AddSC_AscensionPrimalistHeavyEarth();
void AddSC_AscensionPrimalistRangerFrenzy();
void AddSC_AscensionPrimalistEarthshaker();
void AddSC_AscensionPrimalistRunningInstinct();
void AddSC_AscensionPrimalistPowerHammer();
void AddSC_AscensionPrimalistTalentEvents();
void AddSC_AscensionPrimalistEmeraldWill();
void AddSC_AscensionPrimalistTotemicEchoes();
void AddSC_AscensionPrimalistPendant();
void AddSC_AscensionPrimalistThorns();
void AddSC_AscensionPrimalistBloodyClaws();
void AddSC_AscensionPrimalistJudgement();
void AddSC_AscensionPrimalistShattering();
void AddSC_AscensionPrimalistVerdantChase();
void AddSC_AscensionPrimalistJourney();
void AddSC_AscensionPrimalistQuakingThane();
void AddSC_AscensionPrimalistTremors();
void AddSC_AscensionPrimalistCataclysm();
void AddSC_AscensionPrimalistEarthsGuidance();
void AddSC_AscensionPrimalistBramblepatch();
void AddSC_AscensionPrimalistPrimalStrikes();
void AddSC_AscensionPrimalistLithicLance();
void AddSC_AscensionPrimalistEmpoweredBoons();
void AddSC_AscensionPrimalistDruidTraining();
void AddSC_AscensionPrimalistSpiritualFrenzy();
void AddSC_AscensionPrimalistPhysicalCrit();
void AddSC_AscensionPrimalistRipsAndTears();
void AddSC_AscensionPrimalistMountainAvatar();
void AddSC_AscensionPrimalistRylaksBite();
void AddSC_AscensionPrimalistRylaksBlessing();
void AddSC_AscensionPrimalistWildheart();
void AddSC_AscensionPrimalistDreamslip();
void AddSC_AscensionPrimalistNeptulonWrath();
void AddSC_AscensionPrimalistSacredGrove();
void AddSC_AscensionPrimalistAncientWar();
void AddSC_AscensionPrimalistEarthmotherRoar();
void AddSC_AscensionPrimalistCrushingEarth();
void AddSC_AscensionPrimalistSpiritBeast();
void AddSC_AscensionPrimalistWeapons();
void AddSC_AscensionPrimalistTalents();
void AddSC_AscensionPrimalistBones();
void AddSC_AscensionPrimalistBoons();
void AddSC_AscensionPrimalistSeismicResources();
void AddSC_AscensionPrimalistGuidance();
void AddSC_AscensionPrimalistBarrier();
void AddSC_AscensionPrimalistMountainFury();
void AddSC_AscensionPrimalistBoulder();
void AddSC_AscensionPrimalistUrsoc();
void AddSC_AscensionPrimalistTorn();
void AddSC_AscensionPrimalistRexxarMight();
void AddSC_AscensionPrimalistLifeSpirit();
void AddSC_AscensionPrimalistTotem();
void AddSC_AscensionPrimalistTremor();
void AddSC_AscensionPrimalistPulverize();
void AddSC_AscensionPrimalistVitality();
void AddSC_AscensionPrimalistNaturalEfficiency();
void AddSC_AscensionPrimalistGeomancy();
void AddSC_AscensionPrimalistMountain();
void AddSC_AscensionPrimalistPeriodicCritical();
void AddSC_AscensionPrimalistSecondary();
void AddSC_AscensionPrimalistEmbracedByEarth();

namespace
{
enum PrimalistSpells : uint32
{
    SPELL_PRIMALIST_PET_TRAINING = 92148,
    SPELL_EARTHSHAPING = 680441,
    SPELL_STONESHARD_MODIFIER = 680846,
    SPELL_EARTHQUAKE_MODIFIER = 532562,
    SPELL_ERUPTION_MODIFIER = 680450,
    SPELL_PRIMAL_WEAPONS = 537218,
    SPELL_BESTIAL_MIGHT = 801242,
    SPELL_PRIMAL_MIGHT = 704098,
    SPELL_WILDCLAW_BONUS = 563262,
    SPELL_TALONFURY = 806070,
    SPELL_PET_TALONFURY = 806071
};

static_assert([]
{
    for (auto const& rule : AscensionCompatData::ResourceGainRules)
        if (rule.ClassId == CLASS_WILDWALKER &&
            (rule.Event != AscensionCompatData::ResourceGainEvent::Cast ||
             rule.ResourceSpellId != SPELL_EARTHSHAPING ||
             rule.Mutation != AscensionCompatData::ResourceMutation::AuraStacks || rule.Amount <= 0 ||
             rule.ForbiddenAuraSpellId || rule.ChancePercent != 100))
            return false;
    for (auto const& rule : AscensionCompatData::NativePowerGainRules)
        if (rule.ClassId == CLASS_WILDWALKER &&
            ((rule.Event != AscensionCompatData::ResourceGainEvent::EachSuccessfulDamagingHit &&
              rule.Event != AscensionCompatData::ResourceGainEvent::PeriodicDamageTick) ||
             rule.RequiredAuraSpellId || rule.ForbiddenAuraSpellId || rule.AmountSpellId))
            return false;
    return true;
}(), "Primalist resource rules need matching gain handlers");

bool PrimalistEnabled(Player const* player)
{
    return sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

void RemovePrimalistHelpers(Player* player)
{
    if (!player || player->getClass() != CLASS_HERO)
        return;
    for (uint32 id : {SPELL_BESTIAL_MIGHT, SPELL_PRIMAL_MIGHT, SPELL_WILDCLAW_BONUS, SPELL_TALONFURY,
        SPELL_EARTHSHAPING, SPELL_STONESHARD_MODIFIER, SPELL_EARTHQUAKE_MODIFIER, SPELL_ERUPTION_MODIFIER})
        player->RemoveAurasDueToSpell(id, player->GetGUID());
    if (Pet* pet = player->GetPet())
        pet->RemoveAurasDueToSpell(SPELL_PET_TALONFURY, player->GetGUID());
}

void ReconcilePrimalistWeapon(Player* player)
{
    if (!player || player->getClass() != CLASS_HERO)
        return;
    if (!PrimalistEnabled(player) || !player->IsAlive())
    {
        RemovePrimalistHelpers(player);
        return;
    }
    if (IsAscensionPrimalistWeaponsEligible(player, true))
    {
        ReconcileAscensionPrimalistWeapon(player);
        return;
    }

    // The copied helper requires kit ownership, but the last kit spell can already be gone here.
    for (uint32 id : {SPELL_BESTIAL_MIGHT, SPELL_PRIMAL_MIGHT, SPELL_WILDCLAW_BONUS, SPELL_TALONFURY})
        player->RemoveAurasDueToSpell(id, player->GetGUID());
    if (Pet* pet = player->GetPet())
        pet->RemoveAurasDueToSpell(SPELL_PET_TALONFURY, player->GetGUID());
}

bool IsHostilePrimalistTarget(Player const* player, Unit const* target)
{
    return player && target && PrimalistEnabled(player) && player != target && !player->IsFriendlyTo(target);
}

void GainPrimalistNativePower(Player* player, SpellInfo const* info, AscensionCompatData::ResourceGainEvent event)
{
    for (AscensionCompatData::NativePowerGainRule const& rule : AscensionCompatData::NativePowerGainRules)
        if (rule.ClassId == CLASS_WILDWALKER && rule.Event == event &&
            info->Id >= rule.FirstSpellId && info->Id <= rule.LastSpellId)
            player->ModifyPower(static_cast<Powers>(rule.PowerType), rule.InternalAmount);
}

class cw_coa_primalist_resources : public AllSpellScript
{
public:
    cw_coa_primalist_resources() : AllSpellScript("cw_coa_primalist_resources", {
        ALLSPELLHOOK_ON_CAST,
        ALLSPELLHOOK_ON_HIT_RESULT
    }) { }

    void OnSpellCast(Spell* spell, Unit* /*caster*/, SpellInfo const* info, bool /*skipCheck*/) override
    {
        if (!spell || spell->IsTriggered() || !info)
            return;
        Player* player = spell->GetCaster()->ToPlayer();
        if (!PrimalistEnabled(player))
            return;
        for (AscensionCompatData::ResourceGainRule const& rule : AscensionCompatData::ResourceGainRules)
        {
            if (rule.ClassId != CLASS_WILDWALKER || rule.Event != AscensionCompatData::ResourceGainEvent::Cast ||
                info->Id < rule.FirstSpellId || info->Id > rule.LastSpellId ||
                (rule.RequiredAuraSpellId && !player->HasAura(rule.RequiredAuraSpellId)))
                continue;
            if (HandleAscensionPrimalistEarthshapingGain(player))
                continue;
            if (Aura* aura = player->GetAura(rule.ResourceSpellId))
            {
                int32 const remaining = aura->GetDuration();
                aura->ModStackAmount(rule.Amount);
                aura->SetDuration(remaining);
            }
            else if (Aura* aura = player->AddAura(rule.ResourceSpellId, player); aura && rule.Amount > 1)
                aura->ModStackAmount(rule.Amount - 1);
        }
    }

    void OnSpellHitResult(Spell* spell, Unit* target, uint8 miss, uint32 damage, uint32 /*healing*/,
        bool /*critical*/) override
    {
        if (!spell || spell->IsTriggered() || miss != SPELL_MISS_NONE)
            return;
        Player* player = spell->GetCaster()->ToPlayer();
        SpellInfo const* info = spell->GetSpellInfo();
        if (!IsHostilePrimalistTarget(player, target) ||
            (!damage && !info->HasEffect(SPELL_EFFECT_SCHOOL_DAMAGE)))
            return;
        GainPrimalistNativePower(player, info, AscensionCompatData::ResourceGainEvent::EachSuccessfulDamagingHit);
    }
};

class cw_coa_primalist_periodic_resources : public UnitScript
{
public:
    cw_coa_primalist_periodic_resources() : UnitScript("cw_coa_primalist_periodic_resources", true,
        { UNITHOOK_ON_PERIODIC_DAMAGE_RESULT }) { }

    void OnPeriodicDamageResult(Unit* target, Unit* attacker, uint32 damage, SpellInfo const* info) override
    {
        if (!attacker || !info)
            return;
        Player* player = attacker->ToPlayer();
        if (!IsHostilePrimalistTarget(player, target))
            return;
        Creature const* creature = target->ToCreature();
        if (!damage && !(creature && creature->GetScriptName() == "npc_training_dummy"))
            return;
        GainPrimalistNativePower(player, info, AscensionCompatData::ResourceGainEvent::PeriodicDamageTick);
    }
};

class cw_coa_primalist_player : public PlayerScript
{
public:
    cw_coa_primalist_player() : PlayerScript("cw_coa_primalist_player", {
        PLAYERHOOK_ON_LOGIN,
        PLAYERHOOK_ON_LOGOUT,
        PLAYERHOOK_ON_PLAYER_JUST_DIED,
        PLAYERHOOK_ON_LEARN_SPELL,
        PLAYERHOOK_ON_FORGOT_SPELL,
        PLAYERHOOK_ON_LEVEL_CHANGED,
        PLAYERHOOK_ON_AFTER_SPEC_SLOT_CHANGED,
        PLAYERHOOK_ON_EQUIP,
        PLAYERHOOK_ON_UPDATE
    }) { }

    void OnPlayerLogin(Player* player) override
    {
        ReconcilePrimalistWeapon(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        RemovePrimalistHelpers(player);
    }

    void OnPlayerJustDied(Player* player) override
    {
        RemovePrimalistHelpers(player);
    }

    void OnPlayerLearnSpell(Player* player, uint32 spellId) override
    {
        if (spellId == SPELL_PRIMAL_WEAPONS)
            ReconcilePrimalistWeapon(player);
    }

    void OnPlayerForgotSpell(Player* player, uint32 /*spellId*/) override
    {
        ReconcilePrimalistWeapon(player);
    }

    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        ReconcilePrimalistWeapon(player);
    }

    void OnPlayerAfterSpecSlotChanged(Player* player, uint8 /*newSlot*/) override
    {
        ReconcilePrimalistWeapon(player);
    }

    void OnPlayerEquip(Player* player, Item* /*item*/, uint8 /*bag*/, uint8 /*slot*/, bool /*update*/) override
    {
        ReconcilePrimalistWeapon(player);
    }

    void OnPlayerUpdate(Player* player, uint32 /*diff*/) override
    {
        if (!player || player->getClass() != CLASS_HERO)
            return;
        // Ownership can be updated after the learn/forget hooks; also catch unequipping a weapon.
        if (player->HasAura(SPELL_BESTIAL_MIGHT) || player->HasAura(SPELL_PRIMAL_MIGHT) ||
            player->HasAura(SPELL_WILDCLAW_BONUS) || player->HasAura(SPELL_TALONFURY) ||
            player->HasAura(SPELL_EARTHSHAPING) || player->HasAura(SPELL_STONESHARD_MODIFIER) ||
            player->HasAura(SPELL_EARTHQUAKE_MODIFIER) || player->HasAura(SPELL_ERUPTION_MODIFIER))
            ReconcilePrimalistWeapon(player);

        if (PrimalistEnabled(player))
            if (Pet* pet = player->GetPet(); pet && pet->getPetType() == HUNTER_PET &&
                pet->GetPower(POWER_HAPPINESS) != pet->GetMaxPower(POWER_HAPPINESS))
                pet->SetPower(POWER_HAPPINESS, pet->GetMaxPower(POWER_HAPPINESS));
    }
};
}

// Esteria has simultaneous kits; owning the baseline ability replaces CoA specialization 59.
bool IsAscensionPrimalistTameEligible(Player const* player)
{
    return PrimalistEnabled(player) && player->GetLevel() >= 10 && player->HasSpell(SPELL_PRIMALIST_PET_TRAINING);
}

bool IsAscensionPrimalistWeaponsEligible(Player const* player, bool /*allowUnconfirmed*/)
{
    return PrimalistEnabled(player) && player->GetLevel() >= 20 && player->HasSpell(SPELL_PRIMAL_WEAPONS);
}

void ApplyCoAPrimalistContracts(SpellInfo* spellInfo)
{
    if (!sClasslessMgr->cfg.coaEnable || !spellInfo)
        return;
    // Boulder Dash's helper rows use custom aura placeholders in CoA's patch-T Spell.dbc.
    // Convert only the exact three-effect layouts before the source links can grant them.
    if (spellInfo->Id == 680473 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].ApplyAuraName == 77 && spellInfo->Effects[EFFECT_0].MiscValue == 2 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].ApplyAuraName == 305 && spellInfo->Effects[EFFECT_1].MiscValue == 0 &&
        spellInfo->Effects[EFFECT_1].BasePoints == 99 && spellInfo->Effects[EFFECT_1].DieSides == 1 &&
        spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_2].ApplyAuraName == 147 && spellInfo->Effects[EFFECT_2].MiscValue == 1735)
    {
        spellInfo->Effects[EFFECT_2].MiscValue = 1733;
        spellInfo->Effects[EFFECT_0].MiscValue = MECHANIC_DISARM;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_MECHANIC_IMMUNITY;
        spellInfo->Effects[EFFECT_1].MiscValue = MECHANIC_SILENCE;
        spellInfo->Effects[EFFECT_1].BasePoints = 0;
        spellInfo->Effects[EFFECT_1].DieSides = 0;
    }

    if (spellInfo->Id == 681302 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].ApplyAuraName == 77 && spellInfo->Effects[EFFECT_0].MiscValue == 6 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].ApplyAuraName == 77 && spellInfo->Effects[EFFECT_1].MiscValue == 14 &&
        spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_2].ApplyAuraName == 77 && spellInfo->Effects[EFFECT_2].MiscValue == 30)
    {
        spellInfo->Effects[EFFECT_2].ApplyAuraName = SPELL_AURA_MOD_PACIFY;
        spellInfo->Effects[EFFECT_2].MiscValue = 0;
    }

    if (spellInfo->SpellFamilyName == 37 &&
        ((spellInfo->Id == 680473 && spellInfo->Effects[EFFECT_0].MiscValue == MECHANIC_DISARM &&
            spellInfo->Effects[EFFECT_1].ApplyAuraName == SPELL_AURA_MECHANIC_IMMUNITY &&
            spellInfo->Effects[EFFECT_1].MiscValue == MECHANIC_SILENCE &&
            spellInfo->Effects[EFFECT_2].MiscValue == 1733) ||
         (spellInfo->Id == 681302 && spellInfo->Effects[EFFECT_2].ApplyAuraName == SPELL_AURA_MOD_PACIFY &&
            spellInfo->Effects[EFFECT_2].MiscValue == 0) ||
         (spellInfo->Id == 500693 && spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_SCHOOL_DAMAGE &&
            spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_NONE &&
            spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_NONE)))
        spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED;

    if (spellInfo->Id == 806554 && spellInfo->SpellFamilyName == 37 && spellInfo->StackAmount == 5 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].ApplyAuraName == SPELL_AURA_DUMMY)
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;

    if (spellInfo->Id == 806553 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->GetSchoolMask() == SPELL_SCHOOL_MASK_NORMAL && spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MELEE &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_SCHOOL_DAMAGE &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_REMOVE_AURA &&
        spellInfo->Effects[EFFECT_1].TriggerSpell == 806554)
        spellInfo->AttributesCu |= SPELL_ATTR0_CU_IGNORE_ARMOR;

    if (spellInfo->Id == 301353 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].ApplyAuraName == 345 &&
        spellInfo->Effects[EFFECT_0].BasePoints == -1 && spellInfo->Effects[EFFECT_0].MiscValue == 127)
        spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED;

    // Thane's Rage changes only the verified CoA stamina-total modifier row.
    if (spellInfo->Id == 804124 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].ApplyAuraName == SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE &&
        spellInfo->Effects[EFFECT_0].MiscValue == STAT_STAMINA &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].ApplyAuraName == 268 && spellInfo->Effects[EFFECT_1].MiscValue == 2)
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_MOD_STAT;

    // Journey's delayed burst replaces two exact patch-T rows; do not rewrite other family-37 spells.
    if (spellInfo->Id == 302534 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == 27 && spellInfo->Effects[EFFECT_0].TriggerSpell == 302590 &&
        spellInfo->Effects[EFFECT_0].TargetA.GetTarget() == 53 && spellInfo->Effects[EFFECT_0].TargetB.GetTarget() == 16 &&
        spellInfo->Effects[EFFECT_0].RadiusEntry && spellInfo->Effects[EFFECT_0].RadiusEntry->ID == 8 &&
        spellInfo->Effects[EFFECT_1].Effect == 64 && spellInfo->Effects[EFFECT_1].TriggerSpell == 302590 &&
        spellInfo->Effects[EFFECT_1].TargetA.GetTarget() == 1 && spellInfo->Effects[EFFECT_1].TargetB.GetTarget() == 0)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_NONE;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(0);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(0);
    }

    if (spellInfo->Id == 302590 && spellInfo->SpellFamilyName == 37 && spellInfo->MaxAffectedTargets == 10 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_SCHOOL_DAMAGE &&
        spellInfo->Effects[EFFECT_0].TargetA.GetTarget() == 6 && spellInfo->Effects[EFFECT_0].TargetB.GetTarget() == 0 &&
        !spellInfo->Effects[EFFECT_0].RadiusEntry &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].ApplyAuraName == 271 && spellInfo->Effects[EFFECT_1].MiscValue == 127 &&
        spellInfo->Effects[EFFECT_1].TargetA.GetTarget() == 6 && spellInfo->Effects[EFFECT_1].TargetB.GetTarget() == 0 &&
        spellInfo->Effects[EFFECT_1].RadiusEntry && spellInfo->Effects[EFFECT_1].RadiusEntry->ID == 29)
    {
        SpellInfo const* ground = sSpellMgr->GetSpellInfo(302534);
        if (ground && ground->Effects[EFFECT_0].RadiusEntry && ground->MaxAffectedTargets == 5)
        {
            spellInfo->MaxAffectedTargets = ground->MaxAffectedTargets;
            for (SpellEffIndex index : {EFFECT_0, EFFECT_1})
            {
                spellInfo->Effects[index].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENEMY);
                spellInfo->Effects[index].TargetB = SpellImplicitTargetInfo(0);
                spellInfo->Effects[index].RadiusEntry = ground->Effects[EFFECT_0].RadiusEntry;
            }
        }
    }

    if (spellInfo->Id == 805867 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].ApplyAuraName == 261 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].ApplyAuraName == SPELL_AURA_PERIODIC_TRIGGER_SPELL &&
        spellInfo->Effects[EFFECT_1].BasePoints == 1 && spellInfo->Effects[EFFECT_1].TriggerSpell == 804315 &&
        spellInfo->Effects[EFFECT_1].TargetA.GetTarget() == 57 && spellInfo->Effects[EFFECT_1].TargetB.GetTarget() == 0 &&
        spellInfo->Effects[EFFECT_2].ApplyAuraName == 39 && spellInfo->Effects[EFFECT_2].MiscValue == 127)
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_MOD_PACIFY_SILENCE;

    if (spellInfo->Id == 537250 && spellInfo->SpellFamilyName == 37 && spellInfo->ExcludeTargetAuraSpell == 0 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].ApplyAuraName == 231 && spellInfo->Effects[EFFECT_1].Effect == 64)
        spellInfo->ExcludeTargetAuraSpell = 573255;

    if (spellInfo->Id == 680421 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_2].ApplyAuraName == SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN &&
        spellInfo->Effects[EFFECT_2].BasePoints == -21 && spellInfo->Effects[EFFECT_2].MiscValue == 127)
        spellInfo->Effects[EFFECT_2].BasePoints = -16;

    if (spellInfo->Id == 680427 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA && spellInfo->Effects[EFFECT_0].ApplyAuraName == 77 &&
        spellInfo->Effects[EFFECT_0].BasePoints == -1 && spellInfo->Effects[EFFECT_0].MiscValue == 11 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA && spellInfo->Effects[EFFECT_1].ApplyAuraName == 77 &&
        spellInfo->Effects[EFFECT_1].BasePoints == -1 && spellInfo->Effects[EFFECT_1].MiscValue == 12 &&
        spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_APPLY_AURA && spellInfo->Effects[EFFECT_2].ApplyAuraName == 77 &&
        spellInfo->Effects[EFFECT_2].BasePoints == -1 && spellInfo->Effects[EFFECT_2].MiscValue == 7)
    {
        spellInfo->AttributesCu &= ~SPELL_ATTR0_CU_FORCE_AURA_SAVING;
        spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED;
    }

    if (spellInfo->Id == 523526 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_ENERGIZE_PCT && spellInfo->Effects[EFFECT_0].MiscValueB == 1 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_HEAL_PCT && spellInfo->Effects[EFFECT_1].MiscValueB == 1)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_ENERGIZE;
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_HEAL;
    }

    if (spellInfo->Id == 810040 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_HEAL_PCT && spellInfo->Effects[EFFECT_0].MiscValueB == 1 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_ENERGIZE_PCT && spellInfo->Effects[EFFECT_1].MiscValueB == 1 &&
        spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_ENERGIZE_PCT && spellInfo->Effects[EFFECT_2].MiscValueB == 1)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_HEAL;
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_ENERGIZE;
        spellInfo->Effects[EFFECT_2].Effect = SPELL_EFFECT_ENERGIZE;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    }

    // BarrierModifiers is a Hero-only helper aura that must not persist across logout.
    if (spellInfo->Id == 504853 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_DUMMY) &&
        spellInfo->Effects[EFFECT_0].BasePoints == 49 && spellInfo->Effects[EFFECT_0].MiscValue == 1 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].IsAura(SPELL_AURA_DUMMY) &&
        spellInfo->Effects[EFFECT_1].BasePoints == -1 && spellInfo->Effects[EFFECT_1].MiscValue == 127 &&
        spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_2].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) &&
        spellInfo->Effects[EFFECT_2].BasePoints == -1 && spellInfo->Effects[EFFECT_2].MiscValue == 14)
    {
        spellInfo->AttributesCu &= ~SPELL_ATTR0_CU_FORCE_AURA_SAVING;
        spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED;
    }

    // Earthmother's Protection's modifier is activated through the synchronized helper aura.
    if (spellInfo->Id == 560298 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_ADD_FLAT_MODIFIER) &&
        spellInfo->Effects[EFFECT_0].BasePoints == -51 && spellInfo->Effects[EFFECT_0].MiscValue == 23)
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_DUMMY;

    // Earthshaker only extends CoA's exact periodic-crit and modifier masks.
    if (spellInfo->Id == 300698 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_ABILITY_PERIODIC_CRIT) &&
        spellInfo->Effects[EFFECT_0].SpellClassMask == flag96(0, 4194304, 268435456) &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) &&
        spellInfo->Effects[EFFECT_1].BasePoints == 9 &&
        spellInfo->Effects[EFFECT_1].SpellClassMask == flag96(16, 4194304, 268435456) &&
        spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_2].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) &&
        spellInfo->Effects[EFFECT_2].BasePoints == 9 &&
        spellInfo->Effects[EFFECT_2].SpellClassMask == flag96(16, 4194304, 268435456))
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] |= 64;
        for (SpellEffIndex index : {EFFECT_1, EFFECT_2})
        {
            spellInfo->Effects[index].SpellClassMask[0] |= 64;
            spellInfo->Effects[index].SpellClassMask[1] |= 256;
            spellInfo->Effects[index].SpellClassMask[2] |= 263168;
        }
    }

    // Judgement damage uses effect 0; effect 1 is a client-only damage-taken carrier.
    if (spellInfo->Id == 520468 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_SCHOOL_DAMAGE &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].IsAura(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN) &&
        spellInfo->Effects[EFFECT_1].BasePoints == 1 &&
        spellInfo->Effects[EFFECT_1].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY &&
        spellInfo->Effects[EFFECT_1].TargetB.GetTarget() == Targets(0) &&
        spellInfo->Effects[EFFECT_1].MiscValue == 1)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_NONE;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(Targets(0));
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(Targets(0));
    }

    // Tectonic Resonance uses effect 2 as script data; the other two effects are modifiers.
    if (spellInfo->Id == 707173 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_ADD_FLAT_MODIFIER) &&
        spellInfo->Effects[EFFECT_0].BasePoints == -1 && spellInfo->Effects[EFFECT_0].MiscValue == 11 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) &&
        spellInfo->Effects[EFFECT_1].BasePoints == -1 && spellInfo->Effects[EFFECT_1].MiscValue == 19 &&
        spellInfo->Effects[EFFECT_2].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_2].IsAura(SPELL_AURA_ADD_FLAT_MODIFIER) &&
        spellInfo->Effects[EFFECT_2].BasePoints == -31 && spellInfo->Effects[EFFECT_2].MiscValue == 3)
        spellInfo->Effects[EFFECT_2].ApplyAuraName = SPELL_AURA_DUMMY;

    // Mineralization's CoA client row carries aura state 13 (health below 35%).
    // The Hero's Primalist contract intentionally removes that extra cast restriction.
    if (spellInfo->Id == 520465 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->CasterAuraState == AURA_STATE_HEALTHLESS_35_PERCENT)
        spellInfo->CasterAuraState = 0;
    // CoA Stone Tosser stores modifier type 41; map its exact percent aura to the supported multiplier op.
    if (spellInfo->Id == 680862 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) &&
        spellInfo->Effects[EFFECT_0].MiscValue == 41)
        spellInfo->Effects[EFFECT_0].MiscValue = SPELLMOD_BONUS_MULTIPLIER;
    // CoA Wild Carnage's family-37 row carries four jumps; the contract caps it at three.
    if (spellInfo->Id == 800041 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_ADD_FLAT_MODIFIER) &&
        spellInfo->Effects[EFFECT_0].MiscValue == SPELLMOD_JUMP_TARGETS &&
        spellInfo->Effects[EFFECT_0].BasePoints == 4)
        spellInfo->Effects[EFFECT_0].BasePoints = 3;
    // Earthmother's Precision adds hit chance against every school, including physical.
    if (spellInfo->Id == 555724 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_MOD_ATTACKER_SPELL_HIT_CHANCE) &&
        spellInfo->Effects[EFFECT_0].MiscValue == 126)
        spellInfo->Effects[EFFECT_0].MiscValue = SPELL_SCHOOL_MASK_ALL;

    // Ancient of War's second modifier is percentage-based in the CoA client row.
    if (spellInfo->Id == 504222 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].IsAura(SPELL_AURA_ADD_FLAT_MODIFIER))
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_ADD_PCT_MODIFIER;

    // Fae Dust detects all stealth types rather than an unknown custom type.
    if (spellInfo->Id == 804664 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_MOD_STEALTH_DETECT) &&
        spellInfo->Effects[EFFECT_0].MiscValue == 10)
        spellInfo->Effects[EFFECT_0].MiscValue = STEALTH_GENERAL;

    // Earthmother Warden includes the scripted cooldown-modifier spell in its class mask.
    if (spellInfo->Id == 707514 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_ADD_FLAT_MODIFIER) &&
        spellInfo->Effects[EFFECT_0].MiscValue == SPELLMOD_COOLDOWN &&
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] == 16)
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] |= 64;

    // Grove Tender's cooldown reduction likewise includes one scripted modifier spell.
    if (spellInfo->Id == 706148 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) &&
        spellInfo->Effects[EFFECT_0].MiscValue == SPELLMOD_COOLDOWN &&
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] == 16)
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] |= 64;

    // Ride the Wave's speed aura targets the riding ally rather than an area.
    if (spellInfo->Id == 300868 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].IsAura(SPELL_AURA_MOD_INCREASE_SPEED) &&
        spellInfo->Effects[EFFECT_0].TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ALLY &&
        spellInfo->Effects[EFFECT_0].TargetB.GetTarget() == Targets(0))
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ALLY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(Targets(0));
    }

    // Douse starts from a neutral damage value, while its debuff applies the intended 1% increase.
    if (spellInfo->Id == 807559 && spellInfo->SpellFamilyName == 22 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_SCHOOL_DAMAGE &&
        spellInfo->Effects[EFFECT_0].BasePoints == 86 &&
        spellInfo->Effects[EFFECT_0].DieSides == 1)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = -1;
        spellInfo->Effects[EFFECT_0].DieSides = 1;
    }
    if (spellInfo->Id == 803514 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].IsAura(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN) &&
        spellInfo->Effects[EFFECT_1].BasePoints == -3 &&
        spellInfo->Effects[EFFECT_1].MiscValue == 126)
        spellInfo->Effects[EFFECT_1].BasePoints = 1;

    // Grove Guardian Allies needs an explicit ally target on each persistent area effect.
    if (spellInfo->Id == 505208 && spellInfo->SpellFamilyName == 37)
    {
        bool expectedLayout = true;
        for (SpellEffectInfo const& effect : spellInfo->Effects)
            expectedLayout &= effect.Effect == SPELL_EFFECT_PERSISTENT_AREA_AURA &&
                effect.TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ALLY &&
                effect.TargetB.GetTarget() == Targets(0);
        if (expectedLayout)
        {
            for (SpellEffectInfo& effect : spellInfo->Effects)
                effect.TargetB = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ALLY);
            spellInfo->_InitializeExplicitTargetMask();
        }
    }

    // Magmatism's class-script carrier is a low-health damage aura in the shipped CoA row.
    if (spellInfo->Id == 706174 && spellInfo->SpellFamilyName == 37)
    {
        SpellEffectInfo& effect = spellInfo->Effects[EFFECT_1];
        if (effect.Effect == SPELL_EFFECT_APPLY_AURA &&
            effect.IsAura(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS) &&
            effect.MiscValue == ASCENSION_CLASSMASK_AURASTATE_DAMAGE && effect.MiscValueB == 10 &&
            effect.BasePoints == 29 && effect.DieSides == 1 &&
            effect.SpellClassMask == flag96(0, 0, 128))
        {
            effect.ApplyAuraName = SPELL_AURA_MOD_DAMAGE_DONE_VERSUS_AURASTATE;
            effect.MiscValue = AURA_STATE_HEALTH_ABOVE_75_PERCENT;
            effect.MiscValueB = ASCENSION_CLASSMASK_AURASTATE_DAMAGE;
        }
    }

    // Rush of the Hunt deals its bonus damage against bleeding targets.
    if (spellInfo->Id == 300691 && spellInfo->SpellFamilyName == 37)
    {
        SpellEffectInfo& effect = spellInfo->Effects[EFFECT_0];
        if (effect.Effect == SPELL_EFFECT_APPLY_AURA &&
            effect.IsAura(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS) &&
            effect.MiscValue == ASCENSION_CLASSMASK_AURASTATE_DAMAGE &&
            effect.MiscValueB == AURA_STATE_BLEEDING &&
            effect.SpellClassMask == flag96(1, 0, 64))
        {
            effect.ApplyAuraName = SPELL_AURA_MOD_DAMAGE_DONE_VERSUS_AURASTATE;
            effect.MiscValue = AURA_STATE_BLEEDING;
            effect.MiscValueB = ASCENSION_CLASSMASK_AURASTATE_DAMAGE;
        }
    }

    // Heavy Handed makes its buff self-targeted and removes its redundant second aura.
    if (spellInfo->Id == 706345 && spellInfo->SpellFamilyName == 37 &&
        spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_0].ApplyAuraName == SPELL_AURA_MOD_BASE_RESISTANCE_PCT &&
        spellInfo->Effects[EFFECT_0].BasePoints == 9 &&
        spellInfo->Effects[EFFECT_0].MiscValue == 1 &&
        spellInfo->Effects[EFFECT_0].TargetA.GetTarget() == TARGET_UNIT_TARGET_ALLY &&
        spellInfo->Effects[EFFECT_0].TargetB.GetTarget() == Targets(0) &&
        spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
        spellInfo->Effects[EFFECT_1].ApplyAuraName == SPELL_AURA_MOD_BASE_RESISTANCE_PCT &&
        spellInfo->Effects[EFFECT_1].BasePoints == 9 &&
        spellInfo->Effects[EFFECT_1].MiscValue == 1 &&
        spellInfo->Effects[EFFECT_1].TargetA.GetTarget() == TARGET_UNIT_CASTER &&
        spellInfo->Effects[EFFECT_1].TargetB.GetTarget() == Targets(0))
    {
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_NONE;
    }

    // Earthshaping is already applied by CoAGlue.cpp.
    ApplyAscensionPrimalistEarthquakeContract(spellInfo);
    ApplyAscensionPrimalistSpiritBeastContract(spellInfo);
    ApplyAscensionPrimalistWeaponsContract(spellInfo);
}

void HandleAscensionPrimalistCaveInInterrupt(Spell* spell, Player* player)
{
    constexpr uint32 CaveIn = 500615;
    if (!spell || !PrimalistEnabled(player) || !spell->GetSpellInfo() ||
        spell->GetSpellInfo()->Id != CaveIn)
        return;

    if (HandleAscensionPrimalistEarthshapingGain(player))
        return;

    if (Aura* earthshaping = player->GetAura(SPELL_EARTHSHAPING))
    {
        int32 const remaining = earthshaping->GetDuration();
        earthshaping->ModStackAmount(1);
        earthshaping->SetDuration(remaining);
    }
    else
        player->CastSpell(player, SPELL_EARTHSHAPING, true);
}

void AddCoAPrimalistPackage()
{
    new cw_coa_primalist_player();
    new cw_coa_primalist_resources();
    new cw_coa_primalist_periodic_resources();

    // CoAScriptLoader order, excluding Earthshaping which CoAGlue.cpp already registers.
    AddSC_AscensionPrimalistHeavyEarth();
    AddSC_AscensionPrimalistRangerFrenzy();
    AddSC_AscensionPrimalistEarthshaker();
    AddSC_AscensionPrimalistRunningInstinct();
    AddSC_AscensionPrimalistPowerHammer();
    AddSC_AscensionPrimalistTalentEvents();
    AddSC_AscensionPrimalistEmeraldWill();
    AddSC_AscensionPrimalistTotemicEchoes();
    AddSC_AscensionPrimalistPendant();
    AddSC_AscensionPrimalistThorns();
    AddSC_AscensionPrimalistBloodyClaws();
    AddSC_AscensionPrimalistJudgement();
    AddSC_AscensionPrimalistShattering();
    AddSC_AscensionPrimalistVerdantChase();
    AddSC_AscensionPrimalistJourney();
    AddSC_AscensionPrimalistQuakingThane();
    AddSC_AscensionPrimalistTremors();
    AddSC_AscensionPrimalistCataclysm();
    AddSC_AscensionPrimalistEarthsGuidance();
    AddSC_AscensionPrimalistBramblepatch();
    AddSC_AscensionPrimalistPrimalStrikes();
    AddSC_AscensionPrimalistLithicLance();
    AddSC_AscensionPrimalistEmpoweredBoons();
    AddSC_AscensionPrimalistDruidTraining();
    AddSC_AscensionPrimalistSpiritualFrenzy();
    AddSC_AscensionPrimalistPhysicalCrit();
    AddSC_AscensionPrimalistRipsAndTears();
    AddSC_AscensionPrimalistMountainAvatar();
    AddSC_AscensionPrimalistRylaksBite();
    AddSC_AscensionPrimalistRylaksBlessing();
    AddSC_AscensionPrimalistWildheart();
    AddSC_AscensionPrimalistDreamslip();
    AddSC_AscensionPrimalistNeptulonWrath();
    AddSC_AscensionPrimalistSacredGrove();
    AddSC_AscensionPrimalistAncientWar();
    AddSC_AscensionPrimalistEarthmotherRoar();
    AddSC_AscensionPrimalistCrushingEarth();
    AddSC_AscensionPrimalistSpiritBeast();
    AddSC_AscensionPrimalistWeapons();
    AddSC_AscensionPrimalistTalents();
    AddSC_AscensionPrimalistBones();
    AddSC_AscensionPrimalistBoons();
    AddSC_AscensionPrimalistSeismicResources();
    AddSC_AscensionPrimalistGuidance();
    AddSC_AscensionPrimalistBarrier();
    AddSC_AscensionPrimalistMountainFury();
    AddSC_AscensionPrimalistBoulder();
    AddSC_AscensionPrimalistUrsoc();
    AddSC_AscensionPrimalistTorn();
    AddSC_AscensionPrimalistRexxarMight();
    AddSC_AscensionPrimalistLifeSpirit();
    AddSC_AscensionPrimalistTotem();
    AddSC_AscensionPrimalistTremor();
    AddSC_AscensionPrimalistPulverize();
    AddSC_AscensionPrimalistVitality();
    AddSC_AscensionPrimalistNaturalEfficiency();
    AddSC_AscensionPrimalistGeomancy();
    AddSC_AscensionPrimalistMountain();
    AddSC_AscensionPrimalistPeriodicCritical();
    AddSC_AscensionPrimalistEmbracedByEarth();
   AddSC_AscensionPrimalistSecondary();
}
