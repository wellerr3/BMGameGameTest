BaddieMaker = Object:extend()

Wanderer = Object:extend()

function BaddieMaker:new()
  local loc = {
    {32,20, "entry"},{41,17, "dining"},{40,6, "bed1"},{39,30, "garage"}
  }
  self.bads = {}
  self.numBads = 5
  for i = 1, #loc, 1 do
    local bad = Wanderer(loc[i][1], loc[i][2], loc[i][3], i)
    table.insert(self.bads, bad)
  end

end

function BaddieMaker:update(dt)
  for i, v in pairs(self.bads) do
    v:update(dt)
  end
end

function BaddieMaker:draw()
  for i, v in pairs(self.bads) do
    v:draw()
  end
end

function Wanderer:new(x,y, room, i)
  x = x or 32
  y = y or 20
  self.room = room or ''
  self.num = i
  self.x = x * Tilesize
  self.y = y * Tilesize
  self.spriteSheet = love.graphics.newImage("art/ghost.png")
  local numFramesWide = self.spriteSheet:getWidth() / 32
  self.grid = Anim8.newGrid(32, 32, self.spriteSheet:getWidth(), self.spriteSheet:getHeight(), 0,0,0)
  self.img= Anim8.newAnimation(self.grid('1-' .. numFramesWide, 1, numFramesWide.. '-1', 1), .125)
  self.timer = 0
  self.speed = 5
  self.dir = 1
  self.moveing = true
  self.properties = {}
  world:add(self, self.x, self.y, 32, 32)
end


function Wanderer:update(dt)
  self.img:update(dt)
  if not Rooms[self.room].lightsOn then
    self:move()
  end

end


function Wanderer:draw()
  if Rooms[self.room].lightsOn then
    love.graphics.setColor( 1, 0, 0, 1 )
  end
  self.img:draw(self.spriteSheet, self.x, self.y)
  if Rooms[self.room].lightsOn then
    love.graphics.setColor( 1, 1,1, 1 )
  end
end

function Wanderer:wander()
  local px, py = self.x, self.y
  if self.dir == 1 then
    px = px + self.speed
  elseif self.dir == 2 then
    px = px - self.speed
  elseif self.dir == 3 then
    py = py - self.speed
  elseif self.dir == 4 then
    py = py + self.speed
  end
  return px, py
end

function Wanderer:move()
  if math.random(15) == 1 then
    self.dir = math.random(4)
  end
  local px, py = self:wander()
  local goalX, goalY, cols, len = world:check(self, px , py)
  if len == 0 then
    self:checkRoom(px, py)
    self.x, self.y = px, py
    world:move(self, self.x, self.y)
  end
end

function Wanderer:checkRoom(px, py)
  local imp
  if self.dir > 3 then 
    imp = px
  else
    imp = py
  end
  local roomExit = Rooms[self.room][Dirs[self.dir]]
  if roomExit then
    if self.dirs == 1 or self.dirs ==  4 then
      if roomExit > imp then
        if type(Rooms[self.room].adjacent[self.dir]) == "string" then
          self.room = Rooms[self.room].adjacent[self.dir]
        else
          
        end
      end
    else
    end
  end
end

-- Dirs = {"right", "left", "up", "down"}