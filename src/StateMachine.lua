--[[
    This file is largely derivative of StateMachine.lua from GD50 Assignment 5 (Legend of Zelda)
    authored by Colton Ogden cogden@cs50.harvard.edu
]]

StateMachine = Class{}

function StateMachine:init(states)
    self.new = {
        enter = function() end,
        exit = function() end,
        update = function() end,
        render = function() end
    }
    self.states = states or {}
    self.currentState = self.new
end

function StateMachine:change(newState, params)
    assert(self.states[newState])
    self.currentState:exit()
    self.currentState = self.states[newState]()
    self.currentState:enter(params)
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end