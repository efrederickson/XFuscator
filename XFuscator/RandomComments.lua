return function(a)
    a:gsub("[%s]+", function() 
        local r = "" 
        for i = 1, math.random(0, 20) do 
            local x = math.random(1, 100)
            if x < 25 then
                r = r .. string.char(math.random(1, 9))
            elseif x < 50 then
                r = r .. string.char(math.random(11,28))
            elseif x < 75 then
                r = r .. string.char(math.random(32, 90))
            elseif x < 90 then
                r = r .. string.char(math.random(94, 126))
            else
                r = r .. string.char(math.random(128, 255))
            end
        end 
        return " --[[" .. r .. "]] " 
    end)
end
