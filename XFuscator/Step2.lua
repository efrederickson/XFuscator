return function(a, GenerateFluff, useTD)
    GenerateFluff = GenerateFluff or function() return "" end
    local a2 = ""
    math.randomseed(os and os.time() or tick())
    local __X = math.random()
    a2 = [[ math.randomseed(]] .. __X .. [[)
local ____
____ = { function(...) local t = { ...} return ____[8](t) end, print, game, math.frexp, math.random(1, 1100), string.dump, string.sub, table.concat, wait, tick, loadstring, "t", function(x) local x2 = loadstring(x) if x2 then return ____[tonumber("\50\48")](function() x2() end) else return nil end end, "InsertService", 1234567890, getfenv, "", "wai", 7.2, pcall, math.pi, "" }
]] .. GenerateFluff() .. [[local ___ = ____[5]
]] .. GenerateFluff() .. [[local _ = function(x) return string.char(x / ___) end
]] .. GenerateFluff() .. [[local __ = {]]
    math.randomseed(__X)
    local ___X = math.random(1, 1100)
    local a3 = { }
    
    if useTD then
        -- TODO: SHA256 Hash checking
    end
    
    for i = 1, a:len() do
        table.insert(a3, table.concat{ "_(", (string.byte(a:sub(i, i)) * ___X), "), " })
    end
    a2 = a2 .. table.concat(a3, "")
    a2 = a2 .. " } \n"
    a2 = a2 .. GenerateFluff()
    if useTD then
        a2 = a2 .. "return ____[11](assert(#(____[8](__))==" .. #a3 .. " and (____[8](__)) or nil, '" .. XFuscator.DumpString("Tampering detected") .. "'), ____[#____])()\n"
    else
        a2 = a2 .. "return ____[11]((____[8](__)), ____[#____])()\n"
    end
    return a2
end
