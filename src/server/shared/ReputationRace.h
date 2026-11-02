#ifndef ACORE_REPUTATION_RACE_H
#define ACORE_REPUTATION_RACE_H

#include "SharedDefines.h"

// Use only for reputation defaults. Keep racial eligibility and identity intact.
constexpr uint32 GetReputationRaceMask(unsigned race)
{
    switch (race)
    {
        case 12: case 19: case 25: case 30: race = 1; break;
        case 13: case 21: case 24: case 52: race = 4; break;
        case 16: case 29: race = 3; break;
        case 20: case 28: race = 2; break;
        case 22: race = 8; break;
        case 26: race = 10; break;
        case 27: race = 11; break;
        case 31: race = 6; break;
        default: break;
    }

    return GetRaceMaskForRace(race);
}

#endif
