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
    sleep,  -> energy
    angry   -> energy and happy
    sick    -> health
]
weight   [1:7]
dirty    [boolean]

--]]
local Utils = require("Utils")
local Animation = require("Animation")
local ManagerAnimations = require("ManagerAnimations")
local suit = require("SUIT")

Pet = {}
Pet.__index = Pet

function Pet.New()
    local self = {
        --Status VPET
        happy   = 50,
        growth  = 0,    -- Ok
        health  = 100,  -- Ok
        energy  = 100,  -- Ok
        hungry  = 100,  -- Ok
        thirsty = 100,  -- Ok
        smart   = 0,    -- Ok
        
        weight  = 1,
        state  = "Idle",
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
        animations = nil
    }

    function self.reset()
        self.happy   = 50
        self.growth  = 0
        self.health  = 100
        self.energy  = 100
        self.hungry  = 100
        self.thirsty = 100
        self.smart   = 0
        self.state   = "Born"
        self.weight  = 1
        self.dirty   = false 
    end

    function self.heal()
        self.negate("health")
        if self.state ~= "Denying" then 
            self.health = 100
        end
        return self
    end

    function self.drink()
        self.negate("thirsty")
        if self.state ~= "Denying" then 
            self.thirsty = 100
        end
        return self
    end

    function self.eat()
        self.negate("hungry")
        if self.state ~= "Denying" then 
            self.hungry = 100
        end
        return self
    end

    function self.study()
        self.state = "Studying"
    end

    function self.sleep()
        self.state = "Sleeping"
    end
    
    function self.negate(attr)
        if self[attr] > 90 then
            self.state = "Denying"
        end
        return self
    end

    function self.init(kargs)
        for key, value in pairs(kargs) do
            self[key] = value
        end
        return self
    end

    function self.spendAttr(attr, speed)
        self[attr] = self[attr] > 0 and self[attr] - (self.rate[attr] * speed) or self[attr]
    end

    function self.updateAttr()
        local study = self.state ~= "Studying" and 0.3 or -0.3
        self.spendAttr("growth" ,-0.3)
        self.spendAttr("happy"  , 0.3)
        self.spendAttr("health" , 0.3)
        self.spendAttr("energy" , 0.3)
        self.spendAttr("hungry" , 0.3)
        self.spendAttr("thirsty", 0.3)
        self.spendAttr("smart", study)
        
    end
    
    function self.updateState()
        if self.health < 25 then
            self.state = "Sick"
        elseif self.health <= 0 then 
            self.state = "Dead"
        elseif self.health > 99 and self.happy > 99 then
            self.state = "Love"
        elseif self.state == "Denying" then 
            pet.animations.setCurrent("Denying")
        elseif self.state:match("Studying") then
            pet.animations.setCurrent("Studying")
        else
            self.state = "Idle"
        end
    end

    function self.updateAnimation()
        self.animations.setNext(self.state)
        if self.state:match("Denying|Love|Born") then
            self.state = "Idle"
        end
    end

    function self.update(time)
        self.updateAttr()
        self.updateState()
        self.updateAnimation()
        self.animations.update(time)
    end

    function self.sendData()
        data = {
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
        return data
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