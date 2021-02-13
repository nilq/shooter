path = 'game/'

mapper = require path .. 'map'
camera = require path .. 'camera'

game =
    x: 0
    y: 0

    size: 10
    map: {}

    config:
        width:  love.graphics.getWidth!  / 10
        height: love.graphics.getHeight! / 10
        floor:  0.1 -- fraction being floor
        spin:   1   -- probability of spinning the wormy boi

    camera: camera.make love.graphics.getWidth! / 2, love.graphics.getHeight! / 2, 1, 1, 0
    world: {}

game.load = =>
    love.graphics.setBackgroundColor 0.5, 0.8, 0.4

    @map   = mapper.automata (mapper.gen @config), @config
    @world = bump.newWorld 64, 64

game.update = (dt) =>
    return

game.draw = =>
    @camera\set!

    with love.graphics
        for x = 0, #@map
            for y = 0, #@map[0]
                if @map[x][y] == 0
                    .setColor 0.5, 1, 0.6
                    .rectangle 'fill', x * @size, y * @size, @size, @size
                if @map[x][y] == 2
                    .setColor 0.4, 0.7, 0.3
                    .rectangle 'fill', x * @size, y * @size, @size, @size

        .setColor 0, 0, 0
        .rectangle 'fill', @x - 2.5, @y - 2.5, 5, 5

    @camera\unset!

game.key_press = (key) =>
    switch key
        when 'space'
            @map = mapper.automata (mapper.gen @config), @config

game.mouse_moved = (x, y) =>
    @x = x
    @y = y

game.mouse_press = (mouse, x, y) =>
    @scale = 2

game