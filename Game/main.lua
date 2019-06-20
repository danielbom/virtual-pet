
local Pet = require("Pet")
local Utils = require("Utils")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")

function love.load()
    -- Ajustando a janela (tamanho, titulo e fixa)
    love.window.setMode(600, 600, {resizable=false, vsync=true}) 
    -- Cor de fundo: branco
    -- love.graphics.setBackgroundColor(255,255,255)
    pet = Pet.New()
    pet.animations = ManagerAnimations.New()
        .setScale(3)
        .toMiddle()
        .loadAnimations("/Sprites/Togepi/")
end

function love.update(time)
    pet.update(time)
end

function love.draw()
    pet.displayStatus()
    pet.animations.display()
end