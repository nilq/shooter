make = (x, y) ->
    player =
        :x, :y
        dx: 0
        dy: 0
        w: 8
        h: 16
        speed: 60
        friction: 20
        controls:
            dvorak:
                up:    ','
                down:  'o'
                left:  'a'
                right: 'e'
            human:
                up:    'w'
                down:  's'
                left:  'a'
                right: 'd'

            current: 'dvorak'
        gun: {}

    with player
        .load = =>
            @gun = game\spawn_gun (entities.gun.make entities.guns.handgun!, @)

        .update = (dt) =>
            dx = 0
            dy = 0

            if love.keyboard.isDown @controls[@controls.current].left
                dx -= 1
            if love.keyboard.isDown @controls[@controls.current].right
                dx += 1
            if love.keyboard.isDown @controls[@controls.current].up
                dy -= 1
            if love.keyboard.isDown @controls[@controls.current].down
                dy += 1

            len = (dx^2 + dy^2)^0.5

            dx /= len unless len == 0
            dy /= len unless len == 0

            @dx += dx * @speed * dt
            @dy += dy * @speed * dt

            @x, @y, @collisions = game.world\move @, @x + @dx, @y + @dy

            for c in *@collisions
                if c.normal.x != 0
                    @dx = 0

                if c.normal.y != 0
                    @dy = 0

            @dx = math.lerp @dx, 0, dt * @friction
            @dy = math.lerp @dy, 0, dt * @friction

            a = math.atan2 @y - game.y, @x - game.x

            game.start_x = @x
            game.start_y = @y

            -- game.camera.x = math.lerp game.camera.x, @x * game.camera.sx + math.sin(a) * 100, dt * 3
            -- game.camera.y = math.lerp game.camera.y, @y * game.camera.sy + math.cos(a) * 100, dt * 3

            game.camera.x = math.lerp game.camera.x, @x * game.camera.sx, dt * 3
            game.camera.y = math.lerp game.camera.y, @y * game.camera.sy, dt * 3

            @gun.r = game\atan2_obj_to_mouse @

    player.draw = =>
        with love.graphics
            .setColor 1, 1, 1
            .draw game.sprites.player, @x + @w / 2, @y + @h / 2, 0, @flip, 1, @w / 2, @h / 2

            last_flip = @flip
            @flip = (math.sign (game\real_pos_of @) - game.x)
            @flip = last_flip if @flip == 0
            

    player.key_press = (key) =>
        switch key
            when 'return'
                @controls.current = @controls.current == 'dvorak' and 'human' or 'dvorak'

    player.mouse_press = (m, x, y) =>
        switch m
            when 1 -- left
                @gun\shoot!

    player

{
    :make
}
