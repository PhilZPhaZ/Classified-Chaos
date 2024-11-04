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

local function update(classified_files, dt, animation_time, max_rotation)
    for _, file in ipairs(classified_files) do
        if file.visible then
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
    end
end

return update
