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

local transition = {}
local time = 0
local is_transitioning = false

function transition.start()
    is_transitioning = true
    time = 0
end

function transition.update(dt)
    if is_transitioning then
        time = time + dt
        if time >= 1 then -- durée de la transition
            is_transitioning = false
        end
    end
end

function transition.draw_transition_to_game()
    if is_transitioning then
        -- on dessine une animation de transition ici
        -- un cercle qui grossit, par exemple
        local radius = 10 ^ (time * 3.5)
        love.graphics.circle("fill", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, radius)
    end
end

function transition.draw_transition_to_menu()
    if is_transitioning then
        -- dessiner l'animation de transition ici
    end
end

return transition