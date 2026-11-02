#include "worgoblin_loader.h"
#include "Chat.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "Config.h"

enum Spells
{
    BEST_DEALS_ANYWHERE = 69044,
};

enum WorgenRiding
{
    SPELL_APPRENTICE_RIDING  = 33388,
    SPELL_JOURNEYMAN_RIDING  = 33391,
    SPELL_RW_APPR_MALE       = 87840,
    SPELL_RW_APPR_FEMALE     = 87841,
    SPELL_RW_JOURN_MALE      = 110010,
    SPELL_RW_JOURN_FEMALE    = 110011,
    SPELL_RW_OLD_DRAKKIN_APP = 110050,
    SPELL_RW_OLD_DRAKKIN_JRN = 110051,
    SPELL_RW_DRAKKIN_APP     = 120050,
    SPELL_RW_DRAKKIN_JRN     = 120051,
};

namespace
{
    constexpr uint8 RaceSaberon = 64;
    constexpr uint32 RunningWildSpells[] = {
        SPELL_RW_APPR_MALE, SPELL_RW_APPR_FEMALE, SPELL_RW_JOURN_MALE, SPELL_RW_JOURN_FEMALE,
        SPELL_RW_OLD_DRAKKIN_APP, SPELL_RW_OLD_DRAKKIN_JRN, SPELL_RW_DRAKKIN_APP, SPELL_RW_DRAKKIN_JRN
    };

    bool CanUseRunningWild(Player const* player)
    {
        uint8 race = player->getRace(true);
        return race == RACE_WORGEN || race == RaceSaberon ||
            (race == RACE_DRAKKIN_ALLIANCE && player->getGender() == GENDER_MALE);
    }

    bool IsRunningWild(uint32 spellId)
    {
        for (uint32 runningWild : RunningWildSpells)
            if (spellId == runningWild)
                return true;

        return false;
    }
}

class worgoblin : public PlayerScript {

public:
    worgoblin() : PlayerScript("worgoblin") { }

    void OnPlayerLogin(Player* player) override
    {
        if (sConfigMgr->GetOption<bool>("Announce.enable", true))
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the Worgoblin and High Elf modules.");
    }

    void OnPlayerGetReputationPriceDiscount(Player const* player, FactionTemplateEntry const* factionTemplate, float& discount) override
    {
        if (!factionTemplate || !factionTemplate->faction)
            return;

        if (player->HasSpell(BEST_DEALS_ANYWHERE))
            discount *= 0.8;
    }
};

class spell_rocket_barrage : public SpellScript
{
    PrepareSpellScript(spell_rocket_barrage);

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        int32 basePoints = 0 + caster->GetLevel() * 2;
        basePoints += caster->SpellBaseDamageBonusDone(GetSpellInfo()->GetSchoolMask()) * 0.429; //BM=0.429 here, don't ask me how.
        basePoints += caster->GetTotalAttackPowerValue(caster->getClass() != CLASS_HUNTER ? BASE_ATTACK : RANGED_ATTACK) * 0.25; // 0.25=BonusCoefficient, hardcoding it here
        SetEffectValue(basePoints);
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_rocket_barrage::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class player_worgen_running_wild : public PlayerScript
{
public:
    player_worgen_running_wild() : PlayerScript("player_worgen_running_wild") { }

    void OnPlayerLogin(Player* player) override { HandleWorgen(player); }
    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override { HandleWorgen(player); }

    bool OnPlayerCanLearnSpell(Player* player, uint32 spellId) override
    {
        return !IsRunningWild(spellId) || CanUseRunningWild(player);
    }

private:
    void HandleWorgen(Player* player)
    {
        if (!CanUseRunningWild(player))
            for (uint32 spellId : RunningWildSpells)
            {
                player->RemoveAurasDueToSpell(spellId);
                if (player->HasSpell(spellId))
                    player->removeSpell(spellId, SPEC_MASK_ALL, false);
            }

        if (player->getRace() != RACE_WORGEN)
            return;

        // riding-skill spells don't reliably show up on AC for DKs, so give them the fast RW at creation
        if (player->getClass() == CLASS_DEATH_KNIGHT)
        {
            uint32 rwSpell    = GetRWSpell(player, true);
            uint32 otherSpell = GetRWSpell(player, false);

            if (player->HasSpell(otherSpell))
                player->removeSpell(otherSpell, SPEC_MASK_ALL, false);

            if (!player->HasSpell(rwSpell))
                player->learnSpell(rwSpell);

            return;
        }

        uint8 level = player->GetLevel();

        if (sConfigMgr->GetOption<bool>("Worgoblin.RunningWild.FreeApprentice", true)
            && level >= 20 && !player->HasSpell(SPELL_APPRENTICE_RIDING))
            player->learnSpell(SPELL_APPRENTICE_RIDING);

        if (sConfigMgr->GetOption<bool>("Worgoblin.RunningWild.FreeJourneyman", true)
            && level >= 40 && !player->HasSpell(SPELL_JOURNEYMAN_RIDING))
            player->learnSpell(SPELL_JOURNEYMAN_RIDING);

        SyncRunningWild(player);
    }

    uint32 GetRWSpell(Player* player, bool journeyman) const
    {
        bool isMale = player->getGender() == GENDER_MALE;
        if (journeyman)
            return isMale ? SPELL_RW_JOURN_MALE : SPELL_RW_JOURN_FEMALE;
        return isMale ? SPELL_RW_APPR_MALE : SPELL_RW_APPR_FEMALE;
    }

    void SyncRunningWild(Player* player)
    {
        // Only reached for non-DKs, so these HasSpell checks are trustworthy here.
        bool hasJourneyman = player->HasSpell(SPELL_JOURNEYMAN_RIDING);
        bool hasApprentice = player->HasSpell(SPELL_APPRENTICE_RIDING);

        if (!hasJourneyman && !hasApprentice)
            return; // no riding skill yet, nothing to sync

        uint32 wantSpell  = GetRWSpell(player, hasJourneyman);
        uint32 otherSpell = GetRWSpell(player, !hasJourneyman);

        if (player->HasSpell(wantSpell) && !player->HasSpell(otherSpell))
            return; // already correct

        if (player->HasSpell(otherSpell))
            player->removeSpell(otherSpell, SPEC_MASK_ALL, false);

        if (!player->HasSpell(wantSpell))
            player->learnSpell(wantSpell);
    }
};

void Add_Worgoblin()
{
    new worgoblin();
    RegisterSpellScript(spell_rocket_barrage);
    new player_worgen_running_wild();
}
