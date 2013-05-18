Player = {}

function Player:new()
  -- Inheritance
  player = {}
  setmetatable(player, { __index = Player })

  -- attributes
  player.x = 300; player.y = 550
  player.width = 120; player.height = 10
  player.speed = 300
  player.lives = 3
  player.color = {255, 0, 255, 255}
  player.shots = {} -- DELETE THIS LINE

  return player
end

function Player:move(dt)
  if love.keyboard.isDown('left') then
    self.x = self.x - self.speed * dt
  elseif love.keyboard.isDown('right') then
    self.x = self.x + self.speed * dt
  end

  if self.x < 0 then
    self.x = 0
  elseif self.x > 680 then
    self.x = 680
  end
end

function Player:shoot()
  local shot = {}
  shot.x = self.x + self.width / 2
  shot.y = self.y

  table.insert(self.shots, shot)
end

function Player:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end