local make
make = function(x, y)
  local player = {
    x = x,
    y = y,
    dx = 0,
    dy = 0,
    speed = 100,
    friction = 10,
    controls = {
      up = ',',
      down = 'o',
      left = 'a',
      right = 'e'
    }
  }
  do
    player.update = function(self, dt)
      local dx = 0
      local dy = 0
      if love.keyboard.isDown(self.controls.left) then
        dx = dx - 1
      end
      if love.keyboard.isDown(self.controls.right) then
        dx = dx + 1
      end
      if love.keyboard.isDown(self.controls.up) then
        dy = dy - 1
      end
      if love.keyboard.isDown(self.controls.down) then
        dy = dy + 1
      end
      local len = (dx ^ 2 + dy ^ 2) ^ 0.5
      if not (len == 0) then
        dx = dx / len
      end
      if not (len == 0) then
        dy = dy / len
      end
      self.dx = self.dx + (dx * self.speed * dt)
      self.dy = self.dy + (dy * self.speed * dt)
      self.x, self.y, self.collisions = game.world:move(self, self.x + self.dx, self.y + self.dy)
      self.dx = math.lerp(self.dx, 0, dt * self.friction)
      self.dy = math.lerp(self.dy, 0, dt * self.friction)
    end
  end
  player.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(1, 1, 0.5)
      _with_0.rectangle('fill', self.x, self.y, 16, 16)
      return _with_0
    end
  end
  return player
end
return {
  make = make
}
