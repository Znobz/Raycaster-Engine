Player = {}

function Player:load()
    self.x = 120
    self.y = 120
    self.w = 15
    self.h = 15
    self.xVel = 0
    self.yVel = 0
    self.rotAngle = 0
    self.isPlayer = true
    world:add(self, self.x, self.y, self.w, self.h)

end

function Player:collide(dt)
    local finalX = self.x + self.xVel*dt
    local finalY = self.y + self.yVel*dt
    local actualX, actualY, cols, len = world:move(self, finalX, finalY)
    --Collision checking stuff

    self.x = actualX
    self.y = actualY
end

function Player:update(dt)
    if love.keyboard.isScancodeDown('w') then
        self.xVel, self.yVel = 80*math.cos(self.rotAngle), 80*math.sin(self.rotAngle)
    elseif love.keyboard.isScancodeDown('s') then
        self.xVel, self.yVel = -80*math.cos(self.rotAngle), -80*math.sin(self.rotAngle)
    elseif love.keyboard.isScancodeDown('a') then
        self.yVel, self.xVel = -80*math.cos(self.rotAngle), 80*math.sin(self.rotAngle)
    elseif love.keyboard.isScancodeDown('d') then
        self.yVel, self.xVel = 80*math.cos(self.rotAngle), -80*math.sin(self.rotAngle)
    else
        self.xVel, self.yVel = 0, 0
    end

    --Keeps the angle from going below 0 degrees and from overreaching 360 degrees
    if love.keyboard.isScancodeDown('left') then
        self.rotAngle = self.rotAngle - dt
    elseif love.keyboard.isScancodeDown('right') then
        self.rotAngle = self.rotAngle + dt
    end
    --Keeps the angle from going below 0 degrees and from overreaching 360 degrees
    if (self.rotAngle <= -2*math.pi) or (self.rotAngle >= 2*math.pi) then
        self.rotAngle = 0
    end

    Player:collide(dt)
end

function rotRect(mode, x, y, w, h, a, ox, oy)
    ox = ox or 0
    oy = oy or 0
    a = a or 0
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(a)
    love.graphics.rectangle(mode, -ox, -oy, w, h)
    love.graphics.pop()
end

function Player:draw()
    rotRect('line', self.x + self.w*0.5, self.y + self.h*0.5, self.w, self.h, self.rotAngle, self.w*0.5, self.h*0.5)
    
end