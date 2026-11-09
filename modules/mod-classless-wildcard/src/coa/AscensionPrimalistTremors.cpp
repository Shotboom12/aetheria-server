/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
constexpr uint32 TremorsFreeCast = 562312;

bool IsEnabledPrimalist(Player const* player)
{
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

class aura_ascension_primalist_periodic_damage : public AuraScript
{
    PrepareAuraScript(aura_ascension_primalist_periodic_damage);

    bool Load() override
    {
        Player* owner = GetUnitOwner() ? GetUnitOwner()->ToPlayer() : nullptr;
        return IsEnabledPrimalist(owner) && GetCasterGUID() == owner->GetGUID();
    }

    bool Check(ProcEventInfo& event)
    {
        Unit* owner = GetTarget();
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        return IsEnabledPrimalist(owner ? owner->ToPlayer() : nullptr) && owner->IsAlive() &&
            GetCaster() == owner && event.GetActor() == owner && victim && victim != owner &&
            !owner->IsFriendlyTo(victim) && damage && damage->GetDamage() && damage->GetDamageType() == DOT;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_primalist_periodic_damage::Check);
    }
};

class primalist_tremors_metadata : public GlobalScript
{
public:
    primalist_tremors_metadata() : GlobalScript("primalist_tremors_metadata",
        {GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR}) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (!sClasslessMgr->cfg.enabled || !sClasslessMgr->cfg.coaEnable || !info ||
            info->Id != TremorsFreeCast || info->SpellFamilyName != 37 ||
            info->Effects[EFFECT_0].Effect != SPELL_EFFECT_APPLY_AURA ||
            !info->Effects[EFFECT_0].IsAura(SPELL_AURA_ADD_PCT_MODIFIER) ||
            info->Effects[EFFECT_0].MiscValue != SPELLMOD_COST ||
            info->Effects[EFFECT_0].SpellClassMask != flag96(16, 4194304, 262144))
            return;

        info->Effects[EFFECT_0].SpellClassMask[0] |= 64;
    }
};
}

void AddSC_AscensionPrimalistTremors()
{
    RegisterSpellScript(aura_ascension_primalist_periodic_damage);
    new primalist_tremors_metadata();
}