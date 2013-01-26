require'XFuscator.init'

print(('-'):rep(79))
print("------------------ XFUSCATOR - THE BEST LUA OBFUSCATOR 3V4R ------------------")
print("------------------------ Copyright (C) 2012-2013 LoDC ------------------------")
print("---------- Version 2.0 b1 : https://github.com/mlnlover11/XFuscator ----------")
print(('-'):rep(79))
print()

local code = [[
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
    comments = false,
    step2 = true,
    uglify = false,
    encryptConstants = false,
}

local outfn

if arg and arg[1] then
    if arg[1] == '-h' or arg[1] == '-help' then
        --print("-- XFUSCATOR : THE BEST LUA OBFUSCATOR 3V4R --")
        --print("Copyright (C) 2012-2013 LoDC")
        print("")
        print("Usage: XFuscator.lua <script.lua> [options]")
        print("  Obfuscates script.lua and writes the obfuscated code to <script [Obfuscated].lua>")
        print("")
        print("Other usage: XFuscator.lua")
        print("  Obfuscates one line of code read from stdin (console)")
        print("")
        print("Valid options:")
        print("  -nofluff        Doesn't generate pointless \"fluff\" code")
        print("  -fluff          Generates pointless \"fluff\" code")
        print("  -loadstring     Precompiles code with loadstring, along with encrypting locals")
        print("  -noloadstring   Does not precompile code with loadstring")
        print("  -level <level>  Starts obfuscation at level <level>")
        print("  -max <max>      Sets max obfuscation level to <max>")
        print("  -nocomments     Does not generate pointless comments with random chars")
        print("  -nostep2        Does not turn code into slightly encrypted char array ")
        print("                      along with other stuff. This setting is recommeded.")
        print("  -uglify         Converts words into chars >127 and then converts back")
        print("                      During execution. Recomended for large files, as it")
        print("                      can shrink code quite a bit. It also makes it unreadable")
        print("  -encryptconsts      Turns off constant string encryption. Off by default, as ")
        print("                      It causes MASSIVE bloating and it is just simple xor")
        print("  -h  -help       Shows this message")
        return
    end
    code = io.open(arg[1], 'rb'):read'*a'
    outfn = arg[1]:sub(1, -5) .. " [Obfuscated].lua"
    local i = 2
    while i <= #arg do
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
            options.level = tonumber(arg[i + 1] or 1)
            i = i + 1
        elseif a == "-max" then
            options.mxLevel = tonumber(arg[i + 1] or 1)
            i = i + 1
        elseif a == "-nocomments" then
            options.comments = false
        elseif a == "-nostep2" then
            options.step2 = false
        elseif a == "-uglify" then
            options.uglify = true
        elseif a == "-encryptconsts" then
            options.encryptConstants = true
        elseif a == "-h" or a == "-help" then
            
        end
        i = i + 1
    end
else
    print("Code to obfuscate: ")
    code = io.read'*l'
end

local t1 = os and os.time() or tick()
local result, msg = XFuscator.XFuscate(code, options.level, options.mxLevel, options.loadstring, options.fluff, options.comments, options.step2, options.uglify, options.encryptConstants)
local t2 = os and os.time() or tick()
if not outfn then
    print(result)
end
if not result then
    print("-- Failed: " .. msg)
else
    local a, b = loadstring(result)
    if a then
        print"-- Successful!"
        if not outfn then
            a()
        end
    else
        print("-- Failed: " .. b)
    end
    
    if outfn then
        local f = io.open(outfn, 'wb')
        f:write(result)
        f:close()
        print("Written to:", outfn)
    end
end

print("-- Time taken:", t2 - t1)
