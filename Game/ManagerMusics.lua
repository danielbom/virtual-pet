
ManagerAnimation = {}
ManagerAnimation.__index = ManagerAnimation

function ManagerAnimation.New()
    local self = {
        musics = {}
    }

    function self.add(key, pathname, mode, ...)
        -- mode: [stream|static]
        local kargs = {...}
        local loop = kargs.loop
        local volume = kargs.volume
        
        local music = love.audio.newSource(pathname, mode)
        music:setLooping(loop == nil and true or loop)
        music:setVolume(volume == nil and 0.5 or volume)
        self.musics[key] = music
        return self
    end

    function self.setCurrent(key)
        self.stopAll()
        love.audio.play(self.musics[key])
        return self
    end

    function self.stopAll()
        for key, value in pairs(self.musics) do
            love.audio.stop(self.musics[key])
        end
        return self
    end

    return self
end


return ManagerAnimation