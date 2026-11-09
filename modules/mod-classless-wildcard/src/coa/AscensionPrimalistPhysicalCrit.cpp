/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "Unit.h"

namespace
{
class primalist_physical_spell_crit : public AllSpellScript
{
public:
    primalist_physical_spell_crit() : AllSpellScript("primalist_physical_spell_crit",
        {ALLSPELLHOOK_ON_CRIT_CHANCE}) { }

    void OnSpellCritChance(Spell* spell, Unit* target, float& chance) override
    {
        Unit* caster = spell ? spell->GetCaster()->ToUnit() : nullptr;
        Player* player = caster ? caster->ToPlayer() : nullptr;
        SpellInfo const* info = spell ? spell->GetSpellInfo() : nullptr;
        if (!player || player->getClass() != CLASS_HERO || !sClasslessMgr->cfg.enabled ||
            !sClasslessMgr->cfg.coaEnable || !HasCoAKit(player, CLASS_WILDWALKER) || !target || !info ||
            info->SpellFamilyName != 37 || info->DmgClass != SPELL_DAMAGE_CLASS_MAGIC ||
            info->GetSchoolMask() != SPELL_SCHOOL_MASK_NORMAL || !info->IsCritCapable() ||
            info->HasAttribute(SPELL_ATTR2_CANT_CRIT))
            return;

        chance += caster->SpellDoneCritChance(target, info, SPELL_SCHOOL_MASK_NATURE, BASE_ATTACK, false) -
            caster->SpellDoneCritChance(target, info, info->GetSchoolMask(), BASE_ATTACK, false);
    }
};
}

void AddSC_AscensionPrimalistPhysicalCrit()
{
    new primalist_physical_spell_crit();
}
