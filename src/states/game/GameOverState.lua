GameOverState = Class{__includes = BaseState}

function GameOverState:init()

end

function GameOverState:enter(params)

end

function GameOverState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end

    if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] then
        gStateMachine:change('start')
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Game Over', 0, 20, 256, 'center')
    love.graphics.printf('Press Enter to play again', 0, 100, 256, 'center')
    love.graphics.printf('Press Esc to quit', 0, 120, 256, 'center')
end