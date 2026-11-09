/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of the Primalist pet damage proc.

#include "CoAPort.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
class aura_ascension_primalist_bloody_claws : public AuraScript
{
    PrepareAuraScript(aura_ascension_primalist_bloody_claws);

    bool Check(ProcEventInfo& event)
    {
        Player* owner = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        Unit* pet = GetTarget();
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        return owner && owner->getClass() == CLASS_HERO && HasCoAKit(owner, CLASS_WILDWALKER) &&
            owner->GetPet() == pet && pet && pet->IsAlive() && event.GetActor() == pet && victim &&
            victim != pet && !pet->IsFriendlyTo(victim) && damage && damage->GetDamage();
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_primalist_bloody_claws::Check);
    }
};
}

void AddSC_AscensionPrimalistBloodyClaws()
{
    RegisterSpellScript(aura_ascension_primalist_bloody_claws);
}
