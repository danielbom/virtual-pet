
local Pet = require("Pet")
local Utils = require("Utils")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")

function love.load()
    local scalePet = 3
    managerAnimations = ManagerAnimations.New().init({
        denying = Animation.New().initFromDirectory(
            'Sprites/Pet/Denying/', 2, 1
        ).setScale(scalePet).toMiddle(),
        idle = Animation.New().initFromDirectory(
            'Sprites/Pet/Idle/', 2, 1
        ).setScale(scalePet).toMiddle(),
        love = Animation.New().initFromDirectory(
            'Sprites/Pet/Love/', 5, 1.5
        ).setScale(scalePet).toMiddle(),
        sick = Animation.New().initFromDirectory(
            'Sprites/Pet/Sick/', 2, 1
        ).setScale(scalePet).toMiddle(),
        sleeping = Animation.New().initFromDirectory(
            'Sprites/Pet/Sleeping/', 5, 1
        ).setScale(scalePet).toMiddle(),
        studying = Animation.New().initFromDirectory(
            'Sprites/Pet/Studying/', 9, 2
        ).setScale(scalePet).toMiddle(),
        born = Animation.New().initFromDirectory(
            'Sprites/Pet/Born/', 31, 4
        ).setScale(scalePet).toMiddle()
    }).setCurrentAnimation("born")
end

function love.draw()
    managerAnimations.display()
end

function love.update(time)
    managerAnimations.update(time)
end