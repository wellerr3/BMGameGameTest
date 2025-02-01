if arg[2] == 'debug' then
  require('lldebugger').start()
end
-- io.stdout:setvbuf('no')
-- starter

Tilesize = 32
Rooms = {
  entry = {
    lightsOn = false,
    up = 32 * Tilesize,
    down = nil,
    right = 38 * Tilesize,
    left = nil,
    adjacent = {
      up = "living",
      right = "kitchen"
    }
  },
  bath1 = {
    lightsOn = false,
    up = nil,
    down = nil,
    right = 34 * Tilesize,
    left = nil,
    adjacent = {
      right = "entry"
    }
  },
  bath2 = {
    lightsOn = false,
    up = nil,
    down = 9 * Tilesize,
    right = nil,
    left = nil,
    adjacent = {
      down = "bed2"
    }
  },
  bed2 = {
    lightsOn = false,
    up = 9 * Tilesize,
    down = 12 * Tilesize,
    right = nil,
    left = nil,
    adjacent = {
      down = "living",
      up = "bath2"
    }
  },
  bed1 = {
    lightsOn = false,
    up = nil,
    down = 12 * Tilesize,
    right = nil,
    left = nil,
    adjacent = {
      down = "living"
    }
  },
  living = {
    lightsOn = false,
    up = 12 * Tilesize,
    down = 16 * Tilesize,
    right = nil,
    left = nil,
    adjacent = {
      up = {
        loc = 38 * Tilesize,
        right = "bed1",
        left = "bed2"
      },
      down = "kitchen"
    }
  },
  dining = {
    lightsOn = false,
    up = 16 * Tilesize,
    down = 20 * Tilesize,
    right = nil,
    left = nil,
    adjacent = {
      up = "living",
      down = "kitchen"
    }
  },
  kitchen = {
    lightsOn = false,
    up = 20 * Tilesize,
    down = 25 * Tilesize,
    right = 38 * Tilesize,
    left = nil,
    adjacent = {
      up = "kitchen",
      down = {
        loc = 41 * Tilesize,
        right = "foyer",
        left = "garage"
      },
    }
  },
  garage = {
    lightsOn = false,
    up = 25 * Tilesize,
    down = nil,
    right = nil,
    left = nil,
    adjacent = {
      up = "kitchen"
    }
  },
  foyer = {
    lightsOn = false,
    up = 25 * Tilesize,
    down = nil,
    right = nil,
    left = nil,
    adjacent = {
      up = "kitchen"
    }
  }
}


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