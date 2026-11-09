/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Adapted from STRHercules/EsteriaWoW, commit 9f914baff448e635cfe0469e12e957a2a165e5e3.
// Upstream commit author: Zachary Kaiser.

#include "ClasslessMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "Unit.h"

namespace
{
enum MysticThunderSpells : uint32
{
    SPELL_MYSTIC_THUNDER_MARK = 505214,
    SPELL_MYSTIC_THUNDER_SILENCE = 505347
};

bool IsEnabledHero(Unit const* unit)
{
    if (!unit || !sClasslessMgr->cfg.enabled || !sClasslessMgr->cfg.coaEnable)
        return false;

    Player const* player = unit->ToPlayer();
    if (!player)
        if (Unit const* owner = unit->GetOwner())
            player = owner->ToPlayer();

    return player && sClasslessMgr->IsParticipant(player);
}

class stormbringer_mystic_thunder : public AllSpellScript
{
public:
    stormbringer_mystic_thunder() : AllSpellScript("stormbringer_mystic_thunder", {ALLSPELLHOOK_ON_CAST}) { }

    void OnSpellCast(Spell* spell, Unit* caster, SpellInfo const*, bool) override
    {
        if (!spell || !caster || spell->IsTriggered())
            return;

        Aura* mark = caster->GetAura(SPELL_MYSTIC_THUNDER_MARK);
        if (!mark || !IsEnabledHero(mark->GetCaster()))
            return;

        ObjectGuid marker = mark->GetCasterGUID();
        caster->RemoveAurasDueToSpell(SPELL_MYSTIC_THUNDER_MARK, marker);
        caster->CastSpell(caster, SPELL_MYSTIC_THUNDER_SILENCE, true, nullptr, nullptr, marker);
    }
};
}

void AddSC_AscensionStormbringerMysticThunder()
{
    new stormbringer_mystic_thunder();
}
