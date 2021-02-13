local make
make = function(x, y)
  local block = {
    x = x,
    y = y,
    w = game.size,
    h = game.size
  }
  block.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(0, 0, 0)
      _with_0.rectangle('fill', self.x, self.y, self.w, self.h)
      return _with_0
    end
  end
  return block
end
return {
  make = make
}
