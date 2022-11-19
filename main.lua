require("vector2D")
require("statesplash")
require("statemenu")
require("stategame")
require("stategameover")

function love.load()
    background = love.graphics.newImage("images/background.png")
    doodle = love.graphics.newImage("images/doodle.png")
    gameover = love.graphics.newImage("images/gameover.png")
    menu = love.graphics.newImage("images/menu.png")
    platform = love.graphics.newImage("images/platform.png")
    splash = love.graphics.newImage("images/splash.png")

    --load font
    font = love.graphics.newFont("sansation.ttf",25)
    love.graphics.setFont(font)

    --load sounds
    jump = love.audio.newSource("sound/smb_jump-small.wav","static")
    music01 = love.audio.newSource("sound/Circus_Marcus_-_04_-_Le_petit_menuet_de_Bach.ogg", "stream") 
    music02 = love.audio.newSource("sound/Hobotek_-_05_-_Back_to_Attack_Analogue_Action.ogg", "stream") 
    jump:setVolume(0.2)
    music01:setVolume(0.2)
    music02:setVolume(0.2)

    saveFile = "hiscores.txt"
    hiscores = {}

    gameWidth = 400
    gameHeight = 533

    love.window.setMode(gameWidth, gameHeight, {resizable=false, vsync=false})
    love.graphics.setBackgroundColor(1,1,1) --white

    info = love.filesystem.getInfo( saveFile, nil )
    if info == nil then
        --create file
        for i=5,1,-1 do
            data = string.format("%05d", i)
            success, errormsg = love.filesystem.append( saveFile, data, 5 )
            hiscores[i] = i
        end
    else
        --read file
        contents, size = love.filesystem.read( saveFile, info.size )
        hiscores[1] = tonumber(string.sub(contents,0,5))
        hiscores[2] = tonumber(string.sub(contents,6,10))
        hiscores[3] = tonumber(string.sub(contents,11,15))
        hiscores[4] = tonumber(string.sub(contents,16,20))
        hiscores[5] = tonumber(string.sub(contents,21,25))
    end

    statesplash:load()
    stategame:reset()
    state = "SPLASH"
end

function writeHiScores()
    table.sort(hiscores, function(a,b) return a > b end)

    --remove file
    love.filesystem.remove( saveFile )
    --write the 5 first elements
    for i=1,5 do
        data = string.format("%05d", hiscores[i])
        success, errormsg = love.filesystem.append( saveFile, data, 5 )
    end
end

function love.keypressed(key)
    if state == "SPLASH" then statesplash:keypressed(key) end
    if state == "MENU" then statemenu:keypressed(key) end
    if state == "GAME" then stategame:keypressed(key) end
    if state == "GAMEOVER" then stategameover:keypressed(key) end
end

function love.keyreleased(key)
    if state == "SPLASH" then statesplash:keyreleased(key) end
    if state == "MENU" then statemenu:keyreleased(key) end
    if state == "GAME" then stategame:keyreleased(key) end
    if state == "GAMEOVER" then stategameover:keyreleased(key) end
end

function love.update(dt)
    if state == "SPLASH" then statesplash:update(dt) end
    if state == "MENU" then statemenu:update(dt) end
    if state == "GAME" then stategame:update(dt) end
    if state == "GAMEOVER" then stategameover:update(dt) end
end

function love.draw()
    love.graphics.setBackgroundColor(1,1,1)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(background, 0, 0)

    --the states system
    if state == "SPLASH" then statesplash:draw() end
    if state == "MENU" then statemenu:draw() end
    if state == "GAME" then stategame.draw() end
    if state == "GAMEOVER" then stategameover:draw() end
end
