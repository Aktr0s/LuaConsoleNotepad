local file_handle = require("file_handle")
local prompt = require("prompt")
local consoleC = require("console_ctrl")
local infile_action = require("prompt_infile_action")
local explorer_action = require("prompt_explorer_action")
local consoleD = require("console_display")
local fExplorer = require("file_explorer")
local file_name
local content
local editMode = false


local function refresh(table,error)
    local spacing = error and 2 or 1
    local size = consoleC.terminalSize()
    local PromptGap = #table
    local maxDigits = #tostring(#table)
    consoleC.clear()
    for index, value in ipairs(table) do
        io.write(string.format("%" .. maxDigits .. "d& %s\n", index, value))
    end
    if size["rows"] > PromptGap then
        PromptGap = size["rows"] - PromptGap - spacing
        for i = 1, PromptGap do
            io.write("\n")
        end
    end
end

consoleC.forceUTF8OnWindows()
consoleC.clear()
consoleD.display_logo()


if #arg >= 3 then
    error(consoleC.colorizer("error","Too many arguments To get help: --help"))
end
if arg[1] then
    if arg[1] == "--help" or arg[1] == "-h" then
        consoleC.clear()
        consoleD.display_help_message()
        os.exit()
    end
    if file_handle.extensionCheck(arg[1]) then
       editMode = true 
       file_name = arg[1]
       content = file_handle.read_file(file_name)
    else
        error(consoleC.colorizer("info","Only .txt files are supported. To get help: --help"))
    end
else
    fExplorer.listEditableFiles(".")
end



--local file_name = arg[1]
--local content = file_handle.read_file(file_name)

while true do
    if editMode then
        local promptResult, promptArgument, isInvalid = prompt.readyPrompt()

        if isInvalid or infile_action[promptResult] == nil then
            refresh(content, true)
            print(consoleC.colorizer("warning", "Invalid Command."))
        else
            local action = infile_action[promptResult]
            if promptResult == "save" or promptResult == "sq" or promptResult == "exp" then
                if promptResult == "exp" then
                    action(content, file_name)
                    editMode = false
                    consoleC.clear()
                    fExplorer.listEditableFiles(".")
                    goto continue
                end
                action(content, file_name)
            else
                action(content, table.unpack(promptArgument))
            end
            refresh(content, false)
        end
    else
        local promptResult, promptArgument, isInvalid = prompt.readyPrompt()
        if isInvalid or explorer_action[promptResult] == nil then
            print(consoleC.colorizer("warning", "Invalid Command."))
        else
            for i, value in ipairs(promptArgument) do
                promptArgument[i] = file_handle.ensure_txt_extension(value)
            end
            if promptResult == "edit" then
                local success, filename = explorer_action["edit"](table.unpack(promptArgument))
                if success then
                    editMode = true
                    file_name = filename
                    content = file_handle.read_file(file_name)
                    refresh(content, false)
                else
                    print(consoleC.colorizer("error", "Failed to enter edit mode"))
                end
            else
                local action = explorer_action[promptResult]
                if action then
                    action(table.unpack(promptArgument))
                end
            end
        end
    end
    ::continue::
end
