BrakerBox = Object:extend()
Switch = Object:extend()


function BrakerBox:new()
  self.x = 300
  self.y = 300
  self.spriteSheet = love.graphics.newImage("art/breakerBox.png")
  self.switches = {}
  local number = 1
  local switchLoc = {x = self.x + 112,y = self.y + 64}
  for i,v in pairs(LightsOn) do
    local switch = Switch(switchLoc, i)
    table.insert(self.switches, switch)
    number = number + 1
    switchLoc.x = switchLoc.x + 128
    if number > 2 then
      switchLoc.y = switchLoc.y + 96
      switchLoc.x = self.x + 112
      number = 1
    end
  end
end


function BrakerBox:update(dt)
  for i in ipairs(self.switches) do
    self.switches[i]:update(dt)
  end
end


function BrakerBox:draw()
  love.graphics.draw( self.spriteSheet, self.x, self.y)
  for i,switch in ipairs(self.switches) do
    switch:draw(switch.spriteSheet, switch.x, switch.y)
  end
end

function BrakerBox:click()
  
end

function Switch:new(switchLoc, name)
  self.name = name
  self.spriteSheet = love.graphics.newImage("art/bigSwitch2.png")
  -- self.grid = love.graphics.newQuad( 0, 0, self.spriteSheet:getWidth(), self.spriteSheet:getHeight(), self.spriteSheet)
  -- self.grid = Anim8.newGrid(32, 32, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
  self.img = {}
  self.img.off = love.graphics.newQuad( 0, 0, 64, 64, self.spriteSheet)
  self.img.on = love.graphics.newQuad( 64, 0, 64, 64, self.spriteSheet)
  self.x = switchLoc.x
  self.y = switchLoc.y
  self.text = self.name
  self.mode = "off"
  world:add(self, self.x, self.y, 64, 64)
end

function Switch:update()
end

function Switch:draw()
  love.graphics.draw(self.spriteSheet, self.img[self.mode], self.x, self.y)
  -- love.graphics.print(self.name, self.x - 16, self.y)
end

function Switch:click()
  LightsOn[self.name] = not LightsOn[self.name]
  if self.mode == "off" then
    self.mode = "on"
  else
    self.mode = "off"
  end
end
