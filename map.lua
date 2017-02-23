--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 19.02.2017
-- Time: 17:27
-- To change this template use File | Settings | File Templates.
--

P={}
map = P

P.size = 10

if snake then
    P.appleradius = snake.cellsize/2
else
    P.appleradius = 10
end
local m = {}

for i=0, P.size-1 do
    m[i]={}
    for j=0, P.size-1 do
        m[i][j]=0
    end
end

function P.checkplace(x, y)
    return m[x][y] == 0
end

local apple

function P.placeapple()
    local x, y
    if apple == nil then
        repeat
        x = math.random(P.size)-1
        y = math.random(P.size)-1
        until P.checkplace(x,y)
        m[x][y] = 2
        apple = {x = x, y = y}
    end
end

P.placeapple(5)

function P.checkapplecollision()
    if snake.collide(apple.x, apple.y) then
        m[apple.x][apple.y] = 0
        apple = nil
        snake.grow()
    end
end

function P.setvalue(x, y, v)
    m[x][y] = v
end

function P.clean()
    for i=0, P.size-1 do
        for j=0, P.size-1 do
            if m[i][j] == 1 then m[i][j]=0 end
        end
    end
end

function P.placesnake(snake)
    for i=snake.head, snake.tail do
        local x = snake[i].x
        local y = snake[i].y
        if x < 0 then x = P.size - 1 - (math.abs(x)-1)%P.size end
        if x > P.size-1 then x = x%(P.size) end
        if y < 0 then y = P.size - 1 - (math.abs(y)-1)%P.size end
        if y > P.size-1 then y = y%(P.size) end
        m[x][y] = 1
        snake[i].x = x
        snake[i].y = y
    end
end

function P.getvalue(x,y)
    return m[x][y]
end

return map