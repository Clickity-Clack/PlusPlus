local PromptDisplay = class('PromptDisplay')

function PromptDisplay:initialize(question, responses)
    self.questionText = love.graphics.newText(love.graphics.getFont(), question)
end

function PromptDisplay:draw()

end

function PromptDisplay:update()

end

function PromptDisplay:Prompt()
    
end

return PromptDisplay
