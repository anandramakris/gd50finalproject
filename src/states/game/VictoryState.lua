VictoryState = Class{__includes = BaseState}

function VictoryState:init()

end

function VictoryState:enter(params)

end

function VictoryState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end

    if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] then
        gStateMachine:change('start')
    end
end

function VictoryState:render()
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('You Won', 0, 20, 258, 'center')
    love.graphics.printf('Press Enter to play again', 0, 100, 258, 'center')
    love.graphics.printf('Press Esc to quit', 0, 120, 258, 'center')
end