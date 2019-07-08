function loadImage(pathname, ...)
    local kargs = {...}
    local x = kargs[1] or 0
    local y = kargs[2] or 0
    local image = love.graphics.newImage(pathname)
    local width = image:getWidth()
    local height = image:getHeight()
    return {
        image = image,
        quad = love.graphics.newQuad(
            x, y, width, height, image:getDimensions()
        )
    }
end

function middleX(imageX)
    return (love.graphics.getWidth() / 2) - (imageX / 2)
end

function middleY(imageY)
    return (love.graphics.getHeight() / 2) - (imageY / 2)
end

function randomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end

return {
    middleX = middleX,
    middleY = middleY,
    randomFloat = randomFloat,
    loadImage = loadImage
}