local file_handle = require("file_handle")
local prompt = require("prompt")
local tos = require("terminal_os")
local cmd = require("cmdAction")

function display_help_message()
    local help_message = [[
> Usage: lua main.lua [--help] <filename>.txt

--help            -  Displays this message

:del <int>       -  Deletes the given number line.

:clear           -  Wipes the entire file.

:wl <string>     -  Writes a string to the next line when file ends.

:wl <int> <string> - Same as earlier but it writes to a given number line. It overwrites lines.

:sf <int>        -  Shortens the file to the given line number.

:save            -  Saves the file.

:exit            -  Exits the program.

:sae             -  Saves the file and exits the program.
]]
    print(help_message)
end


function refresh(table,error)
    local spacing = error and 2 or 1
    local size = tos.terminalSize()
    local PromptGap = #table
    local maxDigits = #tostring(#table)
    tos.clear()
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


if #arg == 0 then
    error("Error: No arguments specified. To get help: --help")
elseif #arg >= 3 then
    error("Error: Too many arguments To get help: --help")
end
if arg[1] == "--help" then
    tos.clear()
    display_help_message()
    os.exit()
end

if not file_handle.extensionCheck(arg[1]) then
    error("Error: Only .txt files are supported. To get help: --help")
end
local content = file_handle.read_file(arg[1])
refresh(content,false)
while true do
    local promptResult, argument, isInvalid = prompt.readyPrompt()
    if isInvalid or cmd[promptResult] == false then
        refresh(content,isInvalid)
        print("Invalid Command.")
    else
        if promptResult == "del" then content = cmd["del"](content,argument[1])
        elseif promptResult == "wl" then content = cmd["wl"](content,argument[1],argument[2])
        elseif promptResult == "clear" then content = cmd["clear"](content)
        elseif promptResult == "sf" then content = cmd["sf"](content,argument[1])
        elseif promptResult == "save" then cmd["save"](content,arg[1])
        elseif promptResult == "exit" then cmd["exit"]()
        elseif promptResult == "sae" then cmd["sae"](content,arg[1])
        end
        refresh(content,isInvalid)
    end
end
