local function printhi()
    local msg_to_print = 'Hello world' --'hello\"\'[=[asdf]=] world'
    local a = { "asdf", "qwerty" }
    local b = [=[ long String [==[asdf]==] bleh]=]
    print(msg_to_print)
end

printhi()
