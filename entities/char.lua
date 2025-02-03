Char = Object:extend()

function Char:new(x,y, room, name, img)
  x = x or 32
  y = y or 20
  self.room = room or ''
  self.name = name
  self.x = x * Tilesize
  self.y = y * Tilesize
  self.spriteSheet = love.graphics.newImage(img)
  local numFramesWide = self.spriteSheet:getWidth() / 32
  self.grid = Anim8.newGrid(32, 32, self.spriteSheet:getWidth(), self.spriteSheet:getHeight(), 0,0,0)
  self.img= Anim8.newAnimation(self.grid('1-' .. numFramesWide, 1, numFramesWide.. '-1', 1), .125)
  self.timer = 0
  self.speed = 5
  self.dir = 1
  self.moving = true
  self.properties = {}
  world:add(self, self.x, self.y, 32, 32)
end


function Char:update(dt)
  self.img:update(dt)
end


function Char:draw()
  self.img:draw(self.spriteSheet, self.x, self.y)
end

function Char:getMove(px,py)
  local goalX, goalY, cols, len = world:check(self, px , py)
  if len == 0 then
    self:checkRoom(px, py)
    self.x, self.y = px, py
    world:move(self, self.x, self.y)
  end
end

function Char:checkRoom(px, py)
  local imp, notImp, greater
  if Dirs[self.dir] == "up" or Dirs[self.dir] == "down" then
    imp = py
    notImp = px
  else
    imp = px
    notImp = py
  end
  if Dirs[self.dir] == "right" or Dirs[self.dir] == "down" then
    greater = true
  else
    greater = false
  end
  local roomExit = Rooms[self.room][Dirs[self.dir]]

  if roomExit then
    if greaterOrLess(greater, imp, roomExit) then
      -- print ("in matching",  self.room, Dirs[self.dir], Rooms[self.room].adjacent[Dirs[self.dir]])
      if type(Rooms[self.room].adjacent[Dirs[self.dir]]) == "string" then
        self.room = Rooms[self.room].adjacent[Dirs[self.dir]]
      else
        if Rooms[self.room].adjacent[Dirs[self.dir]].loc > notImp then
          if Dirs[self.dir] == "right" or Dirs[self.dir] == "left" then
            self.room = Rooms[self.room].adjacent[Dirs[self.dir]].up
          else
            self.room = Rooms[self.room].adjacent[Dirs[self.dir]].left
          end
        elseif Dirs[self.dir] == "right" or Dirs[self.dir] == "left" then
          self.room = Rooms[self.room].adjacent[Dirs[self.dir]].down
        else
          self.room = Rooms[self.room].adjacent[Dirs[self.dir]].right
        end
      end
    end
  end
end

function greaterOrLess(greater, v1, v2)
  local boo = v1 > v2
  if greater then
    return boo
  else
    return not boo
  end
end

function Char:manual()
  local speed = self.speed
  local vx, vy = 0, 0
  if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
    vy =  speed
    self.dir = 4
  elseif love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    vy = - speed
    self.dir = 3
  end
  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    self.dir = 2
    vx = - speed
  elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    self.dir = 1
    vx = speed
  end
  vx = vx + self.x
  vy = vy + self.y
  return vx, vy
end