PlugMaker = Object:extend()

Plug = Object:extend()

function PlugMaker:new()
  self.plugs = {}
  self.rooms = {}

  for roomName, room in pairs(Rooms) do
    local count = 0
    local onCount = 0
    for i, wall in ipairs(room.walls) do
      local num = 1
      local dev = DifPlugs
      if math.floor(wall.length/dev) > 0 then
        num = math.floor(wall.length/dev)
      end
      for j = 1, num do
        local dx, dy = wall.start.x, wall.start.y
        if wall.dir == "right" then
          dx = (dx + dev*j) - (dev/2)
        elseif wall.dir == "down" then
          dy = (dy + dev*j) - (dev/2)
        end
        local plug = Plug(dx * Tilesize, dy * Tilesize, wall.inside, roomName)
        table.insert(self.plugs, plug)
        count = count +1
        if plug.on then
          onCount = onCount + 1
        end
      end
    end
    self.rooms[roomName] = {}
    self.rooms[roomName].count = count
    self.rooms[roomName].on = onCount
    table.insert (self.rooms, room)
  end
end


function PlugMaker:update(dt)
  local plugCheck = {}
  for i, v in pairs(self.plugs) do
    v:update(dt)
    if not plugCheck[v.roomName] then
      plugCheck[v.roomName] = {on = 0, off = 0}
    end
    if v.on then
      plugCheck[v.roomName].on = plugCheck[v.roomName].on + 1
    else
      plugCheck[v.roomName].off = plugCheck[v.roomName].off + 1
    end
  end
  for i, v in pairs(plugCheck) do
    if v.on > v.off then
      Rooms[i].lightsOn = false
      -- print (BrakerBox.switches[i].on)
      BrakerBox.switches[i].lightOn = false
    end
  end

end


function PlugMaker:draw()
  for i, v in pairs(self.plugs) do
    v:draw()
  end
end

function PlugMaker:delete()
  for i,v in ipairs(self.plugs) do
    world:remove(v)
  end
end
function Plug:new(x,y, insideDir, roomName)
  local offset = 5
  if insideDir == "right" then
    x = x + offset
  elseif insideDir == "left" then
    x = x - offset - 16
  elseif insideDir == "up" then
    y = y - offset - 16
  elseif insideDir == "down" then
    y = y + offset
  end
  self.roomName = roomName
  self.x = x
  self.y = y
  self.spriteSheet = love.graphics.newImage("art/power.png")
  self.sparkSheet = love.graphics.newImage("art/spark.png")
  local numFramesWide = self.sparkSheet:getWidth() / 32
  self.grid = Anim8.newGrid(32, 32, self.sparkSheet:getWidth(), self.sparkSheet:getHeight(), 0,0,0)
  self.spark= Anim8.newAnimation(self.grid('1-' .. numFramesWide, 1, numFramesWide.. '-1', 1), .125)
  self.on = false
  world:add(self, self.x, self.y, 5, 5)
  local isOn = math.random(PlugStart)
  if isOn == 1 then
    self.on = true
  end
end


function Plug:update(dt)
  self.spark:update(dt)
end


function Plug:draw()
  if self.on then
    self.spark:draw(self.sparkSheet, self.x -10, self.y -10)
    love.graphics.setColor( 1, 0, 0)
  else
    love.graphics.setColor( 0, .5, 0)
  end
  love.graphics.draw(self.spriteSheet,self.x, self.y)
  love.graphics.setColor( 1, 1, 1 )
end

function Plug:interact(isBad)
  if isBad then
    self.on = true
  else
    self.on = false
  end
end