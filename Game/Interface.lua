local suit = require("SUIT")
Interface = {}
Interface._index = Interface
width = 0
heigth = 0
status = nil

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

    end

    function self.displayStatus()
        love.graphics.printf(
            "happy: "..math.floor(status.happy), 70, (heigth / 7), 135, "center"
        )
        love.graphics.printf(
            "growth: "..math.floor(status.growth),  70, (heigth / 7) + 20, 135, "center"
        )
        love.graphics.printf(
            "health: "..math.floor(status.health),  70, (heigth / 7) + 40, 135, "center"
        )
        love.graphics.printf(
            "energy: "..math.floor(status.energy), 70, (heigth / 7) + 60, 135, "center"
        )
        love.graphics.printf(
            "hungry: "..math.floor(status.hungry), 70, (heigth / 7) + 80, 135, "center"
        )
        love.graphics.printf(
            "thirsty: "..math.floor(status.thirsty), 70, (heigth / 7) + 100, 135, "center"
        )
        love.graphics.printf(
            "smart: "..math.floor(status.smart), 70, (heigth / 7) + 120, 135, "center"
        )
    end

    function self.draw()
        if isPressed then
            love.graphics.setColor(0, 0, 1)
            love.graphics.rectangle("fill", 70, (heigth / 4) - 70, 210, 210)
            love.graphics.setColor(1, 0, 0)
            self.displayStatus()
            love.graphics.setColor(100,180,50)
        end
        return suit.draw()
    end

    return self
end

return Interface
