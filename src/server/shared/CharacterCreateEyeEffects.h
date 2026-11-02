#ifndef CHARACTER_CREATE_EYE_EFFECTS_H
#define CHARACTER_CREATE_EYE_EFFECTS_H

#include "ElfAppearance.h"
#include "EyeEffects.h"

namespace CharacterCreateEyeEffects
{
    constexpr std::size_t AppearanceBytes(unsigned race)
    {
        if (NewRaceAppearance::FullWidth(race) || HordeBatchAppearance::Uses(race) || race == 6)
            return 12;
        return ElfAppearance::Uses(race) ? 6 : 0;
    }

    template <class Packet>
    bool ReadTail(Packet& packet, unsigned race, bool& present, bool& enabled)
    {
        // Legacy choices and Retail-only choices may omit the packed profile.
        // The profile's own decoder still validates its required size and marker.
        if (CharacterEyeEffects::ReadTail(packet, 0, present, enabled))
            return true;
        std::size_t const appearanceBytes = AppearanceBytes(race);
        return appearanceBytes && CharacterEyeEffects::ReadTail(packet, appearanceBytes, present, enabled);
    }
}

#endif
