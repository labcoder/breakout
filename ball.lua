Ball = {}

function Ball:new(x, y)
  -- Inheritance
  ball = {}
  setmetatable(ball, {__index = Ball})

  --attributes
  ball.x = x or 400; ball.y = y or 530
  ball.speed = 200
  ball.radius = 10
  ball.angle = - math.pi / 4
  ball.color = {255, 255, 255, 255}

  return ball
end

function Ball:move(dt)
  self.x = self.x + math.cos(self.angle) * self.speed * dt
  self.y = self.y + math.sin(self.angle) * self.speed * dt

  -- Check if in bounds
  if self.x < 10 then
    self.x = 10
    self.angle = math.pi - self.angle
  elseif self.x > 790 then
    self.x = 790
    self.angle = math.pi - self.angle
  end

  if self.y < 10 then
    self.y = 10
    self.angle = -self.angle
  elseif self.y > love.graphics.getHeight() - 10 then
    self.y = love.graphics.getHeight() - 10
    self.angle = -self.angle
  end

  -- check if paddle hit
  if checkCollision(self.x, self.y, self.radius, self.radius, player.x, player.y, player.width, player.height) then
    -- (player.x + player.width / 2)
    self.angle = -self.angle
  end

  -- check if a block is hit
  for i,v in ipairs(blocks) do
    if checkCollision(self.x, self.y, self.radius / 2, self.radius / 2, v.x, v.y, v.width, v.height) then
      self.angle = -self.angle
      table.remove(blocks, i)
      break
    end
  end
end

function Ball:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self.x, self.y, self.radius)
end