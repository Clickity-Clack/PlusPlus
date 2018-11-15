class = require 'lib/middleclass'
json = require 'lib/json'
local DisplayManager = require 'DisplayManager'

local displayManager

function love.load()
    love.window.setTitle("PlusPlus")
    -- love.window.setMode(200,200)
    displayManager = DisplayManager()
end

function love.draw()
    displayManager:draw()
end

function love.keypressed(key)
    displayManager:keypressed(key)
end

function love.textinput(text)
    displayManager:textinput(text)
end
