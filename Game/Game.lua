local Pet = require("Pet")
local Utils = require("Utils")
local EnergyBar = require("EnergyBar")
local HungryBar = require("HungryBar")
local Animation = require("Animation")
local Observable = require("Observable")
local ManagerAnimations = require("ManagerAnimations")

Game = {}
Game.__index = Game

local globalTime = 0
local savePeriod = 30

local function loadUserData()
    -- Carregando os dados usuário
    local file = io.open(user.."Data.json", "r")
    if file then
        pet.load(user)
        file.close()
    else
        pet.save(user)
    end
end

function Game.load()
    -- love.audio.play(musics.main)

    -- Carregando o background
    local image = love.graphics
        .newImage("Imagens/background1-festivo.jpeg")
    width, height = image:getWidth(), image:getHeight()
    background = {
        image = image,
        quad = love.graphics.newQuad( 0, 100,
            width, height, image:getDimensions()
        )
    }
    
    -- Carregando o pet
    pet = Pet.New()
    pet.animations = ManagerAnimations.New()
        .setScale(3)
        .xToMiddle()
        .setY(340)
        .loadAnimations("/Sprites/Togepi/")

    -- Carregando a barra de energia
    energyBar = EnergyBar.New()
    energyBar.animations = ManagerAnimations.New()
        .setX(100).setY(0)
        .loadAnimations("/Sprites/EnergyBar/")

    -- Carregando a barra de fome
    hungryBar = HungryBar.New()
    hungryBar.animations = ManagerAnimations.New()
        .setX(200).setY(0).setScale(0.23)
        .loadAnimations("/Sprites/HungryBar/")
    
    -- Registrando observadores
    pet.alert = Observable.New()
    pet.alert.register(energyBar, energyBar.update)
    pet.alert.register(hungryBar, hungryBar.update)

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
    
    -- Atualizando a barra de energia
    energyBar.animations.update(time)
    -- Atualizando a barra de fome
    hungryBar.animations.update(time)
    
    -- Botões
    local x = 180
    local dx = 70
    local y = 515
    if pet.state ~= "Dead" then 
        suit.Button("Comer",   x + dx*1, y, 60, 60)
        suit.Button("Beber",   x + dx*2, y, 60, 60)
        suit.Button("Estudar", x + dx*3, y, 60, 60)
        suit.Button("Curar",   x + dx*4, y, 60, 60)
        suit.Button("Dormir",  x + dx*5, y, 60, 60)
    else
        suit.Button("Reiniciar", x + dx*3, y, 60, 60)
    end
end

function Game.draw()
    -- Desenhando a janela
    love.graphics.draw(canvas.format, canvas.width, canvas.height)

    -- Desenhando o background
    love.graphics.draw( background.image, background.quad)

    -- Desenhando o pet
    pet.displayStatus()
    pet.animations.display()
    energyBar.animations.display()
    hungryBar.animations.display()

    -- Desenhando os componentes de interface
    suit.draw()
end


function Game.mousepressed( x, y, button, isTouch )
    print("press", x, y)
end

function Game.mousereleased( x, y, button, isTouch )
    print("release", x, y)
    -- Se estou clicando no pet
    if x >= 370 and x <= 430 and y >= 380 and y <= 460 then
        if pet.state == "Idle" then
            pet.animations.setCurrent("Love")
        end
    end
end

return Game