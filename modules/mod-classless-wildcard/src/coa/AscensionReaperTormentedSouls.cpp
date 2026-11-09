/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, pinned commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream author: Zachary Kaiser.
#include "ClasslessMgr.h"
#include "Player.h"
#include "Unit.h"
#include "CoAPort.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include <algorithm>
#include <cmath>

namespace
{
bool IsEnabledHero(Unit const* unit)
{
    if (!unit || !sClasslessMgr->cfg.enabled || !sClasslessMgr->cfg.coaEnable)
        return false;

    Player const* player = unit->ToPlayer();
    if (!player)
        if (Unit const* owner = unit->GetOwner())
            player = owner->ToPlayer();

    return player && sClasslessMgr->IsParticipant(player);
}

constexpr uint32 ReapedSoul = 500363;
constexpr uint32 TormentedSoulsBuff = 500481;
constexpr uint32 TormentedSoulHeal = 500482;
constexpr uint32 SoulfusedConstitution = 561100;
constexpr uint32 SoulfusedConstitutionWard = 561234;
constexpr uint32 AdditionalTormentedSouls = 525013;
constexpr uint32 AdditionalTormentedSoulCount = 2;
constexpr float HealBase = 50.0f;
constexpr float HealPerLevel = 0.5f;
constexpr float HealPerStamina = 0.24f;

class spell_ascension_reaper_tormented_souls : public SpellScript
{
    PrepareSpellScript(spell_ascension_reaper_tormented_souls);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({ReapedSoul, TormentedSoulsBuff}); }

    void CountSouls()
    {
        if (!IsEnabledHero(GetCaster()))
        {
            _souls = 0;
            return;
        }
        Aura const* souls = GetCaster()->GetAura(ReapedSoul, GetCaster()->GetGUID());
        _souls = souls ? souls->GetStackAmount() : 0;
    }

    void SkipDelayedReapplication(SpellEffIndex effIndex)
    {
        if (!IsEnabledHero(GetCaster()))
            return;
        PreventHitDefaultEffect(effIndex);
    }

    void CreateTormentedSouls()
    {
        if (!IsEnabledHero(GetCaster()))
            return;
        Unit* caster = GetCaster();
        Aura* buff = caster->GetAura(TormentedSoulsBuff, caster->GetGUID());
        if (!buff || !_souls)
            return;

        uint32 stacks = _souls * (caster->HasAura(SoulfusedConstitution) ? 2 : 1);
        if (caster->HasAura(AdditionalTormentedSouls))
            stacks += AdditionalTormentedSoulCount;
        buff->SetStackAmount(uint8(std::min<uint32>(stacks, UINT8_MAX)));
    }

    void Register() override
    {
        BeforeCast += SpellCastFn(spell_ascension_reaper_tormented_souls::CountSouls);
        OnEffectLaunch += SpellEffectFn(spell_ascension_reaper_tormented_souls::SkipDelayedReapplication, EFFECT_1,
            SPELL_EFFECT_ASCENSION_TRIGGER_SPELL_DELAYED);
        OnEffectLaunchTarget += SpellEffectFn(spell_ascension_reaper_tormented_souls::SkipDelayedReapplication,
            EFFECT_1, SPELL_EFFECT_ASCENSION_TRIGGER_SPELL_DELAYED);
        OnEffectLaunch += SpellEffectFn(spell_ascension_reaper_tormented_souls::SkipDelayedReapplication, EFFECT_2,
            SPELL_EFFECT_ASCENSION_TRIGGER_SPELL_DELAYED);
        OnEffectLaunchTarget += SpellEffectFn(spell_ascension_reaper_tormented_souls::SkipDelayedReapplication,
            EFFECT_2, SPELL_EFFECT_ASCENSION_TRIGGER_SPELL_DELAYED);
        AfterCast += SpellCastFn(spell_ascension_reaper_tormented_souls::CreateTormentedSouls);
    }

    uint32 _souls = 0;
};

class aura_ascension_reaper_tormented_souls : public AuraScript
{
    PrepareAuraScript(aura_ascension_reaper_tormented_souls);

    bool _heroSource = false;

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({TormentedSoulHeal, SoulfusedConstitution, SoulfusedConstitutionWard});
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return _heroSource && eventInfo.GetDamageInfo() && eventInfo.GetActionTarget() == GetTarget();
    }

    void Consume(AuraEffect const*, ProcEventInfo&)
    {
        PreventDefaultAction();
        Unit* owner = GetTarget();
        float const heal = HealBase + HealPerLevel * owner->GetLevel() +
            HealPerStamina * std::max(0.0f, owner->GetStat(STAT_STAMINA));
        owner->CastCustomSpell(TormentedSoulHeal, SPELLVALUE_BASE_POINT0, int32(std::lround(heal)), owner, true);
        GetAura()->ModStackAmount(-1);
    }

    void Ward(AuraEffect const*, AuraEffectHandleModes)
    {
        _heroSource = IsEnabledHero(GetCaster());
        if (!_heroSource)
            return;
        Unit* owner = GetTarget();
        if (!owner->HasAura(SoulfusedConstitution))
            return;
        Aura* ward = owner->GetAura(SoulfusedConstitutionWard, owner->GetGUID());
        if (!ward)
            ward = owner->AddAura(SoulfusedConstitutionWard, owner);
        if (ward)
        {
            ward->SetMaxDuration(GetAura()->GetMaxDuration());
            ward->SetDuration(GetAura()->GetDuration());
        }
    }

    void EndWard(AuraEffect const*, AuraEffectHandleModes)
    {
        if (!_heroSource)
            return;
        GetTarget()->RemoveAurasDueToSpell(SoulfusedConstitutionWard, GetTarget()->GetGUID());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_reaper_tormented_souls::CheckProc);
        OnEffectProc += AuraEffectProcFn(aura_ascension_reaper_tormented_souls::Consume, EFFECT_1,
            SPELL_AURA_PROC_TRIGGER_SPELL);
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_reaper_tormented_souls::Ward, EFFECT_0,
            SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_reaper_tormented_souls::EndWard, EFFECT_0,
            SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL);
    }
};
}

void AddSC_AscensionReaperTormentedSouls()
{
    RegisterSpellScript(spell_ascension_reaper_tormented_souls);
    RegisterSpellScript(aura_ascension_reaper_tormented_souls);
}
