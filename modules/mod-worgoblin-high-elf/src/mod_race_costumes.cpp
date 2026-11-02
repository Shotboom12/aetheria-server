#include "ScriptMgr.h"
#include "Player.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

#include <cstdint>
#include <map>

namespace
{
    struct GenderedDisplay
    {
        uint32 maleDisplayId;
        uint32 femaleDisplayId;
    };

    // To add a new costume: add a line below, recompile, and make sure
    // the trigger spell's effect is a SPELL_AURA_DUMMY (not Transform) -
    // see the note at the bottom of this file about spell_script_names
    // and the spell's own effect setup.
    std::map<uint32, GenderedDisplay> const CostumeSpells =
    {
        // spellId, { maleDisplayId, femaleDisplayId }
        { 68994,    { 94135,          94136          } }, // Gilnean disguise
        { 110020,   { 20585,          20584          } }, // Tauren disguise
    };

    uint32 GetCostumeDisplayId(uint32 spellId, uint8 gender)
    {
        auto itr = CostumeSpells.find(spellId);
        if (itr == CostumeSpells.end())
            return 0;

        return (gender == GENDER_FEMALE) ? itr->second.femaleDisplayId : itr->second.maleDisplayId;
    }
}

// ============================================================
// Aura script - this aura is a plain SPELL_AURA_DUMMY with no other
// built-in behavior, so there's no competing native handler fighting
// us for control of the model. We own the whole apply/remove cycle:
// snapshot the player's current display ID when the aura lands,
// switch to the gendered costume model, and put the snapshot back
// when the aura is removed. This mirrors how AzerothCore's own
// spell_gen_model_visible script (src/server/scripts/Spells/
// spell_generic.cpp) handles the same kind of "disguise while this
// aura is up" pattern.
// ============================================================

class spell_costume_override : public AuraScript
{
    PrepareAuraScript(spell_costume_override);

    uint32 _previousDisplayId = 0;

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* player = GetUnitOwner()->ToPlayer();
        if (!player)
            return;

        uint32 displayId = GetCostumeDisplayId(GetId(), player->getGender());
        if (!displayId)
            return;

        _previousDisplayId = player->GetDisplayId();
        player->SetDisplayId(displayId);

        LOG_DEBUG(
            "scripts",
            "Custom costume applied: spell={}, gender={}, display={}",
            GetId(),
            (uint32)player->getGender(),
            displayId
        );
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* player = GetUnitOwner()->ToPlayer();
        if (!player)
            return;

        if (_previousDisplayId)
            player->SetDisplayId(_previousDisplayId);

        LOG_DEBUG("scripts", "Custom costume removed: spell={}", GetId());
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(
            spell_costume_override::HandleEffectApply,
            EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL
        );
        OnEffectRemove += AuraEffectRemoveFn(
            spell_costume_override::HandleEffectRemove,
            EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL
        );
    }
};

// ============================================================
// Script registration
//
// This binds to whichever spells have a `custom_race_costumes`-style
// spell_script_names row pointing at "spell_costume_override" (same
// requirement as before - see prior messages for the INSERT).
//
// IMPORTANT: each trigger spell's own effect must be changed from
// SPELL_AURA_TRANSFORM to SPELL_AURA_DUMMY (still on EFFECT_0) in
// whatever tool you used to create these custom spells, and the
// client-side DBC re-patched/re-extracted. Otherwise this script
// never fires, since it's listening for a dummy effect that isn't
// there.
// ============================================================

// Saberon appearance toggle. The creator's two-model selector is adapted from Medviten's WHE client support.
namespace
{
    constexpr uint8 SaberonRace = 64;
    constexpr uint32 SaberonTwoForms = 330064;
    constexpr uint32 SaberonVulperaForm = 330065;
}

class spell_saberon_two_forms : public SpellScript
{
    PrepareSpellScript(spell_saberon_two_forms);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SaberonVulperaForm });
    }

    SpellCastResult CheckCast()
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player || player->getRace(true) != SaberonRace)
            return SPELL_FAILED_BAD_TARGETS;

        if (player->IsInCombat())
            return SPELL_FAILED_AFFECTING_COMBAT;

        if (player->IsMounted())
            return SPELL_FAILED_NOT_MOUNTED;

        if (player->GetShapeshiftForm() != FORM_NONE)
            return SPELL_FAILED_NOT_SHAPESHIFT;

        return SPELL_CAST_OK;
    }

    void HandleToggle(SpellEffIndex /*effectIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player || player->getRace(true) != SaberonRace)
            return;

        if (player->HasAura(SaberonVulperaForm))
            player->RemoveAurasDueToSpell(SaberonVulperaForm);
        else
            player->CastSpell(player, SaberonVulperaForm, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_saberon_two_forms::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_saberon_two_forms::HandleToggle, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class player_saberon_two_forms : public PlayerScript
{
public:
    player_saberon_two_forms() : PlayerScript("player_saberon_two_forms") { }

    void OnPlayerLogin(Player* player) override
    {
        if (player->getRace(true) == SaberonRace)
        {
            if (!player->HasSpell(SaberonTwoForms))
                player->learnSpell(SaberonTwoForms);
        }
        else
        {
            player->RemoveAurasDueToSpell(SaberonVulperaForm);
            if (player->HasSpell(SaberonTwoForms))
                player->removeSpell(SaberonTwoForms, SPEC_MASK_ALL, false);
        }
    }

    bool OnPlayerCanLearnSpell(Player* player, uint32 spellId) override
    {
        return (spellId != SaberonTwoForms && spellId != SaberonVulperaForm)
            || player->getRace(true) == SaberonRace;
    }

    void OnPlayerEnterCombat(Player* player, Unit* /*enemy*/) override
    {
        player->RemoveAurasDueToSpell(SaberonVulperaForm);
    }
};

// Dracthyr appearance toggle. The creator's two-model selector is adapted from Medviten's WHE client support.
namespace
{
    bool IsDracthyr(Player* player)
    {
        return player->getRace(true) == 66 || player->getRace(true) == 67;
    }
    constexpr uint32 DracthyrTwoForms = 330066;
    constexpr uint32 DracthyrDragonForm = 330067;
}

class spell_dracthyr_two_forms : public SpellScript
{
    PrepareSpellScript(spell_dracthyr_two_forms);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ DracthyrDragonForm });
    }

    SpellCastResult CheckCast()
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player || !IsDracthyr(player))
            return SPELL_FAILED_BAD_TARGETS;

        if (player->IsInCombat())
            return SPELL_FAILED_AFFECTING_COMBAT;

        if (player->IsMounted())
            return SPELL_FAILED_NOT_MOUNTED;

        if (player->GetShapeshiftForm() != FORM_NONE)
            return SPELL_FAILED_NOT_SHAPESHIFT;

        return SPELL_CAST_OK;
    }

    void HandleToggle(SpellEffIndex /*effectIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player || !IsDracthyr(player))
            return;

        if (player->HasAura(DracthyrDragonForm))
            player->RemoveAurasDueToSpell(DracthyrDragonForm);
        else
            player->CastSpell(player, DracthyrDragonForm, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_dracthyr_two_forms::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_dracthyr_two_forms::HandleToggle, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class player_dracthyr_two_forms : public PlayerScript
{
public:
    player_dracthyr_two_forms() : PlayerScript("player_dracthyr_two_forms") { }

    void OnPlayerLogin(Player* player) override
    {
        if (IsDracthyr(player))
        {
            if (!player->HasSpell(DracthyrTwoForms))
                player->learnSpell(DracthyrTwoForms);
        }
        else
        {
            player->RemoveAurasDueToSpell(DracthyrDragonForm);
            if (player->HasSpell(DracthyrTwoForms))
                player->removeSpell(DracthyrTwoForms, SPEC_MASK_ALL, false);
        }
    }

    bool OnPlayerCanLearnSpell(Player* player, uint32 spellId) override
    {
        return (spellId != DracthyrTwoForms && spellId != DracthyrDragonForm)
            || IsDracthyr(player);
    }

};

void AddSC_mod_race_costumes()
{
    RegisterSpellScript(spell_costume_override);
    RegisterSpellScript(spell_saberon_two_forms);
    new player_saberon_two_forms();
    RegisterSpellScript(spell_dracthyr_two_forms);
    new player_dracthyr_two_forms();
}