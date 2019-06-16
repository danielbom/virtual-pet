
local Pet = require("Pet")
local Utils = require("Utils")
local Animation = require("Animation")


function love.load()
    -- animationSleep = Animation.New().initFromFile(
    --     'Sprites/pikachu_dormindo.png',
    --     344, 344, 2
    -- ).setScale(1.5).xToMiddle().yToMiddle()

    born = Animation.New().initFromDirectory(
        'Sprites/Born/', 31, 4
    ).setScale(10).xToMiddle().yToMiddle()
    print(born)
end

function love.draw()
    -- animationSleep.display()
    born.display()
end

function love.update(time)
    born.update(time)
end