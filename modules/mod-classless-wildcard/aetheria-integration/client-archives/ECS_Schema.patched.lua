--[[ ECS_Schema.lua -------------------------------------------------------------
    Esteria Character Select - race / class / faction presentation (spec 14, 15, 27, 33).

    Design rule: DERIVE, NEVER HARDCODE.

    The client already maintains authoritative tables for its own custom races
    (RACE_DATA / Races_Informations in CharacterInfo.lua). We read those and add a
    presentation layer on top. An ID we have never seen must still render.

    There is deliberately no `if alliance then ... else horde` anywhere: factions
    are table lookups with a neutral fallback, so a third (Freeborn) or a future
    team id works without touching this file's logic.

    Lua 5.1 only.
------------------------------------------------------------------------------ ]]

ECS = ECS or {};
ECS.Schema = ECS.Schema or {};

local S = ECS.Schema;
local C = ECS.Const;

-- ---------------------------------------------------------------- factions
-- spec 14: keyed by faction id; every field optional. `accent` is used as an
-- ACCENT only (spec 27), never as a full row fill.
S.FactionStyle = {
    [0] = { name = "Neutral",  emblem = nil,                      accent = { 0.62, 0.62, 0.62 } },
    [1] = { name = "Alliance", emblem = C.TEX.allianceBadge,      accent = { 0.25, 0.50, 0.90 } },
    [2] = { name = "Horde",    emblem = C.TEX.hordeBadge,         accent = { 0.80, 0.22, 0.22 } },
    -- spec 14: Freeborn is a real third faction in Esteria. It is resolved via
    -- the client's existing name-hash badge mechanism (see CharacterCreate.lua),
    -- NOT via a TeamID, because the glue character list carries no team field.
    [3] = { name = "Freeborn", emblem = C.TEX.freebornBadge,      accent = { 0.62, 0.45, 0.85 } },
};

-- Neutral entry returned for any unknown id (spec 33).
S.NeutralFaction = { name = C.NEUTRAL_FACTION, emblem = nil, accent = { 0.62, 0.62, 0.62 } };

function S.GetFaction(factionID)
    local style = S.FactionStyle[factionID];
    if ( style ) then
        return style;
    end
    return S.NeutralFaction;
end

-- ---------------------------------------------------------------- races
--
-- ============================ CRITICAL HAZARD ==============================
-- The client's real race id space and the glue ORDINAL space are DIFFERENT
-- THINGS and must never be conflated.
--
--   * ChrRaces.dbc carries real race ids up to 44 (see
--     src/server/shared/SharedDefines.h:70-100 and
--     modules/mod-custom-server/data/races/race_registry.json).
--   * CharacterInfo.lua's RACE_DATA / ALLIANCE_RACES / HORDE_RACES are a
--     parallel 1..19 ORDINAL table, and CharacterCreate.lua:986 deliberately
--     passes `raceID = index` (an enumeration ordinal) into GetFactionForRace.
--     That is intentional, not a bug. DO NOT "fix" it to real ids.
--
-- Consequence: RACE_DATA[raceID] is only coincidentally correct for the stock
-- races 1..11, where ordinal happens to equal real id. For every custom race it
-- is WRONG -- which is exactly why the existing GetFactionForRaceName defaults
-- unknown races to "Horde".
--
-- Therefore this layer does NOT key off RACE_DATA by number. The authoritative
-- per-character race signal at runtime is the background MODEL FILE STRING from
-- GetSelectBackgroundModel(index) -- the same signal the existing custom faction
-- override at CharacterSelect.lua:586-594 already trusts (it string-matches
-- "HORDE" and "DARKFALLEN" out of it).
-- ==========================================================================
S.RaceOverride = {
    [78]={name="Ethereal",faction=2,artKey="EtherealHorde"},
    [77]={name="Ethereal",faction=1,artKey="EtherealAlliance"},
    [74] = {name="Centaur", faction=2, artKey="CentaurHorde"},
    [75] = {name="Slime Giant", faction=1, artKey="SlimeGiantAlliance"},
    [76] = {name="Slime Giant", faction=2, artKey="SlimeGiantHorde"},

    [1] = {name="Human", faction=1, artKey="Human"},
    [2] = {name="Orc", faction=2, artKey="Orc"},
    [3] = {name="Dwarf", faction=1, artKey="Dwarf"},
    [4] = {name="Night Elf", faction=1, artKey="NightElf"},
    [5] = {name="Undead", faction=2, artKey="Scourge"},
    [6] = {name="Tauren", faction=2, artKey="Tauren"},
    [7] = {name="Gnome", faction=1, artKey="Gnome"},
    [8] = {name="Troll", faction=2, artKey="Troll"},
    [9] = {name="Goblin", faction=2, artKey="Goblin"},
    [10] = {name="Blood Elf", faction=2, artKey="BloodElf"},
    [11] = {name="Draenei", faction=1, artKey="Draenei"},
    [12] = {name="Worgen", faction=1, artKey="Worgen"},
    [33] = {name="Naga", faction=2, artKey="NagaHorde"},
    [34] = {name="Broken", faction=1, artKey="Broken"},
    [35] = {name="Skeleton", faction=2, artKey="Scourge"},
    [36] = {name="Vrykul", faction=1, artKey="Vrykul"},
    [37] = {name="Tuskarr", faction=1, artKey="Tuskarr"},
    [38] = {name="Forest Troll", faction=2, artKey="Troll"},
    [39] = {name="Taunka", faction=2, artKey="Tauren"},
    [40] = {name="Northrend Skeleton", faction=2, artKey="Scourge"},
    [41] = {name="Ice Troll", faction=2, artKey="Troll"},
    -- Explicit real race IDs keep faction marks and portraits stable even when
    -- GetSelectBackgroundModel returns an empty or shared model token.
    [13] = {name="Void Elf", faction=1, artKey="VoidElf"},
    [14] = {name="Mag'har Orc", faction=2, artKey="Maghar"},
    [15] = {name="Ogre", faction=2, artKey="OgreHorde"},
    [16] = {name="Dark Iron Dwarf", faction=1, artKey="DarkIron"},
    [17] = {name="Illidari Blood Elf", faction=2, artKey="DemonHunterHorde"},
    [18] = {name="Vulpera", faction=2, artKey="Vulpera"},
    [19] = {name="Pandaren", faction=1, artKey="Pandaren"},
    [20] = {name="Pandaren", faction=2, artKey="Pandaren"},
    [21] = {name="Illidari Night Elf", faction=1, artKey="DemonHunterAlliance"},
    [22] = {name="Zandalari Troll", faction=2, artKey="Zandalari"},
    [23] = {name="Gilnean", faction=1, artKey="Human"},
    [24] = {name="High Elf", faction=1, artKey="HighElf"},
    [25] = {name="Kul Tiran", faction=1, artKey="KulTiran"},
    [26] = {name="Nightborne", faction=2, artKey="Nightborne"},
    [27] = {name="Lightforged Draenei", faction=1, artKey="Lightforged"},
    [28] = {name="Man'ari Eredar", faction=2, artKey="Eredar"},
    [29] = {name="Earthen", faction=1, artKey="Earthen"},
    [30] = {name="Forgotten", faction=1, artKey="ThinHuman"},
    [31] = {name="Earthen", faction=2, artKey="EarthenHorde"},
    [32] = {name="Fel Orc", faction=1, artKey="Orc"},
    [43] = {name="Darkfallen", faction=1, artKey="Darkfallen"},
    [44] = {name="Darkfallen", faction=2, artKey="DarkfallenHorde"},
    [60] = {name="Kyrian", faction=1, artKey="KyrianAlliance"},
    [61] = {name="Venthyr", faction=2, artKey="VenthyrHorde"},
    [62] = {name="Sethrak", faction=1, artKey="SethrakAlliance"},
    [63] = {name="Gnoll", faction=2, artKey="GnollHorde"},
    [64] = {name="Saberon", faction=2, artKey="SaberonHorde"},
    [65] = {name="Jinyu", faction=1, artKey="JinyuAlliance"},
    [66] = {name="Dracthyr", faction=2, artKey="DracthyrHorde"},
    [67] = {name="Dracthyr", faction=1, artKey="Dracthyr"},
    [68] = {name="Arakkoa", faction=2, artKey="ArakkoaHorde"},
    [69] = {name="Drakonid", faction=1, artKey="DrakonidAlliance"},
    [70] = {name="Drakonid", faction=2, artKey="DrakonidHorde"},
    [71] = {name="Broken", faction=2, artKey="Broken"},
    [72] = {name="Drakkin", faction=1, artKey="DrakkinAlliance"},
    [54] = {name="Naga", faction=2, artKey="NagaHorde"},
    [55] = {name="Tuskarr", faction=1, artKey="Tuskarr"},
    [56] = {name="Vrykul", faction=1, artKey="Vrykul"},
    [57] = {name="Vrykul", faction=2, artKey="VrykulHorde"},
    [58] = {name="Forgotten", faction=1, artKey="ThinHuman"},
    [59] = {name="Forgotten", faction=2, artKey="ThinHumanHorde"},
    [50] = { name="Haranir", faction=1, artKey="Haranir" },
    [51] = { name="Haranir", faction=2, artKey="HaranirHorde" },
    [48] = { name="Earthen", faction=1, artKey="Earthen" },
    [49] = { name="Earthen", faction=2, artKey="EarthenHorde" },
    [46] = { name = "Highmountain Tauren", faction = 2, artKey = "HighmountainTauren" },
    [47] = { name = "Mechagnome", faction = 1, artKey = "Mechagnome" },
    [45] = { name = "Mag'har Orc", faction = 2, artKey = "Maghar" },
    [52] = { name = "Skyborn", faction = 1, artKey = "Skyborne" },
    [53] = { name = "Skyborn", faction = 2, artKey = "SkyborneHorde" },
    -- IDs 30 and 31 are already mapped to the two Illidari variants above.
};

-- Model/file-string -> presentation. Matching is on an upper-cased, punctuation
-- -stripped form so "NIGHTELF", "NightElf" and "night_elf" all land together.
-- Order matters: the first key found inside the string wins, so put the more
-- specific names before the generic ones.
S.RaceByModelKey = {
    {"CENTAURHORDE",{name="Centaur",faction=2,artKey="CentaurHorde"}},
    {"SLIMEGIANTALLIANCE",{name="Slime Giant",faction=1,artKey="SlimeGiantAlliance"}},
    {"SLIMEGIANTHORDE",{name="Slime Giant",faction=2,artKey="SlimeGiantHorde"}},
    {"ETHEREALHORDE",{name="Ethereal",faction=2,artKey="EtherealHorde"}},
    {"ETHEREALALLIANCE",{name="Ethereal",faction=1,artKey="EtherealAlliance"}},
    { "KYRIAN", { name="Kyrian", faction=1, artKey="KyrianAlliance" } },
    { "VENTHYR", { name="Venthyr", faction=2, artKey="VenthyrHorde" } },
    { "VAMPIRE", { name="Venthyr", faction=2, artKey="VenthyrHorde" } },
    { "NAGAHORDE", { name = "Naga", faction = 2, artKey = "NagaHorde" } },
    { "TUSKARR", { name = "Tuskarr", faction = 1, artKey = "Tuskarr" } },
    { "VRYKULHORDE", { name = "Vrykul", faction = 2, artKey = "VrykulHorde" } },
    { "VRYKUL", { name = "Vrykul", faction = 1, artKey = "Vrykul" } },
    { "THINHUMANHORDE", { name = "Forgotten", faction = 2, artKey = "ThinHumanHorde" } },
    { "THINHUMAN", { name = "Forgotten", faction = 1, artKey = "ThinHuman" } },
    { "DARKFALLEN", { name = "Darkfallen", faction = 1, artKey = "Darkfallen" } },
    -- The Illidari portrait art is faction-specific and keyed by the create
    -- screen's ILLIDARI_ALLIANCE / ILLIDARI_HORDE model-folder tokens.
    { "ILLIDARIHORDE", { name = "Illidari", faction = 2, artKey = "DemonHunterHorde" } },
    { "ILLIDARIALLIANCE", { name = "Illidari", faction = 1, artKey = "DemonHunterAlliance" } },
    { "DEMONHUNTERHORDE", { name = "Illidari", faction = 2, artKey = "DemonHunterHorde" } },
    { "DEMONHUNTERALLIANCE", { name = "Illidari", faction = 1, artKey = "DemonHunterAlliance" } },
    -- GetCharacterInfo may return only the shared display race name. This
    -- last-resort token keeps it renderable; raceFilename/model tokens and IDs
    -- above preserve the faction-specific portrait when available.
    { "ILLIDARI", { name = "Illidari", faction = 2, artKey = "DemonHunterHorde" } },
    { "HIGHELF",    { name = "High Elf",   faction = 1, artKey = "HighElf" } },
    { "BLOODELF",   { name = "Blood Elf",  faction = 2, artKey = "BloodElf" } },
    { "NIGHTELF",   { name = "Night Elf",  faction = 1, artKey = "NightElf" } },
    { "VOIDELF",    { name = "Void Elf",   faction = 1, artKey = "VoidElf" } },
    { "NIGHTBORNE", { name = "Nightborne", faction = 2, artKey = "Nightborne" } },
    { "LIGHTFORGED",{ name = "Lightforged",faction = 1, artKey = "Lightforged" } },
    { "DARKIRON",   { name = "Dark Iron",  faction = 1, artKey = "DarkIron" } },
    { "KULTIRAN",   { name = "Kul Tiran",  faction = 1, artKey = "KulTiran" } },
    -- artKey is the CLIENT'S portrait file name, which is not always the model
    -- token: Zandalari trolls ship `UI-CharacterCreate-Zandalari<sex>.blp` (the
    -- create screen maps ZANDALARITROLL -> ...-ZandalariMale), so `ZandalariTroll`
    -- here asked for a file that does not exist and the row rendered no portrait.
    -- tools/check_artkeys.py cross-checks every key against the create screen's own
    -- mapping and against the plates actually in the client archives.
    { "ZANDALARI",  { name = "Zandalari",  faction = 2, artKey = "Zandalari" } },
    { "VULPERA",    { name = "Vulpera",    faction = 2, artKey = "Vulpera" } },
    { "SETHRAK",    { name = "Sethrak",    faction = 2, artKey = "Sethrak" } },
    { "DRACTHYR",   { name = "Dracthyr",   faction = 2, artKey = "Dracthyr" } },
    { "EREDAR",     { name = "Eredar",     faction = 2, artKey = "Eredar" } },
    { "WORGEN",     { name = "Worgen",     faction = 1, artKey = "Worgen" } },
    { "GOBLIN",     { name = "Goblin",     faction = 2, artKey = "Goblin" } },
    { "PANDAREN",   { name = "Pandaren",   faction = 1, artKey = "Pandaren" } },
    { "FORSAKEN",   { name = "Forsaken",   faction = 1, artKey = "Forsaken" } },
    { "SCOURGE",    { name = "Undead",     faction = 2, artKey = "Scourge" } },
    { "DRAENEI",    { name = "Draenei",    faction = 1, artKey = "Draenei" } },
    { "TAUREN",     { name = "Tauren",     faction = 2, artKey = "Tauren" } },
    { "GNOME",      { name = "Gnome",      faction = 1, artKey = "Gnome" } },
    { "DWARF",      { name = "Dwarf",      faction = 1, artKey = "Dwarf" } },
    { "TROLL",      { name = "Troll",      faction = 2, artKey = "Troll" } },
    { "ORC",        { name = "Orc",        faction = 2, artKey = "Orc" } },
    { "HUMAN",      { name = "Human",      faction = 1, artKey = "Human" } },
    { "BROKEN",     { name = "Broken",     faction = 2, artKey = "Broken" } },
};

-- Normalise a model path or race key into a comparable token.
function S.NormaliseModelKey(value)
    if ( type(value) ~= "string" ) then
        return nil;
    end
    local key = string.upper(value);
    key = string.gsub(key, "%.%a+$", "");      -- strip a trailing ".mdx"/".m2"
    key = string.gsub(key, "[^%w]", "");       -- strip \ / _ - and spaces
    return key;
end

-- Resolve presentation from a background model string (authoritative path).
function S.GetRaceByModel(model)
    local key = S.NormaliseModelKey(model);
    if ( not key ) then
        return nil;
    end
    for index = 1, #S.RaceByModelKey do
        local token = S.RaceByModelKey[index][1];
        local info  = S.RaceByModelKey[index][2];
        if ( string.find(key, token, 1, true) ) then
            return {
                name    = info.name,
                faction = info.faction,
                artKey  = info.artKey,
                known   = true,
                source  = "model",
            };
        end
    end
    return nil;
end

local function HasFactionQualifiedIllidari(info, token)
    if ( not info or type(token) ~= "string" ) then
        return false;
    end
    local key = S.NormaliseModelKey(token) or "";
    return (info.artKey == "DemonHunterHorde" and string.find(key, "HORDE", 1, true) ~= nil)
        or (info.artKey == "DemonHunterAlliance" and string.find(key, "ALLIANCE", 1, true) ~= nil);
end

-- Neutral race record (spec 15: unknown races stay selectable, spec 33).
function S.NeutralRace(raceID)
    return {
        id      = raceID,
        name    = C.FALLBACK_RACE_NAME,
        faction = 0,
        artKey  = nil,
        known   = false,
        source  = "neutral",
    };
end

-- Exact display names come from the deployed ChrRaces.dbc. Background
-- scene tokens alone cannot identify Gnomes/Trolls (shared with Dwarf/Orc),
-- Nightborne (whose file token is Broken), or new races such as Drakkin.
local DISPLAY_RACES = {
    ["CENTAUR"] = {
        {id=74, name="Centaur", faction=2, artKey="CentaurHorde", fileKey="CENTAURHORDE"},
    },
    ["SLIMEGIANT"] = {
        {id=75, name="Slime Giant", faction=1, artKey="SlimeGiantAlliance", fileKey="SLIMEGIANTALLIANCE"},
        {id=76, name="Slime Giant", faction=2, artKey="SlimeGiantHorde", fileKey="SLIMEGIANTHORDE"},
    },
    ["ARAKKOA"] = {
        {id=68, name="Arakkoa", faction=2, artKey="ArakkoaHorde", fileKey="ARAKKOAHORDE"},
    },
    ["BLOODELF"] = {
        {id=10, name="Blood Elf", faction=2, artKey="BloodElf", fileKey="BLOODELF"},
    },
    ["BROKEN"] = {
        {id=34, name="Broken", faction=1, artKey="Broken", fileKey="BROKEN"},
        {id=71, name="Broken", faction=2, artKey="Broken", fileKey="BROKENHORDE"},
    },
    ["DARKIRONDWARF"] = {
        {id=16, name="Dark Iron Dwarf", faction=1, artKey="DarkIron", fileKey="DARKIRONDWARF"},
    },
    ["DRACTHYR"] = {
        {id=66, name="Dracthyr", faction=2, artKey="DracthyrHorde", fileKey="DRACTHYRHORDE"},
        {id=67, name="Dracthyr", faction=1, artKey="Dracthyr", fileKey="DRACTHYR"},
    },
    ["DRAENEI"] = {
        {id=11, name="Draenei", faction=1, artKey="Draenei", fileKey="DRAENEI"},
    },
    ["DRAKKIN"] = {
        {id=72, name="Drakkin", faction=1, artKey="DrakkinAlliance", fileKey="DRAKKINALLIANCE"},
    },
    ["DRAKONID"] = {
        {id=69, name="Drakonid", faction=1, artKey="DrakonidAlliance", fileKey="DRAKONIDALLIANCE"},
        {id=70, name="Drakonid", faction=2, artKey="DrakonidHorde", fileKey="DRAKONIDHORDE"},
    },
    ["DWARF"] = {
        {id=3, name="Dwarf", faction=1, artKey="Dwarf", fileKey="DWARF"},
    },
    ["EARTHEN"] = {
        {id=29, name="Earthen", faction=1, artKey="Earthen", fileKey="NPCEARTHEN"},
        {id=31, name="Earthen", faction=2, artKey="EarthenHorde", fileKey="NPCEARTHEN"},
    },
    ["FELORC"] = {
        {id=32, name="Fel Orc", faction=1, artKey="Orc", fileKey="FELORC"},
    },
    ["FORESTTROLL"] = {
        {id=38, name="Forest Troll", faction=2, artKey="Troll", fileKey="FORESTTROLL"},
    },
    ["GILNEAN"] = {
        {id=23, name="Gilnean", faction=1, artKey="Human", fileKey="GILNEAN"},
    },
    ["GNOLL"] = {
        {id=63, name="Gnoll", faction=2, artKey="GnollHorde", fileKey="GNOLLHORDE"},
    },
    ["GNOME"] = {
        {id=7, name="Gnome", faction=1, artKey="Gnome", fileKey="GNOME"},
    },
    ["GOBLIN"] = {
        {id=9, name="Goblin", faction=2, artKey="Goblin", fileKey="GOBLIN"},
    },
    ["HARANIR"] = {
        {id=50, name="Haranir", faction=1, artKey="Haranir", fileKey="HARANIR"},
        {id=51, name="Haranir", faction=2, artKey="HaranirHorde", fileKey="HARANIRHORDE"},
    },
    ["HIGHELF"] = {
        {id=24, name="High Elf", faction=1, artKey="HighElf", fileKey="HIGHELF"},
    },
    ["HIGHMOUNTAINTAUREN"] = {
        {id=46, name="Highmountain Tauren", faction=2, artKey="HighmountainTauren", fileKey="HIGHMOUNTAINTAUREN"},
    },
    ["HUMAN"] = {
        {id=1, name="Human", faction=1, artKey="Human", fileKey="HUMAN"},
    },
    ["ICETROLL"] = {
        {id=41, name="Ice Troll", faction=2, artKey="Troll", fileKey="ICETROLL"},
    },
    ["ILLIDARIBLOODELF"] = {
        {id=17, name="Illidari Blood Elf", faction=2, artKey="DemonHunterHorde", fileKey="BLOODELFDHHD"},
    },
    ["ILLIDARINIGHTELF"] = {
        {id=21, name="Illidari Night Elf", faction=1, artKey="DemonHunterAlliance", fileKey="NIGHTELFDHHD"},
    },
    ["JINYU"] = {
        {id=65, name="Jinyu", faction=1, artKey="JinyuAlliance", fileKey="JINYUALLIANCE"},
    },
    ["KULTIRAN"] = {
        {id=25, name="Kul Tiran", faction=1, artKey="KulTiran", fileKey="KULTIRAN"},
    },
    ["LIGHTFORGED"] = {
        {id=27, name="Lightforged Draenei", faction=1, artKey="Lightforged", fileKey="TAUNKA"},
    },
    ["MAGHARORC"] = {
        {id=14, name="Mag'har Orc", faction=2, artKey="Maghar", fileKey="MAGHAR"},
    },
    ["MANARIEREDAR"] = {
        {id=28, name="Man'ari Eredar", faction=2, artKey="Eredar", fileKey="EREDAR"},
    },
    ["MECHAGNOME"] = {
        {id=47, name="Mechagnome", faction=1, artKey="Mechagnome", fileKey="MECHAGNOME"},
    },
    ["NAGA"] = {
        {id=33, name="Naga", faction=2, artKey="NagaHorde", fileKey="NAGA"},
        {id=54, name="Naga", faction=2, artKey="NagaHorde", fileKey="NAGAHORDE"},
    },
    ["NIGHTBORNE"] = {
        {id=26, name="Nightborne", faction=2, artKey="Nightborne", fileKey="BROKEN"},
    },
    ["NIGHTELF"] = {
        {id=4, name="Night Elf", faction=1, artKey="NightElf", fileKey="NIGHTELF"},
    },
    ["NORTHRENDSKELETON"] = {
        {id=40, name="Northrend Skeleton", faction=2, artKey="Scourge", fileKey="NORTHRENDSKELETON"},
    },
    ["OGRE"] = {
        {id=15, name="Ogre", faction=2, artKey="OgreHorde", fileKey="OGRE"},
    },
    ["ORC"] = {
        {id=2, name="Orc", faction=2, artKey="Orc", fileKey="ORC"},
    },
    ["PANDAREN"] = {
        {id=19, name="Pandaren", faction=1, artKey="Pandaren", fileKey="PANDAREN"},
        {id=20, name="Pandaren", faction=2, artKey="Pandaren", fileKey="PANDAREN"},
    },
    ["SABERON"] = {
        {id=64, name="Saberon", faction=2, artKey="SaberonHorde", fileKey="SABERONHORDE"},
    },
    ["SETHRAK"] = {
        {id=62, name="Sethrak", faction=1, artKey="SethrakAlliance", fileKey="SETHRAKALLIANCE"},
    },
    ["SKELETON"] = {
        {id=35, name="Skeleton", faction=2, artKey="Scourge", fileKey="SKELETON"},
    },
    ["SKYBORNE"] = {
        {id=52, name="Skyborn", faction=1, artKey="Skyborne", fileKey="SKYBORNE"},
        {id=53, name="Skyborn", faction=2, artKey="SkyborneHorde", fileKey="SKYBORNEHORDE"},
    },
    ["TAUNKA"] = {
        {id=39, name="Taunka", faction=2, artKey="Tauren", fileKey="TAUNKA"},
    },
    ["TAUREN"] = {
        {id=6, name="Tauren", faction=2, artKey="Tauren", fileKey="TAUREN"},
    },
    ["THINHUMAN"] = {
        {id=30, name="Forgotten", faction=1, artKey="ThinHuman", fileKey="THINHUMAN"},
    },
    ["TROLL"] = {
        {id=8, name="Troll", faction=2, artKey="Troll", fileKey="TROLL"},
    },
    ["TUSKARR"] = {
        {id=37, name="Tuskarr", faction=1, artKey="Tuskarr", fileKey="TUSKARR"},
        {id=55, name="Tuskarr", faction=1, artKey="Tuskarr", fileKey="TUSKARR"},
    },
    ["UNDEAD"] = {
        {id=5, name="Undead", faction=2, artKey="Scourge", fileKey="SCOURGE"},
    },
    ["VOIDELF"] = {
        {id=13, name="Void Elf", faction=1, artKey="VoidElf", fileKey="VOIDELF"},
    },
    ["VRYKUL"] = {
        {id=36, name="Vrykul", faction=1, artKey="Vrykul", fileKey="VRYKUL"},
        {id=56, name="Vrykul", faction=1, artKey="Vrykul", fileKey="VRYKUL"},
    },
    ["VULPERA"] = {
        {id=18, name="Vulpera", faction=2, artKey="Vulpera", fileKey="VULPERA"},
    },
    ["WORGEN"] = {
        {id=12, name="Worgen", faction=1, artKey="Worgen", fileKey="WORGEN"},
    },
    ["ZANDALARITROLL"] = {
        {id=22, name="Zandalari Troll", faction=2, artKey="Zandalari", fileKey="ZANDALARITROLL"},
    },
};
function S.GetRaceByDisplayName(displayName, model)
    local key = S.NormaliseModelKey(displayName);
    local candidates = key and DISPLAY_RACES[key];
    if ( type(candidates) ~= "table" ) then return nil end
    local info = candidates[1];
    local modelKey = S.NormaliseModelKey(model);
    for index = 1, #candidates do
        local candidate = candidates[index];
        if ( type(candidate) == "table" and candidate.fileKey == modelKey ) then
            info = candidate;
            break;
        end
    end
    -- Keep each display-name record self-contained. A stale/missing numeric
    -- override must not abort BuildData and hide every character in the account.
    if ( type(info) ~= "table" or type(info.artKey) ~= "string" ) then return nil end
    return {id=info.id, name=info.name, faction=info.faction, artKey=info.artKey,
        known=true, source="display-name"};
end

-- Resolve a race. `raceID` is the value from GetCharacterInfo; `model` is the
-- optional GetSelectBackgroundModel string for the same character.
--
-- Precedence: explicit override (real id) -> model string -> neutral.
-- RACE_DATA is deliberately NOT consulted numerically (see HAZARD above); it is
-- only used for stock ids 1..11 where ordinal == real id by construction, and
-- that path is marked as low-confidence in the returned record.
function S.GetRace(raceID, model, raceHint, raceFileHint)
    if ( type(raceID) == "number" ) then
        local over = S.RaceOverride[raceID];
        if ( over ) then
            return {
                id = raceID, name = over.name or C.FALLBACK_RACE_NAME,
                faction = over.faction or 0, artKey = over.artKey,
                known = true, source = "override",
            };
        end
    end

    -- The stock tuple's raceFilename (field 6) may retain a faction-specific
    -- model token even when the display name and select-background model are shared.
    local byModel = S.GetRaceByModel(model);
    local byRaceFile = S.GetRaceByModel(raceFileHint);
    local byRaceHint = S.GetRaceByModel(raceHint);
    if ( HasFactionQualifiedIllidari(byModel, model) ) then
        return byModel;
    end
    if ( HasFactionQualifiedIllidari(byRaceFile, raceFileHint) ) then
        return byRaceFile;
    end
    if ( HasFactionQualifiedIllidari(byRaceHint, raceHint) ) then
        return byRaceHint;
    end
    -- Centaur and Slime Giant share one display name per faction pair (Slime Giant) or have a single entry;
    -- when the file token names the exact variant, trust it over the display-name default.
    if ( byRaceFile and (byRaceFile.artKey == "SlimeGiantAlliance" or byRaceFile.artKey == "SlimeGiantHorde"
        or byRaceFile.artKey == "CentaurHorde") ) then
        byRaceFile.id = raceID;
        return byRaceFile;
    end
    -- Prefer the model getter over an unqualified filename/display-name fallback;
    -- both may contain only "Illidari" while the actual model token carries side.
    byModel = S.GetRaceByDisplayName(raceHint, model) or byModel or byRaceFile or byRaceHint;
    if ( byModel ) then
        byModel.id = raceID;
        return byModel;
    end

    -- Low-confidence ordinal fallback, kept ONLY so stock races 1..11 keep a
    -- sensible label on a client where the model API is unavailable.
    if ( type(raceID) == "number" and raceID >= 1 and raceID <= 11 and _G.RACE_DATA ) then
        local entry = _G.RACE_DATA[raceID];
        if ( entry and entry[1] ) then
            local name = entry[1];
            if ( _G[name] ) then name = _G[name]; end
            return {
                id = raceID, name = name, faction = entry[2] or 0,
                artKey = S.StockRacePortraitKeys[raceID], known = true, source = "ordinal-fallback",
            };
        end
    end

    return S.NeutralRace(raceID);
end

-- spec 4: per-race portrait art ships as
--   ECS copy      Interface\Glues\CharacterSelect\ECS-Portrait-<artKey><Male|Female>.blp
--   fallback      Interface\Glues\CharacterCreate\UI-CharacterCreate-<artKey><Male|Female>.blp
-- sex is 0/1/nil; anything unexpected falls back to the male plate.
--
-- Art keys ECS has its own masked copy of, generated by
-- tools/make_ecs_portraits.py from the unmasked source portraits. Derived from that
-- generator's mapping and verified against the files on disk by
-- tools/check_artkeys.py, so the two cannot drift apart silently.
S.PortraitArtKeys = {
    ThinHuman=true, Tuskarr=true, Vrykul=true, VrykulHorde=true, NagaHorde=true, ThinHumanHorde=true,
    Haranir=true, HaranirHorde=true,
    Earthen=true, EarthenHorde=true,
    Ogre=true, OgreAlliance=true, OgreHorde=true,
    SethrakAlliance=true, GnollHorde=true, SaberonHorde=true, JinyuAlliance=true,
    DracthyrHorde=true, ArakkoaHorde=true, DrakonidAlliance=true, DrakonidHorde=true,
    DrakkinAlliance=true,
    HighmountainTauren = true,
    Mechagnome = true,
    Maghar = true, Skyborne = true, SkyborneHorde = true,
    BloodElf = true, Broken = true, DarkIron = true, Darkfallen = true,
    DarkfallenHorde = true, DemonHunterAlliance = true, DemonHunterHorde = true,
    Dracthyr = true, Draenei = true, Dwarf = true, Eredar = true, Gnome = true,
    Goblin = true, HighElf = true, Human = true, KulTiran = true, Lightforged = true,
    Nightborne = true, NightElf = true, Orc = true, Pandaren = true, Scourge = true,
    Tauren = true, Troll = true, VoidElf = true, Vulpera = true, Worgen = true,
    Zandalari = true,
};

-- The low-confidence stock-race path still needs a concrete portrait plate.
-- These use the create-screen portrait art already shipped by the client.
S.StockRacePortraitKeys = {
    [1] = "Human", [2] = "Orc", [3] = "Dwarf", [4] = "NightElf",
    [5] = "Scourge", [6] = "Tauren", [7] = "Gnome", [8] = "Troll",
    [9] = "Goblin", [10] = "BloodElf", [11] = "Draenei",
};

-- Verified portrait paths; includes same-race fallback for single-sex art.
S.PortraitPaths = {
    ["EtherealHorde"] = {"Interface/Glues/CharacterSelect/ECS-Portrait-EtherealHordeMale.blp", "Interface/Glues/CharacterSelect/ECS-Portrait-EtherealHordeFemale.blp"},
    ["EtherealAlliance"] = {"Interface/Glues/CharacterSelect/ECS-Portrait-EtherealAllianceMale.blp", "Interface/Glues/CharacterSelect/ECS-Portrait-EtherealAllianceFemale.blp"},
    ["CentaurHorde"] = {"Interface\\Glues\\CharacterCreate\\AetheriaCreatorPortrait-v1-74Male.blp", "Interface\\Glues\\CharacterCreate\\AetheriaCreatorPortrait-v1-74Female.blp"},
    ["SlimeGiantAlliance"] = {"Interface\\Glues\\CharacterCreate\\AetheriaCreatorPortrait-v1-75Male.blp", "Interface\\Glues\\CharacterCreate\\AetheriaCreatorPortrait-v1-75Female.blp"},
    ["SlimeGiantHorde"] = {"Interface\\Glues\\CharacterCreate\\AetheriaCreatorPortrait-v1-76Male.blp", "Interface\\Glues\\CharacterCreate\\AetheriaCreatorPortrait-v1-76Female.blp"},
    ["KyrianAlliance"] = {"Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-KyrianAllianceMale.blp", "Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-KyrianAllianceFemale.blp"},
    ["VenthyrHorde"] = {"Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-VenthyrHordeMale.blp", "Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-VenthyrHordeFemale.blp"},
    ["ArakkoaHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-ArakkoaHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-ArakkoaHordeFemale.blp"},
    ["BloodElf"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-BloodElfMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-BloodElfFemale.blp"},
    ["Broken"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-BrokenMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-BrokenFemale.blp"},
    ["DarkIron"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DarkIronMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DarkIronFemale.blp"},
    ["Darkfallen"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DarkfallenMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DarkfallenFemale.blp"},
    ["DarkfallenHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DarkfallenHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DarkfallenHordeFemale.blp"},
    ["DemonHunterAlliance"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DemonHunterAllianceMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DemonHunterAllianceFemale.blp"},
    ["DemonHunterHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DemonHunterHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DemonHunterHordeFemale.blp"},
    ["Dracthyr"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DracthyrMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DracthyrFemale.blp"},
    ["DracthyrHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DracthyrHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DracthyrHordeFemale.blp"},
    ["Draenei"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DraeneiMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DraeneiFemale.blp"},
    ["DrakkinAlliance"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DrakkinAllianceMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DrakkinAllianceFemale.blp"},
    ["DrakonidAlliance"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DrakonidAllianceMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DrakonidAllianceFemale.blp"},
    ["DrakonidHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DrakonidHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DrakonidHordeFemale.blp"},
    ["Dwarf"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-DwarfMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-DwarfFemale.blp"},
    ["Earthen"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-EarthenMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-EarthenFemale.blp"},
    ["EarthenHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-EarthenHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-EarthenHordeFemale.blp"},
    ["Eredar"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-EredarMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-EredarFemale.blp"},
    ["GnollHorde"] = {"Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-GnollHordeMale.blp", "Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-GnollHordeMale.blp"},
    ["Gnome"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-GnomeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-GnomeFemale.blp"},
    ["Goblin"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-GoblinMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-GoblinFemale.blp"},
    ["Haranir"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-HaranirMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-HaranirFemale.blp"},
    ["HaranirHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-HaranirHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-HaranirHordeFemale.blp"},
    ["HighElf"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-HighElfMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-HighElfFemale.blp"},
    ["HighmountainTauren"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-HighmountainTaurenMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-HighmountainTaurenFemale.blp"},
    ["Human"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-HumanMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-HumanFemale.blp"},
    ["JinyuAlliance"] = {"Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-JinyuAllianceMale.blp", "Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-JinyuAllianceFemale.blp"},
    ["KulTiran"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-KulTiranMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-KulTiranFemale.blp"},
    ["Lightforged"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-LightforgedMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-LightforgedFemale.blp"},
    ["Maghar"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-MagharMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-MagharFemale.blp"},
    ["Mechagnome"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-MechagnomeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-MechagnomeFemale.blp"},
    ["NagaHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-NagaHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-NagaHordeFemale.blp"},
    ["NightElf"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-NightElfMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-NightElfFemale.blp"},
    ["Nightborne"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-NightborneMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-NightborneFemale.blp"},
    ["OgreAlliance"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-OgreAllianceMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-OgreAllianceFemale.blp"},
    ["OgreHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-OgreHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-OgreHordeFemale.blp"},
    ["Orc"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-OrcMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-OrcFemale.blp"},
    ["Pandaren"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-PandarenMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-PandarenFemale.blp"},
    ["SaberonHorde"] = {"Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-SaberonHordeMale.blp", "Interface\\Glues\\CharacterCreate\\EsteriaPortrait-v5-SaberonHordeMale.blp"},
    ["Scourge"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-ScourgeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-ScourgeFemale.blp"},
    ["SethrakAlliance"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-SethrakAllianceMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-SethrakAllianceFemale.blp"},
    ["Skyborne"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-SkyborneMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-SkyborneFemale.blp"},
    ["SkyborneHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-SkyborneHordeMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-SkyborneHordeFemale.blp"},
    ["Tauren"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-TaurenMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-TaurenFemale.blp"},
    ["ThinHuman"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-ThinHumanMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-ThinHumanFemale.blp"},
    ["ThinHumanHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-ThinHumanMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-ThinHumanFemale.blp"},
    ["Troll"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-TrollMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-TrollFemale.blp"},
    ["Tuskarr"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-TuskarrMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-TuskarrFemale.blp"},
    ["VoidElf"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-VoidElfMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-VoidElfFemale.blp"},
    ["Vrykul"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-VrykulMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-VrykulFemale.blp"},
    ["VrykulHorde"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-VrykulMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-VrykulFemale.blp"},
    ["Vulpera"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-VulperaMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-VulperaFemale.blp"},
    ["Worgen"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-WorgenMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-WorgenFemale.blp"},
    ["Zandalari"] = {"Interface\\Glues\\CharacterSelect\\ECS-Portrait-ZandalariMale.blp", "Interface\\Glues\\CharacterSelect\\ECS-Portrait-ZandalariFemale.blp"},
};
function S.GetPortrait(artKey, sex)
    local pair = S.PortraitPaths[artKey];
    if ( pair ) then return pair[sex == 1 and 2 or 1] end
    return "Interface\\Icons\\INV_Misc_QuestionMark";
end

-- ---------------------------------------------------------------- classes
-- Neutral class record.
function S.NeutralClass(classID)
    return { id = classID, name = C.FALLBACK_CLASS_NAME, colour = { 1, 1, 1 }, known = false };
end

-- Class colour. Reads the existing CLASS_COLORS table if present; it is keyed by
-- upper-cased class NAME, and stores a colour-escape string ("|cffRRGGBB").
local function ParseColourEscape(escape)
    if ( type(escape) ~= "string" ) then
        return nil;
    end
    local hex = string.match(escape, "|cff(%x%x%x%x%x%x)");
    if ( not hex ) then
        return nil;
    end
    local r = tonumber(string.sub(hex, 1, 2), 16);
    local g = tonumber(string.sub(hex, 3, 4), 16);
    local b = tonumber(string.sub(hex, 5, 6), 16);
    if ( not r or not g or not b ) then
        return nil;
    end
    return { r / 255, g / 255, b / 255 };
end

S.ParseColourEscape = ParseColourEscape;

S.ClassByID = {
    [1]={"Warrior","WARRIOR"}, [2]={"Paladin","PALADIN"}, [3]={"Hunter","HUNTER"},
    [4]={"Rogue","ROGUE"}, [5]={"Priest","PRIEST"}, [6]={"Death Knight","DEATHKNIGHT"},
    [7]={"Shaman","SHAMAN"}, [8]={"Mage","MAGE"}, [9]={"Warlock","WARLOCK"}, [11]={"Druid","DRUID"},
};
function S.GetClass(classID, className)
    local name = type(className) == "string" and className ~= "" and className or nil;
    local info = S.ClassByID[classID];
    local token = name and string.gsub(string.upper(name), "[^%w]", "") or nil;
    if ( not info and token ) then
        for id, value in pairs(S.ClassByID) do
            if ( value[2] == token ) then classID=id; info=value; break end
        end
    end
    if ( not name and info ) then name=info[1] end
    if ( not name ) then return S.NeutralClass(classID) end
    token = info and info[2] or token;
    local colour = _G.CLASS_COLORS and ParseColourEscape(_G.CLASS_COLORS[token]);
    return {id=classID, name=name, token=token, colour=colour or {1,1,1}, known=true};
end

-- ---------------------------------------------------------------- Freeborn
-- Freeborn is a persistent TEAM (TeamID 3), not a race, and the glue character
-- list carries no team field. The client's existing solution is a name-hash
-- record stored in inert string cvars, written by CharacterCreate.lua and applied
-- by CharacterFreeborn_ApplyBadges() -- which WRAPS UpdateCharacterList().
--
-- We must not duplicate or fight that. Instead we REUSE it: if the Freeborn
-- globals exist we ask them, and fall back to the neutral faction otherwise.
-- That keeps one source of truth for Freeborn membership.
local function MergeFreebornHashes(target, source)
    if ( type(source) ~= "table" ) then return end
    for record, present in pairs(source) do
        if ( present ) then target[tostring(record)] = true end
    end
end

local function UnwrapCVarValue(value)
    for depth = 1, 64 do
        if ( type(value) ~= "string" ) then return nil end
        local lengthText, rest = string.match(value, "^ecs%d+:(%d+)|(.*)$");
        if ( not lengthText ) then return value end
        local length = tonumber(lengthText);
        if ( not length or #rest < length ) then return nil end
        value = string.sub(rest, length + 1);
    end
    return nil;
end

-- ECS shares the proven string cvars with the Freeborn badge store. Each ECS shard
-- wraps and preserves its previous cvar value, which means the Freeborn marker may
-- be nested behind one or more `ecsN:<length>|<shard>` headers. The stock helper
-- only recognizes `fb:` at byte 1, so merge its result with the preserved records.
function S.FreebornHashes()
    local hashes = {};
    if ( type(_G.CharacterFreeborn_BadgeHashes) == "function" ) then
        local ok, existing = pcall(_G.CharacterFreeborn_BadgeHashes);
        if ( ok ) then MergeFreebornHashes(hashes, existing) end
    end

    local cvars = _G.CharacterFreeborn_BadgeCVars;
    local marker = _G.CharacterFreeborn_BadgeMarker or "fb:";
    if ( type(cvars) == "table" and type(_G.GetCVar) == "function" ) then
        for index = 1, #cvars do
            local ok, stored = pcall(_G.GetCVar, cvars[index]);
            if ( ok and type(stored) == "string" ) then
                stored = UnwrapCVarValue(stored);
                if ( type(stored) == "string" and string.sub(stored, 1, #marker) == marker ) then
                    local records = string.sub(stored, #marker + 1);
                    records = string.match(records, "^([^|]*)") or records;
                    for record in string.gmatch(records, "%d+") do
                        hashes[record] = true;
                    end
                end
            end
        end
    end

    return next(hashes) and hashes or nil;
end

-- Returns true when this character name is recorded as Freeborn.
-- Deliberately tolerant: any failure returns false, never an error (spec 33).
function S.IsFreeborn(name, hashes)
    if ( type(name) ~= "string" or name == "" ) then
        return false;
    end
    if ( type(_G.CharacterFreeborn_RecordFor) ~= "function"
        or type(_G.CharacterFreeborn_RecordBase) ~= "number" ) then
        return false;
    end

    hashes = hashes or S.FreebornHashes();
    if ( not hashes or not next(hashes) ) then
        return false;
    end

    local ok, record = pcall(_G.CharacterFreeborn_RecordFor, name);
    if ( not ok or type(record) ~= "number" ) then
        return false;
    end
    return hashes[tostring(record - _G.CharacterFreeborn_RecordBase)] == true;
end

-- Faction id for a character. Freeborn wins over the race-derived faction.
function S.ResolveFactionID(raceFaction, name, hashes)
    if ( S.IsFreeborn(name, hashes) ) then
        return 3;   -- ECS.Const / Schema.FactionStyle Freeborn
    end
    if ( type(raceFaction) == "number" and raceFaction > 0 ) then
        return raceFaction;
    end
    return 0;
end
