
function middleX(imageX)
    return (love.graphics.getWidth() / 2) - (imageX / 2)
end

function middleY(imageY)
    return (love.graphics.getHeight() / 2) - (imageY / 2)
end

function randomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end
function setCanvas()
    
    
end
function loadBG(file)
    print (file)

end
return {
    middleX = middleX,
    middleY = middleY,
    randomFloat = randomFloat,
    canvas = canvas,
    background = background
}