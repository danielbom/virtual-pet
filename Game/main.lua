Router = require("Router")
local Game = require("Game")
local Menu = require("Menu")

function love.load()
    Router
        .add("Menu", Menu)
        .add("Game", Game)
        .setState("Menu")
end