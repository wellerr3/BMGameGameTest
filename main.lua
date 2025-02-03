if arg[2] == 'debug' then
  require('lldebugger').start()
end
-- io.stdout:setvbuf('no')
-- starter

Tilesize = 32
DifPlugs = 3
PlugStart = 20
NumGhosts = 1
Rooms = {
  entry = {
    walls = {
      {
        length = 6,
        dir = "down",
        inside = "right",
        start = {
          x = 31,
          y = 16}
      },
      {
        length = 4,
        dir = "down",
        inside = "left",
        start = {
          x = 38,
          y = 18}
      },
      { 
        length = 4,
        dir = "right",
        inside = "up",
        start = {
          x = 34,
          y = 25
        }
      }
    },
    lightsOn = false,
    up = 18 * Tilesize,
    down = nil,
    right = 38 * Tilesize,
    left = 34 * Tilesize,
    adjacent = {
      up = "living",
      right = "kitchen",
      left = {
        loc = 22 * Tilesize,
        down = "bath1",
        up = "entry"
      }
    }
  },
  bath1 = {
    walls = {
      {
        length = 3,
        dir = "down",
        inside = "right",
        start = {
          x = 31,
          y = 22}
      },
      {
        length = 3,
        dir = "right",
        inside = "down",
        start = {
          x = 31,
          y = 22}
      },
      { 
        length = 3,
        dir = "right",
        inside = "up",
        start = {
          x = 31,
          y = 25
        }
      }
    },
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
    walls = {
      {
        length = 4,
        dir = "down",
        inside = "right",
        start = {
          x = 35,
          y = 3}
      },
      {
        length = 3,
        dir = "right",
        inside = "down",
        start = {
          x = 35,
          y = 3}
      },
      { 
        length = 4,
        dir = "down",
        inside = "left",
        start = {
          x = 38,
          y = 3
        }
      }
    },
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
    walls = {
      {
        length = 7,
        dir = "down",
        inside = "right",
        start = {
          x = 31,
          y = 3}
      },
      {
        length = 4,
        dir = "right",
        inside = "up",
        start = {
          x = 34,
          y = 10}
      },
      { 
        length = 4,
        dir = "down",
        inside = "left",
        start = {
          x = 35,
          y = 3
        }
      },
      {
        length = 3,
        dir = "down",
        inside = "left",
        start = {
          x = 38,
          y = 7
        }
      },
      {
        length = 4,
        dir = "right",
        inside = "up",
        start = {
          x = 34,
          y = 10
        }
      }
    },
    lightsOn = false,
    up = 9 * Tilesize,
    down = 12 * Tilesize,
    right = nil,
    left = nil,
    adjacent = {
      down = "living",
      up = {
        loc = 35 * Tilesize,
        left = "bed2",
        right = "bath2"
      }
    }
  },
  bed1 = {
    walls = {
      {
        length = 7,
        dir = "down",
        inside = "right",
        start = {
          x = 38,
          y = 3}
      },
      {
        length = 6,
        dir = "right",
        inside = "down",
        start = {
          x = 38,
          y = 3}
      },
      { 
        length = 7,
        dir = "down",
        inside = "left",
        start = {
          x = 44,
          y = 3
        }
      },
      {
        length = 3,
        dir = "right",
        inside = "up",
        start = {
          x = 38,
          y = 10
        }
      }
    },
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
    walls = {
      {
        length = 6,
        dir = "down",
        inside = "right",
        start = {
          x = 31,
          y = 10}
      },
      {
        length = 7,
        dir = "right",
        inside = "down",
        start = {
          x = 34,
          y = 10}
      },
      { 
        length = 6,
        dir = "down",
        inside = "left",
        start = {
          x = 44,
          y = 10
        }
      },
      {
        length = 7,
        dir = "right",
        inside = "up",
        start = {
          x = 34,
          y = 16
        }
      }
    },
    lightsOn = false,
    up = 10 * Tilesize,
    down = 16 * Tilesize,
    right = nil,
    left = nil,
    adjacent = {
      up = {
        loc = 38 * Tilesize,
        right = "bed1",
        left = "bed2"
      },
      down = {
        loc = 38 * Tilesize,
        right = "dining",
        left = "entry"
      },
    }
  },
  dining = {
    walls = {
      {
        length = 4,
        dir = "down",
        inside = "right",
        start = {
          x = 38,
          y = 16}
      },
      {
        length = 4,
        dir = "down",
        inside = "left",
        start = {
          x = 44,
          y = 16}
      },
    },
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
    walls = {
      {
        length = 2,
        dir = "down",
        inside = "right",
        start = {
          x = 38,
          y = 20}
      },
      {
        length = 2,
        dir = "right",
        inside = "down",
        start = {
          x = 38,
          y = 20}
      },
      { 
        length = 5,
        dir = "down",
        inside = "left",
        start = {
          x = 44,
          y = 20
        }
      }
    },
    lightsOn = false,
    up = 20 * Tilesize,
    down = 25 * Tilesize,
    right = nil,
    left = 38 * Tilesize,
    adjacent = {
      up = "dining",
      left = "entry",
      down = {
        loc = 41 * Tilesize,
        right = "foyer",
        left = "garage"
      }
    }
  },
  garage = {
    walls = {
      {
        length = 3,
        dir = "right",
        inside = "down",
        start = {
          x = 35,
          y = 25}
      },
      {
        length = 7,
        dir = "down",
        inside = "left",
        start = {
          x = 41,
          y = 25}
      },
      { 
        length = 7,
        dir = "right",
        inside = "up",
        start = {
          x = 35,
          y = 32
        }
      }
    },
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
    walls = {
      {
        length = 7,
        dir = "down",
        inside = "right",
        start = {
          x = 41,
          y = 25}
      },
      {
        length = 3,
        dir = "right",
        inside = "up",
        start = {
          x = 41,
          y = 32}
      },
      { 
        length = 7,
        dir = "down",
        inside = "left",
        start = {
          x = 44,
          y = 25
        }
      }
    },
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
Test = true

Dirs = {"right", "left", "up", "down"}
CurrScene = 'start'

function ChangeDifficulty()
  if PlugStart > 5 then
    PlugStart = PlugStart - 5
  else
    PlugStart = 2
  end
  NumGhosts = NumGhosts + 1
end

function love.load()
  Anim8 = require "lib/anim8"
  Object = require "lib/classic"
  Sti = require "lib/sti"
  bump = require "lib/bump"
  require "entities/face"
  require "entities/brakerBox"
  require "map/map"
  require "entities/hand"
  require "entities/char"
  require "entities/ghost"
  require "entities/hunter"
  require "entities/charMaker"
  require "entities/plug"
  require "scenes/scene"
  require "scenes/gameScene"
  Font = love.graphics.newFont("lib/RasterForgeRegular-JpBgm.ttf", 50)
  Font2 = love.graphics.newFont("lib/RasterForgeRegular-JpBgm.ttf", 25)
  Font3 = love.graphics.newFont("lib/RasterForgeRegular-JpBgm.ttf", 75)
  world = bump.newWorld(128)
  Mouse = {x = 0,y = 0}
  success = love.window.setMode( 1600, 1200 )

  love.graphics.setDefaultFilter("nearest", "nearest")
  math.randomseed(os.time())

  Scene = Scene()

end

function love.update(dt)
  Scene[CurrScene]:update(dt)
end

function love.draw()
  Scene[CurrScene]:draw()

end

function love.mousemoved( x, y, dx, dy, istouch )
  Mouse.x = x
  Mouse.y = y
end

function love.mousepressed(x, y, button, istouch)
  Scene[CurrScene]:mousepressed(x, y, button, istouch)
end

function love.keypressed(key)
  Scene[CurrScene]:keypressed(key)
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