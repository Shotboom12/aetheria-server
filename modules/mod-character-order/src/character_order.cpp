#include "ScriptMgr.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "WorldSession.h"

#include <algorithm>
#include <iterator>
#include <string>
#include <vector>

using namespace Acore::ChatCommands;

namespace
{
    // Unique sender values keep our player gossip actions separate
    // from every other gossip menu.
    constexpr uint32 CHARACTER_ORDER_SENDER_SELECT = 0x434F0001;
    constexpr uint32 CHARACTER_ORDER_SENDER_SELECTED = 0x434F0002;
    constexpr uint32 CHARACTER_ORDER_SENDER_NAVIGATION = 0x434F0003;
    constexpr uint32 CHARACTER_ORDER_SENDER_MOVE_UP = 0x434F0004;
    constexpr uint32 CHARACTER_ORDER_SENDER_MOVE_DOWN = 0x434F0005;
    constexpr uint32 CHARACTER_ORDER_SENDER_MOVE_TOP = 0x434F0006;
    constexpr uint32 CHARACTER_ORDER_SENDER_MOVE_BOTTOM = 0x434F0007;

    constexpr uint32 CHARACTER_ORDER_ACTION_BACK = 1;
    constexpr uint32 CHARACTER_ORDER_ACTION_MOVE_UP = 2;
    constexpr uint32 CHARACTER_ORDER_ACTION_MOVE_DOWN = 3;
    constexpr uint32 CHARACTER_ORDER_ACTION_MOVE_TOP = 4;
    constexpr uint32 CHARACTER_ORDER_ACTION_MOVE_BOTTOM = 5;

    struct CharacterOrderEntry
    {
        uint32 Guid;
        std::string Name;
        uint8 Level;
        uint8 Race;
        uint8 Class;
    };

    char const* GetRaceName(uint8 race)
    {
        switch (race)
        {
            case 1:  return "Human";
            case 2:  return "Orc";
            case 3:  return "Dwarf";
            case 4:  return "Night Elf";
            case 5:  return "Undead";
            case 6:  return "Tauren";
            case 7:  return "Gnome";
            case 8:  return "Troll";
            case 10: return "Blood Elf";
            case 11: return "Draenei";
            default: return "Unknown Race";
        }
    }

    char const* GetClassName(uint8 playerClass)
    {
        switch (playerClass)
        {
            case 1:  return "Warrior";
            case 2:  return "Paladin";
            case 3:  return "Hunter";
            case 4:  return "Rogue";
            case 5:  return "Priest";
            case 6:  return "Death Knight";
            case 7:  return "Shaman";
            case 8:  return "Mage";
            case 9:  return "Warlock";
            case 11: return "Druid";
            default: return "Unknown Class";
        }
    }

    std::vector<CharacterOrderEntry> LoadAccountCharacters(Player* player)
    {
        std::vector<CharacterOrderEntry> characters;

        if (!player || !player->GetSession())
            return characters;

        uint32 accountId = player->GetSession()->GetAccountId();

        QueryResult result = CharacterDatabase.Query(
            "SELECT guid, name, level, race, class "
            "FROM characters "
            "WHERE account = {} "
            "AND deleteInfos_Name IS NULL "
            "ORDER BY COALESCE(`order`, guid), guid",
            accountId);

        if (!result)
            return characters;

        do
        {
            Field* fields = result->Fetch();

            CharacterOrderEntry entry;
            entry.Guid = fields[0].Get<uint32>();
            entry.Name = fields[1].Get<std::string>();
            entry.Level = fields[2].Get<uint8>();
            entry.Race = fields[3].Get<uint8>();
            entry.Class = fields[4].Get<uint8>();

            characters.push_back(entry);
        }
        while (result->NextRow());

        return characters;
    }

    void SaveCharacterOrder(
        Player* player,
        std::vector<CharacterOrderEntry> const& characters)
    {
        if (!player || !player->GetSession() || characters.empty())
            return;

        uint32 accountId = player->GetSession()->GetAccountId();

        CharacterDatabaseTransaction transaction =
            CharacterDatabase.BeginTransaction();

        for (std::size_t index = 0; index < characters.size(); ++index)
        {
            transaction->Append(
                "UPDATE characters "
                "SET `order` = {} "
                "WHERE guid = {} "
                "AND account = {} "
                "AND deleteInfos_Name IS NULL",
                static_cast<uint32>(index + 1),
                characters[index].Guid,
                accountId);
        }

        CharacterDatabase.DirectCommitTransaction(transaction);
    }

    std::string BuildCharacterText(
        CharacterOrderEntry const& entry,
        std::size_t position)
    {
        return std::to_string(position) + ". " +
            entry.Name +
            " - Level " + std::to_string(entry.Level) +
            " " + GetRaceName(entry.Race) +
            " " + GetClassName(entry.Class);
    }

    void ShowCharacterList(Player* player)
    {
        if (!player)
            return;

        ClearGossipMenuFor(player);

        std::vector<CharacterOrderEntry> characters =
            LoadAccountCharacters(player);

        if (characters.empty())
        {
            AddGossipItemFor(
                player,
                GOSSIP_ICON_CHAT,
                "No characters were found on this account.",
                CHARACTER_ORDER_SENDER_NAVIGATION,
                CHARACTER_ORDER_ACTION_BACK);
        }
        else
        {
            for (std::size_t index = 0; index < characters.size(); ++index)
            {
                CharacterOrderEntry const& entry = characters[index];

                AddGossipItemFor(
                    player,
                    GOSSIP_ICON_CHAT,
                    BuildCharacterText(entry, index + 1),
                    CHARACTER_ORDER_SENDER_SELECT,
                    entry.Guid);
            }
        }

        SendGossipMenuFor(
            player,
            DEFAULT_GOSSIP_MESSAGE,
            player->GetGUID());
    }

    void ShowSelectedCharacter(Player* player, uint32 selectedGuid)
    {
        if (!player)
            return;

        // Refetch on every selection instead of trusting the gossip action.
        std::vector<CharacterOrderEntry> characters =
            LoadAccountCharacters(player);

        auto selected = std::find_if(
            characters.begin(),
            characters.end(),
            [selectedGuid](CharacterOrderEntry const& entry)
            {
                return entry.Guid == selectedGuid;
            });

        // Invalid or forged GUID: return safely to the authenticated
        // account's character list.
        if (selected == characters.end())
        {
            ShowCharacterList(player);
            return;
        }

        std::size_t position =
            static_cast<std::size_t>(
                std::distance(characters.begin(), selected)) + 1;

        ClearGossipMenuFor(player);

        std::string information =
            selected->Name +
            " - Level " + std::to_string(selected->Level) +
            " " + GetRaceName(selected->Race) +
            " " + GetClassName(selected->Class) +
            " - Position " + std::to_string(position) +
            " of " + std::to_string(characters.size());

        AddGossipItemFor(
            player,
            GOSSIP_ICON_CHAT,
            information,
            CHARACTER_ORDER_SENDER_SELECTED,
            selected->Guid);

        if (position > 1)
        {
            AddGossipItemFor(
                player,
                GOSSIP_ICON_CHAT,
                "Move up",
                CHARACTER_ORDER_SENDER_MOVE_UP,
                selected->Guid);
        }

        if (position < characters.size())
        {
            AddGossipItemFor(
                player,
                GOSSIP_ICON_CHAT,
                "Move down",
                CHARACTER_ORDER_SENDER_MOVE_DOWN,
                selected->Guid);
        }

        if (position > 1)
        {
            AddGossipItemFor(
                player,
                GOSSIP_ICON_CHAT,
                "Move to top",
                CHARACTER_ORDER_SENDER_MOVE_TOP,
                selected->Guid);
        }

        if (position < characters.size())
        {
            AddGossipItemFor(
                player,
                GOSSIP_ICON_CHAT,
                "Move to bottom",
                CHARACTER_ORDER_SENDER_MOVE_BOTTOM,
                selected->Guid);
        }

        AddGossipItemFor(
            player,
            GOSSIP_ICON_CHAT,
            "Return to character list",
            CHARACTER_ORDER_SENDER_NAVIGATION,
            CHARACTER_ORDER_ACTION_BACK);

        SendGossipMenuFor(
            player,
            DEFAULT_GOSSIP_MESSAGE,
            player->GetGUID());
    }

    void MoveCharacter(
        Player* player,
        uint32 selectedGuid,
        uint32 movement)
    {
        if (!player || !player->GetSession())
            return;

        // Refetch before every movement. Never trust the gossip GUID.
        std::vector<CharacterOrderEntry> characters =
            LoadAccountCharacters(player);

        auto selected = std::find_if(
            characters.begin(),
            characters.end(),
            [selectedGuid](CharacterOrderEntry const& entry)
            {
                return entry.Guid == selectedGuid;
            });

        // The GUID is invalid or does not belong to this account.
        if (selected == characters.end())
        {
            ShowCharacterList(player);
            return;
        }

        std::size_t index =
            static_cast<std::size_t>(
                std::distance(characters.begin(), selected));

        bool changed = false;

        switch (movement)
        {
            case CHARACTER_ORDER_ACTION_MOVE_UP:
                if (index > 0)
                {
                    std::swap(characters[index], characters[index - 1]);
                    changed = true;
                }
                break;

            case CHARACTER_ORDER_ACTION_MOVE_DOWN:
                if (index + 1 < characters.size())
                {
                    std::swap(characters[index], characters[index + 1]);
                    changed = true;
                }
                break;

            case CHARACTER_ORDER_ACTION_MOVE_TOP:
                if (index > 0)
                {
                    CharacterOrderEntry movedCharacter = characters[index];

                    characters.erase(characters.begin() + index);
                    characters.insert(
                        characters.begin(),
                        movedCharacter);

                    changed = true;
                }
                break;

            case CHARACTER_ORDER_ACTION_MOVE_BOTTOM:
                if (index + 1 < characters.size())
                {
                    CharacterOrderEntry movedCharacter = characters[index];

                    characters.erase(characters.begin() + index);
                    characters.push_back(movedCharacter);

                    changed = true;
                }
                break;

            default:
                break;
        }

        if (changed)
            SaveCharacterOrder(player, characters);

        // Stay on the selected character and display its new position.
        ShowSelectedCharacter(player, selectedGuid);
    }
}

class CharacterOrderCommandScript : public CommandScript
{
public:
    CharacterOrderCommandScript()
        : CommandScript("CharacterOrderCommandScript")
    {
    }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable commandTable =
        {
            {
                "charorder",
                HandleCharacterOrderCommand,
                SEC_PLAYER,
                Console::No
            }
        };

        return commandTable;
    }

    static bool HandleCharacterOrderCommand(
        ChatHandler* handler,
        Optional<Tail>)
    {
        Player* player = handler->GetPlayer();

        if (!player || !player->GetSession())
            return false;

        ShowCharacterList(player);
        return true;
    }
};

class CharacterOrderPlayerScript : public PlayerScript
{
public:
    CharacterOrderPlayerScript()
        : PlayerScript(
            "CharacterOrderPlayerScript",
            { PLAYERHOOK_ON_GOSSIP_SELECT })
    {
    }

    void OnPlayerGossipSelect(
        Player* player,
        uint32 /*menuId*/,
        uint32 sender,
        uint32 action) override
    {
        if (!player || !player->GetSession())
            return;

        switch (sender)
        {
            case CHARACTER_ORDER_SENDER_SELECT:
            case CHARACTER_ORDER_SENDER_SELECTED:
                ShowSelectedCharacter(player, action);
                break;

            case CHARACTER_ORDER_SENDER_MOVE_UP:
                MoveCharacter(
                    player,
                    action,
                    CHARACTER_ORDER_ACTION_MOVE_UP);
                break;

            case CHARACTER_ORDER_SENDER_MOVE_DOWN:
                MoveCharacter(
                    player,
                    action,
                    CHARACTER_ORDER_ACTION_MOVE_DOWN);
                break;

            case CHARACTER_ORDER_SENDER_MOVE_TOP:
                MoveCharacter(
                    player,
                    action,
                    CHARACTER_ORDER_ACTION_MOVE_TOP);
                break;

            case CHARACTER_ORDER_SENDER_MOVE_BOTTOM:
                MoveCharacter(
                    player,
                    action,
                    CHARACTER_ORDER_ACTION_MOVE_BOTTOM);
                break;

            case CHARACTER_ORDER_SENDER_NAVIGATION:
                if (action == CHARACTER_ORDER_ACTION_BACK)
                    ShowCharacterList(player);
                break;

            default:
                break;
        }
    }
};

void AddSC_CharacterOrder()
{
    new CharacterOrderCommandScript();
    new CharacterOrderPlayerScript();
}