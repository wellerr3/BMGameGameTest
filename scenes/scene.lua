Scene = Object:extend()
StartScene = Object:extend()
PauseMenu = Object:extend()
LevelEnd = Object:extend()

function Scene:new(level)
  self.start = StartScene()
  self.game = GameScene(level)
  self.pause = PauseMenu()
  self.levelEnd = LevelEnd()
end


function PauseMenu:new()
  self.name = "pauseMenu"
  local offset = 100
  self.width =  love.graphics.getWidth() - (offset * 2)
  self.height = love.graphics.getHeight() - (offset * 2)
  self.x = offset
  self.y = offset
  self.textObj = love.graphics.newText(Font)
  self.menuSelect = 1
  self.menu = {
    "unPause", "exit"
  }
  self.text = self.menu[self.menuSelect]
  self.textBoxX = (love.graphics.getWidth() / 2) - 150
  self.textBoxY = (love.graphics.getHeight() / 2)
  self.menuLocY = {
    self.textBoxY-100, self.textBoxY, self.textBoxY + 100
  }
end


function PauseMenu:update(dt)
  self.text = self.menu[self.menuSelect]
end


function PauseMenu:draw()
  love.graphics.push("all")
    love.graphics.setColor(0,0,.25, 1)
    love.graphics.rectangle( "fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle( "fill", self.textBoxX + 50 - 100, self.menuLocY[self.menuSelect] - 25, 400, 80)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf( self.menu[1], Font, self.textBoxX, self.menuLocY[1], 300, "center")
    love.graphics.printf( self.menu[2], Font, self.textBoxX, self.menuLocY[2], 300, "center")
    -- love.graphics.printf( self.text2, 1, 100, align ("center") )
    -- love.graphics.draw( self.text, love.get, 15)
  love.graphics.pop()
end

function PauseMenu:keypressed(key)
  if key == "down" or key == "s"  then
    self.menuSelect = ((self.menuSelect) % #self.menu) + 1
  end
  if key == "up" or key == "w"  then
    self.menuSelect = self.menuSelect - 2
    self.menuSelect = ((self.menuSelect) % #self.menu) + 1
  end
  if key == "space" then
    self:enter(self.menu[self.menuSelect])
  end
end

function PauseMenu:TextUpdate(text)
  local textObj = love.graphics.newText(Font)
  textObj:add( {{1,1,1}, text}, 0, 0)
  return textObj
end

function PauseMenu:enter(mode)
  if mode == 'unPause' then
    CurrScene = "game"
  elseif mode == "exit" then
    love.event.quit()
  end
end

function PauseMenu:mousepressed(x, y, button, istouch)
  if button == 1 then
    Hand:click()
  end
end




function StartScene:new()
  self.name = "StartScene"
  local offset = 100
  self.width =  love.graphics.getWidth() - (offset * 2)
  self.height = love.graphics.getHeight() - (offset * 2)
  self.x = offset
  self.y = offset
  self.textObj = love.graphics.newText(Font3)
  self.text = "Light 'um Up"
  self.text2 = "If all the lights are on the ghosts disapear but The Ghosts are overloading the circuit! Turn on all the breakers without the circuits overloading to win"
  self.textBoxX = (love.graphics.getWidth() / 2) - 300
  self.textBoxY = (love.graphics.getHeight() / 2)
  self.light = love.graphics.newImage("art/BBLight.png")
  self.ltRotation = -.5
  self.dif = .01
end


function StartScene:update(dt)
  self.ltRotation = self.ltRotation + self.dif
  if self.ltRotation > .5 or self.ltRotation < -.6 then
    self.dif = - self.dif
  end

end


function StartScene:draw()
  love.graphics.push("all")
    love.graphics.setColor(.5,.25,0, 1)
    love.graphics.rectangle( "fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle( "fill", self.textBoxX + 50, 0, 200, 75)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf( self.text, Font3, self.textBoxX, self.height/2 - 200, 600, "center")
    love.graphics.printf( self.text2, Font2, self.textBoxX, self.height/2 + 200, 600, "center")
    -- love.graphics.printf( self.text2, 1, 100, align ("center") )
    -- love.graphics.draw( self.text, love.get, 15)
  love.graphics.pop()
  love.graphics.draw(self.light, self.width/2 + self.light:getWidth()/2, 150, self.ltRotation, nil, nil, self.light:getWidth()/2)
  

end

function StartScene:keypressed(key)
  CurrScene = "game"
end

function StartScene:mousepressed(x, y, button, istouch)
  CurrScene = "game"
end


function LevelEnd:new()
  self.name = "LevelEnd"
  local offset = 100
  self.width =  love.graphics.getWidth() - (offset * 2)
  self.height = love.graphics.getHeight() - (offset * 2)
  self.x = offset
  self.y = offset
  self.textObj = love.graphics.newText(Font)
  self.text = "You Did it!"
  self.textBoxX = (love.graphics.getWidth() / 2) - 150
  self.textBoxY = (love.graphics.getHeight() / 2)

end


function LevelEnd:update(dt)
  self.text = self.text

end


function LevelEnd:draw()
  love.graphics.push("all")
    love.graphics.setColor(.5,.25,0, 1)
    love.graphics.rectangle( "fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle( "fill", self.textBoxX + 50, 0, 200, 75)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf( self.text, Font3, self.textBoxX, self.height/2, 300, "center")
    love.graphics.printf( "now for something a bit harder", Font2, self.textBoxX, (self.height/2) + 200, 300, "center")
    -- love.graphics.printf( self.text2, 1, 100, align ("center") )
    -- love.graphics.draw( self.text, love.get, 15)
  love.graphics.pop()
end

function LevelEnd:keypressed(key)
  self:mousepressed()
  -- ChangeDifficulty()
  -- local game2 = Scene.game:genObjs(2)
  -- print ('2')
  -- CurrScene = "game"
end

function LevelEnd:mousepressed(x, y, button, istouch)
  ChangeDifficulty()
  Scene.game:destroyObjs()
  for key, value in pairs(BrakerBox.switches) do
    value.lightOn = false
    Rooms[key].lightsOn = false
  end
  local game2 = Scene.game:genObjs(2)
  CurrScene = "game"
end

