local file_explorer = {}
local consoleC = require("console_ctrl")

local function get_file_size(filename)
    local file = io.open(filename, "rb")
    if file then
        local size = file:seek("end")
        file:close()
        return size
    else
        return nil
    end
end

local function format_size(size)
    local units = { "B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB" } -- :D
    local unit_index = 1
    while size >= 1024 and unit_index < #units do
        size = size / 1024
        unit_index = unit_index + 1
    end
    return string.format("%.2f %s", size, units[unit_index])
end

local function list_txt_files(path)
    local files = {}
    -- Adjust the command based on your operating system
    local command = "ls " .. path .. "/*.txt" -- For Unix-based systems (Linux, macOS)
    if package.config:sub(1, 1) == "\\" then -- For Windows
        command = 'dir "' .. path .. '\\*.txt" /b 2>nul' -- Redirect errors to null
    end

    local p = io.popen(command)
    if p then
        for file in p:lines() do
            -- Skip lines that are irrelevant, e.g., "File Not Found"
            if file:match("%S") then -- Ensure the line is not empty
                local full_path = path .. "/" .. file -- Combine the path and file name
                local size = get_file_size(full_path) -- Get the file size
                if size then
                    table.insert(files, { name = file, size = size }) -- Store file name and size
                end
            end
        end
        p:close()
    end
    return files
end


local function find_longest_filename(files)
    local max_length = 8 -- Minimum padding for the header
    for _, file_info in ipairs(files) do
        max_length = math.max(max_length, #file_info.name)
    end
    return max_length
end

function file_explorer.listEditableFiles(path)
    local txt_files = list_txt_files(path)

    if #txt_files == 0 then
        print(consoleC.colorizer("infoLogo", "No editable files (.txt) found."))
    else
        local longest_name = find_longest_filename(txt_files)
        local name_col_width = longest_name + 2 -- Add padding
        local size_col_width = 12 -- Fixed width for the size column

        -- Print the table header
        print(consoleC.colorizer("infoLogo","Editable files:"))
        print("╔" .. string.rep("═", name_col_width) .. "╦" .. string.rep("═", size_col_width) .. "╗")
        print("║ " .. string.format("%-" .. (name_col_width - 2) .. "s", "Filename") .. " ║ " .. string.format("%-10s", "Size") .. " ║")
        print("╠" .. string.rep("═", name_col_width) .. "╬" .. string.rep("═", size_col_width) .. "╣")

        -- Print the file rows
        for _, file_info in ipairs(txt_files) do
            print(
                "║ " .. string.format("%-" .. (name_col_width - 2) .. "s", file_info.name) ..
                " ║ " .. string.format("%10s", format_size(file_info.size)) .. " ║"
            )
        end

        -- Print the table footer
        print("╚" .. string.rep("═", name_col_width) .. "╩" .. string.rep("═", size_col_width) .. "╝")
    end
end

return file_explorer
