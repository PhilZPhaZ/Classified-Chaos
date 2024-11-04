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

local is_classified_file_clicked -- fucking bad way to implement it but idk how to do it correctly

local function check_is_classified_file_clicked(all_sprites, x, y)
    for _, file in ipairs(all_sprites.classified_files) do
        if file.moveable and file.visible then
            local width = file.image:getWidth()
            local height = file.image:getHeight()
            if x >= file.x and x <= file.x + width and y >= file.y and y <= file.y + height then
                return true
            end
        end
    end
    return false
end

---------- Mouse presses ----------
local function handle_mouse_press_game(all_sprites, x, y)
    -- first check if a classified file is clicked
    is_classified_file_clicked = check_is_classified_file_clicked(all_sprites, x, y)

    for _, sprite in pairs(all_sprites) do
        if is_classified_file_clicked then
            sprite = reverse(sprite)
        end

        for index, file in ipairs(sprite) do
            if file.moveable and file.visible then
                local width = file.image:getWidth()
                local height = file.image:getHeight()
                if x >= file.x and x <= file.x + width and y >= file.y and y <= file.y + height then
                    file.move = true

                    if file.sprite_type == "classified_file" then
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

local function handle_mouse_press_menu(all_sprites, x, y)
    -- handle mouse press in menu
    for _, file in pairs(all_sprites.button) do
        if file.clickable then
            if x >= file.x and x <= file.x + file.width and y >= file.y and y <= file.y + file.height then
                if file.text == "PLAY" then
                    GAME_STATE = GAME_STATES.GAME
                elseif file.text == "SETTINGS" then
                    -- settings
                elseif file.text == "QUIT" then
                    love.event.quit()
                end
            end
        end
    end
end

function mouse.pressed(all_sprites, x, y, button, istouch, presses)
    if button == 1 then
        if GAME_STATE == GAME_STATES.GAME then
            handle_mouse_press_game(all_sprites, x, y)
        elseif GAME_STATE == GAME_STATES.MENU then
            handle_mouse_press_menu(all_sprites, x, y)
        end
    end
end

---------- Mouse releases ----------
function handle_mouse_release_game(all_sprites, x, y)
    for _, sprite in pairs(all_sprites) do
        for _, file in ipairs(sprite) do
            if file.visible then
                if file.move and file.sprite_type == "classified_file" then
                    file.animating_part_1_clicked = false
                    file.animating_part_2_clicked = true
                    file.animation_timer = 0
                end
                file.resetting_rotation = true
            end
            file.move = false
        end
    end
end

function handle_mouse_release_menu(all_sprites, x, y)
    -- handle mouse release in menu
end

function mouse.released(all_sprites, x, y, button, istouch, presses)
    if button == 1 then
        if GAME_STATE == GAME_STATES.GAME then
            handle_mouse_release_game(all_sprites, x, y)
        elseif GAME_STATE == GAME_STATES.MENU then
            handle_mouse_release_menu(all_sprites, x, y)
        end
    end
end

---------- Mouse movement ----------
function handle_mouse_move_game(all_sprites, x, y, dx, dy, max_rotation)
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

function handle_mouse_move_menu(all_sprites, x, y, dx, dy, max_rotation)
    -- handle mouse move in menu
end

function mouse.moved(all_sprites, x, y, dx, dy, max_rotation)
    if GAME_STATE == GAME_STATES.GAME then
        handle_mouse_move_game(all_sprites, x, y, dx, dy, max_rotation)
    elseif GAME_STATE == GAME_STATES.MENU then
        handle_mouse_move_menu(all_sprites, x, y, dx, dy, max_rotation)
    end
end

---------- Mouse hover ----------
local function handle_mouse_hover_game(all_sprites, x, y)

end

local function handle_mouse_hover_menu(all_sprites, x, y)
    -- handle mouse hover in menu
    -- buttons
    for _, file in pairs(all_sprites.button) do
        if file.clickable then
            if x >= file.x and x <= file.x + file.width and y >= file.y and y <= file.y + file.height then
                file.color = {0.07, 0.07, 0.07}
            else
                file.color = {1, 1, 1}
            end
        end
    end
end

function mouse.hover(all_sprites, x, y)
    if GAME_STATE == GAME_STATES.MENU then
        handle_mouse_hover_menu(all_sprites, x, y)
    elseif GAME_STATE == GAME_STATES.GAME then
        handle_mouse_hover_game(all_sprites, x, y)
    end
end

return mouse