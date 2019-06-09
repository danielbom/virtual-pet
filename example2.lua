
function f(a, b)
    return a or b
end

function f2(arg)
    return f(arg.a, arg.b)
end

function Args(...)
    local kargs = {...}
    for k,v in ipairs(kargs) do
        print(k, v)
    end
end

function love.load()
    animationSleep = newAnimation(love.graphics.newImage('Sprites/pikachu_dormindo.png'), 344, 344, 2)
    animationNormal = newAnimation(love.graphics.newImage('Sprites/pikachu_normal.png'), 344, 344, 1.5)
    animationBad = newAnimation(love.graphics.newImage('Sprites/pikachu_triste.png'), 344, 344, 2)
    animationSick = newAnimation(love.graphics.newImage('Sprites/pikachu_doente.png'), 344, 344, 2)
    animationTired = newAnimation(love.graphics.newImage('Sprites/pikachu_cansado.png'), 344, 344, 2)
    animationEgg = newAnimation(love.graphics.newImage('Sprites/Egg.png'), 344, 344, 1.5)
    animationVaccione = newAnimation(love.graphics.newImage('Sprites/Vaccine.png'), 344, 344, 2)

    animations = {
        animationSleep,
        animationNormal,
        animationBad,
        animationSick,
        animationTired,
        animationEgg,
        animationVaccione,
    }

    animation = animationSleep
    a = animations
    sprite = 1
    anim = 1

    a = {1,2,3,4,5,6}
    local i = 1
    print("While...")
    while a[i] do
        print(a[i])
        i = i + 1
    end

    print("For...")
    for key, value in ipairs(animations) do
        print(key, value)
    end

    local i = 1
    print("While...")
    while i < 10 do 
        print(i)
        i = i + 1
    end

    revDay = {
        Sunday = 2,
        ["Tuesday"] = 1
    }

    print "Dict..."
    for k in pairs(revDay) do
        print(k)
    end

    print [[ Heelllo
    Muuultline
    World]]

    var = f2{b=1, a=3}
    print(var)
    print("ARGS")
    Args(10, 100, 1000)

    print(revDay["Sunday"])
    print(revDay.Sunday)
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image
    animation.quads = {}

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end

function love.draw()
    if anim >= table.getn(animations) then
        anim = 1
    end
    if sprite >= table.getn(animation.quads) then
        sprite = 1
    end
    love.graphics.draw(animations[anim].spriteSheet, animations[anim].quads[sprite], middleX(344), middleY(344), 0, 1)
    sprite = sprite + 1
    -- anim = anim + 1
end

function middleX(imageX)
    return (love.graphics.getWidth() / 2) - (imageX / 2)
end

function middleY(imageY)
    return (love.graphics.getHeight() / 2) - (imageY / 2)
end
