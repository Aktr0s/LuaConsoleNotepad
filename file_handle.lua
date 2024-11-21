local file_handle = {}

function file_handle.extensionCheck(filename)
    return filename:lower():match("%.txt$") ~= nil
end

function file_handle.read_file(filename)
    local file = io.open(filename, "r")
    local text_table = {}
    if file then
        repeat
            local line = file:read("*l")
            if line ~= nil then
                table.insert(text_table, line)
            end
        until not line
        file:close()
    else
        print("Error: File does not exist.")
        io.write("Do you want to create it? [Y/N]")
        local choice = io.read():lower()
        if choice == "y" then
            local temp = io.open(filename, "w")
            temp:close()
        end
    end
    return text_table
end


function file_handle.save_to_file(data_table, filename)
    io.write("Do you want overwrite the file? [Y/N]")
    local choice = io.read():lower()
    if choice == "y" then
        local file = io.open(filename, "w")
        for _, value in ipairs(data_table) do
            file:write(value .. "\n") -- Write each value on a new line
        end
        file:close()
    end
end

function countLines(filename)
    local lineCount = 0  -- Initialize line counter
    local file = io.open(filename, "r")  -- Open the file in read mode

    if not file then
        print("Could not open file:", filename)
        return 0
    end

    -- Read the file line by line
    for line in file:lines() do
        lineCount = lineCount + 1  -- Increment counter for each line
    end

    file:close()  -- Close the file after reading
    return lineCount
end

return file_handle