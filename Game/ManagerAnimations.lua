
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


    function self.loadAnimations(directory)
        self.animationDir = directory
        -- for i in string.gmatch(a, "%w*") do print(#i) end
        for line in love.filesystem.lines(directory..'descriptor.txt') do
            local desc = {}
            for word in string.gmatch(line, "[^%s]+") do
                table.insert(desc, word)
            end
            if #desc == 3 then
                self.animation = Animation
                    .New().initFromDirectory(
                        directory..desc[1]..'/',
                        tonumber(desc[2]),
                        tonumber(desc[3])
                    )
                self.animation.x = self.x
                self.animation.y = self.y
                self.animation.scale = self.scale
                self.animation.rotation = self.rotation
                if self.xmiddle then 
                    self.animation.xToMiddle()
                end
                if self.ymiddle then
                    self.animation.yToMiddle()
                end
                self.animations[desc[1]] = self.animation
                self.animation = desc[1]
            end
        end
        return self
    end

    function self.setX(x)
        self.x = x
        return self
    end

    function self.setY(y)
        self.y = y
        return self
    end

    function self.setScale(scale)
        self.scale = scale
        return self
    end

    function self.setRotation(rotation)
        self.rotate = rotate
        return self
    end

    function self.xToMiddle()
        self.xmiddle = true
        return self
    end

    function self.yToMiddle()
        self.ymiddle = true
        return self
    end

    function self.toMiddle()
        return self.xToMiddle().yToMiddle()
    end


    return self
end


return ManagerAnimation