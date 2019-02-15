local VisualTicker = require 'VisualTicker'
local VisualList = require 'VisualList'
local VisualTickerList = class('VisualTickerList', VisualList)

function VisualTickerList:initialize(tickers)
    VisualList.initialize(self, tickers)
end

function VisualTickerList:incrementSelected()
    self.items[self.selectedItem]:increment()
end

function VisualTickerList:decrementSelected()
    self.items[self.selectedItem]:decrement()
end

function VisualTickerList:clearSelected()
    self.items[self.selectedItem]:clear()
end

function VisualTickerList:textinput(text)
    self.items[self.selectedItem]:textinput(text)
end

function VisualTickerList:backspace()
    self.items[self.selectedItem]:backspace()
end

function VisualTickerList:addTicker()
    self.items[#self.items + 1] = VisualTicker()
end

return VisualTickerList
