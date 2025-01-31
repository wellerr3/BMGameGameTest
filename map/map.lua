
Map = Object:extend()


function Map:new()
  local housePlan = Sti('map/BMgameJam.lua', {'bump'})
  self.x = 100
  self.y = 100
  self.map = housePlan
  self.map:bump_init(world)
end


function Map:update(dt)
  self.map:update(dt)
end


function Map:draw()
  for i, layer in ipairs(self.map.layers) do
    if layer.name == "off" or layer.name == "walls" then
      self.map:drawLayer(layer)
    end
    if LightsOn[layer.name] then
      self.map:drawLayer(layer)
    end
  end
end

-- function Map:new(map, key)
--   self.map = map
--   self.width = self.map.width
--   self.height = self.map.height
--   self.tilewidth = self.map.tilewidth
--   self.tileheight = self.map.tileheight
--   self.above, self.below = self:findOrder()
--   ObjectSet[key] = Objects(key, map.objects)
-- end

-- function Map:update(dt)
--   self.map:update(dt)
-- end

-- function Map:draw(tx, ty, sx, sy)
--   self.map:draw(tx, ty, sx, sy)
-- end
-- function Map:drawLayer(layer)
--   self.map:drawLayer(layer)
-- end
