local prompt = {}

function prompt.readyPrompt()
    while(true)
    do
        io.write("> ")
        local input = io.read():lower()

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
                return cmdName, args
            else
                print("Invalid command.")
            end
        else
            print("Invalid input.")
        end
    end
end

return prompt
