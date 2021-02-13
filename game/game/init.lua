local path = 'game/'
local mapper = require(path .. 'map')
local camera = require(path .. 'camera')
local block = require(path .. 'block')
local entities = require(path .. 'entities')
local game = {
  x = 0,
  y = 0,
  start_x = 0,
  start_y = 0,
  size = 32,
  map = { },
  objects = { },
  config = {
    width = love.graphics.getWidth() / 10,
    height = love.graphics.getHeight() / 10,
    floor = 0.1,
    spin = 1
  },
  camera = camera.make(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 1 / 3.2, 1 / 3.2, 0),
  world = { }
}
game.load = function(self)
  love.graphics.setBackgroundColor(0.5, 0.8, 0.4)
  self.world = bump.newWorld(64, 64)
  return self:new_level()
end
game.new_level = function(self)
  local player = entities.player.make(self.config.width / 2 * game.size, self.config.height / 2 * game.size)
  self.world:add(player, player.x, player.y, 16, 16)
  self:spawn(player)
  self.map = mapper.automata((mapper.gen(self.config)), self.config)
  for x = 0, #self.map do
    for y = 0, #self.map[0] do
      local _exp_0 = self.map[x][y]
      if 2 == _exp_0 then
        local b = block.make(x * self.size, y * self.size, self.size, self.size)
        self.world:add(b, b.x, b.y, b.w, b.h)
        self:spawn(b)
      end
    end
  end
end
game.spawn = function(self, obj)
  return table.insert(self.objects, obj)
end
game.update = function(self, dt)
  local _list_0 = self.objects
  for _index_0 = 1, #_list_0 do
    local obj = _list_0[_index_0]
    if obj.update then
      obj:update(dt)
    end
  end
end
game.draw = function(self)
  self.camera:set()
  do
    local _with_0 = love.graphics
    local _list_0 = self.objects
    for _index_0 = 1, #_list_0 do
      local obj = _list_0[_index_0]
      if obj.draw then
        obj:draw()
      end
    end
    _with_0.setColor(0, 0, 0)
    _with_0.rectangle('fill', self.x - 2.5, self.y - 2.5, 5, 5)
  end
  return self.camera:unset()
end
game.key_press = function(self, key)
  local _exp_0 = key
  if 'space' == _exp_0 then
    self.objects = { }
    self.world = bump.newWorld(64, 64)
    self:new_level()
    collectgarbage("count")
  end
  local _list_0 = self.objects
  for _index_0 = 1, #_list_0 do
    local obj = _list_0[_index_0]
    if obj.key_press then
      obj:key_press(key)
    end
  end
end
game.mouse_moved = function(self, x, y)
  self.x = x / self.camera.sx
  self.y = y / self.camera.sy
end
game.mouse_press = function(self, mouse, x, y)
  self.scale = 2
end
return game
