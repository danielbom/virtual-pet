local suit = require("SUIT")
Interface = {}
Interface._index = Interface

function Interface.New()
    local self = {}
    
    function self.loadButtons(width,heigth)
        width = width - 50
        heigth = heigth - 25
        show_message = false
        suit.theme.color.normal = {bg = {0,0,255}, fg = {255,0,0}}
        suit.theme.color.hovered = {bg = {0, 255, 0}, fg = {0, 0, 255}}
        suit.theme.color.active = {bg = {0,0,0}, fg = {0, 255, 0}}
        suit.Button("Teste", 0, (heigth/6) - 70, 50, 70)

        if suit.Button("jorge", 0, ((heigth/6)*2) - 70, 50, 70).hit then
            show_message = true
        end
        if suit.Button("Teste", 0, ((heigth/6)*3) - 70, 50, 70).hit then
            show_message = true
        end
        if suit.Button("Teste", 0, ((heigth/6)*4) - 70, 50, 70).hit then
            show_message = true
        end
        if suit.Button("Teste", 0, ((heigth/6)*5) - 70, 50, 70).hit then
            show_message = true
        end
        if suit.Button("Teste", 0, ((heigth/6)*6) - 70, 50, 70).hit then
            show_message = true
        end
        suit.Button("Teste", width, ((heigth/6)*1) - 70, 50, 70)
        suit.Button("Teste", width, ((heigth/6)*2) - 70, 50, 70)
        suit.Button("Teste", width, ((heigth/6)*3) - 70, 50, 70)
        suit.Button("Teste", width, ((heigth/6)*4) - 70, 50, 70)
        suit.Button("Teste", width, ((heigth/6)*5) - 70, 50, 70)
        suit.Button("Teste", width, ((heigth/6)*6) - 70, 50, 70)

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