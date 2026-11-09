/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Hero-only adaptation from STRHercules/EsteriaWoW commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream commit author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "CoAPort.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include <iterator>

namespace
{
constexpr uint32 SPELL_ATTACK_BOLTS[] = {500618, 500619, 500620};
constexpr uint32 SPELL_VISUAL_BOLTS[] = {500621, 500622, 500623};
constexpr uint32 SPELL_REAPED_SOUL = 500363;
constexpr uint32 SPELL_BEYOND_DEATH = 301193;
constexpr uint32 SPELL_SOUL_BOLT = 500627;
constexpr uint32 BOLT_INTERVAL_MS = 2500;

bool IsEnabledHero(Unit const* unit)
{
    return HasCoAKit(unit, CLASS_REAPER);
}

class ReliquaryBolts : public BasicEvent
{
public:
    ReliquaryBolts(ObjectGuid caster, uint32 index) : _caster(caster), _index(index) { }

    bool Execute(uint64, uint32) override
    {
        Player* caster = ObjectAccessor::FindPlayer(_caster);
        if (!IsEnabledHero(caster) || !caster->IsAlive())
            return true;

        caster->CastSpell(caster, SPELL_ATTACK_BOLTS[_index], true);

        if (++_index < std::size(SPELL_ATTACK_BOLTS))
            caster->m_Events.AddEventAtOffset(new ReliquaryBolts(_caster, _index), Milliseconds(BOLT_INTERVAL_MS));
        return true;
    }

private:
    ObjectGuid _caster;
    uint32 _index;
};

class spell_reaper_reliquary_of_the_lost : public SpellScript
{
    PrepareSpellScript(spell_reaper_reliquary_of_the_lost);

    uint8 _souls = 0;

    void RememberSouls()
    {
        Player* caster = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        if (!IsEnabledHero(caster))
            return;

        Aura const* souls = caster->GetAura(SPELL_REAPED_SOUL, caster->GetGUID());
        _souls = souls ? souls->GetStackAmount() : 0;
    }

    void Launch()
    {
        Player* caster = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        if (!IsEnabledHero(caster))
            return;

        caster->m_Events.AddEventAtOffset(new ReliquaryBolts(caster->GetGUID(), 0), 0ms);

        for (uint8 index = 0; index < std::size(SPELL_VISUAL_BOLTS) && index < _souls; ++index)
            caster->CastSpell(caster, SPELL_VISUAL_BOLTS[index], true);
    }

    void Register() override
    {
        BeforeCast += SpellCastFn(spell_reaper_reliquary_of_the_lost::RememberSouls);
        AfterCast += SpellCastFn(spell_reaper_reliquary_of_the_lost::Launch);
    }
};

class spell_reaper_beyond_death_bolt : public SpellScript
{
    PrepareSpellScript(spell_reaper_beyond_death_bolt);

    void Launch(SpellEffIndex index)
    {
        SpellInfo const* source = GetSpell()->GetTriggeredByAuraSpellInfo();
        Unit* caster = GetCaster();
        if (!source || source->Id != SPELL_BEYOND_DEATH || !IsEnabledHero(caster))
            return;

        Unit* target = GetHitUnit();
        AuraEffect const* talent = caster->GetAuraEffect(SPELL_BEYOND_DEATH, EFFECT_0, caster->GetGUID());
        if (!target || !talent)
            return;

        PreventHitDefaultEffect(index);
        caster->CastSpell(target, SPELL_SOUL_BOLT, true, nullptr, talent);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_reaper_beyond_death_bolt::Launch, EFFECT_0,
            SPELL_EFFECT_TRIGGER_MISSILE);
    }
};
}

void AddSC_AscensionReaperReliquary()
{
    RegisterSpellScript(spell_reaper_reliquary_of_the_lost);
    RegisterSpellScript(spell_reaper_beyond_death_bolt);
}
