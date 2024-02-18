local bump = require('bump/bump')
require('player')
require('rays')
tileMap = {
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 1},
    {1, 0, 1, 1, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1}
}

function mapLoader()
    box = {}
    for i = 1, #tileMap do 
        for j = 1, #tileMap[i] do
            if tileMap[i][j] == 1 then
                local wall = {}
                wall.x = j*100 - 100
                wall.y = i*100 - 100
                wall.w = 100
                wall.h = 100
                wall.isWall = true
                world:add(wall, wall.x, wall.y, wall.w, wall.h)
            end
        end
    end
end

function love.load()
    world = bump.newWorld()
    Player:load()
    rays:load()
    mapLoader()
end

function love.update(dt)
    Player:update(dt)
    rays:update(dt)
end

function love.draw()
    -- for i = 1, #tileMap do
    --     for j = 1, #tileMap[i] do
    --         if tileMap[i][j] == 1 then
    --             love.graphics.rectangle('line', j*100 - 100, i*100 - 100, 100, 100)
    --         end
    --     end
    -- end
    -- Player:draw()
    rays:draw()
end