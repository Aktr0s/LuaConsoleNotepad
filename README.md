> [!NOTE]
> # ***Version 1.5.0 Now app can run standalone***

# <img src="https://github.com/user-attachments/assets/7944a940-f10f-4fc3-af3b-c5ed0f2e3ea4" alt="LTN-ICON" width="100"> LuaConsoleNotepad (LCN)
### A small kinda notepad written in Lua meant to be run in terminal

### > Usage: lua main.lua [--help] [filename.txt]
*Yes it only supports .txt cause it's so simple :/*


### <ins>--help:</ins>
**In edit mode:**

    :del <number>       -  Deletes the given number line.

    :clean           -  Wipes the entire file.

    :wl <content>     -  Writes a string to the next line when file ends.

    :wl <number> <content> - it overwrites the line with a given number.

    :sf <number>        -  Shortens the file to the given line number.

    :save            -  Saves the file.

    :quit, exit      -  Exits the program.

    :sq              -  Saves the file and exits the program.

**In explorer mode:**

    :help            -  Displays this message

    :logo            - Displays LCN logo

    :clear           - Clears the prompt

    :df <filename>    - Deletes given file.

    :rn <oldname> <newname> - Renames given file.

    :new <filename>  -  Creates new file with given filename.

    :edit <filename>  -  Switches to edit mode with given filename.

    :quit, exit  -  Exits the program.
