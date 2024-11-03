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

-- Classified Chaos
-- le theme est secret
-- Tu travailles dans une agence ultra-secrète où tu dois classifier des informations confidentielles. En cliquant sur différents fichiers, tu découvres des secrets (certains drôles, d’autres étranges ou effrayants) et tu dois les classer dans les bonnes catégories pour gagner des points. Certains secrets peuvent être "inutiles" ou "brûlants", et si tu fais une erreur, tu as des conséquences (pénalités, des secrets qui se répandent, etc.).
-- Plus tu avances, plus les secrets deviennent complexes à classifier, et tu débloques des compétences pour mieux gérer les fuites d’information.

-- global variables
-- screen dimensions
SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720
GAME_STATES = {
    MENU = 0,
    GAME = 1,
}
GAME_STATE = GAME_STATES.GAME

-- imported files
local menu = require("menu")
local game = require("game")
local transition = require("transition")

-- shader
local moonshine = require("moonshine")

-- music
local music_files = {
    "music/Classified Confessions.mp3",
    "music/Confidential Chaos.mp3",
    "music/Encrypted Dreams.mp3",    
}
local music_index = 1

function love.load()
    love.window.setTitle("Classified Chaos")
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {
        fullscreen = false,
        resizable = true,
        minwidth = 1280,
        minheight = 720,
    })
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

    -- load shaders
    effect = moonshine(moonshine.effects.chromasep)
    effect.chromasep.radius = 2

    -- load assets
    menu.load()
    game.load()

    -- load music
    music = love.audio.newSource(music_files[1], "stream")
end

function love.update(dt)
    transition.update(dt)
    if GAME_STATE == GAME_STATES.MENU then
        menu.update(dt)
    elseif GAME_STATE == GAME_STATES.GAME then
        game.update(dt)
    end

    -- play music
    -- when the music ends, play the next one
    if not music:isPlaying() then
        music_index = music_index + 1
        if music_index > #music_files then
            music_index = 1
        end
        music = love.audio.newSource(music_files[music_index], "stream")
        music:play()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if GAME_STATE == GAME_STATES.MENU then
        menu.mousepressed(x, y, button, istouch, presses)
    elseif GAME_STATE == GAME_STATES.GAME then
        game.mousepressed(x, y, button, istouch, presses)
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if GAME_STATE == GAME_STATES.MENU then
        menu.mousereleased(x, y, button, istouch, presses)
    elseif GAME_STATE == GAME_STATES.GAME then
        game.mousereleased(x, y, button, istouch, presses)
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    if GAME_STATE == GAME_STATES.MENU then
        menu.mousemoved(x, y, dx, dy, istouch)
    elseif GAME_STATE == GAME_STATES.GAME then
        game.mousemoved(x, y, dx, dy, istouch)
    end
end

function love.draw()
    effect(function()
        if GAME_STATE == GAME_STATES.MENU then
            menu.draw()
        elseif GAME_STATE == GAME_STATES.GAME then
            game.draw()
        end
    end)
end

function love.resize(w, h)
    SCREEN_WIDTH = w
    SCREEN_HEIGHT = h

    -- update shaders
    effect.resize(w, h)

    -- update game
    game.resize(w, h)
end