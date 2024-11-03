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

local game = {}

-- classified files
local classified_files = {}

-- animations variables
local scale_classified_file_1 = 1
local scale_classified_file_2 = 1
local animating_1 = false
local animating_2 = false
local animation_time = 0.15
local animation_timer_1 = 0
local animation_timer_2 = 0

-- rotation variables
local max_rotation = 0.1

-- mouse variables
local prev_mouse_x = 0
local prev_mouse_y = 0
local mouse_x = 0
local mouse_y = 0

function game.load()
    -- load game assets
    classified_files = {
        {
            image = love.graphics.newImage("assets/classified_file_1.jpeg"),
            x = 0,
            y = 0,
            scale = 1,
            animating_part_1_clicked = false,
            animating_part_2_clicked = false,
            animation_timer = 0,
            move = false,
            rotation = 0,
            resetting_rotation = false,
            index = 1,
        },
        {
            image = love.graphics.newImage("assets/classified_file_2.jpeg"),
            x = 300,
            y = 0,
            scale = 1,
            animating_part_1_clicked = false,
            animating_part_2_clicked = false,
            animation_timer = 0,
            move = false,
            rotation = 0,
            resetting_rotation = false,
            index = 2,
        },
        {
            image = love.graphics.newImage("assets/classified_file_1.jpeg"),
            x = 600,
            y = 0,
            scale = 1,
            animating_part_1_clicked = false,
            animating_part_2_clicked = false,
            animation_timer = 0,
            move = false,
            rotation = 0,
            resetting_rotation = false,
            index = 3,
        },
    }
end

function game.update(dt)
    -- update game
    -- animate classified files
    for _, file in ipairs(classified_files) do
        -- animate classified files
        if file.animating_part_1_clicked then
            file.animation_timer = file.animation_timer + dt
            if file.animation_timer <= animation_time / 2 then
                file.scale = 1 - (file.animation_timer / (animation_time / 2)) * 0.1
            else
                file.scale = 0.9
                file.animating_part_1_clicked = false
            end
        elseif file.animating_part_2_clicked then
            file.animation_timer = file.animation_timer + dt
            if file.animation_timer <= animation_time / 2 then
                file.scale = 0.9 + (file.animation_timer / (animation_time / 2)) * 0.1
            else
                file.scale = 1
                file.animating_part_2_clicked = false
            end
        end
        -- reset rotation
        if file.resetting_rotation then
            local rotation_step = max_rotation / 5
            if math.abs(file.rotation) > rotation_step then
                file.rotation = file.rotation - sign(file.rotation) * rotation_step
            else
                file.rotation = 0
                file.resetting_rotation = false
            end
        end
    end

    -- check if mouse is not moving
    mouse_x, mouse_y = love.mouse.getPosition()
    if mouse_x == prev_mouse_x and mouse_y == prev_mouse_y then
        -- reset rotation
        for _, file in ipairs(classified_files) do
            if file.move then
                file.resetting_rotation = true
            end
        end
    end
    prev_mouse_x, prev_mouse_y = mouse_x, mouse_y
end

function game.mousepressed(x, y, button, istouch, presses)
    -- handle mouse press
    -- check if classified files are clicked
    if button == 1 then
        classified_files = reverse(classified_files)
        for index, file in ipairs(classified_files) do
            local width = file.image:getWidth()
            local height = file.image:getHeight()
            if x >= file.x and x <= file.x + width and
                y >= file.y and y <= file.y + height then
                file.move = true
                file.animating_part_1_clicked = true
                file.animation_timer = 0
                -- change the index of the classified file to be the last one
                table.remove(classified_files, index)
                classified_files = reverse(classified_files)
                table.insert(classified_files, file)
                break
            end
        end
    end
end

function game.mousereleased(x, y, button, istouch, presses)
    -- handle mouse release
    if button == 1 then
        -- stop moving classified files
        for _, file in ipairs(classified_files) do
            if file.move then
                file.animating_part_1_clicked = false
                file.animating_part_2_clicked = true
                file.animation_timer = 0
            end

            file.move = false
            file.resetting_rotation = true
        end
    end
end

function game.mousemoved(x, y, dx, dy, istouch)
    -- handle mouse move
    -- move classified files
    for _, file in ipairs(classified_files) do
        if file.move then
            file.x = file.x + dx
            file.y = file.y + dy

            if dx > 0 then
                if file.rotation < max_rotation then
                    file.rotation = file.rotation + (max_rotation / 5)
                end
            elseif dx < 0 then
                if file.rotation > -max_rotation then
                    file.rotation = file.rotation - (max_rotation / 5)
                end
            end
        end
    end
end

function game.draw()
    -- draw game
    -- draw classified files
    for _, file in ipairs(classified_files) do
        local width = file.image:getWidth()
        local height = file.image:getHeight()
        love.graphics.draw(file.image, file.x + width / 2, file.y + height / 2, file.rotation, file.scale, file.scale, width / 2, height / 2)
    end
end

function game.resize(w, h)

end

return game