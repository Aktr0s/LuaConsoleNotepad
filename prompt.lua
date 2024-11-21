prompt = {}

function prompt.readyPrompt()
    while(True)
    do
        io.write("> ")
        local input = io.read():lower()

        -- Check if the input starts with ':'
        if string.sub(input, 1, 1) == ":" then
            -- Extract the command portion (removing the ':' prefix)
            local command = string.sub(input, 2):match("^%s*(.-)$")

            -- Parse the command and arguments
            local cmdName, rest = command:match("^(%S+)%s*(.*)$") -- Extract command name and the rest
            local args = {}

            -- Tokenize the arguments
            local inQuotes = false
            local buffer = ""
            for i = 1, #rest do
                local char = rest:sub(i, i)
                if char == "\"" then
                    -- Toggle quote mode
                    inQuotes = not inQuotes
                    if not inQuotes then
                        -- Close the quoted argument
                        args[#args + 1] = buffer
                        buffer = ""
                    end
                elseif char == " " and not inQuotes then
                    -- Space outside quotes, add buffer as argument
                    if #buffer > 0 then
                        args[#args + 1] = buffer
                        buffer = ""
                    end
                else
                    -- Add to the current argument buffer
                    buffer = buffer .. char
                end
            end

            -- Add the last buffer as an argument if it exists
            if #buffer > 0 then
                args[#args + 1] = buffer
            end

            -- Output parsed command and arguments
            if cmdName then
                return cmdName, args
            else
                print("Invalid command.")
            end
        else
            print("No command detected.")
        end
    end
end

return prompt
