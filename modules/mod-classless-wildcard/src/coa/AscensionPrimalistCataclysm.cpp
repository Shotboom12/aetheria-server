/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "SpellInfo.h"
#include "SpellAuras.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
enum CataclysmSpells : uint32
{
    CataclysmTalent = 680444,
    SeismicReset = 680445,
    SeismicGraspReset = 681380
};

class aura_ascension_primalist_cataclysm : public AuraScript
{
    PrepareAuraScript(aura_ascension_primalist_cataclysm);

    bool Validate(SpellInfo const*) override { return ValidateSpellInfo({SeismicReset, SeismicGraspReset}); }

    bool Load() override
    {
        Unit* owner = GetUnitOwner();
        Player* player = owner ? owner->ToPlayer() : nullptr;
        return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
            sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER) &&
            GetCasterGUID() == player->GetGUID();
    }

    void Reset(AuraEffect const*, ProcEventInfo&)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SeismicReset, TRIGGERED_FULL_MASK);
        GetTarget()->CastSpell(GetTarget(), SeismicGraspReset, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(aura_ascension_primalist_cataclysm::Reset,
            EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};
}

void AddSC_AscensionPrimalistCataclysm()
{
    RegisterSpellScript(aura_ascension_primalist_cataclysm);
}