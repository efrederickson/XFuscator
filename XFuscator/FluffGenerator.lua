local function GenerateSomeFluff()
    local dumpString = XFuscator.DumpString
    
    local randomTable = { "N00BING N00B TABLE", "game.Workspace:ClearAllChildren()", "?????????", "game", "Workspace", "wait", "loadstring", "Lighting", "TeleportService", "error", "crash__", "_", "____", "\\\"FOOLED YA?!?!\\\"", "\\\"MWAHAHA H4X0RZ\\\"", "string", "table", "\\\"KR3D17 70 XFU5K470R\\\"", "string", "os", "tick", "\"system\"" }
    --for i = 1, 100 do print(math.random(1, #randomTable)) end
    local x = math.random(1, #randomTable)
    if x > (#randomTable / 2) then
        local randomName = randomTable[x]
        return table.concat{ "local ", string.rep("_", math.random(5, 10)), " = ", "____[#____ - 9](", "'" .. dumpString("loadstring(\"return " .. randomName .. "\")()") .. "'", ")\n" }
    elseif x > 3 then
        return table.concat{ "local ", string.rep("_", math.random(5, 10)), " = ____[", math.random(1, 31), "]\n" }
    else -- x == 3, 2, or 1
        return table.concat{ "local ", ("_"):rep(100), " = ", '"' .. dumpString("XFU5K470R R00LZ") .. '"', "\n" }
    end
end
local function GenerateFluff() 
    --local x = { } for i = 1, math.random(2, 10) do table.insert(x, GenerateSomeFluff()) end return table.concat(x) 
    return GenerateSomeFluff()
end

return GenerateFluff
