
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
        local counterl = {{}, {}, {}}
        local counterc = {{}, {}, {}}
        local w = nil
        for i = 1, 3 do
            for j = 1, 3 do
                if matrix[i][j] then
                    local c = counterc[i][matrix[i][j]]
                    counterc[i][matrix[i][j]] = c ~= nil and c + 1 or 1
                    if w == nil and counterc[i][matrix[i][j]] == 3 then
                        w = matrix[i][j]
                    end
                end
                if matrix[j][i] then
                    local c = counterl[i][matrix[j][i]]
                    counterl[i][matrix[j][i]] = c ~= nil and c + 1 or 1
                    if w == nil and counterl[i][matrix[j][i]] == 3 then
                        w = matrix[j][i]
                    end
                end
            end
        end
        if w ~= nil then return w end
        if matrix[1][1] == matrix[2][2] and matrix[2][2] == matrix[3][3] then
            return matrix[1][1]
        elseif matrix[1][3] == matrix[2][2] and matrix[2][2] == matrix[3][1] then
            return matrix[1][3]
        end
        return nil
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

    local x = 650
    local y = 320
    local dy = 100
    local again = suit.Button("Jogar novamente", x, y, 80, 70)
    local exit = suit.Button("Sair", x, y + dy, 80, 70)

    if again.hit then
        matrix = createMatrix()
        current = winner ~= nil and winner.next or O
        winner = nil
    elseif exit.hit then
        Router.setState("Game")
    end
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
    suit.draw()
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