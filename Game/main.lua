
local Pet = require("Pet")
local Utils = require("Utils")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")

file = "Imagens/background.png"
background = love.graphics.newImage(file)
width, heigth = background:getWidth(), background:getHeight() - 1

function love.load()
    -- Ajustando a janela (tamanho, titulo e fixa)
    love.window.setMode(600, 600, {resizable=false, vsync=true}) 
    -- Cor de fundo: branco
    -- love.graphics.setBackgroundColor(255,255,255)
    pet = Pet.New()
    love.window.setMode(width, heigth, {resizable = true})
    canvas = love.graphics.newCanvas(width, heigth)

    --background = Utils.loadBG(file)
    --canvas = Utils.setCanvas()
end

function love.draw()
    love.graphics.clear()
    
    love.graphics.draw(canvas, width, heigth)
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i*background:getWidth(), j*background:getHeight())
        end
    end
    
    pet.animations.display()
end
function love.update(time)
    pet.update(time)
end