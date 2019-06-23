Router = {}
Router.__index = Router


function Router.add(name, obj)
    Router[name] = obj
    return Router
end

function Router.setState(name)
    print("State: ", name)
    Router[name].load()
    love.update = Router[name].update
    love.draw = Router[name].draw
    love.mousepressed = Router[name].mousepressed
    love.mousereleased = Router[name].mousereleased
    love.mousemoved = Router[name].mousemoved
    return Router
end

return Router