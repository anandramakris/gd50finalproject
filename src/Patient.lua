Patient = Class{}

function Patient:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.direction = def.direction
    self.health = def.health
end

function Patient:update(dt)
    
end

function Patient:collides(target)
    return not (self.x + self.width < target.x
            or self.x > target.x + target.width
            or self.y + self.height < target.y
            or self.y > target.y + target.height)
end

function Patient:render()
    love.graphics.draw(gTextures['patient-' .. self.direction], self.x, self.y)
end