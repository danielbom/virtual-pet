local suit = require("SUIT")
Interface = {}
Interface._index = Interface

function Interface.New()
    local self = {}
    
    function self.loadButtons()
        show_message = false
        if suit.Button("Teste", 0, 0, 50, 70).hit then
            show_message = true
        end
        if show_message then
            suit.Label("How are you today?", 50, 0, 300,30)
        end
    end
    
    function self.draw()
        return suit.draw()
    end

    return self 
end

return Interface