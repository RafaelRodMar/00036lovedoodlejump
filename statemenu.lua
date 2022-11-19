statemenu = {}

function statemenu:load()
end

function statemenu:keypressed(key)
    if key == "space" then
        state = "GAME"
        love.audio.stop(music01)
        music02:play()
        stategame:reset()
    end
end

function statemenu:keyreleased(key)
end

function statemenu:update(dt)
end

function statemenu:draw()
    love.graphics.setColor(0,0,0)
    fw = font:getWidth("DOODLE JUMP")
    centerpos = gameWidth / 2 - fw / 2
    love.graphics.print("DOODLE JUMP", centerpos, 20)
    fw = font:getWidth("PRESS JUMP TO PLAY")
    centerpos = gameWidth / 2 - fw / 2
    love.graphics.print("PRESS JUMP TO PLAY", centerpos, 40)
    fw = font:getWidth("HI SCORE")
    centerpos = gameWidth / 2 - fw / 2
    love.graphics.print("HI SCORE", centerpos, 60)
    row = 80
    for i=1,5 do
        fw = font:getWidth(hiscores[i])
        centerpos = gameWidth / 2 - fw / 2
        love.graphics.print(hiscores[i],centerpos,row)
        row = row + 20
    end
    love.graphics.setColor(1,1,1)
end