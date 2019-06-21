
ManagerAnimation = {}
ManagerAnimation.__index = ManagerAnimation

function ManagerAnimation.New()
    local self = {
        animations = {},
        animation = nil,
        next = nil,

        x = 0, y = 0,
        scale = 1,
        rotation = 0
    }


    function self.addAnimation(name, animation)
        self.animations[name] = animation
        self.animation = name
        return self
    end

    function self.setNext(animation) 
        self.next = animation
        return self
    end

    function self.setCurrent(name)
        self.animation = name
        return self
    end

    function self.display()
        local animation = self.animations[self.animation]
        if self.next and animation.hasFinished() then
            self.animation = self.next
            self.next = nil
        end
        animation.display()
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
                self.animation = Animation.New()
                    .initFromDirectory(
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
                self.addAnimation(desc[1], self.animation)
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