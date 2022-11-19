require("objectplayer")
require("objectplatform")

stategame = {}

function stategame:load()
end

function stategame:reset()
    lives = 3
    score = 0
    h = 200
    dy = 0

    entities = {}

    --create the player
    local player = objectplayer:new("player", doodle, 100,  100, 80, 80,
    0, 0, 1, 0, 0)
    table.insert(entities, player)

    --create 10 random platforms
    for i=0, 10 do
        local platform = objectplatform:new("platform", platform, math.random(0,400), math.random(0,533),
        68, 14, 0,0,1,0,0)
        table.insert(entities, platform)
    end
end

function stategame:keypressed(key)
    if key == 'space' and not entities[1].isDying then
        
    end
end

function stategame:keyreleased(key)
end

function isCollide(a,b)
    if a.posx < b.posx + b.width and
        a.posx + a.width > b.posx and
        a.posy < b.posy + b.height and
        a.posy + a.height > b.posy then
            return true
        end

    return false
end

function isCollideRadius(a,b)
	return (b.posx - a.posx)*(b.posx - a.posx) +
		(b.posy - a.posy)*(b.posy - a.posy) <
		(a.radius + b.radius)*(a.radius + b.radius)
end

function stategame:update(dt)
    for i,v in ipairs(entities) do
        v:update(dt)
    end

    dy = dy + 0.3 * dt--gravity
    entities[1].posy = entities[1].posy + dy

    if entities[1].posy > 500 then
        lives = lives - 1
        entities[1].posx = 100
        entities[1].posy = 100
        dy = 0
        if lives == 0 then
            state = "GAMEOVER"
            table.insert(hiscores, score)
            writeHiScores()
        end
    end

    if entities[1].posy < h then
        score = score + h - entities[1].posy
        for i=1, #entities do
            if entities[i].name == "platform" then
                entities[1].posy = h
                entities[i].posy = entities[i].posy - dy --move down the platforms.
                --if the platform reach the floor, create a new one.
                if entities[i].posy > 533 then
                    entities[i].posy=0
                    entities[i].posx = math.random(0,400)
                end
            end
        end
    end

    --if the doodle is over a platform then jump.
    for i=1, #entities do
        if entities[i].name == "platform" then
            if (( entities[1].posx + 50 ) > entities[i].posx ) and ( (entities[1].posx + 20) < entities[i].posx + 68)
        and ( (entities[1].posy + 70) > entities[i].posy) and ( (entities[1].posy + 70) < entities[i].posy + 14) and (dy>0) then
                jump:play()
                dy = - 350 * dt
            end
        end
    end
end

function stategame:draw()
    love.graphics.setColor(1,1,1)
    for i,v in ipairs(entities) do
        v:draw()
    end

    --draw UI
    love.graphics.setColor(1,0,0)
    love.graphics.print("LIVES: " .. lives .. "   SCORE: " .. score, 5, 10)
end