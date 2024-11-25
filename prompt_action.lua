local tos = require("terminal_os")
local prompt_action = {}
    local switch = {
        ["del"] = function(content, ln)
            ln = tonumber(ln)  -- Convert ln to a number if it's a string
        
            if type(ln) == "number" then
                table.remove(content, ln)
            end
            return content
        end,

        ["clear"] = function(content)
            content = {}
            return content
        end,
        ["wl"] = function(content, arg1, arg2)
            -- Check if arg1 can be converted to a number (i.e., arg1 is numeric or string representing a number)
            local index = tonumber(arg1)  -- Convert arg1 to a number if it's a string representing a number
        
            if index then
                -- If arg1 is a valid number (index), and arg2 is a string, update content at index
                if type(arg2) == "string" then
                    content[index] = arg2
                end
            else
                -- If arg1 is a string (and not a valid number), append it to the content table
                table.insert(content, arg1)
            end
        
            return content
        end
        ,

        ["sf"] = function(content, ln)
            ln = tonumber(ln)
            if type(ln) == "number" and ln >= 1 and ln <= #content then
                for i = #content, ln + 1, -1 do
                    table.remove(content, i)
                end
            end
            return content
        end,

        ["save"] = function(content,filename)
            local file = io.open(filename, "w")
            if file then
                for _, v in ipairs(content) do
                    file:write(v .. "\n")
                end 
                file:close()
            end
        end,

        ["quit"] = function()
            tos.clear()
            os.exit()
        end,

        ["sq"] = function(content,filename)
            local file = io.open(filename, "w")
            if file then
                for _, v in ipairs(content) do
                    file:write(v .. "\n")
                end
                file:close()
                tos.clear()
                os.exit()
            end
        end,
        ["default"] = function()
        end
    }

return switch