local VisualTicker = require 'VisualTicker'
local VisualTickerList = class('VisualTickerList')

function VisualTickerList:initialize()
    self.selectedTicker = VisualTicker()
    self.tickers = { self.selectedTicker }
    self.tickerHeight = self.selectedTicker.height
    self.bufferHeight = self.tickerHeight/3
end

function VisualTickerList:drawCentered(x, y)
    for i in pairs(self.tickers) do
        if self.tickers[i] == self.selectedTicker then
            love.graphics.setColor(1, 1, 1)
            self.tickers[i]:drawCentered(x, y + self.tickerHeight * (i - 1) + self.bufferHeight * i)
            love.graphics.setColor(0.4, 0.4, 0.4)
        else
            self.tickers[i]:drawCentered(x, y + self.tickerHeight * (i - 1) + self.bufferHeight * i)
        end
    end
end

function VisualTickerList:getHeight()
    return #self.tickers * (selectedTicker:getHeight() + bufferHeight) + bufferHeight
end

function VisualTickerList:incrementSelected()
    self.selectedTicker:increment()
end

function VisualTickerList:decrementSelected()
    self.selectedTicker:decrement()
end

function VisualTickerList:clearSelected()
    self.selectedTicker:clear()
end

function VisualTickerList:textinput(text)
    self.selectedTicker:textinput(text)
end

function VisualTickerList:backspace()
    self.selectedTicker:backspace()
end

function VisualTickerList:addTicker()
    
end

function VisualTickerList:getSummary()
    local summary = {}
    for i in pairs(self.tickers) do
        table.insert(summary, self.tickers[i]:getSummary())
    end
    return summary
end

return VisualTickerList
