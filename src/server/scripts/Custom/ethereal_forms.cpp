// Adapted from STRHercules/EsteriaWoW 46dfe3b3; Kalibros (Zachary Kaiser).
#include "Chat.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "WorldSession.h"

namespace
{
    constexpr uint32 EtherealTwoForms = 111004;
    enum DonorRacials : uint32
    {
        HumanSwordSpecialization = 20597,
        HumanSpirit = 20598,
        HumanDiplomacy = 20599,
        HumanPerception = 20600,
        HumanPerceptionPassive = 58985,
        HumanMaceSpecialization = 20864,
        HumanEveryManForHimself = 59752,
        OrcBloodFury = 20572,
        OrcHardiness = 20573,
        OrcAxeSpecialization = 20574,
        OrcCommand = 20575,
        OrcCommandWarlock = 20576,
        OrcCommandHunter = 21563,
        OrcBloodFuryShaman = 33697,
        OrcBloodFuryWarlock = 33702,
        OrcCommandDeathKnight = 54562,
        OrcCommandModern = 65222
    };
}

class ethereal_form_player : public PlayerScript
{
public:
    ethereal_form_player() : PlayerScript("ethereal_form_player", {PLAYERHOOK_ON_LOGIN}) { }

    void OnPlayerLogin(Player* player) override
    {
        uint8 const race = player->getRace(true);
        if (race != RACE_ETHEREAL_ALLIANCE && race != RACE_ETHEREAL_HORDE)
            return;

        player->learnSpell(EtherealTwoForms);
        // The legacy eligibility mask supplies class defaults, not donor racial bonuses.
        if (race == RACE_ETHEREAL_ALLIANCE)
            for (uint32 spell : {HumanSwordSpecialization, HumanSpirit, HumanDiplomacy, HumanPerception,
                HumanPerceptionPassive, HumanMaceSpecialization, HumanEveryManForHimself})
                player->removeSpell(spell, SPEC_MASK_ALL, false);
        else
            for (uint32 spell : {OrcBloodFury, OrcHardiness, OrcAxeSpecialization, OrcCommand,
                OrcCommandWarlock, OrcCommandHunter, OrcBloodFuryShaman, OrcBloodFuryWarlock,
                OrcCommandDeathKnight, OrcCommandModern})
                player->removeSpell(spell, SPEC_MASK_ALL, false);
    }
};

class spell_race_ethereal_two_forms : public SpellScript
{
    PrepareSpellScript(spell_race_ethereal_two_forms);

    void HandleDummy(SpellEffIndex /*effect*/)
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player || (player->getRace(true) != RACE_ETHEREAL_ALLIANCE
            && player->getRace(true) != RACE_ETHEREAL_HORDE))
            return;

        if (!player->ToggleRetailForm())
            ChatHandler(player->GetSession()).SendNotification(
                "Save both Ethereal forms before transforming, or wait for the pending save.");
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_race_ethereal_two_forms::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_ethereal_forms()
{
    new ethereal_form_player();
    RegisterSpellScript(spell_race_ethereal_two_forms);
}
