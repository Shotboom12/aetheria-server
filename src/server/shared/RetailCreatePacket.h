#pragma once

#include "RetailAppearance.h"

namespace RetailAppearance
{
    // Parse the optional trailer from the bytes received after the stock create fields.
    // Incoming ByteBuffers have a zero write cursor; callers must pass their storage size.
    inline bool ExtractCreatePayload(std::string_view bytes, std::size_t& legacySize, std::string& payload)
    {
        legacySize = bytes.size();
        payload.clear();
        if (bytes.size() < 6)
            return true;

        std::size_t markerOffset = bytes.size() - 4;
        if (ReadU32(bytes, markerOffset) != 0x31504352)
            return true;

        std::size_t const lengthOffset = bytes.size() - 6;
        std::size_t const payloadSize = static_cast<std::uint8_t>(bytes[lengthOffset])
            | (static_cast<std::size_t>(static_cast<std::uint8_t>(bytes[lengthOffset + 1])) << 8);
        if (!payloadSize || payloadSize > MaxPayloadSize || payloadSize > lengthOffset)
            return false;

        legacySize = lengthOffset - payloadSize;
        payload.assign(bytes.data() + legacySize, payloadSize);
        return true;
    }
}
