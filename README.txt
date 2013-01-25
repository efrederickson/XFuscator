XFuscator - The Best Lua Obfuscator 3V4R
----------------------------------------

Disclaimer:
Might not actually be the best one ever. 
If you find a better one, tell me so I can make XFuscator better than it.


Features:
- Remove comments
- Rename ALL local variables SAFELY
- extract all constants
- Remove extra whitespace
- Add fluff
- precompile with loadstring
- encode source (or binary chunk)
- Add unrepresentable characters in comments
TODO:
- Add ROBLOX features to make the game crash if the script was stolen
- Encrypt?


NOTE: Files become much larger. A 1KB file can easily go to 5-15 KB.
XFuscator (about 10 KB) becomes ~700 KB. If you obfuscate with comments off (-nocomments flag), it makes
it MUCH smaller, but still huge.

Compare to:
Capprime Lua Obfuscator (http://www.capprime.com/CapprimeLuaObfuscator/CapprimeLuaObfuscator.aspx)
- Features: rename variables longer than 4 characters, strip SOME comments and eliminate SOME whitespace
LuaSrcDiet (http://luasrcdiet.luaforge.net/)
- Features: removes whitespace/comments, optimizes constants, renames variables
Lua Obfuscator (http://www.lualearners.org/forum/3869)
- Features: extract constant strings, add gibberish into comments, rename variables, DOES NOT WORK WITH COMMENTS
Lua Code Obfuscator (http://pastebin.com/ixB0UpHB)
- Features: precompiles into bytecode