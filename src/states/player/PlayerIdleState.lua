PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player
    self.player.walking = false
end

function PlayerIdleState:enter(params)
    
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.player:changeState('walk')
    end
end

function PlayerIdleState:render()
    love.graphics.draw(gTextures['player-idle-' .. self.player.direction], self.player.x, self.player.y)
end