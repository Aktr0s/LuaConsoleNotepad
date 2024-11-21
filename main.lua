local file_handle = require("file_handle")
local prompt = require("prompt")
local tso = require("terminal_size_os")

function countTableElements(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end

local params = {}
for i = 1, #arg do
    table.insert(params, arg[i])
end

if countTableElements(params) == 0 then
    error("Error: No arguments specified")
elseif countTableElements(params) >= 2 then
    error("Error: Too many arguments")
end
print(params[1])
print(params[1]:sub(-4):lower() == ".txt")

if not file_handle.extensionCheck(params[1]) then
    error("Error: Only .txt files are supported")
end
local content = file_handle.read_file(params[1])
print(content[1])