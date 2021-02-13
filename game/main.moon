path = ''

state = require path .. 'state'
game  = require path .. 'game'

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