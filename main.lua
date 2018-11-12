class = require 'middleclass'
local utf8 = require "utf8"
local VisualTicker = require 'VisualTicker'

local once
-- local fontHeight
local tickerHeight
local bufferHeight
local winWidth
-- local winHeight

local tickers
local selectedTicker

local labelCenteredX

function love.load()
    love.window.setTitle("PlusPlus")
    -- love.window.setMode(200,200)
    love.graphics.setColor(0.4, 0.4, 0.4)

    input = false
    selectedTicker = VisualTicker()
    -- extraTestTicker = VisualTicker()
    tickers = { selectedTicker }

    once = true
    tickerHeight = selectedTicker.height
    bufferHeight = tickerHeight/3
    winWidth = love.graphics.getWidth()
end

function love.draw()
    drawTickers()
end

function love.keypressed(key)
    if input then 
        if key == 'backspace' then selectedTicker.backspace(key) end
        if key == 'enter' then input = false end
    elseif key == 'kp+' then selectedTicker:increment()
    elseif key == 'kp-' then selectedTicker:decrement()
    elseif key == 'escape' then selectedTicker:clear()
    elseif key == 'q' then love.event.quit() end
end

function drawTickers()
    for i in pairs(tickers) do
        if tickers[i] == selectedTicker then
            love.graphics.setColor(1, 1, 1)
            tickers[i]:drawCenter(winWidth/2, tickerHeight * (i - 1) + bufferHeight * i)
            love.graphics.setColor(0.4, 0.4, 0.4)
        else
            tickers[i]:drawCenter(winWidth/2, tickerHeight * (i - 1) + bufferHeight * i)
        end
    end
end
