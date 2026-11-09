/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the pinned CoA source with Hero and owned-Primalist-kit gating.

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "Unit.h"

namespace
{
enum ShatteringSpells : uint32
{
    Shattering = 520469,
    ShatteringBuff = 520729,
    JudgementDamage = 520468
};

class primalist_shattering : public AllSpellScript
{
public:
    primalist_shattering() : AllSpellScript("primalist_shattering", {ALLSPELLHOOK_ON_HIT_RESULT}) { }

    void OnSpellHitResult(Spell* spell, Unit*, uint8 miss, uint32 damage, uint32, bool) override
    {
        Unit* caster = spell ? spell->GetCaster()->ToUnit() : nullptr;
        SpellInfo const* info = spell ? spell->GetSpellInfo() : nullptr;
        if (!damage || miss != SPELL_MISS_NONE || !caster || !caster->IsPlayer() ||
            !HasCoAKit(caster, CLASS_WILDWALKER) || !caster->IsAlive() || !info ||
            info->Id != JudgementDamage || info->SpellFamilyName != 37 ||
            !caster->HasAura(Shattering, caster->GetGUID()))
            return;

        caster->CastSpell(caster, ShatteringBuff, TRIGGERED_FULL_MASK);
    }
};
}

void AddSC_AscensionPrimalistShattering()
{
    new primalist_shattering();
}
