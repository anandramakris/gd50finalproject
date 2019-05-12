PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player{
        x = 0,
        y = 0,
        width = 16,
        height = 16,
        direction = 'down',
        speed = 45
    }

    self.player.stateMachine = StateMachine{
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['walk'] = function() return PlayerWalkState(self.player) end,
    }
    self.player:changeState('idle')
end

function PlayState:enter(params)
    self.hospital = Hospital(self.player, params.level)
end

function PlayState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end

    self.hospital:update(dt)
end

function PlayState:render()
    self.hospital:render()
end