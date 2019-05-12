Container = Class{}

function Container:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
end

function Container:update(dt)

end

function Container:render()
    love.graphics.draw(gTextures['container'], self.x, self.y)
end