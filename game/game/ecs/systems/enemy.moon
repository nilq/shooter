s.enemy = {'position', 'enemy'}
s.enemy.do = (i, position) ->
    x, y, collisions = game.world\move i, position.x + love.math.random(-5, 5), position.y + love.math.random(-5, 5)
    position.x = x
    position.y = y
