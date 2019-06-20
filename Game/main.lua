
local Pet = require("Pet")
local suit = require("SUIT")
local Utils = require("Utils")
local Interface = require ("Interface")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")

file = "Imagens/background.png"
background = love.graphics.newImage(file)
width, heigth = background:getWidth()-200, background:getHeight() - 1

function love.load()

    pet = Pet.New()
    love.window.setMode(width, heigth, {resizable = true})
    canvas = love.graphics.newCanvas(width, heigth)
    interface = Interface.New()
    
    --background = Utils.loadBG(file)
    --canvas = Utils.setCanvas()
end

function love.draw()
    love.graphics.draw(canvas, width, heigth)
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i*background:getWidth(), j*background:getHeight())
        end
    end
    pet.animations.display()
    
    interface.draw()
end
function love.update(time)
    pet.animations.update(time)
    interface.loadButtons(width,heigth)
end