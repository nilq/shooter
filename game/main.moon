path = ''
export e, c, s = unpack require path .. 'libs/ecs'

require path..'game/ecs/components'
require path..'game/ecs/entities/enemy'
require path..'game/ecs/systems/render'

state = require path .. 'state'

export game = require path .. 'game'
export bump = require path .. 'libs/bump'

with math
    .lerp = (a, b, t) -> a + (b - a) * t
    .sign = (a)       ->
        if a < 0
          -1
        else if a > 1
          1
        else
          0

with love
    .load = ->
        state\change game

    .update = (dt) ->
        state\update dt

    .draw = ->
        state\draw!

    .keypressed = (key) ->
        state\keypressed key

    .mousepressed = (x, y) ->
        state\mousepressed x, y

    .mousemoved = (x, y) ->
        state\mousemoved x, y
