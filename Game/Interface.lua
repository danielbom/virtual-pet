local suit = require("SUIT")
Interface = {}
Interface._index = Interface

function Interface.New()
    local self = {}

    function self.drawStatus(isDraw)
        if isDraw == true then
            status = love.graphics.newQuad(0, 70, 100, 100, 0)
            love.graphics.draw(pet.displayStatus(), status)
        end
    end

    function self.loadButtons(width, heigth)
        width = width - 50
        heigth = heigth - 25
        show_message = false
        suit.theme.color.normal = {bg = {0, 0, 255}, fg = {255, 0, 0}}
        suit.theme.color.hovered = {bg = {0, 255, 0}, fg = {0, 0, 255}}
        suit.theme.color.active = {bg = {0, 0, 0}, fg = {0, 255, 0}}
        if suit.Button("Status", 0, (heigth / 4) - 70, 70, 70).hit then
            self.drawStatus(true)
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
        return suit.draw()
    end

    return self
end

return Interface
