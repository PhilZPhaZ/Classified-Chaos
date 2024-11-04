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

function draw_classified_file(file)
    if file.visible then
        local width = file.image:getWidth()
        local height = file.image:getHeight()
        love.graphics.draw(file.image, file.x + width / 2, file.y + height / 2, file.rotation, file.scale, file.scale, width / 2, height / 2) 
    end
end