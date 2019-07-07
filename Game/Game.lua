Pet = require("Pet")
local Utils = require("Utils")
local EnergyBar = require("EnergyBar")
local Animation = require("Animation")
local Interface = require ("Interface")
local Observable = require("Observable")
local ManagerAnimations = require("ManagerAnimations")

local globalTime = 0
local savePeriod = 30

Game = {}
Game.__index = Game

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
    musics.main:setLooping(true)
    musics.main:setVolume(0.5)
    -- love.audio.play(musics.main)

    -- Carregando o background
    local image = love.graphics.newImage("Imagens/background1-festivo.jpeg")
    width, height = image:getWidth(), image:getHeight()
    background = {
        image = image,
        quad = love.graphics.newQuad( 0, 100,
            width, height, image:getDimensions()
        )
    }
    -- Definindo a janela
    canvas = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }
    love.window.setMode(canvas.width, canvas.height, {resizable = true})
    canvas.format = love.graphics.newCanvas(canvas.width, canvas.height)
    
    interface = Interface.New()

    energyBar = EnergyBar.New()
    energyBar.animations = ManagerAnimations.New()
        .setX(100).setY(0)
        .loadAnimations("/Sprites/EnergyBar/")

    pet = Pet.New()
    pet.animations = ManagerAnimations.New()
        .setScale(3)
        .xToMiddle()
        .setY(340)
        .loadAnimations("/Sprites/Togepi/")
        
    pet.alert = Observable.New()
    pet.alert.register(energyBar, energyBar.update)

    loadUserData()
    pet.animations.setCurrent(pet.state)
end

function Game.update(time)
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

    -- Atualizando a interface
    interface.loadButtons(canvas.width, canvas.height)
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

    -- Desenhando os componentes de interface
    love.graphics.translate(0, 0)
    interface.draw()
end




function Game.mousepressed( x, y, button, isTouch )
    if x >= 600 and x <= 700 and y >= 250 and y <= 350 then
        print("press", x, y)
    end
end

function Game.mousereleased( x, y, button, isTouch )
    if x >= 600 and x <= 700 and y >= 250 and y <= 350 then
        print("release", x, y)
        Router.setState("Menu")
    end
end

return Game