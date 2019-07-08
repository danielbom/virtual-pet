

Background = {}
Background.__index = Background


function Background.New()
    local self = {
        animations = nil
    }
    
    function self.update(object, pet)
        if pet.state == "Dead" then
            self.animations.setCurrent("Dead")
        elseif pet.state == "Sleeping" then
            self.animations.setCurrent("Sleep")
        else
            self.animations.setCurrent("Live")
        end
    end

    return self
end

return Background