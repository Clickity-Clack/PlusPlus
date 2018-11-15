local utf8 = require "utf8"
local SaveDisplay = class('SaveDisplay')
local winWidth = love.graphics.getWidth()
local winHeight = love.graphics.getHeight()

function SaveDisplay:initialize(manager)
    self.manager = manager
    self.promptText = love.graphics.newText(love.graphics.getFont(),'Save as:')
    self.fileName = ''
    self.nameText = love.graphics.newText(love.graphics.getFont(),fileName)
    self.confirmText = love.graphics.newText(love.graphics.getFont(), 'O: Overwrite\nA: Append\nC: Cancel')
    self.confirming = false
end

function SaveDisplay:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.promptText, winWidth/2 - self.promptText:getWidth()/2, winHeight/2 - self.promptText:getHeight())
    if not self.confirming then
        love.graphics.draw(self.nameText, winWidth/2 - self.nameText:getWidth()/2, winHeight/2 + 10)
    else
        love.graphics.draw(self.confirmText, winWidth/2 - self.confirmText:getWidth()/2, winHeight/2 + 10)

    end
end

function SaveDisplay:show(summary)
    self.promptText:set('Save as:')
    self.fileName = ""
    self:updateNameText()
    self.nameText:set(self.fileName)
    self.confirming = false
    self.summary = json.encode(summary)
end

function SaveDisplay:keypressed(key)
    if self.confirming then
        if key == 'o' then self:write()
        elseif key == 'a' then self:append()
        elseif key == 'c' then self:finish() end
    else
        if key == 'return' then
            if self:checkValid(self.fileName) then
                if love.filesystem.getInfo(self.fileName .. '.json') ~= nil then
                    self.promptText:set('File with that name already exists.\n Overwrite? Append? Cancel?')
                    self.confirming = true
                else
                    self:write()
                end
            end
        end
        if key == 'backspace' then
            self:backspace()
        end
    end
end

function SaveDisplay:checkValid(aFileName)
    if aFileName == '' then
        self.promptText:set('Name must not be blank')
        return false
    elseif checkForReservedCharacters(aFileName) then
        self.promptText:set('Name must not contain any of the following characters:\n "/", "\\", "?", "%", "*", ":", "|", "<", ">", """')
        return false
    end
    return true
end

function checkForReservedCharacters(aFileName)
    return string.find(aFileName, '/') or
    string.find(aFileName, '\\') or
    string.find(aFileName, '?') or
    string.find(aFileName, '%%') or
    string.find(aFileName, '*') or
    string.find(aFileName, ':') or
    string.find(aFileName, '|') or
    string.find(aFileName, '<') or
    string.find(aFileName, '>') or
    string.find(aFileName, '"')
end

function SaveDisplay:updateNameText()
    self.nameText:set(self.fileName .. '.json')
end

function SaveDisplay:textinput(text)
    if not self.confirming then
        self.fileName = self.fileName .. text
        self:updateNameText()
    end
end

function SaveDisplay:backspace()
    -- get the byte offset to the last UTF-8 character in the string.
    local byteoffset = utf8.offset(self.fileName, -1)

    if byteoffset then
        -- remove the last UTF-8 character.
        -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
        self.fileName = string.sub(self.fileName, 1, byteoffset - 1)
        self:updateNameText()
    end
end

function SaveDisplay:write()
    love.filesystem.write(self.fileName .. '.json', self.summary)
    self:finish()
end

function SaveDisplay:append()
    -- love.filesystem.append(self.fileName .. '.json', self.summary)
    -- self:finish()
    print("Aye! This dunnae work")
end

function SaveDisplay:finish()
    self.manager:showTickers()
end

return SaveDisplay
