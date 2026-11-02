#pragma once

#include "RetailAppearanceChoices.h"
#include <cstddef>
#include <cstdint>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

namespace RetailAppearance
{
    constexpr std::uint8_t Version = 1;
    constexpr std::uint8_t MaxForms = 2;
    constexpr std::uint8_t MaxOptionsPerForm = 64;
    constexpr std::size_t MaxPayloadSize = 1024;

    struct Choice
    {
        std::uint32_t Option = 0;
        std::uint32_t Value = 0;
    };

    struct Form
    {
        std::uint8_t LocalRace = 0;
        std::uint8_t RetailRace = 0;
        std::uint8_t Sex = 0;
        std::vector<Choice> Choices;
    };

    inline std::uint32_t ReadU32(std::string_view bytes, std::size_t& offset)
    {
        std::uint32_t value = static_cast<std::uint8_t>(bytes[offset]);
        value |= static_cast<std::uint32_t>(static_cast<std::uint8_t>(bytes[offset + 1])) << 8;
        value |= static_cast<std::uint32_t>(static_cast<std::uint8_t>(bytes[offset + 2])) << 16;
        value |= static_cast<std::uint32_t>(static_cast<std::uint8_t>(bytes[offset + 3])) << 24;
        offset += 4;
        return value;
    }

    inline void WriteU32(std::string& bytes, std::uint32_t value)
    {
        bytes.push_back(static_cast<char>(value & 0xFF));
        bytes.push_back(static_cast<char>((value >> 8) & 0xFF));
        bytes.push_back(static_cast<char>((value >> 16) & 0xFF));
        bytes.push_back(static_cast<char>((value >> 24) & 0xFF));
    }

    inline std::string EncodeForm(Form const& form)
    {
        if (form.Choices.empty() || form.Choices.size() > MaxOptionsPerForm)
            return {};
        std::string bytes;
        bytes.reserve(6 + form.Choices.size() * 8);
        bytes.push_back(static_cast<char>(Version));
        bytes.push_back(1);
        bytes.push_back(static_cast<char>(form.LocalRace));
        bytes.push_back(static_cast<char>(form.RetailRace));
        bytes.push_back(static_cast<char>(form.Sex));
        bytes.push_back(static_cast<char>(form.Choices.size()));
        for (Choice const& choice : form.Choices)
        {
            WriteU32(bytes, choice.Option);
            WriteU32(bytes, choice.Value);
        }
        return bytes;
    }

    inline bool Decode(std::string_view bytes, std::vector<Form>& forms)
    {
        forms.clear();
        if (bytes.size() < 2 || bytes.size() > MaxPayloadSize || static_cast<std::uint8_t>(bytes[0]) != Version)
            return false;

        std::size_t offset = 1;
        std::uint8_t formCount = static_cast<std::uint8_t>(bytes[offset++]);
        if (!formCount || formCount > MaxForms)
            return false;

        for (std::uint8_t formIndex = 0; formIndex < formCount; ++formIndex)
        {
            if (bytes.size() - offset < 4)
                return false;

            Form form;
            form.LocalRace = static_cast<std::uint8_t>(bytes[offset++]);
            form.RetailRace = static_cast<std::uint8_t>(bytes[offset++]);
            form.Sex = static_cast<std::uint8_t>(bytes[offset++]);
            std::uint8_t choiceCount = static_cast<std::uint8_t>(bytes[offset++]);
            if (form.Sex > 1 || !choiceCount || choiceCount > MaxOptionsPerForm
                || bytes.size() - offset < static_cast<std::size_t>(choiceCount) * 8)
                return false;

            form.Choices.reserve(choiceCount);
            for (std::uint8_t choiceIndex = 0; choiceIndex < choiceCount; ++choiceIndex)
            {
                Choice choice{ReadU32(bytes, offset), ReadU32(bytes, offset)};
                for (Choice const& previous : form.Choices)
                    if (previous.Option == choice.Option)
                        return false;
                form.Choices.push_back(choice);
            }
            forms.push_back(std::move(form));
        }
        return offset == bytes.size();
    }

    inline bool Validate(std::string_view bytes, std::uint8_t characterRace, std::uint8_t characterSex)
    {
        std::vector<Form> forms;
        if (!Decode(bytes, forms))
            return false;

        bool hasCharacterForm = false;
        for (Form const& form : forms)
        {
            if (!RetailAppearanceData::ProfileExists(form.LocalRace, form.RetailRace, form.Sex)
                || form.Choices.size() != RetailAppearanceData::ExpectedOptionCount(form.LocalRace,
                    form.RetailRace, form.Sex))
                return false;

            hasCharacterForm |= form.LocalRace == characterRace && form.Sex == characterSex;
            for (Choice const& choice : form.Choices)
                if (!RetailAppearanceData::ChoiceExists(form.LocalRace, form.RetailRace, form.Sex,
                    choice.Option, choice.Value))
                    return false;
        }
        return hasCharacterForm;
    }
}
