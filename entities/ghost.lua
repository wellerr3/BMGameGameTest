

Ghost = Char:extend()



function Ghost:new(x, y, room, i)
  Ghost.super.new(self, x, y, room, "ghost".. i, "art/ghost.png")
  self.sad = false
end


function Ghost:update(dt)
  Ghost.super.update(self, dt)
  if not Rooms[self.room].lightsOn then
    self.speed = 200
    self.sad = false
  else
    self.speed = 50
    self.sad = true
  end
  self:move(dt)
end


function Ghost:draw()
  if self.sad then
    love.graphics.setColor( 1, 0, 0, 1 )
  end
  Ghost.super.draw(self)
  if self.sad then
    love.graphics.setColor( 1, 1, 1, 1 )
  end
end

function Ghost:wander(dt)
  local px, py, offsetX, offsetY, offset = 0, 0, 0, 0, 20
  if self.dir == 1 then
    px = px + self.speed
    offsetX = offset
  elseif self.dir == 2 then
    px = px - self.speed
    offsetX = -offset
  elseif self.dir == 3 then
    py = py - self.speed
    offsetY = -offset
  elseif self.dir == 4 then
    py = py + self.speed
    offsetY = offset
  end
  px = (px*dt) + self.x
  py =  (py*dt) + self.y
  -- if not self.sad then
  self:checkForPlug(px + offsetX, py+ offsetY)
  -- end
  return px, py
end

function Ghost:move(dt)
  if math.random(15) == 1 then
    self.dir = math.random(4)
  end
  local px, py = self:wander(dt)
  Ghost.super.getMove(self, px, py)
end

function Ghost:checkForPlug(px, py)
  local goalX, goalY, cols, len = world:check(self, px, py)
  for i, v in ipairs(cols) do
    if v.other and v.other.interact then
      v.other:interact(true)
    end
  end
end


function Ghost:lookForDark()

end