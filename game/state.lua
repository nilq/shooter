local state = {
  current = { }
}
state.change = function(self, a)
  self.current = a
  return a:load()
end
state.update = function(self, dt)
  return self.current:update(dt)
end
state.draw = function(self)
  return self.current:draw()
end
state.keypressed = function(self, key)
  return self.current:key_press(key)
end
state.mousemoved = function(self, x, y)
  return self.current:mouse_moved(x, y)
end
state.mousepressed = function(self, mouse, x, y)
  return self.current:mouse_press(mouse, x, y)
end
return state
