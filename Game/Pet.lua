--[[

health      [0:100]
energy      [0:100]
hungry      [0:100]
growth      [0:100]
smart       [0:100]
happy       [0:100]
thirsty     [0:100]
emotions 
[
    happy,  -> happy
    sad,    -> happy
    normal, -> happy
    sleepy, -> energy
    angry   -> energy and happy
    sick    -> health
]
weight   [1:7]
dirty    [boolean]

--]]
local Utils = require("Utils")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")

Pet = {}
Pet.__index = Pet

function Pet.New()
    local self = {
        --Status VPET
        happy   = 50,
        growth  = 0,
        health  = 100,
        energy  = 100,
        hungry  = 100,
        thirsty = 100,
        smart   = 50,
        
        weight  = 1,
        state  = "normal",
        dirty  = false,

        -- Controll
        happyRate   = 5/100,
        growthRate  = 1/100,
        healthRate  = 6/100,
        energyRate  = 5/100,
        hungryRate  = 3/100,
        smartRate   = 1/100,
        thirstyRate = 2/100,

        last_update = os.time(),
        animationDir = "/Sprites/Togepi/",

    }

    function self.init(...)
        local kargs = {...}
        for key, value in pairs(kargs) do
            self[key] = value
        end
        return self
    end

    function self.spendAttr(attr, speed)
        self[attr] = self[attr] - (self[attr.."Rate"] * speed)
    end

    function self.update(time)
        self.spendAttr("growth" ,-0.3)
        self.spendAttr("happy"  , 0.3)
        self.spendAttr("health" , 0.3)
        self.spendAttr("energy" , 0.3)
        self.spendAttr("hungry" , 0.3)
        self.spendAttr("thirsty", 0.3)
        pet.animations.update(time)
    end

    function self.displayStatus()
        local width = love.graphics.getWidth() / 2 - 66
        local base = 100
        love.graphics.printf(
            "happy: "..math.floor(self.happy), width, base, 135, "center"
        )
        love.graphics.printf(
            "growth: "..math.floor(self.growth), width, base + 20, 135, "center"
        )
        love.graphics.printf(
            "health: "..math.floor(self.health), width, base + 40, 135, "center"
        )
        love.graphics.printf(
            "energy: "..math.floor(self.energy), width, base + 60, 135, "center"
        )
        love.graphics.printf(
            "hungry: "..math.floor(self.hungry), width, base + 80, 135, "center"
        )
        love.graphics.printf(
            "thirsty: "..math.floor(self.thirsty), width, base + 100, 135, "center"
        )
        love.graphics.printf(
            "smart: "..math.floor(self.smart), width, base + 120, 135, "center"
        )
    end

    return self
end


return Pet