
ManagerAnimation = {}
ManagerAnimation.__index = ManagerAnimation

function ManagerAnimation.New()
    local self = {
        animations = {},
        animation = nil
    }

    function self.init(animations)
        for key, value in pairs(animations) do
            self.addAnimation(key, value)
        end
        return self
    end

    function self.addAnimation(name, animation)
        self.animations[name] = animation
        self.animation = name
        return self
    end

    function self.setCurrentAnimation(name)
        self.animation = name
        return self
    end

    function self.display()
        self.animations[self.animation].display()
    end

    function self.update(time)
        self.animations[self.animation].update(time)
    end

    return self
end


return ManagerAnimation