local cmdAction = {}
    local switch = {
        ["del"] = function(content,ln)
            if  type(ln) == "int" then
                content[ln] = ""
            end
            return content
        end,

        ["clear"] = function(content)
            table.remove(content)
            return content
        end,
        ["wl"] = function(content,arg1,arg2)
            if type(arg1) == "string" then
                for i, v in ipairs(content) do
                    if v == "" then
                        content[i] = arg1
                        break
                    else
                        content[#content + 1] = arg1
                    end
                end
            elseif (type(arg1) == "int" and type(arg2) == "string") then
                content[arg1] = arg2
            else
                
            end
            return content
        end,

        ["sf"] = function(content,ln)
            if type(ln) == "int" then
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

        ["exit"] = function()
            os.exit()
        end,

        ["sae"] = function(content,filename)
            local file = io.open(filename, "w")
            if file then
                for _, v in ipairs(content) do
                    file:write(v .. "\n")
                end
                file:close()
                os.exit()
            end
        end,
        ["default"] = function()
        end
    }
return cmdAction