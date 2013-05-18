Block = {}

function Block:new(x, y)
  -- Inheritance
  block = {}
  setmetatable(block, {__index = Block})

  -- attributes
  block.x = x; block.y = y
  block.width = 80; block.height = 30
  block.color = {math.random(255), math.random(255), math.random(255), 255}
  block.power = nil

  return block
end

function Block:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function levelOne()
  blocks = {}
  for i = 0, 8 do
    for j = 0, 5 do
      block = Block:new(i * 85 + 20, j * 35 + 20)
      table.insert(blocks, block)
    end
  end

  return blocks
end