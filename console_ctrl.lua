local console_ctrl = {}

function console_ctrl.terminalSize()
    local size = {['rows'] = 0, ['cols'] = 0}
    if package.config:sub(1,1) == '\\' then
        --windows detected
        local handle = io.popen('mode con', 'r')
        if handle then
            local result = handle:read('*a')
            handle:close()
            local rows, cols = result:match("Lines:%s*(%d+)%s*Columns:%s*(%d+)")
            if rows and cols then
                size['rows'] = tonumber(rows)
                size['cols'] = tonumber(cols)
            else
                print("Failed to parse terminal size.")
            end
        end
    else
        --unix detected
        local handle = io.popen('stty size', 'r')
        if handle then
            local result = handle:read('*a')
            handle:close()
            local rows, cols = result:match("(%d+) (%d+)")
            size['rows'] = tonumber(rows)
            size['cols'] = tonumber(cols)
        end
    end
    return size
end

function console_ctrl.clear()
    if package.config:sub(1,1) == '\\' then
        os.execute("cls")
    else
        os.execute("clear")
    end
end

function console_ctrl.forceUTF8OnWindows()
    if package.config:sub(1,1) == '\\' then
        os.execute("chcp 65001")
    end
end

function console_ctrl.colorizer(messageType, text)
    local styles = {
        warning = {text = "\27[33m", icon = "[!]", entryText = "Warning: "},
        error = {text = "\27[1;31m", icon = "[X]", entryText = "Error: "},
        info = {text = "\27[4;36m", icon = "[i]", entryText = "Info: "},
        infoLogo = {text = "\27[34m", icon = "[@]", entryText = ""},
    }
    local style = styles[messageType]
    if not style then
        return text
    end
    return style.text .. style.icon .. style.entryText .. text .. "\27[0m"
end


return console_ctrl