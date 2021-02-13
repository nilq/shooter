s.render = {'position', 'size', 'sprite'}
s.render.do = (i, position, size, sprite) ->
    love.graphics.rectangle 'fill', position.x, position.y, size.w, size.h
