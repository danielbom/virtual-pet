-- Bibliotecas sem dependências
suit = require("SUIT")
Json = require("Json")

-- Variáveis globais
user = ""

-- Janela
canvas = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),
}
love.window.setMode(canvas.width, canvas.height)
canvas.format = love.graphics.newCanvas(canvas.width, canvas.height)

-- Cores globais dos botões
suit.theme.color.normal = {
    bg = {255, 255, 225}, 
    fg = {0, 0, 0}}
suit.theme.color.hovered = {
    bg = {255, 255, 225}, 
    fg = {0, 0, 255}}
suit.theme.color.active = {
    bg ={255, 255, 225}, 
    fg = {0, 255, 0}}

-- Bibliotecas com dependências de variáveis globais
Musics = require("ManagerMusics")
Router = require("Router")
Game = require("Game")
Menu = require("Menu")

function love.load()
    -- Definindo o titulo
    love.window.setTitle("Virtual Pet")

    -- Adicionando as musicas
    musics = Musics.New()
        .add("Main", "/Sounds/Ballerina.mp3", "stream")
        .add("Menu", "/Sounds/Jigsaw_Puzzle.mp3", "stream")
        .add("Sleep", "/Sounds/Sleeping_Sheep.mp3", "stream")

    -- Definindo as telas do jogo
    Router
        .add("Menu", Menu)
        .add("Game", Game)
        .setState("Game")
end