/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of the Primalist physical-periodic critical hook.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

#include <algorithm>

namespace
{
constexpr uint32 Earthshaker = 300698;

class aura_ascension_earthshaker_periodic : public AuraScript
{
    PrepareAuraScript(aura_ascension_earthshaker_periodic);

    bool Load() override
    {
        Player* player = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        SpellInfo const* info = GetSpellInfo();
        return player && player->getClass() == CLASS_HERO && HasCoAKit(player, CLASS_WILDWALKER) &&
            info && info->SpellFamilyName == 37 && info->GetSchoolMask() == SPELL_SCHOOL_MASK_NORMAL;
    }

    void Snapshot(AuraEffect const* effect, AuraEffectHandleModes)
    {
        Unit* caster = GetCaster();
        if (!caster || !caster->HasAura(Earthshaker))
            return;

        SpellInfo const* info = GetSpellInfo();
        float chance = caster->SpellDoneCritChance(GetTarget(), info, SPELL_SCHOOL_MASK_NATURE, BASE_ATTACK, true);
        chance = GetTarget()->SpellTakenCritChance(caster, info, info->GetSchoolMask(), chance, BASE_ATTACK, true);
        GetEffect(effect->GetEffIndex())->SetCritChance(std::max(0.0f, chance));
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_earthshaker_periodic::Snapshot,
            EFFECT_ALL, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};
}

void AddSC_AscensionPrimalistEarthshaker()
{
    RegisterSpellScript(aura_ascension_earthshaker_periodic);
}
