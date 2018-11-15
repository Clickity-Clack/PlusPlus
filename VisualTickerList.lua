local VisualTicker = require 'VisualTicker'
local VisualTickerList = class('VisualTickerList')

function VisualTickerList:initialize()
    self.selectedTicker = 1
    self.tickers = { VisualTicker() }
    self.tickerHeight = self.tickers[self.selectedTicker].height
    self.bufferHeight = self.tickerHeight/3
end

function VisualTickerList:drawCentered(x, y)
    love.graphics.setColor(0.4, 0.4, 0.4)
    local relativeToSelected
    for i in pairs(self.tickers) do
        relativeToSelected = i - self.selectedTicker
        if i == self.selectedTicker then
            love.graphics.setColor(1, 1, 1)
            self.tickers[i]:drawCentered(x, y - self.tickerHeight/2 + relativeToSelected*(self.bufferHeight + self.tickerHeight))
            love.graphics.setColor(0.4, 0.4, 0.4)
        else
            self.tickers[i]:drawCentered(x, y - self.tickerHeight/2 + relativeToSelected*(self.bufferHeight + self.tickerHeight))
        end
    end
end

function VisualTickerList:getHeight()
    return #self.tickers * (selectedTicker:getHeight() + bufferHeight) + bufferHeight
end

function VisualTickerList:incrementSelected()
    self.tickers[self.selectedTicker]:increment()
end

function VisualTickerList:decrementSelected()
    self.tickers[self.selectedTicker]:decrement()
end

function VisualTickerList:clearSelected()
    self.tickers[self.selectedTicker]:clear()
end

function VisualTickerList:textinput(text)
    self.tickers[self.selectedTicker]:textinput(text)
end

function VisualTickerList:backspace()
    self.tickers[self.selectedTicker]:backspace()
end

function VisualTickerList:addTicker()
    self.tickers[#self.tickers + 1] = VisualTicker()
end

function VisualTickerList:selectNext()
    if self.selectedTicker == #self.tickers then
        self.selectedTicker = 1
    else
        self.selectedTicker = self.selectedTicker + 1
    end
end

function VisualTickerList:selectPrevious()
    if self.selectedTicker == 1 then
        self.selectedTicker = #self.tickers
    else
        self.selectedTicker = self.selectedTicker - 1
    end
end

function VisualTickerList:getSummary()
    local summary = {}
    for i in pairs(self.tickers) do
        table.insert(summary, self.tickers[i]:getSummary())
    end
    return summary
end

return VisualTickerList
