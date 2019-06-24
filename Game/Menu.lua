Menu = {}
Menu.__index = Menu

local inputs = {
    login = { text = "" },
    pass = { text = "" }
}

local players = {
    data = {}
}

function players.load()
    local filename = "players.json"
    local file = io.open(filename,"r")
    if file ~= nil then
        local string = file:read()
        file:close()
        players.data = Json.parse(string)
    end
end

function players.save()
    local filename = "players.json"
    local string = Json.stringify(players.data)
    local file = io.open(filename,"w")
    file:write(string)
    file:close()
end

function players.check(user, pass)
    return players.data[user] == pass
end

function Menu.load()
    players.load()
end

function inputs.check()
    return inputs.login.text ~= '' and inputs.pass.text ~= ''
end

function Menu.update(time)
    local create = suit.Button("Create a pet", 300, 300, 50, 70)
    local load = suit.Button("Load Game", 400, 300, 50, 70)
    local quit = suit.Button("Quit", 500, 300, 50, 70)
    
    if create.hit then
        if inputs.check() then
            players.data[inputs.login.text] = inputs.pass.text
            players.save()
            user = inputs.login.text
            Router.setState("Game")
        else 
            print ("Usuário ou senha inválidos.")
        end
    elseif load.hit then
        if inputs.check() and players.check(inputs.login.text, inputs.pass.text) then
            user = inputs.login.text
            Router.setState("Game")
        else
            print("Usuário ou senha incorretos.")
        end
    elseif quit.hit then
        love.event.quit()
    end

    local login = suit.Input(inputs.login, 200, 100, 200, 30)
    local pass = suit.Input(inputs.pass, 200, 150, 200, 30)
    suit.Label("Pet: ", 50, 100, 200, 30)
    suit.Label("Pass: ", 50, 150, 200, 30)
    
    if login.submitted or pass.submitted then
        if players.check(inputs.login.text, inputs.pass.text) then
            user = inputs.login.text
            Router.setState("Game")
        else 
            print("Usuário ou senha incorretos.")
        end
    end
end

function Menu.draw()
    suit.draw()
end

function Menu.textinput(t)
    suit.textinput(t)
end

function Menu.keypressed(key)
    suit.keypressed(key)
end

function Menu.mousereleased( x, y, button, isTouch )
    print("release", x, y)
end


return Menu
