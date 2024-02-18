rays = {}

function rays:load()
    self.x1 = Player.x + Player.w/2 + Player.w/2*math.cos(Player.rotAngle)
    self.y1 = Player.y + Player.h/2 + Player.h/2*math.sin(Player.rotAngle)
end


function rays:rayCasting()
    local rayAngle = Player.rotAngle - 30*math.pi/180
    local width = love.graphics.getWidth() / 60
    for i = 0, 60 do
        --ray path incrementers
        local segx1, segy1 = self.x1, self.y1
        local rayCos, raySin = math.cos(rayAngle) / 2, math.sin(rayAngle) / 2
        local wall = 0
        --cast ray until it detects a wall
        while (wall == 0) do
            segx1 = segx1 + rayCos
            segy1 = segy1 + raySin
            wall = tileMap[math.floor((segy1 + 100)/100)][math.floor((segx1 + 100)/100)]
        end

        --distortion fixer
        local newAng = rayAngle - Player.rotAngle
        if (newAng <= -2*math.pi) or (newAng >= 2*math.pi) then
            newAng = 0
        end

        local distance = math.sqrt((segx1 - self.x1) ^ 2 + (segy1 - self.y1) ^ 2) * math.cos(newAng)
        local wallHeight = math.floor(3000 / distance)

        -- Wall colors
        local hue = 1 / (distance / 100)
        local r = 220/255 * hue
        local g = 20/255 * hue
        local b = 60/255 * hue
        --love.graphics.line(self.x1, self.y1, segx1, segy1)
        love.graphics.push()
            love.graphics.setColor(r, g, b)
            love.graphics.rectangle('fill', i * width, love.graphics.getHeight() / 2 - wallHeight / 2, width, wallHeight)
        love.graphics.pop()

        --increments angle
        rayAngle = rayAngle + math.pi/180
    end
end

function rays:update(dt)
    -- updates x and y starting positions of rays
    self.x1 = Player.x + Player.w/2 + Player.w/2*math.cos(Player.rotAngle)
    self.y1 = Player.y + Player.h/2 + Player.h/2*math.sin(Player.rotAngle)

end

function rays:draw()
    --dots
    -- draws the result of the rayCast
    rays:rayCasting()
    --love.graphics.line(self.x1, self.y1, theX, theY)
    -- for i = 1, #self.segs do
    --     --love.graphics.circle('fill', self.segs[i].x, self.segs[i].y, 2)
    --     love.graphics.line(self.x1, self.y1, self.segs[i].x, self.segs[i].y)
    -- end
    --print(-30*math.pi/180 - Player.rotAngle)
end