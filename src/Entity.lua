Entity = Class{}

function Entity:init(def)
    -- initialize position, dimensions, direction facing, walk speed
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.direction = def.direction
    self.speed = def.speed

    -- flag to see if entity is walking
    self.walking = false

    -- used for vampires only
    self.suck = false
    self.stunned = false
end

function Entity:update(dt)
    self.stateMachine:update(dt)
end

function Entity:changeState(newState)
    self.stateMachine:change(newState)
end

function Entity:collides(target)
    return not (self.x + self.width < target.x
            or self.x > target.x + target.width
            or self.y + self.height < target.y
            or self.y > target.y + target.height)
end

function Entity:render()
    self.stateMachine:render()
end