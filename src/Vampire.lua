Vampire = Class{__includes = Entity}

function Vampire:init(def)
    Entity.init(self, def)
end

function Vampire:update(dt)
    Entity.update(self, dt)
end

function Vampire:render()
    love.graphics.draw(gTextures['vampire-' .. self.direction], self.x, self.y)
end