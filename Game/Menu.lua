Menu = {}
Menu.__index = Menu

local inputs = {
    login = { text = "" },
    pass = { text = "" }
}

local players = {
    data = {}
}

local loveWidth = love.graphics.getWidth()
local loveHeight = love.graphics.getHeight()

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
    local image = love.graphics.newImage("Imagens/logo.png")
    width, height = image:getWidth(), image:getHeight()
    background = {
        image = image,
        quad = love.graphics.newQuad( 0, 0,
            width, height, image:getDimensions()
        )
    }
    players.load()
end

function inputs.check()
    return inputs.login.text ~= '' and inputs.pass.text ~= ''
end

function Menu.update(time)
    local x = 275
    local dx = 100
    local y = 450
    local create = suit.Button("Create a pet", x, y, 50, 70)
    local load = suit.Button("Load Game", x + dx, y, 50, 70)
    local quit = suit.Button("Quit", x + dx * 2, y, 50, 70)
    
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

    local x = 320
    local y = 320
    local dy = 50
    local login = suit.Input(inputs.login, x, y, 200, 30)
    local pass = suit.Input(inputs.pass, x, y + dy, 200, 30)
    suit.Label("Pet: ", x - 150, y, 200, 30)
    suit.Label("Pass: ", x - 150, y + dy, 200, 30)
    
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
    love.graphics.translate(100, 100)
    love.graphics.draw( background.image, background.quads)
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
