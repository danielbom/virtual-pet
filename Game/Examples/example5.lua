function love.load()
    --Imagens do Mini-Game
    game_base = love.graphics.newImage("MiniGame/game_base.png")
    game_paper = love.graphics.newImage("MiniGame/game_paper.png")
    game_rock = love.graphics.newImage("MiniGame/game_rock.png")
    game_scissors = love.graphics.newImage("MiniGame/game_scissors.png")

    --fonte
    fonteName = love.graphics.newFont("Fonte/Roboto-Medium.ttf", 32)

    name = {{0,0,0}, "PIKACHU"}
    deadText = {{0,0,0}, "RESET"} 
    math.randomseed(os.time())
    
    --Carregando imagens do mouse
    normalCursor =  love.mouse.newCursor(love.image.newImageData("Imagens/normalCursor.png"), 1, 1)
    appleCursor =  love.mouse.newCursor(love.image.newImageData("Imagens/appleCursor.png"), 27, 31)
    spongeCursor =  love.mouse.newCursor(love.image.newImageData("Imagens/spongeCursor.png"), 27, 31)
    love.mouse.setCursor(normalCursor)
    mouseStatus = "normal"
end

function love.draw()
    love.mouse.setCursor(normalCursor)
    love.graphics.printf({{0,0,0},"Infelizmente seu Pikachu morreu!"}, 70, 50, 516, "center")
end

function love.mousepressed(mx, my, button)
    --COMIDA
    if button == 1 and my >= 552 and my < 552 + 100 and  mx >= 21 and mx < 21 + 100 and isSleep == false then
        if mouseStatus ~= "eat" then
            UI = UIHungry;
            love.mouse.setCursor(appleCursor)
            mouseStatus = "eat"
        else
            UI = UINormal;
            mouseStatus = "normal"
            love.mouse.setCursor(normalCursor)
        end
    --CURAR
    elseif button == 1 and my >= 552 and my < 552 + 100 and  mx >= 297 and mx < 297 + 100 and isSleep == false then
        love.audio.pause(mainMusic)
        love.audio.play(healAudio)
        love.audio.play(mainMusic)
        mouseStatus = "heal"
        love.mouse.setCursor(normalCursor)
        UI = UIHealth;
        if isSick then
            isSick = false
            healthPercentFloat = 100
        else
            healthPercentFloat = healthPercentFloat - 10
        end

    -- JOGAR
    local randomNumber = math.random(1,3)
end
