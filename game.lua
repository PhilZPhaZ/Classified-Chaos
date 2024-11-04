--[[
Copyright 2024 philzphaz classified chaos

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]

require "lib.table"
require "lib.math"
require "drawing.draw"

-- sprites
local sprites = require "sprites"
local animation = require "animation"
local mouse = require "input.mouse"

-- game
local game = {}

-- all sprites
local all_sprites = {}

-- animations variables
local animation_time = 0.15

-- rotation variables
local max_rotation = 0.1

-- mouse variables
local prev_mouse_x = 0
local prev_mouse_y = 0
local mouse_x = 0
local mouse_y = 0

function game.load()
    -- load game assets
    all_sprites = {
        classified_files = sprites.CLASSIFIED_FILE,
    }
end

function game.update(dt)
    -- update game
    -- animate classified files
    animation.CLASSIFIED_FILE(all_sprites.classified_files, dt, animation_time, max_rotation)

    -- check if mouse is not moving
    mouse_x, mouse_y = love.mouse.getPosition()
    if mouse_x == prev_mouse_x and mouse_y == prev_mouse_y then
        -- reset rotation
        for _, sprite in pairs(all_sprites) do
            for _, file in ipairs(sprite) do
                if file.move then
                    file.resetting_rotation = true
                end
            end
        end
    end
    prev_mouse_x, prev_mouse_y = mouse_x, mouse_y
end

function game.mousepressed(x, y, button, istouch, presses)
    -- handle mouse press
    -- check if classified files are clicked
    mouse.pressed(all_sprites, x, y, button, istouch, presses)
end

function game.mousereleased(x, y, button, istouch, presses)
    -- handle mouse release
    mouse.released(all_sprites, x, y, button, istouch, presses)
end

function game.mousemoved(x, y, dx, dy, istouch)
    -- handle mouse move
    mouse.moved(all_sprites, x, y, dx, dy, max_rotation)
end

function game.draw()
    -- draw game
    -- draw classified files
    for _, sprite in pairs(all_sprites) do
        for _, file in ipairs(sprite) do
            if file.visible then
                draw(file)
            end
        end
    end
end

function game.resize(w, h)

end

return game