
local Pet = require("Pet")
local suit = require("SUIT")
local Utils = require("Utils")
local EnergyBar = require("EnergyBar")
local Animation = require("Animation")
local Interface = require ("Interface")
local Observable = require("Observable")
local ManagerAnimations = require("ManagerAnimations")

t = 0
d = 30
user = "Daniel"

function love.load()
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

function love.update(time)
    print(t)
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

function love.draw()
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