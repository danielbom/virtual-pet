local Game = require("Game")
local Controller = require("Controller")

function love.load()
    Controller.New()
        .add("Game", Game)
        .setState("Game")
end