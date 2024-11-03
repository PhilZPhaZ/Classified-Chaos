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
local menu = {}

function menu.load()
    -- load menu assets
end

function menu.update(dt)
    -- update menu
end

function menu.mousepressed(x, y, button, istouch, presses)
    -- handle mouse press
end

function menu.mousereleased(x, y, button, istouch, presses)
    -- handle mouse release
end

function menu.mousemoved(x, y, dx, dy, istouch)
    -- handle mouse move
end

function menu.draw()
    -- draw menu
    -- some text to test shader
    love.graphics.print("Press space to start", 10, 10)
    -- other text
    love.graphics.print("Press escape to quit", 10, 30)
    -- even more text
    love.graphics.print("Press enter to do something", 10, 50)

end

return menu