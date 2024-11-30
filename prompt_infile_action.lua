local consoleC = require("console_ctrl")
local file_handle = require("file_handle")
local quitAction = function()
    consoleC.clear()
    os.exit()
end

local prompt_infile_action = {}

local switch = {
    ["del"] = function(content, ln)
        ln = tonumber(ln)
    
        if type(ln) == "number" then
            table.remove(content, ln)
        end
        return content
    end,
    ["clean"] = function(content)
        content = {}
        return content
    end,
    ["wl"] = function(content, arg1, arg2)
        local index = tonumber(arg1)
    
        if index then
            if type(arg2) == "string" then
                content[index] = arg2
            end
        else
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
    ["save"] = file_handle.save_to_file,
    ["sq"] = function(content,filename)
        file_handle.save_to_file(content,filename)
        os.exit()
    end,
    ["exp"] = file_handle.save_to_file,
    ["quit"] = quitAction,
    ["exit"] = quitAction,
}

return switch