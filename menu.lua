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
local mouse = require "input.mouse"
local sprites = require "sprites"

local menu = {}
local font = love.graphics.newFont("assets/font/PixelifySans-VariableFont_wght.ttf", 54)

-- assets
local background

-- button dimensions
local total_buttons_height
local button_spacing = 10

-- all sprites
local all_sprites = {}

-- mouse coordinates
local mouse_x, mouse_y

-- sound effects
local click_sound
local hover_click_sound = false

local function update_buttons()
    total_buttons_height = 0
    -- update buttons
    for _, button in pairs(all_sprites.button) do
        button.width = font:getWidth(button.text)
        button.height = font:getHeight(button.text)
        total_buttons_height = total_buttons_height + button.height + button_spacing
    end

    -- update coordinates depending on screen size
    local y = SCREEN_HEIGHT / 2 - total_buttons_height / 2
    for _, button in pairs(all_sprites.button) do
        button.x = SCREEN_WIDTH / 2 - button.width / 2
        button.y = y
        y = y + button.height + button_spacing
    end
end

function menu.load()
    -- load menu assets
    background = love.graphics.newImage("assets/menu_assets/background.png")

    -- load all sprites
    all_sprites = {
        button = sprites.MENU_BUTTON,
    }

    -- update buttons
    update_buttons()

    -- load sound effects
    click_sound = love.audio.newSource("assets/sound/button_click.wav", "static")
end

function menu.update(dt)
    -- update menu
    -- handle mouse hover
    mouse_x, mouse_y = love.mouse.getPosition()
    local is_hover = mouse.hover(all_sprites, mouse_x, mouse_y)

    -- play hover sound effect
    if is_hover and not hover_click_sound then
        hover_click_sound = true
        click_sound:play()
    elseif not is_hover then
        hover_click_sound = false
    end
end

function menu.mousepressed(x, y, button, istouch, presses)
    mouse.pressed(all_sprites, x, y, button, istouch, presses)
    click_sound:play()
end

function menu.mousereleased(x, y, button, istouch, presses)
    -- handle mouse release
end

function menu.mousemoved(x, y, dx, dy, istouch)
    -- handle mouse move
end

function menu.draw()
    love.graphics.draw(background, 0, 0, 0, SCREEN_WIDTH / background:getWidth(), SCREEN_HEIGHT / background:getHeight())

    -- draw menu
    love.graphics.setFont(font)

    -- text (PLAY, SETTINGS, QUIT)
    for _, sprite in pairs(all_sprites) do
        for _, file in pairs(sprite) do
            if file.visible then
                love.graphics.setColor(file.color)
                love.graphics.print(file.text, file.x, file.y)
            end
        end
    end
end

function menu.resize(w, h)
    SCREEN_WIDTH = w
    SCREEN_HEIGHT = h

    -- update buttons
    update_buttons()
end

return menu