
local Pet = require("Pet")
local Utils = require("Utils")
local Animation = require("Animation")


function love.load()
    animations = {
        born = Animation.New().initFromDirectory(
            'Sprites/Born/', 31, 4
        ).setScale(10).xToMiddle().yToMiddle()
    }
    animation = "born"
end

function love.draw()
    animations[animation].display()
end

function love.update(time)
    animations[animation].update(time)
end