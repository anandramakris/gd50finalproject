PlayerWalkState = Class{__includes = BaseState}

function PlayerWalkState:init(player)
    self.player = player
    self.player.walking = true
end

function PlayerWalkState:enter(params)
    
end

function PlayerWalkState:update(dt)
    -- update direction and position
    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.x = self.player.x - self.player.speed*dt
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + self.player.speed*dt
    elseif love.keyboard.isDown('up') then
        self.player.direction = 'up'
        self.player.y = self.player.y - self.player.speed*dt
    elseif love.keyboard.isDown('down') then
        self.player.direction = 'down'
        self.player.y = self.player.y + self.player.speed*dt
    else
        self.player:changeState('idle')
    end
end

function PlayerWalkState:render()
    love.graphics.draw(gTextures['player-walk-' .. self.player.direction], self.player.x, self.player.y)
end