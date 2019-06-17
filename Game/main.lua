
local Pet = require("Pet")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")

function love.load()
    pet = Pet.New()
end

function love.draw()
    pet.animations.display()
end

function love.update(time)
    pet.animations.update(time)
end