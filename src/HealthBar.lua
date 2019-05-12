HealthBar = Class{}

function HealthBar:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.value = def.value
    self.max = def.max
end

function HealthBar:update(dt)

end

function HealthBar:updateValue(health)
    self.value = health
end

function HealthBar:render()
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.rectangle('fill', self.x, self.y, (self.value*self.width)/self.max, self.height)
end