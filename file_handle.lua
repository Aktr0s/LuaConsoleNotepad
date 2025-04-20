local consoleC = require("console_ctrl")
local file_handle = {}

function file_handle.extensionCheck(filename)
    return filename:lower():match("%.txt$") ~= nil
end

function file_handle.read_file(filename)
    local file = io.open(filename, "r")
    if file then
        local text_table = {}
        for line in file:lines() do
            table.insert(text_table, line)
        end
        file:close()
        return text_table
    else
        print(consoleC.colorizer("error", "Specified file does not exist."))
        return nil
    end
end

function file_handle.save_to_file(data_table, filename)
    io.write(consoleC.colorizer("warning","Do you want overwrite the file? [Y/N]"))
    local choice = io.read():lower()
    if choice == "y" then
        local file = io.open(filename, "w")
        if file then
            for _, value in ipairs(data_table) do
                file:write(value .. "\n")
            end
            file:close()
        end
    end
end

function file_handle.ensure_txt_extension(filename)
    if filename:sub(-4) ~= ".txt" then
        filename = filename .. ".txt"
    end
    return filename
end

local function countLines(filename)
    local lineCount = 0
    local file = io.open(filename, "r")

    if not file then
        print("Could not open file:", filename)
        return 0
    end

    for line in file:lines() do
        lineCount = lineCount + 1
    end

    file:close()
    return lineCount
end

return file_handle