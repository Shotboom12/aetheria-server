/*
 * Minimal read-only reader for client DBC (WDBC) files, used by the CoA class
 * mechanics to load spell charge tables. The reference CoA core ships a larger
 * helper; this one only provides what the Aetheria Hero module calls.
 */

#ifndef AETHERIA_COA_CLIENT_DBC_H
#define AETHERIA_COA_CLIENT_DBC_H

#include "Common.h"
#include "Config.h"
#include "Log.h"
#include <cstring>
#include <filesystem>
#include <fstream>
#include <string>
#include <vector>

// Directory that holds client DBC files the server reads for CoA data.
// CoA.ClientDbcDirectory overrides; otherwise <DataDir>/dbc is used.
inline std::filesystem::path GetClientDBCPath(char const* fileName)
{
    std::string directory = sConfigMgr->GetOption<std::string>("CoA.ClientDbcDirectory", "");
    if (directory.empty())
        directory = sConfigMgr->GetOption<std::string>("DataDir", ".") + "/dbc";
    return std::filesystem::path(directory) / fileName;
}

class ClientDBC
{
public:
    class Record
    {
    public:
        Record(uint8 const* data, uint32 fieldCount) : _data(data), _fieldCount(fieldCount) { }

        // Out-of-range columns read as 0 so callers never read past the record.
        uint32 GetUInt32(uint32 column) const
        {
            if (!_data || column >= _fieldCount)
                return 0;
            uint32 value = 0;
            std::memcpy(&value, _data + size_t(column) * 4, sizeof(value));
            return value;
        }

    private:
        uint8 const* _data;
        uint32 _fieldCount;
    };

    // expectedFieldCount of 0 accepts any layout.
    bool Load(std::filesystem::path const& path, uint32 expectedFieldCount = 0)
    {
        _records = 0;
        _fieldCount = 0;
        _recordSize = 0;
        _data.clear();

        std::ifstream file(path, std::ios::binary);
        if (!file)
        {
            LOG_WARN("coa", "Client DBC {} was not found", path.string());
            return false;
        }

        char header[20];
        if (!file.read(header, sizeof(header)) || std::memcmp(header, "WDBC", 4) != 0)
        {
            LOG_ERROR("coa", "Client DBC {} is not a WDBC file", path.string());
            return false;
        }

        uint32 fields = 0, recordSize = 0, stringSize = 0;
        std::memcpy(&_records, header + 4, 4);
        std::memcpy(&fields, header + 8, 4);
        std::memcpy(&recordSize, header + 12, 4);
        std::memcpy(&stringSize, header + 16, 4);

        if (!fields || recordSize < fields * 4 || (expectedFieldCount && fields != expectedFieldCount))
        {
            LOG_ERROR("coa", "Client DBC {} has an unexpected layout ({} fields, record size {})",
                path.string(), fields, recordSize);
            _records = 0;
            return false;
        }

        uint64 const bytes = uint64(_records) * recordSize;
        if (bytes > (256ull << 20))
        {
            LOG_ERROR("coa", "Client DBC {} is unreasonably large", path.string());
            _records = 0;
            return false;
        }

        _data.resize(size_t(bytes));
        if (bytes && !file.read(reinterpret_cast<char*>(_data.data()), std::streamsize(bytes)))
        {
            LOG_ERROR("coa", "Client DBC {} is truncated", path.string());
            _data.clear();
            _records = 0;
            return false;
        }

        _fieldCount = fields;
        _recordSize = recordSize;
        (void)stringSize; // string block is not needed for numeric tables
        return true;
    }

    uint32 GetRecordCount() const { return _records; }

    Record GetRecord(uint32 row) const
    {
        if (row >= _records)
            return Record(nullptr, 0);
        return Record(_data.data() + size_t(row) * _recordSize, _fieldCount);
    }

private:
    uint32 _records = 0;
    uint32 _fieldCount = 0;
    uint32 _recordSize = 0;
    std::vector<uint8> _data;
};

#endif
