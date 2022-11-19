objectplatform = {}

objectplatform_mt = { __index = objectplatform }

function objectplatform:new(name, tex, x, y, w, h, u, v, nFrames, ang, rad)
    local entity = {}
    setmetatable(entity, objectplatform_mt)
    
    entity.name = name
    entity.texture = tex
    entity.posx = x
    entity.posy = y
    entity.width = w
    entity.height = h
    entity.velx = 0
    entity.vely = 0
    entity.angle = ang
    entity.radius = rad
    entity.alpha = 0
    entity.frames = {}
    entity.currentRow = 0
    entity.currentFrame = 1
    entity.numFrames = nFrames
    entity.thrust = 0
    entity.destroy = false

    return entity
end

function objectplatform:update(dt)
end

function objectplatform:draw()
    love.graphics.draw(self.texture, self.posx,self.posy)
end