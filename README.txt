XFuscator - The Best Lua Obfuscator 3V4R
----------------------------------------

Disclaimer:
Might not actually be the best one ever. 
If you find a better one, tell me so I can make XFuscator better than it.

NOTE: Files become much larger. A 1KB file can easily go to 5-15 KB.
XFuscator (about 10 KB) becomes 500-700 KB. 


Features:
- Remove comments
- Rename ALL local variables SAFELY (see below, obfuscates precompiled local names also)
- extract all constants
- Remove extra whitespace
- Add fluff
- precompile with loadstring
- precompiled chunks have their locals made completely unrepresentable
- encode source (or binary chunk)
- Add unrepresentable characters in comments
- In precompiled code, renames locals to something like <local$1>_[0-20 chars of range 0-255]
- option to encrypt constant strings (uses XOR with random key)
- Tamper detection (length checking)
TODO:
- Tamper detection (SHA256 hash)
- Add ROBLOX features to make the game crash if the script was stolen
- extract global variables and replace with a CONSTANT_POOL index (no, because this would cause issues when one changed)
- encode (binary, hex)

Compare to:
Capprime Lua Obfuscator (http://www.capprime.com/CapprimeLuaObfuscator/CapprimeLuaObfuscator.aspx)
- Features: rename variables longer than 4 characters, strip SOME comments and eliminate SOME whitespace
LuaSrcDiet (http://luasrcdiet.luaforge.net/)
- Features: removes whitespace/comments, optimizes constants, renames variables
Lua Obfuscator (http://www.lualearners.org/forum/3869)
- Features: extract constant strings, add gibberish into comments, rename variables, DOES NOT WORK WITH COMMENTS
Lua Code Obfuscator (http://pastebin.com/ixB0UpHB)
- Features: precompiles into bytecode



CHANGELOG
------------------------------------
Version 2.0b1
- Complete rewrite, along with updated code parsing and using LAT to edit precompiled chunks

Version 1.1
- changed variable regex

Version 1.0
- Initial release