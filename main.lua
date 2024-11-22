local file_handle = require("file_handle")
local prompt = require("prompt")
local tso = require("terminal_size_os")

function display_help_message()
    local help_message = [[
> Usage: lua main.lua [--help] <filename>.txt

:help            -  Displays this message

:del <int>       -  Deletes the given number line.

:clear           -  Wipes the entire file.

:wl <string>     -  Writes a string to the next line when file ends. It overwrites lines.

:wl <int> <string> - Same as earlier but it writes to a given number line.

:sf <int>        -  Shortens the file to the given line number.

:save            -  Saves the file.

:exit            -  Exits the program.

:sae             -  Saves the file and exits the program.
]]
    print(help_message)
end


if #arg == 0 then
    error("Error: No arguments specified. To get help: --help")
elseif #arg >= 3 then
    error("Error: Too many arguments To get help: --help")
end
if arg[1] == "--help" then
    display_help_message()
    os.exit()
end

if not file_handle.extensionCheck(arg[1]) then
    error("Error: Only .txt files are supported. To get help: --help")
end
local content = file_handle.read_file(arg[1])
print(content[1])