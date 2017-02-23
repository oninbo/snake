--
-- Created by IntelliJ IDEA.
-- User: Lena Lebedeva
-- Date: 19.02.2017
-- Time: 16:54
-- To change this template use File | Settings | File Templates.
--

local right = 1
local left = 2
local up = 3
local down = 4

local P = {}
snake = P

P.head = 0
P.tail = -1

local timer = 0
P.speed = 4.5
P.direction = 1
P.cellsize = 32

local function puthead(v)
    local i = P.head - 1
    P.head = i
    P[i] = v
end

local function removehead()
    local i = P.head
    P[i] = nil
    P.head = i+1
end

local function puttail(v)
    local i = P.tail + 1
    P.tail = i
    P[i] = v
end

local function removetail()
    local i = P.tail
    P[i] = nil
    P.tail = i-1
end

function P.create()
    P.direction = 1
    for i=P.head, P.tail do
        removetail()
    end
    puthead({x = 0,y = 0})
    puthead({x = 1,y = 0})
    puthead({x = 2,y = 0})
end

P.create()

local function timertick(dt)
    timer = timer + dt
    if timer >= 1/P.speed then
        timer = 0
        return true
    else return false end
end

function P.size()
    return math.abs(P.head - P.tail)+1
end

function P.move(dt)
    P.setDirection()
    if timertick(dt) then
        P.grow()
        removetail()
    end
end

function P.collide(x,y)
    return
        (P.direction == right and P[P.head].x+1 == x and P[P.head].y == y) or
        (P.direction == left and P[P.head].x-1 == x and P[P.head].y == y) or
        (P.direction == down and P[P.head].y+1 == y and P[P.head].x == x) or
        (P.direction == up and P[P.head].y-1 == y and P[P.head].x == x)
end

function P.checkdeath()
    for i=P.head, P.tail do
        local x = P[i].x
        local y = P[i].y
        if P.collide(x,y) then
            return true
        end
    end
    return false
end

function P.grow()
    if P.direction == right then puthead({x = P[P.head].x+1, y = P[P.head].y}) --right
    elseif P.direction == left then puthead({x = P[P.head].x-1, y = P[P.head].y}) -- left
    elseif P.direction == up then puthead({x = P[P.head].x, y = P[P.head].y-1}) -- up
    elseif P.direction == down then puthead({x = P[P.head].x, y = P[P.head].y+1}) -- down
    end
end

function P.setDirection()
    if love.keyboard.isDown("down") and P.direction ~= 3 then snake.direction = down
    elseif love.keyboard.isDown("up") and P.direction ~= 4 then snake.direction = up
    elseif love.keyboard.isDown("left") and P.direction ~= 1 then snake.direction = left
    elseif love.keyboard.isDown("right") and P.direction ~= 2 then snake.direction = right
    end
end

function P.eat()
    love.audio.play( eatsounds[math.random(3)] )
    P.grow()
end

return snake