local utf8 = require "utf8"
local Ticker = class('Ticker')

function Ticker:initialize(aCount, aLabel)
    self.count = aCount or 0
    self.label = aLabel or 'count'
end

function Ticker:increment()
    self.count = self.count + 1
end

function Ticker:decrement()
    self.count = self.count - 1
end

function Ticker:clear()
    self.count = 0
end

function Ticker:textinput(text)
    self.label = self.label .. text
end

function Ticker:backspace(key)
    -- get the byte offset to the last UTF-8 character in the string.
    local byteoffset = utf8.offset(self.label, -1)

    if byteoffset then
        -- remove the last UTF-8 character.
        -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
        self.label = string.sub(self.label, 1, byteoffset - 1)
    end
end

function Ticker:getSummary()
    local summary = {}
    summary.count = self.count
    summary.label = self.label
    return summary
end

return Ticker
