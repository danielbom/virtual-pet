Pet = require("Pet")
local Utils = require("Utils")
local EnergyBar = require("EnergyBar")
local Animation = require("Animation")
local Interface = require ("Interface")
local Observable = require("Observable")
local ManagerAnimations = require("ManagerAnimations")

local t = 0
local d = 30

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
        .toMiddle()
        .loadAnimations("/Sprites/Togepi/")
        
    pet.alert = Observable.New()
    pet.alert.register(energyBar, energyBar.update)

    loadUserData()
    pet.animations.setCurrent(pet.state)
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
    love.graphics.translate(-500, 0)
    love.graphics.draw( background.image, background.quads)

    -- Desenhando o pet
    love.graphics.translate(500, 0)
    love.graphics.setColor(255,0,0, 255)
    pet.displayStatus()
    love.graphics.setColor(100,180,50,255)
    love.graphics.translate(0, 200)
    pet.animations.display()
    love.graphics.translate(0, -200)
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

function Game.mousemoved( x, y, dx, dy, istouch )
    if x >= 600 and x <= 700 and y >= 250 and y <= 350 then
        -- print("moved", x, y)
    end
end

return Game