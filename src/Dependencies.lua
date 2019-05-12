Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Container'
require 'src/Entity'
require 'src/HealthBar'
require 'src/Hospital'
require 'src/Patient'
require 'src/Player'
require 'src/StateMachine'
require 'src/Vampire'
require 'src/Wall'

require 'src/states/BaseState'

require 'src/states/game/GameOverState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/VictoryState'

require 'src/states/player/PlayerIdleState'
require 'src/states/player/PlayerWalkState'

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

gTextures = {
    ['tile'] = love.graphics.newImage('graphics/tile.png'),
    ['container'] = love.graphics.newImage('graphics/container.png'),
    ['wall'] = love.graphics.newImage('graphics/wall.png'),
    ['player-idle-up'] = love.graphics.newImage('graphics/player-idle-up.png'),
    ['player-idle-down'] = love.graphics.newImage('graphics/player-idle-down.png'),
    ['player-idle-left'] = love.graphics.newImage('graphics/player-idle-left.png'),
    ['player-idle-right'] = love.graphics.newImage('graphics/player-idle-right.png'),
    ['player-walk-up'] = love.graphics.newImage('graphics/player-idle-up.png'),
    ['player-walk-down'] = love.graphics.newImage('graphics/player-idle-down.png'),
    ['player-walk-left'] = love.graphics.newImage('graphics/player-walk-left.png'),
    ['player-walk-right'] = love.graphics.newImage('graphics/player-walk-right.png'),
    ['patient-up'] = love.graphics.newImage('graphics/patient-up.png'),
    ['patient-down'] = love.graphics.newImage('graphics/patient-down.png'),
    ['patient-left'] = love.graphics.newImage('graphics/patient-left.png'),
    ['patient-right'] = love.graphics.newImage('graphics/patient-right.png'),
    ['vampire-up'] = love.graphics.newImage('graphics/vampire-up.png'),
    ['vampire-down'] = love.graphics.newImage('graphics/vampire-down.png')
}