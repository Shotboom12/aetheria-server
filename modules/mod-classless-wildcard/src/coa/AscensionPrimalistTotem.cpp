/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "TemporarySummon.h"
#include "Unit.h"

namespace
{
enum PrimalTotemEntries : uint32
{
    PrimalTotem = 224861,
    PrimalTotemSummon = 504229,
    PrimalTotemAura = 806694
};

class spell_ascension_primal_totem : public SpellScript
{
    PrepareSpellScript(spell_ascension_primal_totem);

    bool Validate(SpellInfo const* info) override
    {
        return info && info->Id == PrimalTotemSummon &&
            info->SpellFamilyName == uint32(CLASS_WILDWALKER) + 6 &&
            info->Effects[EFFECT_0].Effect == SPELL_EFFECT_SUMMON &&
            info->Effects[EFFECT_0].MiscValue == int32(PrimalTotem) &&
            ValidateSpellInfo({PrimalTotemAura});
    }

    bool Load() override
    {
        Unit* caster = GetCaster();
        return caster && caster->IsPlayer() && HasCoAKit(caster, CLASS_WILDWALKER);
    }

    void Summon(SpellEffIndex index)
    {
        PreventHitDefaultEffect(index);
        Player* owner = GetCaster()->ToPlayer();
        WorldLocation const* destination = GetHitDest();
        int32 duration = GetSpellInfo()->GetDuration();
        if (!destination || duration <= 0)
            return;

        if (TempSummon* totem = owner->SummonCreature(PrimalTotem, *destination,
            TEMPSUMMON_TIMED_DESPAWN, uint32(duration)))
        {
            totem->SetOwnerGUID(owner->GetGUID());
            totem->SetFaction(owner->GetFaction());
            totem->SetLevel(owner->GetLevel());
            totem->SetReactState(REACT_PASSIVE);
            totem->SetUInt32Value(UNIT_CREATED_BY_SPELL, PrimalTotemSummon);
            totem->CastSpell(totem, PrimalTotemAura, TRIGGERED_FULL_MASK);
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_ascension_primal_totem::Summon, EFFECT_0, SPELL_EFFECT_SUMMON);
    }
};
}

void AddSC_AscensionPrimalistTotem()
{
    RegisterSpellScript(spell_ascension_primal_totem);
}
