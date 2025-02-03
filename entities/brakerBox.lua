BrakerBox = Object:extend()
Switch = Object:extend()
SmallBreaker = Object:extend()

function BrakerBox:new()
  self.x = 300
  self.y = 300
  self.spriteSheet = love.graphics.newImage("art/breakerBox.png")
  self.switches = {}
  self.smallBreaker = SmallBreaker()
  self.light = love.graphics.newImage("art/BBLight.png")
  self.timer = 0
  local number = 1
  local switchLoc = {x = self.x + 112,y = self.y + 64}
  for i,v in pairs(Rooms) do
    local switch = Switch(switchLoc, i)
    self.switches[i] = switch
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
  for i, v in pairs(self.switches) do
    v:update(dt)
  end
  if self.smallBreaker.timer > 0 then
    self.smallBreaker.timer = self.smallBreaker.timer - 1
  end
  if self.smallBreaker.timer == 0  and self.smallBreaker.avalable == true then
    local goalX, goalY, cols, len = world:check(self.smallBreaker, self.smallBreaker.x - 32, self.smallBreaker.y)
    if len == 0  then
      self.smallBreaker.avalable = false
    end
  end
end


function BrakerBox:draw()
  love.graphics.draw( self.spriteSheet, self.x, self.y)
  for i, switch in pairs(self.switches) do
    switch:draw(switch.spriteSheet, switch.x, switch.y)
  end
  if self.smallBreaker.avalable == true and (self.smallBreaker.timer == 0 or (self.smallBreaker.timer % 2 == 0 and self.smallBreaker.timer % 5 == 0)) then
    love.graphics.draw(self.light, self.x - 32, self.y - 128)
  end
end

function BrakerBox:click()
  
end

function SmallBreaker:new()
  self.avalable = false
  self.x = 1208
  self.y = 534
  self.timer = 0
  self.width = 3
  self.height = 21
  world:add(self, self.x, self.y, self.width, self.height)
end

function SmallBreaker:interact()
  self.avalable = true
  self.timer = 100
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
  self.lightOn = false
  world:add(self, self.x, self.y, 64, 64)
end

function Switch:update()
    Rooms[self.name].lightsOn = self.lightOn
end

function Switch:draw()
  if self.lightOn then
    love.graphics.draw(self.spriteSheet, self.img.on, self.x, self.y)
  else
    love.graphics.draw(self.spriteSheet, self.img.off, self.x, self.y)
  end
  
  -- love.graphics.print(self.name, self.x - 16, self.y)
end

function Switch:click()
  if self.lightOn == false then
    self.lightOn = true
    CheckIfAllOn()
  else
    self.lightOn = false
  end
end

function CheckIfAllOn()
  local allOn = true
  for i, v in pairs(BrakerBox.switches) do
    if v.lightOn == false then
      allOn = false
    end
  end
  if allOn then
    CurrScene = 'levelEnd'
    -- win screen
  end
end