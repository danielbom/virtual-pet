user = ""

suit = require("SUIT")
Json = require("Json")

Router = require("Router")
Game = require("Game")
Menu = require("Menu")


function love.load()
    Router
        .add("Menu", Menu)
        .add("Game", Game)
        .setState("Menu")
end