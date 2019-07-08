-- Bibliotecas sem dependências
suit = require("SUIT")
Json = require("Json")

-- Variáveis globais
user = ""

-- Musicas
musics = {
    main = love.audio.newSource("/Sounds/Ballerina.mp3", "stream"),
    menu = love.audio.newSource("/Sounds/Jigsaw_Puzzle.mp3", "stream")
}
musics.main:setLooping(true)
musics.main:setVolume(0.5)
musics.menu:setLooping(true)
musics.menu:setVolume(0.5)

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
Router = require("Router")
Game = require("Game")
Menu = require("Menu")


function love.load()
    -- Definindo o titulo
    love.window.setTitle("Virtual Pet")

    -- Definindo as telas do jogo
    Router
        .add("Menu", Menu)
        .add("Game", Game)
        .setState("Game")
end