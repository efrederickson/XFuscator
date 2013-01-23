require 'LuaMinify.ParseLua'
require 'LuaMinify.FormatMini'

function obfuscate(code, useLoadstring, level, mxLevel, makeFluff)
    if type(useLoadstring) == 'number' then
        local tmp = level
        level = useLoadstring
        mxLevel = tmp
        useLoadstring = true
    end
    if useLoadstring == nil then useLoadstring = true end
    level = level or 1
    mxLevel = mxLevel or 2
    if makeFluff == nil then makeFluff = true end
    
    local concat = function(...) return table.concat({...}, "") end
    local function dumpString(x) 
        --return concat("\"", x:gsub(".", function(d) return "\\" .. string.byte(d) end), "\"") 
        return x:gsub(".", function(d) return "\\" .. string.byte(d) end)
    end
    local function GenerateSomeFluff()
        if makeFluff == false then return "" end
        
        local randomTable = { "N00BING N00B TABLE", "game.Workspace:ClearAllChildren()", "?????????", "game", "Workspace", "wait", "loadstring", "Lighting", "TeleportService", "error", "crash__", "_", "____", "\\\"FOOLED YA?!?!\\\"", "\\\"MWAHAHA H4X0RZ\\\"", "string", "table", "\\\"KR3D17 70 XFU5K470R\\\"", "string", "os", "tick", "\"system\"" }
        --for i = 1, 100 do print(math.random(1, #randomTable)) end
        local x = math.random(1, #randomTable)
        if x > (#randomTable / 2) then
            local randomName = randomTable[x]
            return concat("local ", string.rep("_", math.random(5, 10)), " = ", "____[#____ - 9](", "'" .. dumpString("loadstring(\"return " .. randomName .. "\")()") .. "'", ")\n")
        elseif x > 3 then
            return concat("local ", string.rep("_", math.random(5, 10)), " = ____[", math.random(1, 31), "]\n")
        else -- x == 3, 2, or 1
            return concat("local ", ("_"):rep(100), " = ", '"' .. dumpString("XFU5K470R R00LZ") .. '"', "\n")
        end
    end
    local function GenerateFluff() 
        --local x = { } for i = 1, math.random(2, 10) do table.insert(x, GenerateSomeFluff()) end return table.concat(x) 
        if makeFluff then
            return GenerateSomeFluff()
        else
            return ""
        end
    end
    math.randomseed(os and os.time() or tick())
    
    local str = ""
    local success,tok = LexLua(code)
    if not success then
        return "-- Failed to parse code: " .. tok .. "\r\n" .. code
    end
    
    -- Rip constant strings out
    local function makeStrNode(index)
        --[[return { 
            Type = 'IndexExpr',
            ParentCount = 1,
            Base = { AstType = 'VarExpr', Name = "CONSTANT_POOL" },
            Index = { AstType = 'NumberExpr', Value = index }
        }]] -- Ast Node
        return 
        { Type = 'Symbol', Data = '(', Line = 0, Char = 0 },
        { Type = 'Ident', Data = 'CONSTANT_POOL', Line = 0, Char = 0 },
        { Type = 'Symbol', Data = '[', Line = 0, Char = 0 },
        { Type = 'Number', Data = tostring(index), Line = 0, Char = 0 },
        { Type = 'Symbol', Data = ']', Line = 0, Char = 0 },
        { Type = 'Symbol', Data = ')', Line = 0, Char = 0 }
    end
    
    local tokens = tok:getTokenList()
    table.insert(tokens, 1, { Type = 'Keyword', Data = 'local', Line = 0, Char = 0 })
    table.insert(tokens, 2, { Type = 'Ident', Data = 'CONSTANT_POOL', Line = 0, Char = 0 })
    table.insert(tokens, 3, { Type = 'Symbol', Data = '=', Line = 0, Char = 0 })
    table.insert(tokens, 4, { Type = 'Symbol', Data = '{', Line = 0, Char = 0 })
    table.insert(tokens, 5, { Type = 'Symbol', Data = '}', Line = 0, Char = 0 })
    
    local constantPoolTokIndex = 5
    local CONSTANT_POOL = { }
    local function insertString(str, index)
        local _, code = LexLua("[" .. index .. "] = " .. '"' .. str .. "\", ")
        local t = code:getTokenList()
        for i = 1, #t - 1 do
            table.insert(tokens, constantPoolTokIndex + (i - 1), t[i])
        end
        constantPoolTokIndex = constantPoolTokIndex + 6
    end
    
    local index = 1
    tok:Save()
    while not tok:Is'Eof' do
        local p = tok:getp()
        local t = tok:Peek()
        if t.Type == 'String' then
            --tok:Get()
            local str = t.Constant
            --print("string",str)
            str = dumpString(str)
            local nodes
            if not CONSTANT_POOL[str] then
                CONSTANT_POOL[str] = index
                insertString(str, index)
                index = index + 1
                p = p + 5
            end
            nodes = { makeStrNode(CONSTANT_POOL[str]) }
            local x
            
            if tokens[p].Type == 'String' then
                x = table.remove(tokens, p)
            else
                x = table.remove(tokens, p + 1) -- remove string from tokens
                p = p + 1 -- increment pointer
            end
            --print(x.Type, x.Data)
            
            --tokens[p + 1] = nodes[1]
            --for i = 2, #tokens do
            for i = 1, #nodes do
                table.insert(tokens, p + i - 1, nodes[i])
            end
            
            tok:setp(p + #nodes)
            --p = p + #nodes
        else
            local x = tok:Get()
            --print(x and x.Type)
        end
    end
    
    insertString("\88\70\85\53\75\52\55\48\82\32\49\53\32\52\87\51\53\48\77\51\46\32\75\82\51\68\49\55\32\55\48\32\88\70\85\53\75\52\55\48\82\33", index)
    tok:Restore()
    
    local ast
    local s = ""
    --for k, v in pairs(tokens) do s = s .. (v.Data or "") .. " " end
    success, ast = ParseLua(tok)
    --success, ast = ParseLua(s)
    
    if not success then
        for k, v in pairs(tok:getTokenList()) do
            print(v.Type, v.Data)
        end
        return "-- Failed to parse code: " .. ast .. "\r\n" .. code
    end
    
    local a = Format_Mini(ast)
    if useLoadstring then
        a = string.dump(loadstring(a))
    end
    
    -- Convert to char/table/loadstring thing
    math.randomseed(os and os.time() or tick())
    local __X = math.random()
    local a2 = [[ math.randomseed(]] .. __X .. [[)
local ____
____ = { function(...) local t = { ...} return ____[8](t) end, print, game, math.frexp, math.random(1, 1100), string.dump, string.sub, table.concat, wait, tick, loadstring, "t", function(x) local x2 = loadstring(x) if x2 then return ____[tonumber("\50\48")](function() x2() end) else return nil end end, "InsertService", 1234567890, getfenv, "", "wai", 7.2, pcall, math.pi, "" }
]] .. GenerateFluff() .. [[local ___ = ____[5]
]] .. GenerateFluff() .. [[local _ = function(x) return string.char(x / ___) end
]] .. GenerateFluff() .. [[local __ = {]]
    math.randomseed(__X)
    local ___X = math.random(1, 1100)
    local a3 = { }
    for i = 1, a:len() do
        table.insert(a3, concat("_(", (string.byte(a:sub(i, i)) * ___X), "), "))
    end
    a2 = a2 .. table.concat(a3, "")
    a2 = a2 .. " } \n"
    a2 = a2 .. GenerateFluff()
    a2 = a2 .. "return ____[11]((____[8](__)), ____[#____])()\n"
    --a2 = a2 .. GenerateFluff() TODO
    if level < mxLevel then
        print(concat("OBFUSCATED AT LEVEL ", level, " OUT OF ", mxLevel, " (" .. a:len() .. " Obfuscated characters)"))
        return obfuscate(a2, level + 1, mxLevel)
    else
        print(concat("OBFUSCATED AT LEVEL ", level, " OUT OF ", mxLevel, " (", a:len(), " Obfuscated Characters) [Done]"))
        a2 = a2:gsub("[%s]+", " ")
        return a2
    end
end


code = [[
local function printhi()
    local msg_to_print = 'Hello world' --'hello\"\'[=[asdf]=] world'
    local a = { "asdf", "qwerty" }
    local b = [=[ long String [==[asdf]==] bleh]=]
    print(msg_to_print)
end

printhi()

--print(CONSTANT_POOL[0])
]]

local options = { 
    fluff = true,
    useLoadstring = true,
    level = 1,
    mxLevel = 1,
}

local outfn

if arg and arg[1] then
    code = io.open(arg[1], 'rb'):read'*a'
    outfn = arg[1]:sub(1, -5) .. " [Obfuscated].lua"
    local i = 2
    while i < #arg do
    --for i = 2, #arg do
        local a = arg[i]:lower()
        if a == "-nofluff" then
            options.fluff = false
        elseif a == "-fluff" then
            options.fluff = true
        elseif a == "-loadstring" then
            options.loadstring = true
        elseif a == "-noloadstring" then
            options.loadstring = false
        elseif a == "-level" or a == "-l" then
            options.level = tonumber(arg[i + 1])
            i = i + 1
        elseif a == "-max" then
            options.mxLevel = tonumber(arg[i + 1])
            i = i + 1
        end
        i = i + 1
    end
else
    print("Code to obfuscate: ")
    code = io.read'*l'
end

local t1 = os and os.time() or tick()
result = obfuscate(code, options.useLoadstring, options.level, options.mxLevel, options.fluff)
local t2 = os and os.time() or tick()
if not outfn then
    print(result)
end
a, b = loadstring(result)
if a then
    print"--Successful!"
    if not outfn then
        a()
    end
else
    print("--Failed: " .. b)
end
if outfn then
    local f = io.open(outfn, 'wb')
    f:write(result)
    f:close()
    print("Written to:", outfn)
end
print("Time taken:", t2 - t1)
