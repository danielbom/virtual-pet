

SmartBar = {}
SmartBar.__index = SmartBar


function SmartBar.New()
    local self = {
        animations = nil
    }
        
    function self.update(object, pet)
        --[[
            Expert       : [100-99]
            Hard         : [ 99-75]
            Intermediate : [ 75-45]
            Novice       : [ 45-15]
            Noob         : [ 15-0]
        --]]
        if pet.smart >= 99 then
            self.animations.setNext("Expert")
        elseif pet.smart >= 75 then
            self.animations.setNext("Hard")
        elseif pet.smart >= 45 then
            self.animations.setNext("Intermediate")
        elseif pet.smart >= 15 then
            self.animations.setNext("Novice")
        else 
            self.animations.setNext("Noob")
        end
    end

    return self
end

return SmartBar