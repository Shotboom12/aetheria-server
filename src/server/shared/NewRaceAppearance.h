#pragma once
#include "HighmountainAppearance.h"
#include "HaranirAppearance.h"
#include "CreatureAppearance.h"

namespace NewRaceAppearance
{
    constexpr bool Uses(unsigned race)
    {
        return race == 46 || race == 47 || (race >= 50 && race <= 56);
    }

    constexpr bool FullWidth(unsigned race)
    {
        return race == 50 || race == 51;
    }

    constexpr bool Validate(unsigned race, unsigned gender, std::array<std::uint8_t, 13> const& fields)
    {
        if (gender > 1)
            return false;
        if (FullWidth(race))
            return HaranirAppearance::Validate(gender, fields);
        unsigned const used = race == 46 ? 6 : 5;
        for (unsigned i = used; i < fields.size(); ++i)
            if (fields[i])
                return false;
        if (race == 46)
        {
            std::array<std::uint8_t, 6> values{};
            for (unsigned i = 0; i < values.size(); ++i)
                values[i] = fields[i];
            return HighmountainAppearance::Validate(gender, values);
        }
        std::array<std::uint8_t, 5> values{};
        for (unsigned i = 0; i < values.size(); ++i)
            values[i] = fields[i];
        if (race >= 54 && race <= 56)
            return CreatureAppearance::Validate(race, gender, values);
        std::array<unsigned, 5> capacities{};
        switch (race * 2 + gender)
        {
            case 94: capacities = {96, 84, 56, 231, 60}; break;
            case 95: capacities = {96, 14, 72, 231, 60}; break;
            case 104: capacities = {130, 130, 75, 32, 64}; break;
            case 105: capacities = {130, 10, 87, 32, 64}; break;
            case 106: capacities = {130, 130, 75, 32, 64}; break;
            case 107: capacities = {130, 10, 87, 32, 64}; break;
            default: return false;
        }
        for (unsigned i = 0; i < values.size(); ++i)
            if (values[i] >= capacities[i])
                return false;
        return true;
    }
}
