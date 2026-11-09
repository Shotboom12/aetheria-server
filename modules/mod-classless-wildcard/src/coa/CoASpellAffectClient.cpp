/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

#include "ClasslessMgr.h"
#include "AscensionPooledVitality.h"
#include "CoAPort.h"
#include "CoASpellAffectData.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "WorldPacket.h"
#include <algorithm>
#include <map>
#include <tuple>
#include <utility>

namespace
{
enum DirectModifierType : uint8
{
    DIRECT_FLAT = 3,
    DIRECT_PERCENT = 4,
    DIRECT_RESET = 5,
    DIRECT_COST = 6
};
using Totals = std::map<std::tuple<uint32, uint8, uint8>, int32>;
struct DirectModifiers : DataMap::Base
{
    Totals totals;
};
constexpr char STATE[] = "cw_coa_direct_modifiers";

void Send(Player* player, uint8 type, uint32 modifier = 0, uint8 op = 0, int32 value = 0)
{
    WorldPacket packet(SMSG_ESTERIA_SPELL_MOD, 11);
    packet << type << uint8(0) << op << value << modifier;
    player->SendDirectMessage(&packet);
}

void Synchronize(Player* player)
{
    if (!player)
        return;
    Totals totals;
    ClasslessWildcard::CharState const* state = sClasslessMgr->FindState(player);
    bool const eligible = sClasslessMgr->IsParticipant(player) && sClasslessMgr->cfg.coaEnable &&
        state && !state->exempt;
    if (eligible)
        for (uint8 op = 0; op < MAX_CLIENT_SPELLMOD; ++op)
            for (SpellModifier const* mod : player->GetSpellModList(op))
            {
                if (mod->mask || (mod->ownerAura && mod->ownerAura->IsRemoved()))
                    continue;
                auto const end = CoASpellAffect::Targets.end();
                auto entry = std::lower_bound(CoASpellAffect::Targets.begin(), end, mod->spellId,
                    [](CoASpellAffect::Entry const& row, uint32 id) { return row.modifier < id; });
                if (entry != end && entry->modifier == mod->spellId)
                    totals[{mod->spellId, op, uint8(mod->type == SPELLMOD_PCT ? DIRECT_PERCENT : DIRECT_FLAT)}]
                        += mod->value;
            }
    // Exact prices are authoritative on the server. While aura 357 is active,
    // include eligible Classic mana spells as well as the CoA spell families.
    bool const hasInstantManaDiscount = eligible &&
        player->GetTotalAuraModifier(SPELL_AURA_ASCENSION_MOD_INSTANT_MANA_COST_PCT) != 0;
    if (eligible && (hasInstantManaDiscount || sClasslessMgr->OwnedCoAClassMask(player)))
        for (auto const& [id, known] : player->GetSpellMap())
        {
            if (!known || known->State == PLAYERSPELL_REMOVED || !known->IsInSpec(player->GetActiveSpec()))
                continue;
            SpellInfo const* info = sSpellMgr->GetSpellInfo(id);
            if (!info || info->IsPassive())
                continue;
            bool const coaSpell = info->SpellFamilyName >= 18 && info->SpellFamilyName <= 38;
            bool const discountedManaSpell = hasInstantManaDiscount && info->PowerType == POWER_MANA &&
                !info->IsChanneled() && (!info->CastTimeEntry || info->CastTimeEntry->CastTime == 0);
            if (!coaSpell && !discountedManaSpell)
                continue;
            int32 cost = info->CalcPowerCost(player, info->GetSchoolMask());
            using namespace AscensionBloodmage;
            if (info->SpellFamilyName == BloodmageSpellFamily && info->PowerType == POWER_RAGE &&
                player->IsAlive() && player->IsInWorld() &&
                HasCoAKit(player, CLASS_SON_OF_ARUGAL) && player->HasAura(PooledVitalityTalent) &&
                !player->HasAura(CursedForm))
                if (Aura const* pool = player->GetAura(PooledVitality, player->GetGUID());
                    pool && pool->GetStackAmount() >= 10)
                {
                    Empowerment const kind = GetEmpowerment(id);
                    if (kind == CrimsonTide || kind == Fleshcraft || kind == Apotheosis)
                        cost = 0;
                }
            totals[{id, SPELLMOD_COST, DIRECT_COST}] = std::max(cost, 0);
        }
    DirectModifiers* previous = player->CustomData.Get<DirectModifiers>(STATE);
    if ((!previous && totals.empty()) || (previous && previous->totals == totals))
        return;
    previous = player->CustomData.GetDefault<DirectModifiers>(STATE);
    for (auto const& entry : previous->totals)
    {
        if (totals.find(entry.first) != totals.end())
            continue;
        auto const& [modifier, op, type] = entry.first;
        // Zero removes direct modifiers; -1 removes an exact cost (zero is a valid cost).
        Send(player, type, modifier, op, type == DIRECT_COST ? -1 : 0);
    }
    for (auto const& [key, value] : totals)
    {
        auto const existing = previous->totals.find(key);
        if (existing != previous->totals.end() && existing->second == value)
            continue;
        auto const& [modifier, op, type] = key;
        Send(player, type, modifier, op, value);
    }
    previous->totals = std::move(totals);
}

class cw_coa_direct_modifiers : public PlayerScript
{
public:
    cw_coa_direct_modifiers() : PlayerScript("cw_coa_direct_modifiers",
        { PLAYERHOOK_ON_LOGIN, PLAYERHOOK_ON_UPDATE }) { }

    void OnPlayerLogin(Player* player) override
    {
        // Clear any previous character's exact spell modifiers before the first world-tick snapshot.
        player->CustomData.Erase(STATE);
        Send(player, DIRECT_RESET);
    }
    void OnPlayerUpdate(Player* player, uint32 /*diff*/) override
    {
        Synchronize(player);
    }
};
}

void AddCoASpellAffectClientScripts()
{
    new cw_coa_direct_modifiers();
}
