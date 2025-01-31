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


function love.load()
  Anim8 = require "lib/anim8"
  Object = require "lib/classic"
  Sti = require "lib/sti"
  bump = require "lib/bump"
  require "face"
  require "brakerBox"
  require "map"
  require "hand"

  world = bump.newWorld(128)
  Mouse = {x = 0,y = 0}
  success = love.window.setMode( 1600, 1200 )

  love.graphics.setDefaultFilter("nearest", "nearest")
  math.randomseed(os.time())
  Face = Face()
  BrakerBox = BrakerBox()
  GameMap = Map()
  Hand = Hand()

end

function love.update(dt)
  Face:update(dt)
  BrakerBox:update(dt)
  GameMap:update(dt)
  Hand:update(dt)
end

function love.draw()
  GameMap:draw()
  Face:draw()
  BrakerBox:draw()
  Hand:draw()
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



function Click(x,y)


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