/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"

#include <vector>

namespace
{
constexpr uint32 EarthsGuidanceCooldown = 681357;

bool IsEnabledPrimalist(Unit const* unit)
{
    Player const* player = unit && unit->IsPlayer() ? unit->ToPlayer() : nullptr;
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

class aura_ascension_earths_guidance : public AuraScript
{
    PrepareAuraScript(aura_ascension_earths_guidance);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({EarthsGuidanceCooldown}); }

    bool Check(ProcEventInfo& event)
    {
        Unit* owner = GetTarget();
        if (!IsEnabledPrimalist(owner) || !owner->IsAlive() || GetCaster() != owner || event.GetActor() != owner)
            return false;
        if (HealInfo const* heal = event.GetHealInfo())
            return heal->GetEffectiveHeal() > 0;
        DamageInfo const* damage = event.GetDamageInfo();
        Unit* victim = event.GetActionTarget();
        return damage && damage->GetDamage() && victim && victim != owner && !owner->IsFriendlyTo(victim);
    }

    void Reduce(AuraEffect const*, ProcEventInfo&)
    {
        PreventDefaultAction();
        Player* player = GetTarget()->ToPlayer();
        SpellInfo const* cooldownSpell = sSpellMgr->GetSpellInfo(EarthsGuidanceCooldown);
        if (!player || !IsEnabledPrimalist(player) || !cooldownSpell)
            return;

        int32 delta = cooldownSpell->Effects[EFFECT_0].CalcValue(player);
        if (delta >= 0)
            return;
        std::vector<uint32> cooldowns;
        for (auto const& [id, cooldown] : player->GetSpellCooldownMap())
            if (SpellInfo const* info = sSpellMgr->GetSpellInfo(id); info && info->SpellFamilyName == 37 &&
                info->SpellFamilyFlags.HasFlag(80, 4194560, 263168))
                cooldowns.push_back(id);
        for (uint32 id : cooldowns)
        {
            if (uint64(-int64(delta)) >= player->GetSpellCooldownDelay(id))
                player->RemoveSpellCooldown(id, true);
            else
                player->ModifySpellCooldown(id, delta);
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_earths_guidance::Check);
        OnEffectProc += AuraEffectProcFn(aura_ascension_earths_guidance::Reduce,
            EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};
}

void AddSC_AscensionPrimalistEarthsGuidance()
{
    RegisterSpellScript(aura_ascension_earths_guidance);
}