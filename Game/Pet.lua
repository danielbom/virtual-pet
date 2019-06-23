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
        rate = {
            happy   = 5/100,
            growth  = 1/100,
            health  = 6/100,
            energy  = 5/100,
            hungry  = 3/100,
            smart   = 1/100,
            thirsty = 2/100,
        },

        last_update = os.time(),
    }

    function self.init(kargs)
        for key, value in pairs(kargs) do
            self[key] = value
        end
        return self
    end

    function self.spendAttr(attr, speed)
        self[attr] = self[attr] - (self.rate[attr] * speed)
    end

    function self.updateAttr()
        self.spendAttr("growth" ,-0.3)
        self.spendAttr("happy"  , 0.3)
        self.spendAttr("health" , 0.3)
        self.spendAttr("energy" , 0.3)
        self.spendAttr("hungry" , 0.3)
        self.spendAttr("thirsty", 0.3)
    end
    
    function self.updateState()
        if self.health < 35 then
            self.state = "Sick"
        elseif self.health > 99 and self.happy > 99 then
            self.state = "Love"
        else
            self.state = "Idle"
        end
    end

    function self.updateAnimation()
        if self.state == "Idle" then
            self.animations.setNext("Idle")
        elseif self.state == "Love" then
            self.animations.setNext("Love")
        elseif self.state == "Sick" then
            self.animations.setNext("Sick")
        elseif self.state == "Studying" then
            self.animations.setNext("Studying")
        elseif self.state == "Denying" then
            self.animations.setNext("Denying")
            self.state = "Idle"
        end
    end

    function self.update(time)
        self.updateAttr()
        self.updateState()
        self.updateAnimation()
        self.animations.update(time)
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

    function self.save(user)
        local data = {
            animation = self.animations.animationDir,
            happy   = self.happy,
            growth  = self.growth,
            health  = self.health,
            energy  = self.energy,
            hungry  = self.hungry,
            thirsty = self.thirsty,
            smart   = self.smart,
            weight  = self.weight,
            state   = self.state,
            dirty   = self.dirty,
        }
        local filename = user.."Data.json"
        local string = Json.stringify(data)
        local file = io.open(filename,"w")
        file:write(string)
        file:close()
    end

    function self.load(user)
        local filename = user.."Data.json"
        local file = io.open(filename,"r")
        local string = file:read()
        local object = Json.parse(string)
        self.init(object)
    end

    return self
end


return Pet