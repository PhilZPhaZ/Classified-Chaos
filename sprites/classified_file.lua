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

local classified_file = {
    {
        image = love.graphics.newImage("assets/classified_file/classified_file_1.jpeg"),
        x = 0,
        y = 0,
        scale = 1,
        animating_part_1_clicked = false,
        animating_part_2_clicked = false,
        animation_timer = 0,
        move = false,
        rotation = 0,
        resetting_rotation = false,
        visible = true,
        moveable = true,
        sprite_type = "classified_file",
    },
    {
        image = love.graphics.newImage("assets/classified_file/classified_file_2.jpeg"),
        x = 300,
        y = 0,
        scale = 1,
        animating_part_1_clicked = false,
        animating_part_2_clicked = false,
        animation_timer = 0,
        move = false,
        rotation = 0,
        resetting_rotation = false,
        visible = true,
        moveable = true,
        sprite_type = "classified_file",
    },
    {
        image = love.graphics.newImage("assets/classified_file/classified_file_1.jpeg"),
        x = 600,
        y = 0,
        scale = 1,
        animating_part_1_clicked = false,
        animating_part_2_clicked = false,
        animation_timer = 0,
        move = false,
        rotation = 0,
        resetting_rotation = false,
        visible = true,
        moveable = true,
        sprite_type = "classified_file",
    },
}

return classified_file