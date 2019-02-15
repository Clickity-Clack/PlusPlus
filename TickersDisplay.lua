local TickersDisplay = class('TickersDisplay')
local VisualTickerList = require 'VisualTickerList'
local VisualTicker = require 'VisualTicker'
winWidth = love.graphics.getWidth()
winHeight = love.graphics.getHeight()

function TickersDisplay:initialize(aManager)
    self.manager = aManager
    self.input = false
    self.tickerList = VisualTickerList({VisualTicker()})
end

function TickersDisplay:draw()
    self.tickerList:drawCentered(winWidth/2, winHeight/2)
end

function TickersDisplay:keypressed(key)
    if self.input then 
        if key == 'backspace' then self.tickerList:backspace() end
        if key == 'return' then self.input = false end
    elseif key == 'kp+' or key == '+' or key == '.' then self.tickerList:incrementSelected()
    elseif key == 'kp-' or key == '-' or key == ',' then self.tickerList:decrementSelected()
    elseif key == 'escape' then self.tickerList:clearSelected()
    elseif key == 'n' then self.tickerList:addTicker()
    elseif key == 'down' then self.tickerList:selectNext()
    elseif key == 'up' then self.tickerList:selectPrevious()
    elseif key == 'l' then self.input = true
    elseif key == 's' then self:save()
    elseif key == 'o' then self:open()
    elseif key == 'q' then love.event.quit() end
    lastKey = key
end

function TickersDisplay:textinput(text)
    if self.input then
        self.tickerList:textinput(text)
    end
end

function TickersDisplay:save()
    -- local out = json.encode(self.tickerList:getSummary())
    -- love.filesystem.write('saveFile.json', out)
    self.manager:showSave(self.tickerList:getSummary())
end

function TickersDisplay:open()
    print('this doesn\'t do anything yet')
end

return TickersDisplay
