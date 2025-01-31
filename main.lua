if arg[2] == 'debug' then
  require('lldebugger').start()
end
-- io.stdout:setvbuf('no')
-- starter

LightsOn = {
  entry = false,
  bath1 = false,
  bath2 = false,
  bed2 = false,
  bed1 = false,
  living = false,
  dining = false,
  kitchen = false,
  garage = false,
  foyer = false
}


Tilesize = 32
TestRect = {x= 0, y= 0,w= 22, h=22}
Test = false

Dirs = {"right", "left", "up", "down"}

function love.load()
  Anim8 = require "lib/anim8"
  Object = require "lib/classic"
  Sti = require "lib/sti"
  bump = require "lib/bump"
  require "entities/face"
  require "entities/brakerBox"
  require "map/map"
  require "entities/hand"
  require "entities/wanderer"

  world = bump.newWorld(128)
  Mouse = {x = 0,y = 0}
  success = love.window.setMode( 1600, 1200 )

  love.graphics.setDefaultFilter("nearest", "nearest")
  math.randomseed(os.time())
  Face = Face()
  BrakerBox = BrakerBox()
  GameMap = Map()
  Hand = Hand()
  Baddies = BaddieMaker()

  

end

function love.update(dt)
  Face:update(dt)
  BrakerBox:update(dt)
  GameMap:update(dt)
  Hand:update(dt)
  Baddies:update(dt)

end

function love.draw()
  GameMap:draw()
  Face:draw()
  BrakerBox:draw()
  Hand:draw()
  Baddies:draw()
  if Test == true then
    DrawRects()
  end
end

function love.mousemoved( x, y, dx, dy, istouch )
  Mouse.x = x
  Mouse.y = y
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    Hand:click()
  end
end

function love.keypressed(key)
  if key == "escape" then
		love.event.quit()
	end
end


function DrawRects()
  love.graphics.rectangle("fill", TestRect.x, TestRect.y, TestRect.w, TestRect.h)

    local items, len = world:getItems()
    for i = 1, len do
      local x, y, w, h = world:getRect(items[i])
      love.graphics.setColor(1,0,1,.5)
      love.graphics.rectangle("fill", x, y, w, h)
      love.graphics.setColor(1,1,1,1)
    end
end



-- error handler
local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
  if lldebugger then
    error(msg, 2)
  else
    return love_errorhandler(msg)
  end
end