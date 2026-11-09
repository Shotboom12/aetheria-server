/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "SpellMgr.h"
#include "SpellAuras.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
class primalist_periodic_critical : public AllSpellScript
{
public:
    primalist_periodic_critical() : AllSpellScript("primalist_periodic_critical", {ALLSPELLHOOK_ON_CRIT_CHANCE}) { }

    void OnSpellCritChance(Spell* spell, Unit* target, float& chance) override
    {
        if (!spell || !target)
            return;

        Unit* caster = spell->GetCaster()->ToUnit();
        Player* player = caster ? caster->ToPlayer() : nullptr;
        SpellInfo const* info = spell->GetSpellInfo();
        if (!player || player->getClass() != CLASS_HERO || !sClasslessMgr->cfg.enabled ||
            !sClasslessMgr->cfg.coaEnable || !HasCoAKit(player, CLASS_WILDWALKER) ||
            !info || !player->HasAura(805336) || info->SpellFamilyName != 37 ||
            !(info->SpellFamilyFlags[0] & 8))
            return;

        for (AuraEffect const* effect : target->GetAuraEffectsByType(SPELL_AURA_PERIODIC_DAMAGE))
            if (effect->GetCasterGUID() == player->GetGUID() && effect->GetSpellInfo()->SpellFamilyName == 37 &&
                (effect->GetSpellInfo()->SpellFamilyFlags[0] & 64))
            {
                chance = 100.0f;
                return;
            }
    }
};
}

void AddSC_AscensionPrimalistPeriodicCritical()
{
    new primalist_periodic_critical();
}