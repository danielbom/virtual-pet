--[[

health      [0:100]
energy      [0:100]
hungry      [0:100]
growth      [0:100]
smart       [0:100]
happiness   [0:100]
thirsty     [0:100]
emotions 
[
    happy,  -> happiness
    sad,    -> happiness
    normal, -> happiness
    sleepy, -> energy
    angry   -> energy and happiness
    sick    -> health
]
weight   [1:7]
dirty    [boolean]

--]]
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")

Pet = {}
Pet.__index = Pet

function Pet.New()
    local self = {
        health = 100,
        energy = 100,
        hungry = 100,
        growth = 0,
        smart = 50,
        happiness = 50,
        thirsty = 100,
        emotion = "normal",
        weight = 1,
        dirty = false,
        -- Controll
        last_update = os.time(),
        animationDir = "/Sprites/Togepi/"
    }

    function self.init(...)
        local kargs = {...}
        for key, value in pairs(kargs) do
            self[key] = value
        end
        return self
    end

    function self.update(time)
        -- TODO: ...
    end

    function self.loadAnimations(directory)
        local scalePet = 3
        self.animations = ManagerAnimations.New()
        -- for i in string.gmatch(a, "%w*") do print(#i) end
        for line in love.filesystem.lines(directory..'descriptor.txt') do
            local desc = {}
            for word in string.gmatch(line, "[^%s]+") do
                table.insert(desc, word)
            end
            if #desc == 3 then
                self.animations.addAnimation(
                    desc[1], Animation.New().initFromDirectory(
                        directory..desc[1]..'/',
                        tonumber(desc[2]),
                        tonumber(desc[3])
                    ).setScale(scalePet).toMiddle()
                )
                self.animations.setCurrentAnimation(desc[1])
            end
        end
    end

    self.loadAnimations(self.animationDir)

    return self
end


return Pet