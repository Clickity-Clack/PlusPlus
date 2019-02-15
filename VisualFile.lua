local VisualFile = class('VisualFile')

function VisualFile:Initialize(filename)    
    self.filenameText = love.graphics.newText(love.graphics.getFont(), filename)
    self.width = self.filenameText:getWidth()
    self.height = self.filenameText:getHeight()
end

function VisualTicker:drawCentered(x, y)
    love.graphics.draw(self.filenameText, x - self.filenameText:getWidth()/2, y)
end

return VisualFile
