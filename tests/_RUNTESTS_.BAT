@echo off
del "*[Obfuscated].lua"
for %%f in (*.lua) do (
 cd ..
 XFuscator.lua "tests/%%f"
 cd tests
)

cd ..
XFuscator.lua XFuscator.lua
cd tests
move "..\XFuscator [Obfuscated].lua" "XFuscator [Obfuscated].lua"
echo DONE OBFUSCATING TESTS