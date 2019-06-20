
local Pet = require("Pet")
local suit = require("SUIT")
local Utils = require("Utils")
local Interface = require ("Interface")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")


file = "Imagens/background.png"
background = love.graphics.newImage(file)
width, heigth = background:getWidth(), background:getHeight()

backgroundQuad = love.graphics.newQuad(
    0, 0, width, heigth,
    background:getDimensions()
)

function love.load()
    pet = Pet.New()
    pet.animations = ManagerAnimations.New()
        .setScale(3)
        .toMiddle()
        .loadAnimations("/Sprites/Togepi/")
    
    love.window.setMode(width, heigth, {resizable = true})
    canvas = love.graphics.newCanvas(width, heigth)
    interface = Interface.New()
end

function love.update(time)
    pet.update(time)
    interface.loadButtons()
end

function love.draw()
    love.graphics.draw(canvas, width, heigth)
    love.graphics.draw(background, backgroundQuad)
    -- for i = 0, love.graphics.getWidth() / background:getWidth() do
    --     for j = 0, love.graphics.getHeight() / background:getHeight() do
    --         love.graphics.draw(
    --             background, i*background:getWidth(), j*background:getHeight()
    --         )
    --     end
    -- end
    pet.displayStatus()
    pet.animations.display()
    
    interface.draw()
end