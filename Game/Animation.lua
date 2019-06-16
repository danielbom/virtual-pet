
local Utils = require("Utils")
Animation = {}
Animation.__index = Animation

function Animation.New()
    local self = {
        -- Conntrol sprite list from directory
        spritesList = {},

        -- Control sprite sheet
        spriteSheet = nil,
        quads = {},
        width = 0,
        height = 0,

        -- Control display
        x = 0, y = 0,
        rotation = 0,
        scale = 1,

        -- Mode: dir or file
        mode = "",

        -- Sprint time
        duration = 1,
        currentTime = 0,
    }

    function self._loadFromDirectory(dirname, n)
        for i = 1, n do
            local image = love.graphics.newImage(dirname..i..'.png')
            self.width = image:getWidth()
            self.height = image:getHeight()
            local quad = love.graphics.newQuad(
                0, 0, self.width, self.height,
                image:getDimensions()
            )
            table.insert(self.quads, quad)
            table.insert(self.spritesList, image)
            print('Load file: '..dirname..i..'.png')
        end

        self.mode = "dir"
    end
    function self.initFromDirectory(dirname, numberOfSprites, duration)
        self._loadFromDirectory(dirname, numberOfSprites)
        self.duration = duration
        return self
    end 

    function self._loadFromFiles(filename)
        local image = love.graphics.newImage(filename)
        self.spriteSheet = image
        
        for y = 0, image:getHeight() - height, height do
            for x = 0, image:getWidth() - width, width do
                local quad = love.graphics.newQuad(
                    x, y, width, height,
                    image:getDimensions()
                )
                table.insert(self.quads, quad)
            end
        end

        self.mode = "file"
    end
    function self.initFromFile(filename, width, height, duration)
        self._loadFromFiles(filename)        
        self.duration = duration
        self.height = height
        self.width = width
        return self
    end

    function self.display()
        local shift = self.currentTime / self.duration * #self.quads
        local sprite = (math.floor(shift) % #self.spritesList) + 1
        if self.mode == 'file' then
            love.graphics.draw(
                self.spriteSheet,
                self.quads[sprite],
                self.x, self.y,
                self.rotation,
                self.scale
            )
        elseif self.mode == 'dir' then
            print(sprite)
            love.graphics.draw(
                self.spritesList[sprite],
                self.quads[sprite],
                self.x, self.y,
                self.rotation,
                self.scale
            )
        end
    end

    function self.update(time)
        self.currentTime = self.currentTime + time
    end

    function self.xToMiddle()
        self.x = Utils.middleX(self.width * self.scale)
        return self
    end

    function self.yToMiddle()
        self.y = Utils.middleY(self.height * self.scale)
        return self
    end

    function self.setScale(scale)
        self.scale = scale
        return self
    end

    return self
end


return Animation