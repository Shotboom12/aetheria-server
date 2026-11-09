/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adapters for the safe, independent parts of Primalist Secondary.
// Effects relying on absent core metadata hooks remain deliberately unported.

#include "CoAPort.h"
#include "SpellMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>
#include <limits>

namespace
{
constexpr uint32 NaturesBlessingHeal = 807561;
constexpr uint32 GazeOfTheradras = 805919;
constexpr uint32 GazeSlow = 572908;
constexpr uint32 HammerOfLifeAura = 803973;
constexpr uint32 HammerOfLifeHeal = 806073;
constexpr uint32 HammerOfLifeDamage = 807651;
constexpr uint32 AncientOfLore = 805105;
constexpr uint32 AncientSlow = 504369;
constexpr uint32 CrackingEarth = 560145;
constexpr uint32 CrackingStack = 560146;
constexpr uint32 EarthsEmbrace = 806143;
constexpr uint32 EmbracedByEarth = 561037;
constexpr uint32 EmbraceDisorient = 706200;
constexpr uint32 TotemWarrior = 704099;
constexpr uint32 TotemWarriorHit = 555732;
constexpr uint32 BoonOfTheBear = 500939;
constexpr uint32 VolcanicBlast = 681353;
constexpr uint32 VolcanicBlastAura = 680451;
constexpr uint32 VolcanicBlastAuraSecondary = 681480;
constexpr uint32 SavageFrenzy = 806549;
constexpr uint32 StoneGrip = 800145;

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class primalist_secondary_hero_auras : public UnitScript
{
public:
    primalist_secondary_hero_auras() : UnitScript("primalist_secondary_hero_auras", true,
        { UNITHOOK_ON_AURA_APPLY, UNITHOOK_ON_AURA_REMOVE }) { }

    void OnAuraApply(Unit* unit, Aura* aura) override
    {
        Player* player = GetPrimalistHero(unit);
        if (player && aura && aura->GetId() == AncientOfLore && aura->GetCasterGUID() == player->GetGUID() &&
            !player->HasAura(AncientSlow, player->GetGUID()))
            player->AddAura(AncientSlow, player);
    }

    void OnAuraRemove(Unit* unit, AuraApplication* application, AuraRemoveMode mode) override
    {
        Player* player = GetPrimalistHero(unit);
        if (!player || !application)
            return;
        Aura* aura = application->GetBase();
        if (!aura || aura->GetCasterGUID() != player->GetGUID())
            return;

        if (aura->GetId() == AncientOfLore)
            player->RemoveAurasDueToSpell(AncientSlow, player->GetGUID());
        else if (aura->GetId() == CrackingEarth)
            player->RemoveAurasDueToSpell(CrackingStack, player->GetGUID());
        else if (aura->GetId() == EarthsEmbrace && mode == AURA_REMOVE_BY_EXPIRE &&
            player->IsAlive() && player->IsInWorld() && player->HasAura(EmbracedByEarth, player->GetGUID()))
            player->CastSpell(player, EmbraceDisorient, true);
    }
};

class aura_ascension_natures_blessing : public AuraScript
{
    PrepareAuraScript(aura_ascension_natures_blessing);

    bool Validate(SpellInfo const* info) override
    {
        return info->SpellFamilyName == 37 && info->Effects[EFFECT_0].ApplyAuraName == 354 &&
            info->Effects[EFFECT_0].TriggerSpell == NaturesBlessingHeal &&
            ValidateSpellInfo({ NaturesBlessingHeal });
    }

    bool Load() override { return GetPrimalistHero(GetUnitOwner()) != nullptr; }

    bool Check(ProcEventInfo& event)
    {
        SpellInfo const* info = event.GetSpellInfo();
        HealInfo const* heal = event.GetHealInfo();
        Unit* target = event.GetActionTarget();
        bool seismicWave = info && (info->Id == 805462 || (info->Id >= 572873 && info->Id <= 572878));
        return seismicWave && event.GetActor() == GetTarget() && target && target->IsAlive() &&
            GetTarget()->IsFriendlyTo(target) && heal && heal->GetHeal();
    }

    void Proc(AuraEffect const* effect, ProcEventInfo& event)
    {
        PreventDefaultAction();
        uint64 amount = uint64(event.GetHealInfo()->GetHeal()) *
            std::clamp(effect->GetAmount(), 0, 100) / 100;
        if (amount)
            GetTarget()->CastCustomSpell(NaturesBlessingHeal, SPELLVALUE_BASE_POINT0,
                int32(std::min<uint64>(amount, std::numeric_limits<int32>::max())),
                event.GetActionTarget(), TRIGGERED_FULL_MASK, nullptr, effect);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_natures_blessing::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_natures_blessing::Proc, EFFECT_0, AuraType(354));
    }
};

class spell_ascension_gaze_of_theradras : public SpellScript
{
    PrepareSpellScript(spell_ascension_gaze_of_theradras);

    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    void Before(SpellMissInfo miss)
    {
        Unit* target = GetHitUnit();
        _newVictim = miss == SPELL_MISS_NONE && target && target->CanHaveThreatList() &&
            target->GetVictim() != GetCaster();
    }

    void After()
    {
        Unit* target = GetHitUnit();
        if (_newVictim && target && target->IsAlive() && target->HasAura(GazeOfTheradras, GetCaster()->GetGUID()))
            GetCaster()->CastSpell(target, GazeSlow, true);
    }

    void Register() override
    {
        BeforeHit += BeforeSpellHitFn(spell_ascension_gaze_of_theradras::Before);
        AfterHit += SpellHitFn(spell_ascension_gaze_of_theradras::After);
    }

    bool _newVictim = false;
};

class spell_ascension_seismic_wave : public SpellScript
{
    PrepareSpellScript(spell_ascension_seismic_wave);

    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    void AddHealingPower(SpellEffIndex)
    {
        int32 power = GetCaster()->SpellBaseHealingBonusDone(GetSpellInfo()->GetSchoolMask());
        SetEffectValue(GetEffectValue() + int32(power * 0.3f));
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_ascension_seismic_wave::AddHealingPower,
            EFFECT_0, SPELL_EFFECT_HEAL);
    }
};

class spell_ascension_totem_warrior : public SpellScript
{
    PrepareSpellScript(spell_ascension_totem_warrior);

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({ TotemWarrior, TotemWarriorHit, BoonOfTheBear });
    }

    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    void Repeat()
    {
        Unit* owner = GetCaster();
        Unit* victim = GetHitUnit();
        if (!victim || !victim->IsAlive() || owner->IsFriendlyTo(victim) || GetHitDamage() <= 0 ||
            !owner->HasAura(BoonOfTheBear, owner->GetGUID()))
            return;

        if (AuraEffect const* talent = owner->GetAuraEffect(TotemWarrior, EFFECT_0, owner->GetGUID()))
        {
            int32 amount = int32(int64(GetHitDamage()) * std::clamp(talent->GetAmount(), 0, 100) / 100);
            if (amount)
                owner->CastCustomSpell(TotemWarriorHit, SPELLVALUE_BASE_POINT0, amount, victim,
                    TRIGGERED_FULL_MASK, nullptr, talent);
        }
    }

    void Register() override { AfterHit += SpellHitFn(spell_ascension_totem_warrior::Repeat); }
};

class aura_ascension_volcanic_blast : public AuraScript
{
    PrepareAuraScript(aura_ascension_volcanic_blast);

    bool Validate(SpellInfo const* info) override
    {
        return info && info->Effects[EFFECT_0].ApplyAuraName == 354 &&
            ValidateSpellInfo({ VolcanicBlast, VolcanicBlastAura, VolcanicBlastAuraSecondary });
    }

    bool Load() override { return GetPrimalistHero(GetUnitOwner()) != nullptr; }

    bool Check(ProcEventInfo& event)
    {
        Unit* owner = GetTarget();
        Player* player = GetPrimalistHero(owner);
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        return player && player->IsAlive() && GetCaster() == player && event.GetActor() == player &&
            victim && victim != player && !player->IsFriendlyTo(victim) && damage && damage->GetDamage() &&
            (event.GetHitMask() & PROC_HIT_CRITICAL) &&
            (damage->GetSchoolMask() & (SPELL_SCHOOL_MASK_NORMAL | SPELL_SCHOOL_MASK_NATURE));
    }

    void Proc(AuraEffect const* effect, ProcEventInfo& event)
    {
        PreventDefaultAction();
        uint64 amount = uint64(event.GetDamageInfo()->GetDamage()) *
            std::clamp(effect->GetAmount(), 0, 100) / 100;
        if (amount)
            GetTarget()->CastCustomSpell(VolcanicBlast, SPELLVALUE_BASE_POINT0,
                int32(std::min<uint64>(amount, std::numeric_limits<int32>::max())),
                event.GetActionTarget(), TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_volcanic_blast::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_volcanic_blast::Proc, EFFECT_0, AuraType(354));
    }
};

class primalist_volcanic_targets : public AllSpellScript
{
public:
    primalist_volcanic_targets() : AllSpellScript("primalist_volcanic_targets", { ALLSPELLHOOK_ON_HIT_RESULT }) { }

    void OnSpellHitResult(Spell* spell, Unit* target, uint8 miss, uint32, uint32, bool) override
    {
        Unit* caster = spell ? spell->GetCaster()->ToUnit() : nullptr;
        Player* player = GetPrimalistHero(caster);
        if (!player || !player->IsAlive() || !spell->GetSpellInfo() ||
            spell->GetSpellInfo()->Id != VolcanicBlast || miss != SPELL_MISS_NONE || !target ||
            target == player || player->IsFriendlyTo(target) ||
            !player->HasAura(CrackingEarth, player->GetGUID()))
            return;

        uint64 count = spell->GetScriptValue(CrackingStack) + 1;
        spell->SetScriptValue(CrackingStack, count);
        if (count == 5)
            player->CastSpell(player, CrackingStack, true);
    }
};

class aura_ascension_hammer_of_life : public AuraScript
{
    PrepareAuraScript(aura_ascension_hammer_of_life);

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({ HammerOfLifeAura, HammerOfLifeHeal, HammerOfLifeDamage });
    }

    bool Load() override { return GetPrimalistHero(GetUnitOwner()) != nullptr; }

    bool Check(ProcEventInfo& event)
    {
        Unit* owner = GetTarget();
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        return owner && owner->IsAlive() && event.GetActor() == owner && victim && victim != owner &&
            !owner->IsFriendlyTo(victim) && damage && damage->GetDamage();
    }

    void Proc(AuraEffect const* effect, ProcEventInfo& event)
    {
        PreventDefaultAction();
        uint64 amount = uint64(event.GetDamageInfo()->GetDamage()) *
            std::clamp(effect->GetAmount(), 0, 100) / 100;
        if (!amount)
            return;

        int32 value = int32(std::min<uint64>(amount, std::numeric_limits<int32>::max()));
        GetTarget()->CastCustomSpell(HammerOfLifeHeal, SPELLVALUE_BASE_POINT0, value, GetTarget(),
            TRIGGERED_FULL_MASK);
        GetTarget()->CastCustomSpell(HammerOfLifeDamage, SPELLVALUE_BASE_POINT0, value, GetTarget(),
            TRIGGERED_FULL_MASK);
    }

    void IgnoreSecondTrigger(AuraEffect const*, ProcEventInfo&) { PreventDefaultAction(); }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_hammer_of_life::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_hammer_of_life::Proc, EFFECT_0, AuraType(354));
        OnEffectProc += AuraEffectProcFn(aura_ascension_hammer_of_life::IgnoreSecondTrigger,
            EFFECT_2, AuraType(354));
    }
};

class primalist_secondary_focused_metadata : public GlobalScript
{
public:
    primalist_secondary_focused_metadata() : GlobalScript("primalist_secondary_focused_metadata",
        { GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR }) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (info->SpellFamilyName != 37)
            return;

        if (info->Id == SavageFrenzy)
        {
            for (SpellEffectInfo& effect : info->Effects)
                if (effect.IsAura() && effect.TargetA.GetTarget() == TARGET_UNIT_PET &&
                    effect.TargetB.GetTarget() == 0)
                    effect.TargetB = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
            info->_InitializeExplicitTargetMask();
        }

        if (info->Id == CrackingEarth)
        {
            info->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_DUMMY;
            info->ProcFlags = 0;
        }

        if (info->Id == CrackingStack)
        {
            info->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_MOD_MAX_AFFECTED_TARGETS;
            info->AttributesCu &= ~SPELL_ATTR0_CU_FORCE_AURA_SAVING;
            info->AttributesCu |= SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED;
        }

        if (info->Id == VolcanicBlast || info->Id == TotemWarriorHit)
        {
            info->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
            info->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
            info->AttributesEx4 |= SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS;
            info->AscensionInheritsResolvedAmount = true;
            info->Effects[EFFECT_0].BonusMultiplier = 0.0f;
        }

        if (info->Id == GazeSlow)
            info->ProcCharges = 1;

        if (info->Id == AncientSlow || info->Id == GazeSlow)
        {
            info->AttributesCu &= ~SPELL_ATTR0_CU_FORCE_AURA_SAVING;
            info->AttributesCu |= SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED;
        }

        if (info->Id == EmbraceDisorient)
            info->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_TAKE_DAMAGE;

        if (info->Id == StoneGrip)
        {
            info->Effects[EFFECT_1].Effect = 0;
            info->Mechanic = MECHANIC_SAPPED;
        }
    }
};
}

void AddSC_AscensionPrimalistSecondary()
{
    new primalist_secondary_hero_auras();
    new primalist_secondary_focused_metadata();
    new primalist_volcanic_targets();
    RegisterSpellScript(aura_ascension_natures_blessing);
    RegisterSpellScript(spell_ascension_gaze_of_theradras);
    RegisterSpellScript(spell_ascension_seismic_wave);
    RegisterSpellScript(aura_ascension_hammer_of_life);
    RegisterSpellScript(spell_ascension_totem_warrior);
    RegisterSpellScript(aura_ascension_volcanic_blast);
}
