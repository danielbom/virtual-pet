
Router = require("Router")
local Pet = require("Pet")
local suit = require("SUIT")
local Utils = require("Utils")
local EnergyBar = require("EnergyBar")
local Animation = require("Animation")
local Interface = require ("Interface")
local Observable = require("Observable")
local ManagerAnimations = require("ManagerAnimations")

local t = 0
local d = 30
local user = "Daniel"

Game = {}
Game.__index = Game


function Game.load()
    -- Carregando o background
    local image = love.graphics.newImage("Imagens/background.png")
    width, height = image:getWidth(), image:getHeight()
    background = {
        image = image,
        quad = love.graphics.newQuad( 0, 0,
            width, height, image:getDimensions()
        )
    }
    -- Definindo a janela
    canvas = {
        width = width,
        height = height,
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
        .toMiddle()
        .loadAnimations("/Sprites/Togepi/")
        
    pet.alert = Observable.New()
    pet.alert.register(energyBar, energyBar.update)

    pet.save(user)
    pet.load(user)
end

function Game.update(time)
    -- print(t)
    t = t + time
    if t >= d then
        pet.save(user)
        t = 0
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
    love.graphics.draw(background.image, background.quads)

    -- Desenhando o pet
    pet.displayStatus()
    pet.animations.display()

    energyBar.animations.display()

    -- Desenhando os componentes de interface
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

function Game.mousemoved( x, y, dx, dy, istouch )
    if x >= 600 and x <= 700 and y >= 250 and y <= 350 then
        -- print("moved", x, y)
    end
end

return Game