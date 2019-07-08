

ThirstyBar = {}
ThirstyBar.__index = ThirstyBar


function ThirstyBar.New()
    local self = {
        animations = nil
    }
        
    function self.update(object, pet)
        --[[
            95 : [100-90]
            70 : [ 90-65]
            45 : [ 65-35]
            25 : [ 35-5]
            0  : [ 5-0]
        --]]
        if pet.thirsty >= 90 then
            self.animations.setNext("95")
        elseif pet.thirsty >= 65 then
            self.animations.setNext("70")
        elseif pet.thirsty >= 35 then
            self.animations.setNext("45")
        elseif pet.thirsty >= 5 then
            self.animations.setNext("25")
        else 
            self.animations.setNext("0")
        end
    end

    return self
end

return ThirstyBar