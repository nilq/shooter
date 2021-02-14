path = ''
export e, c, s = unpack require path .. 'libs/ecs'

love.graphics.setBackgroundColor 1, 1, 1
love.graphics.setDefaultFilter 'nearest', 'nearest'

require path..'game/ecs/components'
require path..'game/ecs/entities/enemy'
require path..'game/ecs/systems/render'
require path..'game/ecs/systems/enemy'

state = require path .. 'state'

export game = require path .. 'game'
export bump = require path .. 'libs/bump'

love.graphics = require path .. 'libs/autobatch'

with math
    .lerp = (a, b, t) -> a + (b - a) * t
    .sign = (a)       ->
        if a < 0
          -1
        else if a > 1
          1
        else
          0

dt_ = 0

with love
    .load = ->
        state\change game

    .update = (dt) ->
        state\update dt
        dt_ = dt

    .draw = ->
        state\draw!
        with love.graphics
            .setColor 0, 0, 0
            .print love.timer.getFPS!, 10, 10
            .print dt_, 10, 30

    .keypressed = (key) ->
        state\keypressed key

    .mousepressed = (x, y, button) ->
        state\mousepressed x, y, button

    .mousemoved = (x, y) ->
        state\mousemoved x, y
