

HungryBar = {}
HungryBar.__index = HungryBar


function HungryBar.New()
    local self = {
        animations = nil
    }
        
    function self.update(object, pet)
        --[[
            100: [100-90]
            83 : [ 90-75]
            50 : [ 75-50]
            33 : [ 50-30]
            15 : [ 30-5]
            0  : [ 5-0 ]
        --]]
        if pet.hungry >= 90 then
            self.animations.setNext("100")
        elseif pet.hungry >= 75 then
            self.animations.setNext("83")
        elseif pet.hungry >= 50 then
            self.animations.setNext("50")
        elseif pet.hungry >= 30 then
            self.animations.setNext("33")
        elseif pet.hungry >= 5 then
            self.animations.setNext("16")
        else 
            self.animations.setNext("0")
        end
    end

    return self
end

return HungryBar