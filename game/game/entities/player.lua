local make
make = function(x, y)
  local player = {
    x = x,
    y = y,
    dx = 0,
    dy = 0,
    speed = 10,
    friction = 4,
    controls = {
      up = ',',
      down = 'o',
      left = 'a',
      right = 'e'
    }
  }
  do
    local _with_0 = player
    _with_0.update = function(self, dt)
      if love.keyboard.isDown(self.controls.left) then
        local dx = dx - (self.speed * dt)
      end
      if love.keyboard.isDown(self.controls.right) then
        local dx = dx + (self.speed * dt)
      end
      if love.keyboard.isDown(self.controls.up) then
        local dy = dy - (self.speed * dt)
      end
      if love.keyboard.isDown(self.controls.down) then
        local dy = dy + (self.speed * dt)
      end
      self.x, self.y, self.collisions = game.world:move(self, self.x + self.dx, self.y + self.dy)
    end
    return _with_0
  end
end
return {
  make = make
}
