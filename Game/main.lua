
local Pet = require("Pet")
local suit = require("SUIT")
local Utils = require("Utils")
local Interface = require ("Interface")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")


file = "Imagens/background.png"
background = love.graphics.newImage(file)
width, height = background:getWidth(), background:getHeight()

backgroundQuad = love.graphics.newQuad(
    0, 0, width, height,
    background:getDimensions()
)

function love.load()
    pet = Pet.New()
    pet.animations = ManagerAnimations.New()
        .setScale(3)
        .toMiddle()
        .loadAnimations("/Sprites/Togepi/")
    
    love.window.setMode(width, height, {resizable = true})
    canvas = love.graphics.newCanvas(width, height)
    interface = Interface.New()
end

function love.update(time)
    pet.update(time)
    interface.loadButtons(width, height)
end

function love.draw()
    love.graphics.draw(canvas, width, height)
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