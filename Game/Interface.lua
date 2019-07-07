local suit = require("SUIT")
Interface = {}
Interface._index = Interface
width = 0
heigth = 0
status = nil

function Interface.New()
    local self = {}

    function self.loadButtons()
        
        suit.theme.color.normal = {bg = {255, 255, 225}, fg = {0, 0, 0}}
        suit.theme.color.hovered = {bg = {255, 255, 225}, fg = {0, 0, 255}}
        suit.theme.color.active = {bg = {255, 255, 225}, fg = {0, 255, 0}}
        
        suit.Button("Comer", 0, ((heigth / 4) * 2) - 70, 70, 70)
        suit.Button("Beber", 0, ((heigth / 4) * 3) - 70, 70, 70)
        suit.Button("Estudar", 0, ((heigth / 4) * 4) - 70, 70, 70)
        suit.Button("Curar", width - 20, ((heigth / 4) * 3) - 70, 70, 70)
        suit.Button("Dormir", width - 20, ((heigth / 4) * 4) - 70, 70, 70)

    end

    function self.draw()
        suit.draw()
    end

    return self
end

return Interface
