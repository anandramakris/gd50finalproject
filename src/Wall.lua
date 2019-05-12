Wall = Class{}

function Wall:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
end

function Wall:update(dt)

end

function Wall:render()
    love.graphics.draw(gTextures['wall'], self.x, self.y)
end