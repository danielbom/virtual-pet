
local Pet = require("Pet")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")

function love.load()
    -- Ajustando a janela (tamanho, titulo e fixa)
    love.window.setMode(600, 600, {resizable=false, vsync=true}) 
    -- Cor de fundo: branco
    -- love.graphics.setBackgroundColor(255,255,255)
    pet = Pet.New()
end

function love.draw()
    pet.displayStatus()
    pet.animations.display()
end

function love.update(time)
    pet.update(time)
end