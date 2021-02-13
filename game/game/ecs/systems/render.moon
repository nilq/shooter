s.render = {'position', 'size', 'sprite'}
s.render.do = (i, position, size, sprite) ->
    with love.graphics
        .setColor 1, 1, 1
        .draw game.sprites.enemy.fucker, position.x, position.y, 0, 1, 1
