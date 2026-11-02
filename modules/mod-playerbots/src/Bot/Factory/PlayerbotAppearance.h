/*
 * This file is part of the mod-playerbots module for AzerothCore.
 * Released under GNU GPL v2 or later; see the module's AUTHORS file.
 */
#ifndef PLAYERBOT_APPEARANCE_H
#define PLAYERBOT_APPEARANCE_H

#include "AddedRaceAppearance.h"
#include "ElfAppearance.h"
#include "Random.h"
#include <optional>
#include <vector>

namespace PlayerbotAppearance
{
    using Fields = std::array<std::uint8_t, 13>;
    struct Option
    {
        unsigned field, count, factor;
    };
    struct Requirement
    {
        unsigned option, value, required;
        std::uint64_t mask;
    };
    struct Eligibility
    {
        unsigned option, value;
        std::uint32_t classes;
    };
    inline constexpr std::array<Requirement, 0> NoRequirements{};
    inline constexpr std::array<Eligibility, 0> NoEligibility{};

    // Keep normal Blood Elf bot profiles inside the installed CharSections.dbc palette.
    // Retail option catalogs include values that this 3.3.5 client has no face/hair sections for.
    template<class Rules>
    constexpr auto RestrictBloodElfToInstalledSections(Rules rules, bool male)
    {
        for (auto& rule : rules)
            if ((rule.option == 0 && rule.value >= 20) // face indices
                || (rule.option == 1 && rule.value >= 10) // skin colors with no complete face set
                || (rule.option == 2 && rule.value >= 16) // hair styles
                || (rule.option == 3 && rule.value >= 13) // hair colors
                || (male && rule.option == 4 && rule.value >= 10)) // facial hair styles
                rule.classes = 0;
        return rules;
    }

    inline constexpr auto BloodElfMaleBotEligibility =
        RestrictBloodElfToInstalledSections(NormalElfAppearance::BloodElfMaleEligibility, true);
    inline constexpr auto BloodElfFemaleBotEligibility =
        RestrictBloodElfToInstalledSections(NormalElfAppearance::BloodElfFemaleEligibility, false);

    // Normal Blood Elves use the 3.3.5 customization slots only. Demon Hunter cosmetics
    // such as horns, blindfolds, and tattoos belong to the separate Demon Hunter race entries.
    inline constexpr std::array<Option, 5> BloodElfMaleClassicOptions = {{
        {1, 20, 1}, // Face
        {0, 24, 1}, // Skin
        {2, 21, 1}, // Hair style
        {3, 20, 1}, // Hair color
        {4, 13, 1}, // Facial hair
    }};
    inline constexpr std::array<Option, 4> BloodElfFemaleClassicOptions = {{
        {1, 20, 1}, // Face
        {0, 24, 1}, // Skin
        {2, 25, 1}, // Hair style
        {3, 20, 1}, // Hair color
    }};

    template<class Options, class Requirements, class EligibilityTable, class Validator>
    std::optional<Fields> Sample(Options const& options, Requirements const& requirements,
        EligibilityTable const& eligibility, Fields const& seed, unsigned characterClass, Validator validate)
    {
        auto choice = [&](Fields const& fields, unsigned index)
        {
            auto const& option = options[index];
            return fields[option.field] / option.factor % option.count;
        };
        auto setChoice = [&](Fields& fields, unsigned index, unsigned value)
        {
            auto const& option = options[index];
            fields[option.field] = static_cast<std::uint8_t>(fields[option.field]
                - choice(fields, index) * option.factor + value * option.factor);
        };
        // Draw logical options, then repair dependencies before validating the whole packet.
        // Independent random bytes would combine unrelated choices packed into the same byte.
        for (unsigned attempt = 0; attempt < 64; ++attempt)
        {
            Fields fields = seed;
            for (unsigned index = 0; index < options.size(); ++index)
                setChoice(fields, index, urand(0, options[index].count - 1));
            for (unsigned pass = 0; pass < options.size(); ++pass)
            {
                bool changed = false;
                for (unsigned index = 0; index < options.size(); ++index)
                {
                    auto allowed = [&](unsigned value)
                    {
                        for (auto const& rule : eligibility)
                            if (rule.option == index && rule.value == value && characterClass
                                && !(rule.classes & (std::uint32_t{1} << (characterClass - 1))))
                                return false;
                        for (auto const& rule : requirements)
                            if (rule.option == index && rule.value == value)
                            {
                                unsigned const required = rule.required == index
                                    ? value : choice(fields, rule.required);
                                if (required >= 64 || !(rule.mask & (std::uint64_t{1} << required)))
                                    return false;
                            }
                        return true;
                    };
                    if (allowed(choice(fields, index)))
                        continue;
                    std::vector<unsigned> candidates;
                    for (unsigned value = 0; value < options[index].count; ++value)
                        if (allowed(value))
                            candidates.push_back(value);
                    if (!candidates.empty())
                    {
                        setChoice(fields, index, candidates[urand(0, static_cast<unsigned>(candidates.size() - 1))]);
                        changed = true;
                    }
                }
                if (!changed)
                    break;
            }
            if (validate(fields))
                return fields;
        }
        // Never create a bot with an invalid packet when a profile cannot be resolved.
        return std::nullopt;
    }

    inline bool Supports(unsigned race, unsigned gender)
    {
        if (AddedRaceAppearance::Uses(race))
            return AddedRaceAppearance::GenderAllowed(race, gender);
        if (CreatureAppearance::Uses(race))
            return CreatureAppearance::GenderAllowed(race, gender);
        return gender < 2 && ElfAppearance::Uses(race);
    }

    inline constexpr std::array<Option, 10> Catalog52_0 = {{
        {0, 5, 1},
        {1, 10, 1},
        {2, 25, 1},
        {3, 32, 1},
        {0, 26, 5},
        {4, 4, 1},
        {4, 2, 4},
        {4, 8, 8},
        {1, 13, 10},
        {2, 3, 25},
    }};

    inline constexpr std::array<Option, 10> Catalog52_1 = {{
        {0, 5, 1},
        {1, 10, 1},
        {2, 29, 1},
        {3, 32, 1},
        {0, 26, 5},
        {4, 4, 1},
        {4, 2, 4},
        {4, 8, 8},
        {1, 1, 10},
        {2, 3, 29},
    }};

    inline constexpr std::array<Option, 10> Catalog53_0 = {{
        {0, 5, 1},
        {1, 10, 1},
        {2, 25, 1},
        {3, 32, 1},
        {0, 26, 5},
        {4, 4, 1},
        {4, 2, 4},
        {4, 8, 8},
        {1, 13, 10},
        {2, 3, 25},
    }};

    inline constexpr std::array<Option, 10> Catalog53_1 = {{
        {0, 5, 1},
        {1, 10, 1},
        {2, 29, 1},
        {3, 32, 1},
        {0, 26, 5},
        {4, 4, 1},
        {4, 2, 4},
        {4, 8, 8},
        {1, 1, 10},
        {2, 3, 29},
    }};

    inline constexpr std::array<Option, 12> Catalog47_0 = {{
        {0, 8, 1},
        {1, 14, 1},
        {2, 7, 1},
        {3, 7, 1},
        {1, 6, 14},
        {2, 4, 7},
        {2, 2, 28},
        {4, 20, 1},
        {3, 33, 7},
        {0, 3, 8},
        {0, 4, 24},
        {4, 3, 20},
    }};

    inline constexpr std::array<Option, 12> Catalog47_1 = {{
        {0, 8, 1},
        {1, 14, 1},
        {2, 9, 1},
        {3, 7, 1},
        {1, 1, 14},
        {2, 4, 9},
        {2, 2, 36},
        {4, 20, 1},
        {3, 33, 7},
        {0, 3, 8},
        {0, 4, 24},
        {4, 3, 20},
    }};

    inline std::optional<Fields> Generate(unsigned race, unsigned gender, unsigned characterClass)
    {
        if (AddedRaceAppearance::Uses(race))
        {
            if (!AddedRaceAppearance::GenderAllowed(race, gender))
                return std::nullopt;
            Fields fields{};
            auto const capacities = AddedRaceAppearance::Capacities(race, gender);
            for (unsigned i = 0; i < capacities.size(); ++i)
                fields[i] = static_cast<std::uint8_t>(urand(0, capacities[i] - 1));
            return fields;
        }

        if (!Supports(race, gender) || characterClass == 0 || characterClass > 11)
            return std::nullopt;
        Fields seed{};
        auto validate = [&](Fields const& fields)
        {
            if (CreatureAppearance::Uses(race))
            {
                std::array<std::uint8_t, 5> native{};
                for (unsigned i = 0; i < native.size(); ++i)
                    native[i] = fields[i];
                return CreatureAppearance::Validate(race, gender, native);
            }
            return ElfAppearance::Validate(race, gender, fields, characterClass);
        };
        if (NormalElfAppearance::Uses(race))
        {
            auto logicalValidate = [&](Fields const& fields)
            {
                return NormalElfAppearance::Validate(race, gender, fields, characterClass);
            };
            std::optional<Fields> logical;
            if (race == 4 && gender == 0)
                logical = Sample(DemonHunterAppearance::NightElfMaleOptions,
                    DemonHunterAppearance::NightElfMaleRequirements,
                    NormalElfAppearance::NightElfMaleEligibility, seed, characterClass, logicalValidate);
            if (race == 4 && gender == 1)
                logical = Sample(DemonHunterAppearance::NightElfFemaleOptions,
                    DemonHunterAppearance::NightElfFemaleRequirements,
                    NormalElfAppearance::NightElfFemaleEligibility, seed, characterClass, logicalValidate);
            if (race == 10 && gender == 0)
                logical = Sample(BloodElfMaleClassicOptions,
                    DemonHunterAppearance::BloodElfMaleRequirements,
                    BloodElfMaleBotEligibility, seed, characterClass, logicalValidate);
            if (race == 10 && gender == 1)
                logical = Sample(BloodElfFemaleClassicOptions,
                    DemonHunterAppearance::BloodElfFemaleRequirements,
                    BloodElfFemaleBotEligibility, seed, characterClass, logicalValidate);
            if (race == 24 && gender == 0)
                logical = Sample(DemonHunterAppearance::BloodElfMaleOptions,
                    DemonHunterAppearance::BloodElfMaleRequirements,
                    NormalElfAppearance::HighElfMaleEligibility, seed, characterClass, logicalValidate);
            if (race == 24 && gender == 1)
                logical = Sample(DemonHunterAppearance::BloodElfFemaleOptions,
                    DemonHunterAppearance::BloodElfFemaleRequirements,
                    NormalElfAppearance::HighElfFemaleEligibility, seed, characterClass, logicalValidate);
            if (!logical)
                return std::nullopt;
            auto const adjusted = NormalElfAppearance::ApplyEyePalette(race, gender, *logical, characterClass);
            if (!logicalValidate(adjusted))
                return std::nullopt;
            Fields wire = adjusted;
            std::uint32_t const extra = NormalElfAppearance::Extra(race, gender, adjusted);
            for (unsigned i = 5; i < wire.size(); ++i)
                wire[i] = i < 8 ? static_cast<std::uint8_t>(extra >> ((i - 5) * 8)) : 0;
            return validate(wire) ? std::optional<Fields>{wire} : std::nullopt;
        }
        switch (race)
        {
            case 1:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(HumanBatchAppearance::MaleOptions, HumanBatchAppearance::MaleRequirements,
                        HumanBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(HumanBatchAppearance::FemaleOptions, HumanBatchAppearance::FemaleRequirements,
                        HumanBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 3:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(DwarfBatchAppearance::MaleOptions, DwarfBatchAppearance::MaleRequirements,
                        DwarfBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(DwarfBatchAppearance::FemaleOptions, DwarfBatchAppearance::FemaleRequirements,
                        DwarfBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 5:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(UndeadBatchAppearance::MaleOptions, UndeadBatchAppearance::MaleRequirements,
                        UndeadBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(UndeadBatchAppearance::FemaleOptions, UndeadBatchAppearance::FemaleRequirements,
                        UndeadBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 7:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(GnomeBatchAppearance::MaleOptions, GnomeBatchAppearance::MaleRequirements,
                        GnomeBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(GnomeBatchAppearance::FemaleOptions, GnomeBatchAppearance::FemaleRequirements,
                        GnomeBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 8:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(TrollBatchAppearance::MaleOptions, TrollBatchAppearance::MaleRequirements,
                        TrollBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(TrollBatchAppearance::FemaleOptions, TrollBatchAppearance::FemaleRequirements,
                        TrollBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 9:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(GoblinBatchAppearance::MaleOptions, GoblinBatchAppearance::MaleRequirements,
                        GoblinBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(GoblinBatchAppearance::FemaleOptions, GoblinBatchAppearance::FemaleRequirements,
                        GoblinBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 11:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(DraeneiBatchAppearance::MaleOptions, DraeneiBatchAppearance::MaleRequirements,
                        DraeneiBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(DraeneiBatchAppearance::FemaleOptions, DraeneiBatchAppearance::FemaleRequirements,
                        DraeneiBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 12:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(WorgenBatchAppearance::MaleOptions, WorgenBatchAppearance::MaleRequirements,
                        WorgenBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(WorgenBatchAppearance::FemaleOptions, WorgenBatchAppearance::FemaleRequirements,
                        WorgenBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 13:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(VoidelfBatchAppearance::MaleOptions, VoidelfBatchAppearance::MaleRequirements,
                        VoidelfBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(VoidelfBatchAppearance::FemaleOptions, VoidelfBatchAppearance::FemaleRequirements,
                        VoidelfBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 16:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(DarkironBatchAppearance::MaleOptions, DarkironBatchAppearance::MaleRequirements,
                        DarkironBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(DarkironBatchAppearance::FemaleOptions, DarkironBatchAppearance::FemaleRequirements,
                        DarkironBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 18:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(VulperaBatchAppearance::MaleOptions, VulperaBatchAppearance::MaleRequirements,
                        VulperaBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(VulperaBatchAppearance::FemaleOptions, VulperaBatchAppearance::FemaleRequirements,
                        VulperaBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 19:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(PandarenBatchAppearance::MaleOptions, PandarenBatchAppearance::MaleRequirements,
                        PandarenBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(PandarenBatchAppearance::FemaleOptions, PandarenBatchAppearance::FemaleRequirements,
                        PandarenBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 20:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(PandarenBatchAppearance::MaleOptions, PandarenBatchAppearance::MaleRequirements,
                        PandarenBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(PandarenBatchAppearance::FemaleOptions, PandarenBatchAppearance::FemaleRequirements,
                        PandarenBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 22:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(ZandalariBatchAppearance::MaleOptions, ZandalariBatchAppearance::MaleRequirements,
                        ZandalariBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(ZandalariBatchAppearance::FemaleOptions, ZandalariBatchAppearance::FemaleRequirements,
                        ZandalariBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 25:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(KultiranBatchAppearance::MaleOptions, KultiranBatchAppearance::MaleRequirements,
                        KultiranBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(KultiranBatchAppearance::FemaleOptions, KultiranBatchAppearance::FemaleRequirements,
                        KultiranBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 26:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(NightborneBatchAppearance::MaleOptions, NightborneBatchAppearance::MaleRequirements,
                        NightborneBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(NightborneBatchAppearance::FemaleOptions, NightborneBatchAppearance::FemaleRequirements,
                        NightborneBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 27:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(LightforgedBatchAppearance::MaleOptions, LightforgedBatchAppearance::MaleRequirements,
                        LightforgedBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(LightforgedBatchAppearance::FemaleOptions, LightforgedBatchAppearance::FemaleRequirements,
                        LightforgedBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 28:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(ManariBatchAppearance::MaleOptions, ManariBatchAppearance::MaleRequirements,
                        ManariBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(ManariBatchAppearance::FemaleOptions, ManariBatchAppearance::FemaleRequirements,
                        ManariBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 29:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(EarthenBatchAppearance::MaleOptions, EarthenBatchAppearance::MaleRequirements,
                        EarthenBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(EarthenBatchAppearance::FemaleOptions, EarthenBatchAppearance::FemaleRequirements,
                        EarthenBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 31:
                seed[12] = HordeBatchAppearance::Marker(race);
                if (gender == 0)
                    return Sample(EarthenBatchAppearance::MaleOptions, EarthenBatchAppearance::MaleRequirements,
                        EarthenBatchAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(EarthenBatchAppearance::FemaleOptions, EarthenBatchAppearance::FemaleRequirements,
                        EarthenBatchAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 2:
                seed[7] = OrcAppearanceV2::Marker;
                if (gender == 0)
                    return Sample(OrcAppearanceV2::OrcMaleOptions, OrcAppearanceV2::OrcMaleRequirements,
                        OrcAppearanceV2::OrcMaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(OrcAppearanceV2::OrcFemaleOptions, OrcAppearanceV2::OrcFemaleRequirements,
                        OrcAppearanceV2::OrcFemaleEligibility, seed, characterClass, validate);
                break;
            case 14:
                seed[7] = OrcAppearanceV2::Marker;
                if (gender == 0)
                    return Sample(OrcAppearanceV2::MagharMaleOptions, OrcAppearanceV2::MagharMaleRequirements,
                        OrcAppearanceV2::MagharMaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(OrcAppearanceV2::MagharFemaleOptions, OrcAppearanceV2::MagharFemaleRequirements,
                        OrcAppearanceV2::MagharFemaleEligibility, seed, characterClass, validate);
                break;
            case 6:
                TaurenAppearance::Mark(seed);
                if (gender == 0)
                    return Sample(TaurenAppearance::MaleOptions, TaurenAppearance::MaleRequirements,
                        TaurenAppearance::MaleEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(TaurenAppearance::FemaleOptions, TaurenAppearance::FemaleRequirements,
                        TaurenAppearance::FemaleEligibility, seed, characterClass, validate);
                break;
            case 17:
                if (gender == 0)
                    return Sample(DemonHunterAppearance::BloodElfMaleOptions, DemonHunterAppearance::BloodElfMaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(DemonHunterAppearance::BloodElfFemaleOptions, DemonHunterAppearance::BloodElfFemaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                break;
            case 21:
                if (gender == 0)
                    return Sample(DemonHunterAppearance::NightElfMaleOptions, DemonHunterAppearance::NightElfMaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(DemonHunterAppearance::NightElfFemaleOptions, DemonHunterAppearance::NightElfFemaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                break;
            case 46:
                if (gender == 0)
                    return Sample(HighmountainAppearance::MaleOptions, HighmountainAppearance::MaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(HighmountainAppearance::FemaleOptions, HighmountainAppearance::FemaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                break;
            case 50:
                if (gender == 0)
                    return Sample(HaranirAppearance::MaleOptions, HaranirAppearance::MaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(HaranirAppearance::FemaleOptions, HaranirAppearance::FemaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                break;
            case 51:
                if (gender == 0)
                    return Sample(HaranirAppearance::MaleOptions, HaranirAppearance::MaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(HaranirAppearance::FemaleOptions, HaranirAppearance::FemaleRequirements,
                        NoEligibility, seed, characterClass, validate);
                break;
            case 47:
                if (gender == 0)
                    return Sample(Catalog47_0, NoRequirements, NoEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(Catalog47_1, NoRequirements, NoEligibility, seed, characterClass, validate);
                break;
            case 52:
                if (gender == 0)
                    return Sample(Catalog52_0, NoRequirements, NoEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(Catalog52_1, NoRequirements, NoEligibility, seed, characterClass, validate);
                break;
            case 53:
                if (gender == 0)
                    return Sample(Catalog53_0, NoRequirements, NoEligibility, seed, characterClass, validate);
                if (gender == 1)
                    return Sample(Catalog53_1, NoRequirements, NoEligibility, seed, characterClass, validate);
                break;
            default:
                if (CreatureAppearance::Uses(race))
                    return Sample(CreatureAppearance::Options(race, gender), NoRequirements,
                        NoEligibility, seed, characterClass, validate);
                break;
        }
        return std::nullopt;
    }

    inline std::uint64_t Extra(Fields const& fields)
    {
        std::uint64_t extra = 0;
        for (unsigned i = 5; i < fields.size(); ++i)
            extra |= std::uint64_t{fields[i]} << ((i - 5) * 8);
        return extra;
    }
}
#endif
