/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Hero-only adaptation of the Primalist Lithic Lance replacement.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
constexpr uint32 GeodeBarrageFirst = 500402;
constexpr uint32 LithicLanceTalent = 706159;
constexpr uint32 LithicLanceReady = 807048;
constexpr uint32 LithicLanceSpell = 681251;
constexpr uint32 LanceEarthshaping = 681264;
constexpr uint32 LanceCooldown = 681354;

Player* GetHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

bool HasPrimalistKit(Unit* unit)
{
    return HasCoAKit(unit, CLASS_WILDWALKER);
}

class aura_ascension_lithic_lance_ready : public AuraScript
{
    PrepareAuraScript(aura_ascension_lithic_lance_ready);

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({ GeodeBarrageFirst, LithicLanceTalent, LithicLanceSpell });
    }

    bool Load() override { return GetHero(GetUnitOwner()) != nullptr; }

    void Apply(AuraEffect const*, AuraEffectHandleModes)
    {
        Player* player = GetTarget()->ToPlayer();
        if (!player || !HasPrimalistKit(player) || !player->HasAura(LithicLanceTalent, player->GetGUID()))
            return;

        if (player->GetSpellMap().find(LithicLanceSpell) == player->GetSpellMap().end())
            player->learnSpell(LithicLanceSpell, true);

        uint32 highest = 0;
        for (uint32 id = GeodeBarrageFirst; id; id = sSpellMgr->GetNextSpellInChain(id))
            if (player->HasActiveSpell(id))
                highest = id;
        if (highest)
            player->SetTemporarySpellReplacement(highest, LithicLanceSpell);
    }

    void Remove(AuraEffect const*, AuraEffectHandleModes)
    {
        Player* player = GetTarget()->ToPlayer();
        if (!player)
            return;
        for (uint32 id = GeodeBarrageFirst; id; id = sSpellMgr->GetNextSpellInChain(id))
            if (player->GetTemporarySpellReplacement(id) == LithicLanceSpell)
                player->SetTemporarySpellReplacement(id, 0);
        player->removeSpell(LithicLanceSpell, SPEC_MASK_ALL, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_lithic_lance_ready::Apply,
            EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_lithic_lance_ready::Remove,
            EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class aura_ascension_lithic_lance_talent : public AuraScript
{
    PrepareAuraScript(aura_ascension_lithic_lance_talent);

    bool Load() override { return GetHero(GetUnitOwner()) != nullptr; }

    void Remove(AuraEffect const*, AuraEffectHandleModes)
    {
        if (Player* player = GetHero(GetTarget()))
            player->RemoveAurasDueToSpell(LithicLanceReady, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_lithic_lance_talent::Remove,
            EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_ascension_lithic_lance : public SpellScript
{
    PrepareSpellScript(spell_ascension_lithic_lance);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({ LithicLanceReady }); }
    bool Load() override { return GetHero(GetCaster()) != nullptr; }

    void Consume()
    {
        if (Player* player = GetHero(GetCaster()); player && HasPrimalistKit(player))
            player->RemoveAurasDueToSpell(LithicLanceReady, player->GetGUID());
    }

    void Rage()
    {
        Player* player = GetHero(GetCaster());
        if (player && HasPrimalistKit(player) && GetHitDamage() > 0)
            player->EnergizeBySpell(player, LithicLanceSpell, 200, POWER_RAGE);
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_ascension_lithic_lance::Consume);
        AfterHit += SpellHitFn(spell_ascension_lithic_lance::Rage);
    }
};

class primalist_lithic_lance_metadata : public GlobalScript
{
public:
    primalist_lithic_lance_metadata() : GlobalScript("primalist_lithic_lance_metadata",
        { GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR }) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (info->SpellFamilyName == 37 && (info->Id == LanceEarthshaping || info->Id == LanceCooldown) &&
            info->Effects[EFFECT_1].TriggerSpell == LithicLanceReady)
            info->Effects[EFFECT_1].Effect = 0;
        if (info->Id == LanceEarthshaping && info->SpellFamilyName == 37 &&
            info->Effects[EFFECT_0].Effect == SPELL_EFFECT_ASCENSION_MODIFY_AURA_STACKS &&
            info->Effects[EFFECT_0].MiscValue == 1)
            info->Effects[EFFECT_0].MiscValue = 2;
    }
};
}

void AddSC_AscensionPrimalistLithicLance()
{
    new primalist_lithic_lance_metadata();
    RegisterSpellScript(aura_ascension_lithic_lance_ready);
    RegisterSpellScript(aura_ascension_lithic_lance_talent);
    RegisterSpellScript(spell_ascension_lithic_lance);
}
