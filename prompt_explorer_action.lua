local consoleC = require("console_ctrl")
local consoleD = require("console_display")
local fExplorer = require("file_explorer")
local quitAction = function()
    consoleC.clear()
    os.exit()
end


local listFiles = function ()
    fExplorer.listEditableFiles(".")
end

local prompt_explorer_action = {}

local switch = {
    ["df"] = function(filename)
        if os.remove(filename) then
            print(consoleC.colorizer("info","File deleted successfully."))
        else
            print(consoleC.colorizer("error","Failed to delete the file."))
        end
    end,
    ["rn"] = function(oldfilename, newfilename)
        if oldfilename == nil or newfilename == nil then
            print(consoleC.colorizer("error","Please provide both old and new filenames."))
            return
        end
        if oldfilename == newfilename then
            print(consoleC.colorizer("error","Old and new filenames are the same."))
            return
        end
        if os.rename(oldfilename, newfilename) then
            print(consoleC.colorizer("info","File renamed successfully."))
        else
            print(consoleC.colorizer("error","Failed to rename the file."))
        end
    end,
    ["new"] = function(filename)
        if filename == ".txt" then
            print(consoleC.colorizer("error","Please provide a filename."))
            return
        end
        local file, err = io.open(filename, "w")
        if not file then
            print(consoleC.colorizer("error","Failed to create".. filename .. err))
        else
            file:close()
            print(consoleC.colorizer("info","File created successfully."))
        end
    end,
    ["edit"] = function(filename)
        return true, filename
    end,
    ["help"] = consoleD.display_help_message,
    ["h"] = consoleD.display_help_message,
    ["clear"] = consoleC.clear,
    ["logo"] = consoleD.display_logo,
    ["list"] = listFiles,
    ["dir"] = listFiles,
    ["ls"] = listFiles,
    ["quit"] = quitAction,
    ["exit"] = quitAction,
}

return switch