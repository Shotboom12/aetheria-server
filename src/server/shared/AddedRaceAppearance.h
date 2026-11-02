#ifndef ACORE_ADDED_RACE_APPEARANCE_H
#define ACORE_ADDED_RACE_APPEARANCE_H

#include <array>
#include <cstdint>

namespace AddedRaceAppearance
{
    constexpr bool Uses(unsigned race)
    {
        return race == 74 || race == 75 || race == 76 || race == 60 || race == 61 || race == 62 || race == 64 || race == 65 || race == 66 || race == 67;
    }

    constexpr std::array<unsigned, 5> Capacities(unsigned race, unsigned gender)
    {
        if (gender > 1)
            return {};
        switch (race * 2 + gender)
        {
            case 148: return {16, 1, 9, 1, 8};
            case 149: return {16, 1, 14, 1, 1};
            case 150: case 152: return {35, 2, 1, 1, 1};
            case 120: return {19, 15, 160, 110, 96};
            case 121: return {23, 20, 95, 55, 96};
            case 122: return {7, 108, 8, 7, 32};
            case 123: return {6, 216, 6, 6, 40};
            case 124: return {1, 1, 4, 1, 1};
            case 125: return {1, 1, 1, 1, 1};
            case 128: return {4, 10, 3, 3, 1};
            case 130: return {7, 1, 1, 7, 1};
            case 131: return {4, 1, 1, 4, 1};
            case 132: return {248, 21, 22, 252, 240};
            case 133: return {248, 21, 21, 252, 240};
            case 134: return {248, 21, 22, 252, 240};
            case 135: return {248, 21, 21, 252, 240};
            default: return {};
        }
    }

    constexpr bool GenderAllowed(unsigned race, unsigned gender)
    {
        return Capacities(race, gender)[0] != 0;
    }

    constexpr bool Validate(unsigned race, unsigned gender, std::array<std::uint8_t, 5> const& fields)
    {
        auto const capacities = Capacities(race, gender);
        for (unsigned i = 0; i < fields.size(); ++i)
            if (fields[i] >= capacities[i])
                return false;
        if (race == 60)
        {
            if (fields[4] < 80)
                return fields[2] < (gender ? 5u : 10u);
            return fields[3] < (gender ? 25u : 17u);
        }
        return true;
    }
}

#endif
