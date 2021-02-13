path = 'game/'

mapper   = require path .. 'map'
camera   = require path .. 'camera'
block    = require path .. 'block'
entities = require path .. 'entities'

game =
    x: 0
    y: 0

    start_x: 0
    start_y: 0

    size: 32
    map: {}

    -- non-ECS event-queue
    objects: {}

    config:
        width:  love.graphics.getWidth!  / 10
        height: love.graphics.getHeight! / 10
        floor:  0.1 -- fraction being floor
        spin:   1   -- probability of spinning the wormy boi

    camera: camera.make love.graphics.getWidth! / 2, love.graphics.getHeight! / 2, 1 / 3.2, 1 / 3.2, 0
    world: {}

game.load = =>
    love.graphics.setBackgroundColor 0.5, 0.8, 0.4

    @world = bump.newWorld 64, 64
    @new_level!

game.new_level = =>
    player = entities.player.make @config.width / 2 * game.size, @config.height / 2 * game.size
    @world\add player, player.x, player.y, 16, 16

    @spawn player

    @map   = mapper.automata (mapper.gen @config), @config

    for x = 0, #@map
        for y = 0, #@map[0]
            switch @map[x][y]
                when 2 -- solid block
                    b = block.make x * @size, y * @size, @size, @size
                    @world\add b, b.x, b.y, b.w, b.h

                    @spawn b

game.spawn = (obj) =>
    table.insert @objects, obj

game.update = (dt) =>
    for obj in *@objects
        obj\update dt if obj.update

game.draw = =>
    @camera\set!

    with love.graphics
        for obj in *@objects
            obj\draw! if obj.draw

        -- for x = 0, #@map
        --     for y = 0, #@map[0]
        --         if @map[x][y] == 0
        --             .setColor 0.5, 1, 0.6
        --             .rectangle 'fill', x * @size, y * @size, @size, @size
        --         if @map[x][y] == 2
        --             .setColor 0.4, 0.7, 0.3
        --             .rectangle 'fill', x * @size, y * @size, @size, @size

        .setColor 0, 0, 0
        .rectangle 'fill', @x - 2.5, @y - 2.5, 5, 5

    s()

    @camera\unset!

game.key_press = (key) =>
    switch key
        when 'space'
            @objects = {}
            @world   = bump.newWorld 64, 64
            @new_level!

            collectgarbage("count")

    for obj in *@objects
        obj\key_press key if obj.key_press

game.mouse_moved = (x, y) =>
    @x = x / @camera.sx
    @y = y / @camera.sy

game.mouse_press = (mouse, x, y) =>
    @scale = 2

game
