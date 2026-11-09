/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"

namespace
{
enum UrsocSpells : uint32
{
    SavageFrenzy = 806549,
    SonOfUrsoc = 706176,
    UrsocForm = 806048
};

class aura_ascension_son_of_ursoc : public AuraScript
{
    PrepareAuraScript(aura_ascension_son_of_ursoc);

    bool Validate(SpellInfo const* info) override
    {
        return info && info->Id == SavageFrenzy && info->SpellFamilyName == uint32(CLASS_WILDWALKER) + 6 &&
            info->Effects[EFFECT_0].IsAura(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE) &&
            ValidateSpellInfo({SonOfUrsoc, UrsocForm});
    }

    bool Load() override
    {
        Unit* owner = GetUnitOwner();
        return owner && owner->IsPlayer() && HasCoAKit(owner, CLASS_WILDWALKER) &&
            GetCasterGUID() == owner->GetGUID();
    }

    void Apply(AuraEffect const*, AuraEffectHandleModes)
    {
        Unit* owner = GetTarget();
        if (owner && owner->HasAura(SonOfUrsoc, owner->GetGUID()) && owner->IsInWorld())
        {
            owner->RemoveMovementImpairingAuras(true);
            owner->CastSpell(owner, UrsocForm, true);
        }
    }

    void Remove(AuraEffect const*, AuraEffectHandleModes)
    {
        GetTarget()->RemoveAurasDueToSpell(UrsocForm, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(aura_ascension_son_of_ursoc::Apply,
            EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(aura_ascension_son_of_ursoc::Remove,
            EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL);
    }
};

class primalist_ursoc_metadata : public GlobalScript
{
public:
    primalist_ursoc_metadata() : GlobalScript("primalist_ursoc_metadata",
        {GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR}) { }

    void OnLoadSpellCustomAttr(SpellInfo* info) override
    {
        if (!info || info->Id != UrsocForm || info->SpellFamilyName != 36)
            return;

        SpellEffectInfo const& form = info->Effects[EFFECT_0];
        SpellEffectInfo const& second = info->Effects[EFFECT_1];
        SpellEffectInfo const& third = info->Effects[EFFECT_2];
        if (form.Effect == SPELL_EFFECT_APPLY_AURA && form.IsAura(SPELL_AURA_MOD_SHAPESHIFT) &&
            form.BasePoints == 0 && form.DieSides == 0 && form.MiscValue == 421493 && form.MiscValueB == 0 &&
            second.Effect == SPELL_EFFECT_NONE && second.BasePoints == 0 && second.DieSides == 0 &&
            second.ApplyAuraName == 0 && second.MiscValue == 0 && second.MiscValueB == 0 &&
            third.Effect == SPELL_EFFECT_NONE && third.BasePoints == 0 && third.DieSides == 0 &&
            third.ApplyAuraName == 0 && third.MiscValue == 0 && third.MiscValueB == 0)
            info->AttributesCu |= SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED;
    }
};
}

void AddSC_AscensionPrimalistUrsoc()
{
    new primalist_ursoc_metadata();
    RegisterSpellScript(aura_ascension_son_of_ursoc);
}
