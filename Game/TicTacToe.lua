
local Utils = require("Utils")

TicTacToe = {}
TicTacToe.__index = TicTacToe

function createMatrix()
    -- Matrix do jogo
    local matrix = {{nil, nil, nil},
                    {nil, nil, nil},
                    {nil, nil, nil}}
    
    matrix.filled = 0
    function matrix.set(x, y, value)
        matrix[x][y] = value
        matrix.filled = matrix.filled + 1
    end
    
    function matrix.check()
        local counter = {{}, {}, {}}
        local d1 = matrix[1][1]
        local d2 = matrix[2][2]
        local winner = nil
        for i = 1, 3 do
            for j = 1, 3 do
                if matrix[i][j] then
                    local c = counter[i][matrix[i][j]]
                    counter[i][matrix[i][j]] = c ~= nil and c + 1 or 1
                    if winner == nil and counter[i][matrix[i][j]] == 3 then
                        winner = matrix[i][j]
                    end
                end
            end
            d1 = matrix[i][i] == d1 and d1 or nil
            d2 = matrix[i][4-i] == d2 and d2 or nil
        end
        return winner or d1 or d2 or nil
    end

    function matrix.full()
        return matrix.filled == 9
    end

    return matrix
end

function TicTacToe.load()
    Musics.setCurrent("TicTacToe")
    love.graphics.setBackgroundColor(1,1,1,1)

    -- Carregando a imagem do jogo
    game = Utils.loadImage("Imagens/TicTacToe.png")
    -- Carregando o X
    X = Utils.loadImage("Imagens/X.png")
    -- Carregando o O
    O = Utils.loadImage("Imagens/O.png")
    
    -- Encadeando os objetos para fazer a troca de jogadores
    X.next = O
    O.next = X
    current = X
    winner = nil
    
    -- Posições para posicionar as sprites O e X
    x = {25, 226, 425}
    y = {25, 230, 420}
    matrix = createMatrix()
end

function TicTacToe.update(time)
    winner = matrix.check()
    print((winner == O and "O") or (winner == X and "X") or "NO")
end

function TicTacToe.draw()
    love.graphics.draw(game.image, game.quad)
    for i = 1, 3 do
        for j = 1, 3 do
            if matrix[i][j] then
                love.graphics.draw(
                    matrix[i][j].image,
                    matrix[i][j].quad,
                    x[i], y[j], 0, 0.25
                )
            end
        end
    end
end


function TicTacToe.mousepressed( xx, yy, button, isTouch )
    if winner == nil and not matrix.full() then
        local d = 150
        local xk = 0
        local yk = 0
        for i = 1, 3 do
            if x[i] < xx and x[i] + d > xx then
                xk = i
            end
            if y[i] < yy and y[i] + d > yy then
                yk = i
            end
        end
        if xk ~= 0 and yk ~= 0 and not matrix[xk][yk] then
            matrix.set(xk, yk, current)
            current = current.next
        end
    end
end

function TicTacToe.mousereleased( x, y, button, isTouch )
    -- print("release", x, y)
end

return TicTacToe