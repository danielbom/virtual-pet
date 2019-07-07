Menu = {}
Menu.__index = Menu

local inputs = {
    login = { text = "" },
    pass = { text = "" },
    hidden = "",
    error = 0
}

local players = {
    data = {}
}

local loveWidth = love.graphics.getWidth()
local loveHeight = love.graphics.getHeight()

function players.load()
    -- Carrega os dados salvos de um jogador
    local filename = "players.json"
    local file = io.open(filename,"r")
    if file ~= nil then
        local string = file:read()
        file:close()
        players.data = Json.parse(string)
    end
end

function players.save()
    -- Cria um save para o jogador
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
    musics.main:setLooping(true)
    musics.main:setVolume(0.5)
    love.audio.play(musics.main)

    -- Definindo o titulo
    love.window.setTitle("Virtual Pet")

    -- Carregando o background
    local image = love.graphics
        .newImage("Imagens/background1.desfocado.jpeg")
    width, height = image:getWidth(), image:getHeight()
    background = {
        image = image,
        quad = love.graphics.newQuad( 90, 90,
            width, height, image:getDimensions()
        )
    }

    -- Carregando o model do login
    local image = love.graphics
        .newImage("Imagens/MoldeLoginSemBG.png")
    width, height = image:getWidth(), image:getHeight()
    moldeLogin = {
        image = image,
        quad = love.graphics.newQuad( 0, 0,
            width, height, image:getDimensions()
        )
    }

    -- Carregando a logo
    local image = love.graphics
        .newImage("Imagens/logos4.png")
    width, height = image:getWidth(), image:getHeight()
    logo = {
        image = image,
        quad = love.graphics.newQuad( 0, 0,
            width, height, image:getDimensions()
        )
    }
    players.load()
end

function inputs.check()
    -- Verifica se as entradas são válidas
    return inputs.login.text ~= '' and inputs.pass.text ~= ''
end

function inputs.clear()
    -- Limpa as entradas do usuário
    inputs.login.text = ""
    inputs.pass.text = ""
    inputs.hidden = ""
end

function Menu.update(time)
    -- Criando os botões
    local x = 290
    local dx = 100
    local y = 400
    suit.theme.color.normal = {bg = {255, 255, 225}, fg = {0, 0, 0}}
    suit.theme.color.hovered = {bg = {255, 255, 225}, fg = {0, 0, 255}}
    suit.theme.color.active = {bg = {255, 255, 225}, fg = {0, 255, 0}}
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
            inputs.error = inputs.error + 1
            print ("Usuário ou senha inválidos.")
        end
    elseif load.hit then
        if inputs.check() and players.check(inputs.login.text, inputs.pass.text) then
            user = inputs.login.text
            Router.setState("Game")
        else
            inputs.clear()
            inputs.error = 1
            print("Usuário ou senha incorretos.")
        end
    elseif quit.hit then
        love.event.quit()
    end

    -- Criando as caixas de texto
    local x = 340
    local y = 290
    local dy = 50
    inputs.login.obj = suit.Input(inputs.login, x, y, 200, 30)
    inputs.pass.obj = suit.Input(inputs.pass, x, y + dy, 200, 30)
    
    -- Verificando se foi digitado enter
    if inputs.login.obj.submitted or inputs.pass.obj.submitted then
        if players.check(inputs.login.text, inputs.pass.text) then
            user = inputs.login.text
            Router.setState("Game")
        else 
            inputs.error = inputs.error + 1
            print("Usuário ou senha incorretos.")
        end
    end

    -- Controle para esconder a senha
    if inputs.pass.text ~= "" and inputs.pass.text:match("[^*]") then
        local hidden = inputs.pass.text:gsub("*", "")
        inputs.hidden = inputs.hidden .. hidden
        inputs.pass.text = inputs.pass.text:gsub("[^*]", "*")
    end
end

function Menu.draw()
    -- Desenhando o background
    love.graphics.push()
        love.graphics.translate(0,-70)
        love.graphics.draw( background.image, background.quad )
    love.graphics.pop()
    
    -- Desenhando a logo
    love.graphics.push()
        love.graphics.translate(80,50)
        love.graphics.draw( logo.image, logo.quad )
    love.graphics.pop()
    
    -- Desenho a caixa de texto de entrada
    love.graphics.push()
        love.graphics.translate(0,-105)
        love.graphics.draw(
            moldeLogin.image,
            moldeLogin.quad,
            220, 300,
            0, 0.4
        )
        local x = 450
        local y = 400
        local dy = 50
        love.graphics.print("Pet: ", x - 150, y)
        love.graphics.print("Pass: ", x - 150, y + dy)

        if inputs.error ~= 0 then
            love.graphics.print(
                "Usuário e senha inválidos (" .. inputs.error .. ")",
                x - 120, y + 80
            )
        end
    love.graphics.pop()
    suit.draw()
end

function Menu.textinput(t)
    suit.textinput(t)
end

function Menu.keypressed(key)
    suit.keypressed(key)
end

function Menu.keypressed(key)
    if key == "delete" or key == "backspace" then
        inputs.clear()
    end
end

return Menu
