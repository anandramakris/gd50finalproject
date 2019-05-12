StartState = Class{__includes = BaseState}

function StartState:init()

end

function StartState:enter(params)

end

function StartState:update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end

    if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] then
        gStateMachine:change('play',{
            level = 1
        })
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Push the Patient!', 0, 20, 256, 'center')
    love.graphics.printf('GD50 Final Project', 0, 60, 256, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter to continue', 0, 100, 256, 'center')
    love.graphics.printf('Press Esc to quit', 0, 120, 256, 'center')
    love.graphics.printf('Press Space to pump blood and keep off the vampires', 0, 140, 256, 'center')
end