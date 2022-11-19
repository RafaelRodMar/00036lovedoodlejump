statesplash = {}

function statesplash:load()
end

function statesplash:keypressed(key)
end

function statesplash:keyreleased(key)
    if key == "space" then
        state = "MENU"
        music01:play()
    end
end

function statesplash:update(dt)
end

function statesplash:draw()
    love.graphics.draw(splash, 0, 0)
end