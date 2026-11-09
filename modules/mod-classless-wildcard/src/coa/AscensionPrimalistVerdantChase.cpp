/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from the staged STRHercules/azerothcore-wotlk-coa core input.

#include "ClasslessMgr.h"
#include "CoAPort.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellInfo.h"

#include <algorithm>
#include <utility>
#include <vector>

namespace
{
enum VerdantChaseSpells : uint32
{
    VerdantChaseHelper = 560306,
    SpiritCharge = 800144,
    PrimalRush = 500696
};

bool IsEnabledPrimalist(Player const* player)
{
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled &&
        sClasslessMgr->cfg.coaEnable && HasCoAKit(player, CLASS_WILDWALKER);
}

class spell_ascension_verdant_chase : public SpellScript
{
    PrepareSpellScript(spell_ascension_verdant_chase);

    bool Load() override { return IsEnabledPrimalist(GetCaster() ? GetCaster()->ToPlayer() : nullptr); }

    bool Validate(SpellInfo const* info) override
    {
        return info && info->Id == VerdantChaseHelper &&
            info->Effects[EFFECT_0].Effect == SPELL_EFFECT_ASCENSION_MODIFY_COOLDOWN_PCT &&
            info->Effects[EFFECT_0].MiscValue == int32(SpiritCharge) &&
            info->Effects[EFFECT_1].Effect == SPELL_EFFECT_ASCENSION_MODIFY_COOLDOWN_PCT &&
            info->Effects[EFFECT_1].MiscValue == int32(PrimalRush) &&
            ValidateSpellInfo({SpiritCharge, PrimalRush});
    }

    void Reduce(SpellEffIndex index)
    {
        PreventHitDefaultEffect(index);
        Player* player = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
        if (!IsEnabledPrimalist(player))
            return;

        uint32 first = index == EFFECT_0 ? SpiritCharge : PrimalRush;
        std::vector<std::pair<uint32, uint32>> reductions;
        for (auto const& entry : player->GetSpellCooldownMap())
            if (sSpellMgr->GetFirstSpellInChain(entry.first) == first)
                reductions.emplace_back(entry.first, CalculatePct(player->GetSpellCooldownDelay(entry.first),
                    std::clamp(GetEffectValue(), 0, 100)));
        for (auto const& [spell, reduction] : reductions)
            if (reduction)
                player->ModifySpellCooldown(spell, -int32(reduction));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_ascension_verdant_chase::Reduce, EFFECT_0, SPELL_EFFECT_ANY);
        OnEffectHitTarget += SpellEffectFn(spell_ascension_verdant_chase::Reduce, EFFECT_1, SPELL_EFFECT_ANY);
    }
};
}

void AddSC_AscensionPrimalistVerdantChase()
{
    RegisterSpellScript(spell_ascension_verdant_chase);
}