local path = 'game/'
local mapper = require(path .. 'map')
local camera = require(path .. 'camera')
local game = {
  x = 0,
  y = 0,
  size = 10,
  map = { },
  config = {
    width = love.graphics.getWidth() / 10,
    height = love.graphics.getHeight() / 10,
    floor = 0.1,
    spin = 1
  },
  camera = camera.make(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 1, 1, 0),
  world = { }
}
game.load = function(self)
  love.graphics.setBackgroundColor(0.5, 0.8, 0.4)
  self.map = mapper.automata((mapper.gen(self.config)), self.config)
  self.world = bump.newWorld(64, 64)
end
game.update = function(self, dt) end
game.draw = function(self)
  self.camera:set()
  do
    local _with_0 = love.graphics
    for x = 0, #self.map do
      for y = 0, #self.map[0] do
        if self.map[x][y] == 0 then
          _with_0.setColor(0.5, 1, 0.6)
          _with_0.rectangle('fill', x * self.size, y * self.size, self.size, self.size)
        end
        if self.map[x][y] == 2 then
          _with_0.setColor(0.4, 0.7, 0.3)
          _with_0.rectangle('fill', x * self.size, y * self.size, self.size, self.size)
        end
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
    self.map = mapper.automata((mapper.gen(self.config)), self.config)
  end
end
game.mouse_moved = function(self, x, y)
  self.x = x
  self.y = y
end
game.mouse_press = function(self, mouse, x, y)
  self.scale = 2
end
return game
