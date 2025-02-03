Hunter = Char:extend()



function Hunter:new(x, y, room, i)
  Hunter.super.new(self, x, y, room, "hunter", "art/hunter.png")
  self.rotDraw = {
    Anim8.newAnimation(self.grid(1, 1), .125),
    Anim8.newAnimation(self.grid(1, 2), .125),
    Anim8.newAnimation(self.grid(1, 3), .125),
    Anim8.newAnimation(self.grid(1, 4), .125)
  }
end


function Hunter:update(dt)
  Hunter.super.update(self, dt)
  self:move(dt)
end

function Hunter:draw()
  self.rotDraw[self.dir]:draw(self.spriteSheet, self.x, self.y)
end


function Hunter:move(dt)
  local px, py = self:manual(dt)
  Hunter.super.getMove(self, px, py)
end

function Hunter:Query()
  local px, py = self.x, self.y
  local checkDist = 32
  if Dirs[self.dir] == "right" then
    px = px + checkDist
  elseif Dirs[self.dir] == "left" then
    px = px - checkDist
  elseif Dirs[self.dir] == "up" then
    py = py - checkDist
  elseif Dirs[self.dir] == "down" then
    py = py + checkDist
  end
  local goalX, goalY, cols, len = world:check(self, px + 5, py)
  for i, v in ipairs(cols) do
    if v.other and v.other.interact then
      v.other:interact(false)
    end
  end
end
