local prompt = {}

function prompt.readyPrompt()
    while(true)
    do
        io.write("> ")
        local input = io.read()

        if string.sub(input, 1, 1) == ":" then

            local command = string.sub(input, 2):match("^%s*(.-)$")


            local cmdName, rest = command:match("^(%S+)%s*(.*)$")
            local args = {}

            local inQuotes = false
            local buffer = ""
            for i = 1, #rest do
                local char = rest:sub(i, i)
                if char == "\"" then
                    inQuotes = not inQuotes
                    if not inQuotes then
                        args[#args + 1] = buffer
                        buffer = ""
                    end
                elseif char == " " and not inQuotes then
                    if #buffer > 0 then
                        args[#args + 1] = buffer
                        buffer = ""
                    end
                else
                    buffer = buffer .. char
                end
            end

            if #buffer > 0 then
                args[#args + 1] = buffer
            end

            if cmdName then
                args[#args + 1] = "" --ensures that there are at least two arguments
                local invalid = false
                return cmdName, args, invalid
            else
                local invalid = true
                cmdName = ""
                args = {}
                return cmdName, args, invalid
            end
        else
            local invalid = true
            local cmdName = ""
            local args = {}
            return cmdName, args, invalid
        end
    end
end

return prompt
