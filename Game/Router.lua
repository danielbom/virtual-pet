Controller = {}
Controller.__index = Controller


function Controller.New()
    local self = {}

    function self.add(name, obj)
        self[name] = obj
        return self
    end

    function self.setState(name)
        self[name].load()
        love.update = self[name].update
        love.draw = self[name].draw
        return self
    end

    return self
end

return Controller