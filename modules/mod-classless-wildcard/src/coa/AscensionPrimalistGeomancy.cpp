/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of Rockslide and Tectonic Resonance.

#include "CoAPort.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellInfo.h"
#include "Unit.h"

#include <algorithm>

namespace
{
enum GeomancySpells : uint32
{
    Rockslide = 560154,
    RockslideHelper = 560155,
    StoneshardFirst = 680448,
    TectonicResonance = 707173,
    EarthquakeSlow = 520696
};

constexpr TriggerCastFlags RepeatCastFlags = TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_DISALLOW_PROC_EVENTS);

Player* GetPrimalistHero(Unit* unit)
{
    Player* player = unit ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) ? player : nullptr;
}

class aura_ascension_tectonic_resonance_slow : public AuraScript
{
    PrepareAuraScript(aura_ascension_tectonic_resonance_slow);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({TectonicResonance, EarthquakeSlow}); }

    void Calculate(AuraEffect const*, int32& amount, bool&)
    {
        Player* caster = GetPrimalistHero(GetCaster());
        if (caster)
            if (AuraEffect const* talent = caster->GetAuraEffect(TectonicResonance, EFFECT_2))
                amount += talent->GetAmount();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(aura_ascension_tectonic_resonance_slow::Calculate,
            EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED);
    }
};

class aura_ascension_rockslide : public AuraScript
{
    PrepareAuraScript(aura_ascension_rockslide);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({RockslideHelper, StoneshardFirst}); }

    bool Check(ProcEventInfo& event)
    {
        Player* owner = GetPrimalistHero(GetTarget());
        Spell const* source = event.GetProcSpell();
        Unit* victim = source ? source->m_targets.GetUnitTarget() : nullptr;
        return owner && owner->IsAlive() && event.GetActor() == owner && source && source->GetCaster() == owner &&
            source->GetSpellInfo()->SpellFamilyName == 37 &&
            sSpellMgr->GetFirstSpellInChain(source->GetSpellInfo()->Id) == StoneshardFirst &&
            victim && victim->IsAlive() && owner->IsValidAttackTarget(victim);
    }

    void Repeat(AuraEffect const*, ProcEventInfo& event)
    {
        PreventDefaultAction();
        Player* owner = GetPrimalistHero(GetTarget());
        Spell const* source = event.GetProcSpell();
        if (!owner || !source || !source->m_targets.GetUnitTarget())
            return;

        ObjectGuid const ownerGuid = owner->GetGUID();
        ObjectGuid const victimGuid = source->m_targets.GetUnitTarget()->GetGUID();
        uint32 const spell = source->GetSpellInfo()->Id;
        int32 const delay = sSpellMgr->GetSpellInfo(RockslideHelper)->Effects[EFFECT_0].CalcValue(owner);
        owner->m_Events.AddEventAtOffset([ownerGuid, victimGuid, spell]()
        {
            Player* player = ObjectAccessor::FindPlayer(ownerGuid);
            if (!GetPrimalistHero(player) || !player->IsAlive() || !player->HasAura(Rockslide, ownerGuid))
                return;
            Unit* victim = ObjectAccessor::GetUnit(*player, victimGuid);
            if (victim && victim->IsAlive() && player->IsValidAttackTarget(victim))
                player->CastSpell(victim, spell, RepeatCastFlags);
        }, Milliseconds(std::max(1, delay)));
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_rockslide::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_rockslide::Repeat, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};
}

void AddSC_AscensionPrimalistGeomancy()
{
    RegisterSpellScript(aura_ascension_tectonic_resonance_slow);
    RegisterSpellScript(aura_ascension_rockslide);
}
