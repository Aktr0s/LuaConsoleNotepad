local console_display = {}
function console_display.display_help_message()
    local help_message = "\27[32m"..[[
> Usage: lua main.lua [--help] [<filename>.txt]
In edit mode:

:del <number>       -  Deletes the given number line.

:clean           -  Wipes the entire file.

:wl <content>     -  Writes a string to the next line when file ends.

:wl <number> <content> - it overwrites the line with a given number.

:sf <number>        -  Shortens the file to the given line number.

:save            -  Saves the file.

:quit, exit      -  Exits the program.

:exp             - Saves the file and switches to explorer mode.

:sq              -  Saves the file and exits the program.

In explorer mode:

:help            -  Displays this message

:logo            - Displays LCN logo

:clear           - Clears the prompt

:df <filename>    - Deletes given file.

:rn <oldname> <newname> - Renames given file.

:new <filename>  -  Creates new file with given filename.

:edit <filename>  -  Switches to edit mode with given filename.

:quit, exit  -  Exits the program.
]].."\27[0m"
    print(help_message)
end


function console_display.display_logo()
    local logo = "\27[34m" .. [[
            .·:'''''''''''''''''''''''''''':·.
            : : ██╗      ██████╗███╗   ██╗ : :
            : : ██║     ██╔════╝████╗  ██║ : :
            : : ██║     ██║     ██╔██╗ ██║ : :
            : : ██║     ██║     ██║╚██╗██║ : :
            : : ███████╗╚██████╗██║ ╚████║ : :
            : : ╚══════╝ ╚═════╝╚═╝  ╚═══╝ : :
            '·:............................:·'
            _                                                 
|       _. /   _  ._   _  _  |  _  |\ |  _ _|_  _  ._   _.  _|
|_ |_| (_| \_ (_) | | _> (_) | (/_ | \| (_) |_ (/_ |_) (_| (_|
                                                   |          
    ]] .. "\27[0m"
    print(logo)
end

return console_display