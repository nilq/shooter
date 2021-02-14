path = 'game/'

mapper   = require path .. 'map'
camera   = require path .. 'camera'
block    = require path .. 'block'

export entities = require path .. 'entities'

game =
    x: 0
    y: 0

    start_x: 0
    start_y: 0

    size: 32
    map: {}

    player: {} -- we need a reference to the player; enemies etc. need to know what's up

    -- non-ECS event-queue
    objects: {}
    grass:   {} -- jush fucking grass, draw it in the background
    guns:    {} -- guns and bullets

    -- for ticking all the animations
    animation_loop: {}

    -- ECS entity id list
    ecs_ids: {}

    config:
        width:  love.graphics.getWidth!  / 10
        height: love.graphics.getHeight! / 10
        floor:  0.1  -- fraction being floor
        spin:   0.22 -- probability of spinning the wormy boi
        ca:
            iterations: 3
            spawn_threshold: 4
            die_threshold: 5

    camera: camera.make love.graphics.getWidth! / 2, love.graphics.getHeight! / 2, 1.25, 1.25, 0
    world: {}

    sprites: require path .. 'sprites'

game.load = =>
    @world = bump.newWorld 64, 64
    @new_level!

check_side = (map, x, y, t) ->
    if map[x] and map[x][y]
        return map[x][y] == t
    false

game.animate = (obj, field, a, b, speed) =>
    table.insert @animation_loop,
        :obj
        :field
        :a
        :b
        :speed
        time: a

game.remove_animation = (obj, field) =>
    for i, a in ipairs @animation_loop
        table.remove @animation_loop, i if a.obj == obj and a.field == field
        break

game.new_level = =>
    @objects = {}
    @grass   = {}
    @guns    = {}

    cx, cy = @config.width / 2 * game.size, @config.height / 2 * game.size

    for id in *@ecs_ids
        e.delete(id)

    @ecs_ids = {}
    for i = 0, @config.ca.iterations
        id = e.enemy {
            position: {x: cx, y: cy}
            size: {w: 32, h: 32}
            sprite: {src: ""}
            enemy:
                waypoint: {x:0, y:0}
        }
        @ecs_ids[#@ecs_ids+1] = id
        @world\add id, cx, cy, 32, 32

    imap = mapper.gen @config

    for i = 0, 10
        imap = mapper.automata imap, @config

    @map = mapper.add_walls imap, @config

    for x = 0, #@map
        for y = 0, #@map[0]
            switch @map[x][y]
                when 0
                    b = block.make x * @size, y * @size, game.sprites.stones['0000']
                    b.sprite = @sprites.floor.grass
                    @spawn_grass b

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

                    down = check_side @map, x, y + 1, 0

                    name ..= (check_side @map, x, y - 1, 0) and 1 or 0
                    name ..= (check_side @map, x + 1, y, 0) and 1 or 0
                    name ..= down                           and 1 or 0
                    name ..= (check_side @map, x - 1, y, 0) and 1 or 0

                    b = block.make x * @size, y * @size, @sprites.floor.grass
                    @spawn_grass b

                    b = block.make x * @size, y * @size, game.sprites.stones[name], down
                    @world\add b, b.x, b.y, b.w, b.h

                    @spawn b

    @player = entities.player.make @start_x * @size, @start_y * @size
    @world\add @player, @player.x, @player.y, 8, 16

    @spawn @player

game.spawn = (obj) =>
    table.insert @objects, obj
    obj\load! if obj.load
    obj

game.spawn_grass = (grass) =>
    table.insert @grass, grass

game.spawn_gun = (gun) =>
    table.insert @guns, gun
    gun

game.remove_bullet = (b) =>
    for i, v in ipairs @guns
        if v == b
            table.remove @guns, i
            break
        

    @world\remove b

game.update = (dt) =>
    for obj in *@objects
        continue unless obj
        obj\update dt if obj.update

    for gun in *@guns
        continue unless gun
        gun\update dt if gun.update

    for an in *@animation_loop
        an.time += dt * an.speed
        if (math.floor an.time) > an.b
            an.time = an.a

        an.obj[an.field] = math.floor an.time

game.real_pos_of = (obj) =>
    cx = love.graphics.getWidth! / 2
    cy = love.graphics.getHeight! / 2

    x = obj.x * @camera.sx + cx - @camera.x + obj.w / 2 * @camera.sx
    y = obj.y * @camera.sy + cy - @camera.y + obj.h / 2 * @camera.sy

    x, y

game.atan2_obj_to_mouse = (obj) =>
    x, y = @real_pos_of obj

    math.atan2 y - @y, x - @x

game.draw = =>
    @camera\set!

    with love.graphics
        for grass in *@grass
            continue unless grass
            grass\draw! if grass.draw

        for obj in *@objects
            continue unless obj
            obj\draw! if obj.draw

        for gun in *@guns
            continue unless gun
            gun\draw! if gun.draw

        -- for x = 0, #@map
        --     for y = 0, #@map[0]
        --         if @map[x][y] == 0
        --             .setColor 0.5, 1, 0.6
        --             .rectangle 'fill', x * @size, y * @size, @size, @size
        --         if @map[x][y] == 2
        --             .setColor 0.4, 0.7, 0.3
        --             .rectangle 'fill', x * @size, y * @size, @size, @size

    s!

    @camera\unset!

    -- cx = love.graphics.getWidth! / 2
    -- cy = love.graphics.getHeight! / 2

    -- love.graphics.setColor 0, 0, 1
    -- love.graphics.line @x, @y, @player.x * @camera.sx + cx - @camera.x + @player.w / 2 * @camera.sx, @player.y * @camera.sy + cy - @camera.y + @player.h / 2 * @camera.sy

    love.graphics.setColor 0, 0, 0
    love.graphics.print 'layout (enter to change): ' .. @player.controls.current, 10, 60

    love.graphics.print 'floor (change: 1 and 2): ' .. @config.floor, 10, 90
    love.graphics.print 'spin  (change: 3 and 4): ' .. @config.spin, 10, 120

    -- love.graphics.rectangle 'fill', x, y, 20, 20

game.key_press = (key) =>
    switch key
        when 'space'
            @world   = bump.newWorld 64, 64
            @new_level!

            collectgarbage("count")

        when '1'
            @config.floor -= 0.02
        when '2'
            @config.floor += 0.02
        when '3'
            @config.spin -= 0.02
        when '4'
            @config.spin += 0.02

    for obj in *@objects
        obj\key_press key if obj.key_press

game.mouse_moved = (x, y) =>
    @x = x
    @y = y

game.mouse_press = (mouse, x, y) =>
    for obj in *@objects
        obj\mouse_press mouse, x, y if obj.mouse_press

game
