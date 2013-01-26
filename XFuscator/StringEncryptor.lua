return function(ast)
    local constantPoolAstNode = ast.Body[1].InitList[1]
    local bit = bit or bit32 or require'bit'
    local xor = bit.bxor or bit.xor
    local password = math.random(1, 100)
    local _, node = ParseLua([[local decrypt = function(c)
    local bit = bit or bit32 or require'bit'
    return bit.bxor(]] .. tostring(password) .. [[, c)
end
]])
    table.insert(ast.Body, 1, node.Body[1])
    for k, v in pairs(constantPoolAstNode.EntryList) do
        if v.Value then
            if v.Value.AstType == 'StringExpr' then
                local str = v.Value.Value.Constant
                local t = { }
                for i = 1, str:len() do
                    t[#t + 1] = xor(str:sub(i, i):byte(), password)
                end
                
                local newNode = "local _ = table.concat { "
                for k, v in pairs(t) do
                    newNode = newNode .. "string.char(decrypt(" .. v .. ")), "
                end
                newNode = newNode .. " }"
                local _, node = ParseLua(newNode)
                if not _ then error(node) end
                constantPoolAstNode.EntryList[k].Value = node.Body[1].InitList[1]
            end
        end
    end
end
