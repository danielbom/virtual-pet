
Musics = {}
Musics.__index = Musics

Musics.musics = {}
Musics.current = ""


function Musics.add(key, pathname, mode, ...)
    -- mode: [stream|static]
    local kargs = {...}
    local loop = kargs.loop
    local volume = kargs.volume
    
    local music = love.audio.newSource(pathname, mode)
    music:setLooping(loop == nil and true or loop)
    music:setVolume(volume == nil and 0.5 or volume)
    Musics.musics[key] = music
    return Musics
end

function Musics.setCurrent(key)
    Musics.current = key
    Musics.stopAll()
    love.audio.play(Musics.musics[key])
    return Musics
end

function Musics.stopAll()
    for key, value in pairs(Musics.musics) do
        love.audio.stop(Musics.musics[key])
    end
    return Musics
end


return Musics