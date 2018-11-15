local DisplayManager = class('DisplayManager')
local TickersDisplay = require 'TickersDisplay'
local SaveDisplay = require 'SaveDisplay'

local tickersDisplay
local saveDisplay
local currentDisplay

function DisplayManager:initialize()
    tickersDisplay = TickersDisplay(self)
    saveDisplay = SaveDisplay(self)
    self.currentDisplay = tickersDisplay
end

function DisplayManager:showSave(summary)
    self.currentDisplay = saveDisplay
    saveDisplay:show(summary)
end

function DisplayManager:showTickers()
    self.currentDisplay = tickersDisplay
end

function DisplayManager:draw()
    self.currentDisplay:draw()
end

function DisplayManager:keypressed(key)
    self.currentDisplay:keypressed(key)
end

function DisplayManager:textinput(text)
    self.currentDisplay:textinput(text)
end

return DisplayManager
