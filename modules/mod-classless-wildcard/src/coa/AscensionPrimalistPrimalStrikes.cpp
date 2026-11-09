/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
class aura_ascension_primal_strikes : public AuraScript
{
    PrepareAuraScript(aura_ascension_primal_strikes);

    bool Check(ProcEventInfo& event)
    {
        Unit* owner = GetTarget();
        Player* player = owner ? owner->ToPlayer() : nullptr;
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
            sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER) && player->IsAlive() &&
            GetCaster() == owner && event.GetActor() == owner && victim && victim != owner &&
            !owner->IsFriendlyTo(victim) && event.GetSpellInfo() && damage && damage->GetDamage() &&
            (damage->GetSchoolMask() & SPELL_SCHOOL_MASK_NORMAL) && (event.GetHitMask() & PROC_HIT_CRITICAL);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_primal_strikes::Check);
    }
};
}

void AddSC_AscensionPrimalistPrimalStrikes()
{
    RegisterSpellScript(aura_ascension_primal_strikes);
}
