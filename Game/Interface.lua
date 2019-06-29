local suit = require("SUIT")
Interface = {}
Interface._index = Interface
width = 0
heigth = 0

function Interface.New()
    local self = {}

    function self.loadButtons(width1, heigth1)
        width = width1 - 50
        heigth = heigth1 - 25
        
        suit.theme.color.normal = {bg = {0, 0, 255}, fg = {255, 0, 0}}
        suit.theme.color.hovered = {bg = {0, 255, 0}, fg = {0, 0, 255}}
        suit.theme.color.active = {bg = {0, 0, 0}, fg = {0, 255, 0}}
        
        if suit.Button("Status", 0, (heigth / 4) - 70, 70, 70).hit then
            status = pet.sendData()
            if isPressed then
                isPressed = false
            else 
                isPressed = true
            end
        end

        if suit.Button("Comer", 0, ((heigth / 4) * 2) - 70, 70, 70).hit then
            show_message = true
        end
        if suit.Button("Beber", 0, ((heigth / 4) * 3) - 70, 70, 70).hit then
            show_message = true
        end
        if suit.Button("Estudar", 0, ((heigth / 4) * 4) - 70, 70, 70).hit then
            show_message = true
        end
        suit.Button("Brincar", width - 20, ((heigth / 4) * 1) - 70, 70, 70)
        suit.Button("Carinho", width - 20, ((heigth / 4) * 2) - 70, 70, 70)
        suit.Button("Remédio", width - 20, ((heigth / 4) * 3) - 70, 70, 70)
        suit.Button("Luz", width - 20, ((heigth / 4) * 4) - 70, 70, 70)

        if show_message then
            suit.Label("How are you today?", 50, 0, 300, 30)
        end
    end
    function self.draw()
        if isPressed then
            love.graphics.setColor(0, 0, 1)
            love.graphics.rectangle("fill", 70, (heigth / 4) - 70, 210, 210)
            love.graphics.setColor(1, 0, 0)
            love.graphics.print(status.health, 70, (heigth / 4) - 70)
            love.graphics.setColor(100,180,50)
        end
        return suit.draw()
    end

    return self
end

return Interface
