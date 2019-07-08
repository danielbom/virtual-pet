

HungryBar = {}
HungryBar.__index = HungryBar


function HungryBar.New()
    local self = {
        animations = nil
    }
        
    function self.update(object, pet)
        --[[
            100: [100-95]
            83 : [ 95-80]
            50 : [ 80-60]
            33 : [ 60-35]
            15 : [ 35-15]
            0  : [ 15-0 ]
        --]]
        if pet.hungry >= 90 then
            self.animations.setNext("100")
        elseif pet.hungry >= 80 then
            self.animations.setNext("83")
        elseif pet.hungry >= 60 then
            self.animations.setNext("50")
        elseif pet.hungry >= 35 then
            self.animations.setNext("33")
        elseif pet.hungry >= 15 then
            self.animations.setNext("16")
        else 
            self.animations.setNext("0")
        end
    end

    return self
end

return HungryBar