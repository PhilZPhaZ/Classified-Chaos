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

--[[
Module: mouse
This module handles mouse interactions for sprite manipulation in a graphical environment. 
It provides functions to manage mouse press, release, and movement events affecting visible sprites.

Functions:
1. mouse.pressed(all_sprites, x, y, button): Handles mouse press events, enabling movement for clicked sprites.
   Args: 
     - all_sprites: Table of sprite groups.
     - x: X-coordinate of the mouse.
     - y: Y-coordinate of the mouse.
     - button: Mouse button pressed (1 for left button).
   Returns: None.

2. mouse.released(all_sprites, button): Handles mouse release events, stopping movement and resetting sprite states.
   Args: 
     - all_sprites: Table of sprite groups.
     - button: Mouse button released (1 for left button).
   Returns: None.

3. mouse.moved(all_sprites, x, y, dx, dy, max_rotation): Updates sprite positions and rotations based on mouse movement.
   Args: 
     - all_sprites: Table of sprite groups.
     - x: Current X-coordinate of the mouse.
     - y: Current Y-coordinate of the mouse.
     - dx: Change in X-coordinate.
     - dy: Change in Y-coordinate.
     - max_rotation: Maximum rotation limit for sprites.
   Returns: None.
]]

require "lib.table"

local mouse = {}

function mouse.pressed(all_sprites, x, y, button)
    if button == 1 then
        for _, sprite in pairs(all_sprites) do
            sprite = reverse(sprite)
            for index, file in ipairs(sprite) do
                if file.visible then
                    local width = file.image:getWidth()
                    local height = file.image:getHeight()
                    if x >= file.x and x <= file.x + width and
                        y >= file.y and y <= file.y + height then
                        file.move = true
                        file.animating_part_1_clicked = true
                        file.animation_timer = 0
                        table.remove(sprite, index)
                        sprite = reverse(sprite)
                        table.insert(sprite, file)
                        break
                    end
                end
            end
        end
    end
end

function mouse.released(all_sprites, button)
    if button == 1 then
        for _, sprite in pairs(all_sprites) do
            for _, file in ipairs(sprite) do
                if file.visible then
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
    end
end

function mouse.moved(all_sprites, x, y, dx, dy, max_rotation)
    for _, sprite in pairs(all_sprites) do
        for _, file in ipairs(sprite) do
            if file.move and file.visible and file.moveable then
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
end

return mouse