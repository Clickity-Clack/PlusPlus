local Ticker = require 'Ticker'
local VisualTicker = class('VisualTicker', Ticker)

function VisualTicker:initialize(aCount, aLabel)
    Ticker.initialize(self)
    self.countText = love.graphics.newText(love.graphics.getFont(), self.count)
    self.labelText = love.graphics.newText(love.graphics.getFont(), self.label)
    self.labelIsWider = self.labelText:getWidth() > self.countText:getWidth()
    self.width = self.labelIsWider and self.labelText:getWidth() or self.countText:getWidth()
    self.height = self.labelText:getHeight() * 2.5
end

function VisualTicker:drawCentered(x, y)
    love.graphics.draw(self.countText, x - self.countText:getWidth()/2, y)
    love.graphics.draw(self.labelText, x - self.labelText:getWidth()/2, y + self.labelText:getHeight() * 1.5)
end

function VisualTicker:increment()
    Ticker.increment(self)
    self.countText:set(self.count)
    checkWider(self)
end

function VisualTicker:decrement()
    Ticker.decrement(self)
    self.countText:set(self.count)
    checkWider(self)
end

function VisualTicker:clear()
    Ticker.clear(self)
    self.countText:set(self.count)
    checkWider(self)
end

function VisualTicker:backspace()
    Ticker.backspace(self)
    self.labelText:set(self.label)
    checkWider(self)
end

function VisualTicker:textinput(text)
    Ticker.textinput(self, text)
    self.labelText:set(self.label)
    checkWider(self)
end

function checkWider(self)
    local startWider = self.labelIsWider
    self.labelIsWider = self.labelText:getWidth() > self.countText:getWidth()
    if self.labelIsWider ~= startWider then
        self.width = self.labelIsWider and self.labelText:getWidth() or self.countText:getWidth()
    end
end

return VisualTicker
