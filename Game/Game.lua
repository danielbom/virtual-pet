local Pet = require("Pet")
local Utils = require("Utils")

local SmartBar = require("SmartBar")
local EnergyBar = require("EnergyBar")
local HungryBar = require("HungryBar")
local HealthBar = require("HealthBar")
local ThirstyBar = require("ThirstyBar")
local Background = require("Background")

local Observable = require("Observable")
local ManagerAnimations = require("ManagerAnimations")

Game = {}
Game.__index = Game

local globalTime, savePeriod = 0, 10

local function loadUserData()
    -- Carregando os dados usuário
    local filename = user.file()
    local file = io.open(filename, "r")
    if file then
        pet.load(filename)
        file.close()
    else
        pet.save(filename)
    end
end

function Game.load()
    Musics.setCurrent("Main")
    
    -- Carregando o pet
    pet = Pet.New()
    pet.animations = ManagerAnimations.New()
        .xToMiddle().setY(340).setScale(3)
        .loadAnimations("/Sprites/Togepi/")

    local x,dx,y = 60,100,2
    -- Carregando a barra de energia
    energyBar = EnergyBar.New()
    energyBar.animations = ManagerAnimations.New()
        .setX(x + dx * 1).setY(y).setScale(0.9)
        .loadAnimations("/Sprites/EnergyBar/")

    -- Carregando a barra de fome
    hungryBar = HungryBar.New()
    hungryBar.animations = ManagerAnimations.New()
        .setX(x + dx * 2).setY(y).setScale(0.21)
        .loadAnimations("/Sprites/HungryBar/")
    
    -- Carregando a barra de inteligencia
    smartBar = SmartBar.New()
    smartBar.animations = ManagerAnimations.New()
        .setX(x + dx * 3).setY(y).setScale(0.45)
        .loadAnimations("/Sprites/SmartBar/")
        .setCurrent("Noob")
    
    -- Carregando a barra de sede
    thirstyBar = ThirstyBar.New()
    thirstyBar.animations = ManagerAnimations.New()
        .setX(x + dx * 4).setY(y).setScale(0.45)
        .loadAnimations("/Sprites/ThirstyBar/")

    hearthBar = HealthBar.New()
    hearthBar.animations = ManagerAnimations.New()
        .setX(x + dx * 5).setY(y).setScale(1)
        .loadAnimations("/Sprites/HealthBar/")
    
    -- Carregando o background
    background = Background.New()
    background.animations = ManagerAnimations.New()
        .setX(-50).setY(-100).setScale(1)
        .loadAnimations("/Sprites/Background/")

    -- Registrando observadores
    pet.alert = Observable.New()
    pet.alert.register(smartBar, smartBar.update)
    pet.alert.register(energyBar, energyBar.update)
    pet.alert.register(hungryBar, hungryBar.update)
    pet.alert.register(hearthBar, hearthBar.update)
    pet.alert.register(thirstyBar, thirstyBar.update)
    pet.alert.register(background, background.update)

    -- Carregando dados do usuário
    loadUserData()
    pet.animations.setCurrent(pet.state)
end

function Game.update(time)
    -- Salvando os dados do usuário
    globalTime = globalTime + time
    if globalTime >= savePeriod then
        pet.save(user)
        globalTime = 0
    end

    -- Atualizando o pet
    pet.update(time)
    pet.alert.notify(pet)
    
    -- Atualizando a barra de status
    smartBar.animations.update(time)
    energyBar.animations.update(time)
    hungryBar.animations.update(time)
    hearthBar.animations.update(time)
    thirstyBar.animations.update(time)

    -- Atualizando o background
    background.animations.update(time)
    
    -- Botões
    local x,dx,y = 120,70,515
    if pet.state ~= "Dead" then 
        local sleep = suit.Button("Dormir",  x + dx*1, y, 60, 60)
        local heal  = suit.Button("Curar",   x + dx*2, y, 60, 60)
        local play  = suit.Button("Jogar",   x + dx*3, y, 60, 60)
        local study = suit.Button("Estudar", x + dx*4, y, 60, 60)
        local eat   = suit.Button("Comer",   x + dx*5, y, 60, 60)
        local drink = suit.Button("Beber",   x + dx*6, y, 60, 60)

        if     eat.hit   then pet.eat()
        elseif heal.hit  then pet.heal()
        elseif drink.hit then pet.drink()
        elseif study.hit then pet.study()
        elseif sleep.hit then pet.sleep()
        elseif play.hit and pet.play() then
            pet.save(user)
            Router.setState("TicTacToe")
        end

    else
        local reload = suit.Button("Reiniciar", x + dx*3, y, 60, 60)
        local exit   = suit.Button("Sair",      x + dx*4, y, 60, 60)

        if reload.hit then
            pet.reset()
            pet.save(user)
        elseif exit.hit then
            os.remove(user.."Data.json")
            Router.setState("Menu")
        end
    end
end

function Game.draw()
    -- Desenhando a janela
    love.graphics.draw(canvas.format, canvas.width, canvas.height)

    -- Desenhando o background
    background.animations.display()

    -- Desenhando o pet
    pet.animations.display()

    -- Desenhando a barra de status
    smartBar.animations.display()
    energyBar.animations.display()
    hungryBar.animations.display()
    hearthBar.animations.display()
    thirstyBar.animations.display()

    -- Desenhando os componentes de interface
    suit.draw()
end


function Game.mousepressed( x, y, button, isTouch )
    print("press", x, y)
    -- Se estou clicando no pet
    if x >= 370 and x <= 430 and y >= 380 and y <= 460 then
        if pet.state == "Idle" then
            pet.state = "Love"
        end
    end
end

return Game