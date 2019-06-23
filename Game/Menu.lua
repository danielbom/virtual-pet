local suit = require("SUIT")

Game = {}
Game.__index = Game

function Game.load()
end

function Game.update(time)
    start = suit.Button("Start Game", 300, 300, 50, 70)
    load = suit.Button("Load Game", 400, 300, 50, 70)
    quit = suit.Button("Quit", 500, 300, 50, 70)
    if start.hit then
        print("Start!!!")
    elseif load.hit then
        print("Load!!!")
    elseif quit.hit then
        love.event.quit()
    end
end

function Game.draw()
    suit.draw()
end



function Game.mousereleased( x, y, button, isTouch )
    print("release", x, y)
end


return Game
