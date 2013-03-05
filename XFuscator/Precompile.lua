return function(a)
    a, b = loadstring(a)
    if not a then
        error("Failed to precompile code: " .. b)
    end
    a = string.dump(a)
    local file
    
    local function makeRandomName()
        local id = ""
        for i = 1, math.random(0, 20) do
            id = id .. string.char(math.random(0, 255))
        end
        return id
    end
        
    if a:sub(1, 5) == '\27LuaQ' then -- Renames locals to completely unrepresentable strings. MWAHAHA!!
        file = LAT.Lua51.Disassemble(a)
    elseif a:sub(1, 5) == '\27LuaR' then
        file = LAT.Lua52.Disassemble(a)
    end
    
    local function doFunc(f)
        for i = 0, f.Locals.Count - 1 do
            local lcl = f.Locals[i]
            -- gives it away ;)
            --lcl.Name = "<local$" .. tostring(i) .. ">_" .. makeRandomName()
            lcl.Name = tostring(i) .. makeRandomName()
        end
    end
    
    if file then
        print("  - Renaming locals in precompiled chunk to utter nonsense ...")
        doFunc(file.Main)
        
        a = file:Compile(false) -- Don't verify chunk
    end
    return a
end
