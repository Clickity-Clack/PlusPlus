local VisualList = class('VisualList')

function VisualList:initialize(items)
    self.selectedItem = 1
    self.items = items
    self.itemHeight = self.items[self.selectedItem].height
    self.bufferHeight = self.itemHeight/3
end

function VisualList:drawCentered(x, y)
    love.graphics.setColor(0.4, 0.4, 0.4)
    local relativeToSelected
    for i in pairs(self.items) do
        relativeToSelected = i - self.selectedItem
        if i == self.selectedItem then
            love.graphics.setColor(1, 1, 1)
            self.items[i]:drawCentered(x, y - self.itemHeight/2 + relativeToSelected*(self.bufferHeight + self.itemHeight))
            love.graphics.setColor(0.4, 0.4, 0.4)
        else
            self.items[i]:drawCentered(x, y - self.itemHeight/2 + relativeToSelected*(self.bufferHeight + self.itemHeight))
        end
    end
end

function VisualList:selectNext()
    if self.selectedItem == #self.items then
        self.selectedItem = 1
    else
        self.selectedItem = self.selectedItem + 1
    end
end

function VisualList:selectPrevious()
    if self.selectedItem == 1 then
        self.selectedItem = #self.items
    else
        self.selectedItem = self.selectedItem - 1
    end
end

function VisualList:getSummary()
    local summary = {}
    for i in pairs(self.items) do
        table.insert(summary, self.items[i]:getSummary())
    end
    return summary
end

return VisualList
