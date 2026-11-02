#pragma once
#include "DemonHunterAppearance.h"
#include "NormalElfAppearance.h"
#include "OrcPostureAppearance.h"
#include "OrcAppearanceV2.h"
#include "TaurenAppearance.h"
#include "HordeBatchAppearance.h"
#include "NewRaceAppearance.h"

namespace ElfAppearance
{
    constexpr bool Uses(unsigned race)
    {
        return NewRaceAppearance::Uses(race) || HordeBatchAppearance::Uses(race) || NormalElfAppearance::Uses(race) || race == 6 || race == 17 || race == 21
            || OrcPostureAppearance::Uses(race);
    }

    constexpr bool Validate(unsigned race, unsigned gender, std::array<std::uint8_t, 13> fields,
        unsigned characterClass = 0)
    {
        if (NewRaceAppearance::Uses(race))
            return NewRaceAppearance::Validate(race, gender, fields);
        if (HordeBatchAppearance::Uses(race))
        {
            if (HordeBatchAppearance::IsModern(race, fields))
                return HordeBatchAppearance::Validate(race, gender, fields, characterClass);
            for (unsigned index = 5; index < fields.size(); ++index)
                if (fields[index])
                    return false;
            return gender <= 1;
        }
        if (race == 6)
        {
            if (TaurenAppearance::IsModern(fields))
                return TaurenAppearance::Validate(gender, fields, characterClass);
            for (unsigned index = 5; index < fields.size(); ++index)
                if (fields[index])
                    return false;
            return gender <= 1;
        }
        if (OrcAppearanceV2::Uses(race) && OrcAppearanceV2::IsModern(fields))
            return OrcAppearanceV2::Validate(race, gender, fields, characterClass);
        if (OrcPostureAppearance::Uses(race))
            return OrcPostureAppearance::Validate(race, gender, fields);
        if (!NormalElfAppearance::Uses(race))
            return DemonHunterAppearance::Validate(race, gender, fields);
        bool const modern = (fields[7] & 0x80) != 0;
        if (!modern)
        {
            // Existing five-byte ordinary appearances retain their saved values.
            for (unsigned i = 5; i < fields.size(); ++i)
                if (fields[i] != 0)
                    return false;
            return gender <= 1;
        }
        fields = NormalElfAppearance::Decode(race, gender, fields);
        return NormalElfAppearance::Validate(race, gender, fields, characterClass);
    }
}
