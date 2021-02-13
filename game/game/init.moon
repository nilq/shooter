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

    -- ECS entity id list
    ecs_ids: {}

    config:
        width:  love.graphics.getWidth!  / 10
        height: love.graphics.getHeight! / 10
        floor:  0.1 -- fraction being floor
        spin:   1   -- probability of spinning the wormy boi

    camera: camera.make love.graphics.getWidth! / 2, love.graphics.getHeight! / 2, 2.5, 2.5, 0
    world: {}

    sprites: require path .. 'sprites'

game.load = =>
    @world = bump.newWorld 64, 64
    @new_level!

check_side = (map, x, y, t) ->
    if map[x] and map[x][y]
        return map[x][y] == t
    false

game.new_level = =>
    cx, cy = @config.width / 2 * game.size, @config.height / 2 * game.size

    for id in *@ecs_ids
        e.delete(id)

    @ecs_ids = {}
    for i = 0, 10
        id = e.enemy {
            position: {x: cx, y: cy}
            size: {w: 32, h: 32}
            sprite: {src: ""}
            enemy:
                waypoint: {x:0, y:0}
        }
        @ecs_ids[#@ecs_ids+1] = id
        @world\add id, cx, cy, 32, 32

    @map   = mapper.automata (mapper.gen @config), @config

    for x = 0, #@map
        for y = 0, #@map[0]
            switch @map[x][y]
                when 0
                    b = block.make x * @size, y * @size, game.sprites.stones['0000']
                    b.sprite = @sprites.floor.grass
                    @spawn b

                    if 0 == math.random 0, 3
                        keys = {}
                        for k in pairs @sprites.environment
                            table.insert keys, k

                        b = block.make x * @size, y * @size, @sprites.environment[keys[math.random #keys]]

                        @spawn b

                when 1 -- wall
                    b = block.make x * @size, y * @size, game.sprites.stones['0000']
                    @spawn b
                when 2 -- solid block
                    name = ''

                    name ..= (check_side @map, x, y - 1, 0) and 1 or 0
                    name ..= (check_side @map, x + 1, y, 0) and 1 or 0
                    name ..= (check_side @map, x, y + 1, 0) and 1 or 0
                    name ..= (check_side @map, x - 1, y, 0) and 1 or 0

                    b = block.make x * @size, y * @size, @sprites.floor.grass
                    @spawn b

                    b = block.make x * @size, y * @size, game.sprites.stones[name]
                    @world\add b, b.x, b.y, b.w, b.h

                    @spawn b

    player = entities.player.make @start_x * @size, @start_y * @size
    @world\add player, player.x, player.y, 8, 16

    @spawn player

game.spawn = (obj) =>
    table.insert @objects, obj

game.update = (dt) =>
    for obj in *@objects
        continue unless obj
        obj\update dt if obj.update

game.draw = =>
    @camera\set!

    with love.graphics
        for obj in *@objects
            continue unless obj
            obj\draw! if obj.draw

        -- for x = 0, #@map
        --     for y = 0, #@map[0]
        --         if @map[x][y] == 0
        --             .setColor 0.5, 1, 0.6
        --             .rectangle 'fill', x * @size, y * @size, @size, @size
        --         if @map[x][y] == 2
        --             .setColor 0.4, 0.7, 0.3
        --             .rectangle 'fill', x * @size, y * @size, @size, @size

        
        .setColor 0, 0, 1
        x = @start_x
        y = @start_y

    s!

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
    @x = x
    @y = y

game.mouse_press = (mouse, x, y) =>
    @scale = 2

game
