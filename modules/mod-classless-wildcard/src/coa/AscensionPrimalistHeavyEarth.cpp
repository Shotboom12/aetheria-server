/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Hero-only adaptation of Primalist Heavy Earth.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>
#include <limits>

namespace
{
constexpr uint32 HeavyEarthTalent = 706160;
constexpr uint32 HeavyEarthBuff = 560142;
constexpr uint32 HeavyEarthDamage = 561198;
constexpr uint32 Earthshaping = 680441;
constexpr uint32 GolemForm = 805335;
constexpr uint32 Stoneshard = 680448;
constexpr uint32 GeodeBarrageDamage = 803138;

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class spell_ascension_heavy_earth : public SpellScript
{
    PrepareSpellScript(spell_ascension_heavy_earth);

    bool Validate(SpellInfo const*) override
    {
        return ValidateSpellInfo({ HeavyEarthTalent, HeavyEarthBuff, Earthshaping, GolemForm });
    }

    bool Load() override { return GetPrimalistHero(GetCaster()) != nullptr; }

    void Consume()
    {
        Player* player = GetPrimalistHero(GetCaster());
        if (!player || !player->HasAura(HeavyEarthTalent, player->GetGUID()))
            return;

        Aura const* resource = player->GetAura(Earthshaping, player->GetGUID());
        if (!resource || !resource->GetStackAmount())
            return;

        uint8 stacks = resource->GetStackAmount();
        Aura* reward = player->AddAura(HeavyEarthBuff, player);
        if (!reward)
            return;
        if (AuraEffect* effect = reward->GetEffect(EFFECT_0))
            effect->ChangeAmount(5 * int32(stacks));
        reward->RefreshDuration();
        player->RemoveAurasDueToSpell(Earthshaping, player->GetGUID());
        if (Aura* form = player->GetAura(GolemForm, player->GetGUID()))
            form->RefreshDuration();
    }

    void Register() override { AfterCast += SpellCastFn(spell_ascension_heavy_earth::Consume); }
};

class aura_ascension_heavy_earth : public AuraScript
{
    PrepareAuraScript(aura_ascension_heavy_earth);

    bool Validate(SpellInfo const* info) override
    {
        return info->Id == HeavyEarthBuff && info->Effects[EFFECT_0].ApplyAuraName == AuraType(354) &&
            ValidateSpellInfo({ HeavyEarthDamage });
    }

    bool Load() override { return GetPrimalistHero(GetUnitOwner()) != nullptr; }

    bool Check(ProcEventInfo& event)
    {
        Player* owner = GetPrimalistHero(GetTarget());
        Unit* victim = event.GetActionTarget();
        SpellInfo const* spell = event.GetSpellInfo();
        DamageInfo const* damage = event.GetDamageInfo();
        if (!owner || !owner->IsAlive() || GetCasterGUID() != owner->GetGUID() || event.GetActor() != owner ||
            !victim || owner->IsFriendlyTo(victim) || !spell || spell->SpellFamilyName != 37 || !damage ||
            !damage->GetDamage() || damage->GetDamageType() == DOT)
            return false;

        SpellInfo const* firstRank = spell->GetFirstRankSpell();
        return spell->Id == GeodeBarrageDamage || (firstRank && firstRank->Id == Stoneshard);
    }

    void Repeat(AuraEffect const* effect, ProcEventInfo& event)
    {
        PreventDefaultAction();
        uint64 amount = uint64(event.GetDamageInfo()->GetDamage()) * std::max(0, effect->GetAmount()) / 100;
        if (amount)
            GetTarget()->CastCustomSpell(HeavyEarthDamage, SPELLVALUE_BASE_POINT0,
                int32(std::min<uint64>(amount, std::numeric_limits<int32>::max())),
                event.GetActionTarget(), TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_heavy_earth::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_heavy_earth::Repeat, EFFECT_0, AuraType(354));
    }
};

class primalist_heavy_earth_metadata : public GlobalScript
{
public:
    primalist_heavy_earth_metadata() : GlobalScript("primalist_heavy_earth_metadata",
        { GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR }) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (info->Id == HeavyEarthDamage && info->SpellFamilyName == 37 &&
            info->Effects[EFFECT_0].Effect == SPELL_EFFECT_SCHOOL_DAMAGE)
            info->AscensionInheritsResolvedAmount = true;
    }
};
}

void AddSC_AscensionPrimalistHeavyEarth()
{
    new primalist_heavy_earth_metadata();
    RegisterSpellScript(spell_ascension_heavy_earth);
    RegisterSpellScript(aura_ascension_heavy_earth);
}
