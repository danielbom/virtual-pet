

EnergyBar = {}
EnergyBar.__index = EnergyBar


function EnergyBar.New()
    local self = {
        animations = nil
    }
        
    function self.update(object, pet)
        --[[
            Complete: [100-95]
            Full    : [ 95-80]
            Semifull: [ 80-60]
            Middle  : [ 60-35]
            Semilow : [ 35-15]
            Low     : [ 15-5 ]
            Empty   : [  5-0 ]
        --]]
        if pet.energy >= 90 then
            self.animations.setNext("Complete")
        elseif pet.energy >= 80 then
            self.animations.setNext("Full")
        elseif pet.energy >= 60 then
            self.animations.setNext("Semifull")
        elseif pet.energy >= 35 then
            self.animations.setNext("Middle")
        elseif pet.energy >= 15 then
            self.animations.setNext("Semilow")
        elseif pet.energy >= 5 then
            self.animations.setNext("Low")
        else
            self.animations.setNext("Empty")
        end
    end

    return self
end

return EnergyBar