--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 19.02.2017
-- Time: 16:40
-- To change this template use File | Settings | File Templates.
--

function love.load()
    love.window.setTitle("Snake Game")
    require "snake"
    require "map"
    love.window.setMode((snake.cellsize)*map.size, (snake.cellsize)*map.size, {resizable=false, vsync=false})
    math.randomseed(os.time())
    applesprite = love.graphics.newImage("apple.png")
    snakesprite = love.graphics.newImage("blockEmerald.png")
    background = love.graphics.newImage("sand.png")
    applesprite:setFilter("nearest","nearest")
    snakesprite:setFilter("nearest","nearest")
    background:setFilter("nearest","nearest")
    spritescale = snake.cellsize/applesprite:getWidth()
end

function love.update(dt)
    if love.keyboard.isDown( "escape" ) then love.event.quit( ) end
    if snake.checkdeath() then
        local buttons = {"Exit", "Retry"}
        local buttonpressed = love.window.showMessageBox("Game over", "You lose :'(\n Press", buttons, "info")
        if buttonpressed == 1 then love.event.quit( )
        elseif buttonpressed == 2 then snake.create() end
    end
    snake.move(dt)
    map.clean()
    map.placesnake(snake)
    map.placeapple()
    map.checkapplecollision()
    --snake.setDirection()
end

function love.draw()
    for i=0, map.size-1 do
        for j=0, map.size-1 do
            love.graphics.draw(background, i*(snake.cellsize), j*(snake.cellsize), 0, spritescale)
            if map.getvalue(i,j) == 1 then
                love.graphics.draw(snakesprite, i*(snake.cellsize), j*(snake.cellsize), 0, spritescale)
            elseif map.getvalue(i,j) == 2 then
                love.graphics.draw(applesprite, i*(snake.cellsize), j*(snake.cellsize), 0, spritescale)
            end
        end
    end
end