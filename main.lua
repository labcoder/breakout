require 'player'
require 'block'

function love.load()
  player = Player:new()
  blocks = levelOne()

  enemies = {}
end

function love.keyreleased(key)
  if (key == ' ') then
    player:shoot()
  end
end

function love.update(dt)
  player:move(dt)

  local remEnemy = {}
  local remShot = {}

  -- update the shots
  for i,v in ipairs(player.shots) do
    -- move them up
    v.y = v.y - dt * 100

    -- flag shots off screen
    if v.y < 0 then
      table.insert(remShot, i)
    end

    -- check for collision with enemies
    for ii,vv in ipairs(enemies) do
      if checkCollision(v.x,v.y,2,5,vv.x,vv.y,vv.width,vv.height) then
        -- flag enemy and shot for removal
        table.insert(remEnemy, ii)
        table.insert(remShot, i)
      end
    end
  end

  -- remove the flagged enemies
  for i,v in ipairs(remEnemy) do
    table.remove(enemies, v)
  end

  for i,v in ipairs(remShot) do
    table.remove(player.shots, v)
  end

  -- update enemies enemies
  for i,v in ipairs(enemies) do
    local remEnemyShot = {}

    -- let them fall down slowly
    v.y = v.y + 10 * dt

    -- enemy shots
    for ii,vv in ipairs(v.shots) do
      vv.y = vv.y + dt * 100 -- move the shots down

      -- flag shots off screen
      if vv.y > 460 then
        table.insert(remEnemyShot, ii)
      end

      -- check for collision with player
      if checkCollision(vv.x,vv.y,2,5,player.x,player.y,player.width,player.height) then
        -- flag enemy and shot for removal
        endGame(0)
        table.insert(remEnemyShot, ii)
      end
    end

    -- Did they shoot now?
    if math.random() > .999 then
      enemyShoot(v)
    end

    -- remove the flagged enemies
    for ii,vv in ipairs(remEnemyShot) do
      table.remove(v.shots, vv)
    end

    -- Did they reach the ground?
    if v.y > 465 then
      endGame(0)
    end
  end
end

function love.draw()
  player:draw()

  for i,b in ipairs(blocks) do
    b:draw()
  end

  -- shots
  love.graphics.setColor(255, 255, 255, 255)
  for i,v in ipairs(player.shots) do
      love.graphics.rectangle('fill', v.x, v.y, 2, 5)
  end
end

function checkCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function endGame(victory)
  if victory then
    -- WIN GAME
  else
    -- LOSE GAME
  end
end
