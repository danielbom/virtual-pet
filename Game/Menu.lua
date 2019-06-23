
Game = {}
Game.__index = Game

function Game.load()
end

function Game.update(time)
end

function Game.draw()
end



function Game.mousereleased( x, y, button, isTouch )
    print("release", x, y)
    Router.setState("Game")
end

function Game.mousemoved( x, y, dx, dy, istouch )
    print("moved", x, y)
end

return Game
