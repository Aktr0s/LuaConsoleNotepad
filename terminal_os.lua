terminal_os = {}

function terminal_os.terminalSize()
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

function terminal_os.clear()
    if package.config:sub(1,1) == '\\' then
        os.execute("cls")
    else
        os.execute("clear")
    end
end

return terminal_os