/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the pinned CoA source for the Hero-owned Primalist kit.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"

namespace
{
class aura_ascension_vitality_surge : public AuraScript
{
    PrepareAuraScript(aura_ascension_vitality_surge);

    bool Check(ProcEventInfo& event)
    {
        Player* owner = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        HealInfo const* heal = event.GetHealInfo();
        return owner && owner->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
            sClasslessMgr->cfg.coaEnable && HasCoAKit(owner, CLASS_WILDWALKER) &&
            GetCasterGUID() == owner->GetGUID() && event.GetActor() == owner && heal &&
            heal->GetHealer() == owner && heal->GetEffectiveHeal() > 0;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_vitality_surge::Check);
    }
};
}

void AddSC_AscensionPrimalistVitality()
{
    RegisterSpellScript(aura_ascension_vitality_surge);
}
