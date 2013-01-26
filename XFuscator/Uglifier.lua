return function(a)
    local dumpString = XFuscator.DumpString
    
    local keywords = { "and", "break", "do", "else", "elseif",
    "end", "false", "for", "function", "if",
        "in", "local", "nil", "not", "or", "repeat",
            "return", "then", "true", "until", "while" }

    -- make code SMALL
    local wordMap = {
        
    }

    local base_char = 128
    while base_char + #wordMap <= 255 and a:find("["..string.char(base_char).."-"..string.char(base_char+#wordMap-1).."]") do
        base_char = base_char + 1
    end

    for _, w in pairs(keywords) do
        wordMap[w] = base_char
        base_char = base_char + 1
    end
    for w in a:gmatch("([%a_][%w_]+)") do
        wordMap[w] = base_char
        base_char = base_char + 1
    end
    if base_char <= 255 then 
        for k, v in pairs(wordMap) do
            a:gsub(k, string.char(v))
            --print(k, v)
        end
        
        local tmp = "local wordMap = { "
        for k, v in pairs(wordMap) do
            tmp = tmp .. '["' .. dumpString(k) .. '"] = ' .. v .. ", "
        end
        tmp = tmp .. [[ }
    local code -- assigned later
    local function patch()
        for k, v in pairs(wordMap) do
            code = code:gsub(string.char(v), k)
        end
    end
    code = "]] .. dumpString(a) .. [["
    patch()
    loadstring(code)()]]
    end
    return a
end
