GameScene = Object:extend()

function GameScene:new(level)
  GameMap = Map()
  Hand = Hand()
  BrakerBox = BrakerBox()
  self:genObjs(level)
end

function GameScene:genObjs(level)
  self.level = level
  self.name = "gameScene"
  Chars = CharMaker()
  Plugs = PlugMaker()
end

function GameScene:destroyObjs()
  Chars:delete()
  Plugs:delete()
end
function GameScene:update(dt)
  -- Face:update(dt)
  BrakerBox:update(dt)
  GameMap:update(dt)
  Hand:update(dt)
  Chars:update(dt)
  Plugs:update(dt)
end

function GameScene:draw()
  GameMap:draw()
  -- Face:draw()
  BrakerBox:draw()
  Hand:draw()
  Chars:draw()
  Plugs:draw()
  if Test == true then
    DrawRects()
  end
end


function GameScene:mousepressed(x, y, button, istouch)
  if button == 1 then
    Hand:click()
  end
end

function GameScene:keypressed(key)
  if key == "escape" then
		CurrScene = "pause"
	end
  if key == "space" then
		HunterGuy:Query()
	end
end
