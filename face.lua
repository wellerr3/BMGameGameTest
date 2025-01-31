
Face = Object:extend()



function Face:new()
  self.x = 0
  self.y = 0
  self.spriteSheet = love.graphics.newImage("art/face.png")
  local numFramesWide = self.spriteSheet:getWidth() / 128
  self.grid = Anim8.newGrid(128, 128, self.spriteSheet:getWidth(), self.spriteSheet:getHeight(), 0,0,0)
  self.img= Anim8.newAnimation(self.grid('1-' .. numFramesWide, 1, numFramesWide.. '-1', 1), .125, "pauseAtEnd")
  self.timer = 0
end


function Face:update(dt)
  self.img:update(dt)
  if self.timer > 0 then
    self.timer = self.timer - 1
    if self.timer == 0 then
      -- :click()
    end
  end
end


function Face:draw()
  self.img:draw(self.spriteSheet, self.x, self.y, 0)
end

function Face:click()
  if self.timer == 0 then
    self.timer = 30
    self.img:gotoFrame(1)
    self.img:resume()
  end

end

