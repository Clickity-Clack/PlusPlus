class = require 'lib/middleclass'
json = require 'lib/json'
local VisualTickerList = require 'VisualTickerList'

local once
local bufferHeight
local winWidth

local tickers

function love.load()
    love.window.setTitle("PlusPlus")
    -- love.window.setMode(200,200)
    love.graphics.setColor(0.4, 0.4, 0.4)

    input = false
    tickerList = VisualTickerList()

    once = true
    winWidth = love.graphics.getWidth()
end

function love.draw()
    tickerList:drawCentered(winWidth/2, 0)
end

function love.keypressed(key)
    if input then 
        if key == 'backspace' then tickerList:backspace(key) end
        if key == 'return' then input = false end
    elseif key == 'kp+' then tickerList:incrementSelected()
    elseif key == 'kp-' then tickerList:decrementSelected()
    elseif key == 'escape' then tickerList:clearSelected()
    elseif key == 'l' then input = true
    elseif key == 'q' then love.event.quit() end
end

function love.textinput(text)
    if input then
        tickerList:textinput(text)
    end
end
