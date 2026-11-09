/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Focused Hero adaptation of Judgement of the Three Hammers.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
enum JudgementSpells : uint32
{
    JudgementDamage = 520468,
    MountainHammer = 681130
};

class aura_ascension_primalist_judgement : public AuraScript
{
    PrepareAuraScript(aura_ascension_primalist_judgement);

    bool Check(ProcEventInfo& event)
    {
        Player* owner = GetTarget() ? GetTarget()->ToPlayer() : nullptr;
        Unit* victim = event.GetActionTarget();
        DamageInfo const* damage = event.GetDamageInfo();
        SpellInfo const* info = event.GetSpellInfo();
        return owner && owner->getClass() == CLASS_HERO && HasCoAKit(owner, CLASS_WILDWALKER) &&
            owner->IsAlive() && GetCaster() == owner && event.GetActor() == owner && victim &&
            victim != owner && !owner->IsFriendlyTo(victim) && damage && damage->GetDamage() &&
            damage->GetDamageType() != DOT && (!info || info->Id != JudgementDamage);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(aura_ascension_primalist_judgement::Check);
    }
};

class primalist_judgement_damage : public AllSpellScript
{
public:
    primalist_judgement_damage() : AllSpellScript("primalist_judgement_damage",
        {ALLSPELLHOOK_ON_CALCULATED_TARGET}) { }

    void OnSpellCalculatedTarget(Spell* spell, Unit*, TargetInfo& hit) override
    {
        Player* player = spell && spell->GetCaster() ? spell->GetCaster()->ToPlayer() : nullptr;
        if (!player || player->getClass() != CLASS_HERO || !HasCoAKit(player, CLASS_WILDWALKER) ||
            spell->GetSpellInfo()->Id != JudgementDamage || hit.damage <= 0)
            return;
        player->ApplySpellMod(MountainHammer, SPELLMOD_DAMAGE, hit.damage);
        player->ApplySpellMod(MountainHammer, SPELLMOD_DAMAGE, hit.damageBeforeTakenMods);
    }
};
}

void AddSC_AscensionPrimalistJudgement()
{
    RegisterSpellScript(aura_ascension_primalist_judgement);
    new primalist_judgement_damage();
}
