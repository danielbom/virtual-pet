
local Pet = require("Pet")
local suit = require("SUIT")
local Utils = require("Utils")
local Interface = require ("Interface")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")


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

    pet = Pet.New()
    pet.animations = ManagerAnimations.New()
        .setScale(3)
        .toMiddle()
        .loadAnimations("/Sprites/Togepi/")
end

function love.update(time)
    -- Atualizando o pet
    pet.update(time)

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

    -- Desenhando os componentes de interface
    interface.draw()
end