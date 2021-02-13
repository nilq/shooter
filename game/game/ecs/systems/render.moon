s.render = {'position', 'size', 'sprite'}
s.render.do = (i, position, size, sprite) ->
    r, g, b, a = love.graphics.getColor!
    love.graphics.setColor 1, 0, 0, 1
    love.graphics.rectangle 'fill', position.x, position.y, size.w, size.h
    love.graphics.setColor r, g, b, a
