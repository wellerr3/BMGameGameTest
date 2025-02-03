CharMaker = Object:extend()

function CharMaker:new()
  local loc = {
    {41,17, "dining"}
    ,{40,6, "bed1"}
    ,{39,30, "garage"}
    ,{43,17, "dining"}
    ,{32,23, "bath1"}
    ,{42,30, "foyer"}
    ,{38,30, "garage"}
    ,{32,4, "bed2"}
    ,{36,4, "bath2"}
  }
  self.chars = {}
  for i = 1, NumGhosts, 1 do
    local bad = Ghost(loc[i][1], loc[i][2], loc[i][3], i)
    table.insert(self.chars, bad)
  end
  HunterGuy = Hunter(32,20,"entry", 0)
  table.insert(self.chars, HunterGuy)
end

function CharMaker:update(dt)
  for i, v in pairs(self.chars) do
    v:update(dt)
  end
end

function CharMaker:draw()
  for i, v in pairs(self.chars) do
    v:draw()
  end
end

function CharMaker:delete()
  for i,v in ipairs(self.chars) do
    world:remove(v)
  end
end