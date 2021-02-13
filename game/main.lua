local path = ''
local state = require(path .. 'state')
game = require(path .. 'game')
bump = require(path .. 'libs/bump')
do
  local _with_0 = math
  _with_0.lerp = function(a, b, t)
    return a + (b - a) * t
  end
  _with_0.sign = function(a)
    if a < 0 then
      return -1
    else
      if a > 1 then
        return 1
      else
        return 0
      end
    end
  end
end
do
  local _with_0 = love
  _with_0.load = function()
    return state:change(game)
  end
  _with_0.update = function(dt)
    return state:update(dt)
  end
  _with_0.draw = function()
    return state:draw()
  end
  _with_0.keypressed = function(key)
    return state:keypressed(key)
  end
  _with_0.mousepressed = function(x, y)
    return state:mousepressed(x, y)
  end
  _with_0.mousemoved = function(x, y)
    return state:mousemoved(x, y)
  end
  return _with_0
end
