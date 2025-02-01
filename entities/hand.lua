
Hand = Object:extend()



function Hand:new()
  self.x = 0
  self.y = 0
  self.spriteSheet = love.graphics.newImage("art/hand.png")
  local numFramesWide = self.spriteSheet:getWidth() / 32
  self.grid = Anim8.newGrid(32, 32, self.spriteSheet:getWidth(), self.spriteSheet:getHeight(), 0,0,0)
  self.img= Anim8.newAnimation(self.grid('1-' .. numFramesWide, 1, numFramesWide.. '-1', 1), .125)
  world:add(self, self.x, self.y, 5, 5)
end


function Hand:update(dt)
  self.img:update(dt)
  self.x = Mouse.x
  self.y = Mouse.y
  world:update(self, self.x, self.y)
end


function Hand:draw()
  -- self.img:draw(self.spriteSheet, Mouse.x, Mouse.y)
end

function Hand:click()
  local goalX, goalY, cols, len = world:check(self, Mouse.x, Mouse.y)
  for i, v in ipairs(cols) do
    if v.other and v.other.click then
      v.other:click()
    end
  end
end

