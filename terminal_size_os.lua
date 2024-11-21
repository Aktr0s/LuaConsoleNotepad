terminal_size_os = {}

function terminal_size_os.terminalSize()
    local size = {['rows'] = 0, ['cols'] = 0}
    if package.config:sub(1,1) == '\\' then
        --windows detected
        local handle = io.popen('mode con', 'r')
        local result = handle:read('*a')
        handle:close()
        local rows, cols = result:match("Lines:%s*(%d+)%s*Columns:%s*(%d+)")
        if rows and cols then
            size['rows'] = rows
            size['cols'] = cols
        else
            print("Failed to parse terminal size.")
        end
    else
        --unix detected
        local handle = io.popen('stty size', 'r')
        local result = handle:read('*a')
        handle:close()
        local rows, cols = result:match("(%d+) (%d+)")
        size['rows'] = rows
        size['cols'] = cols
    end
    return size
end

return terminal_size_os