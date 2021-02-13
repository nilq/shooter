make = (x, y) ->
    player =
        :x, :y
        dx: 0
        dy: 0
        speed: 60
        friction: 20
        controls:
            up:    'up'
            down:  'down'
            left:  'left'
            right: 'right'

    with player
        .update = (dt) =>
            dx = 0
            dy = 0

            if love.keyboard.isDown @controls.left
                dx -= 1
            if love.keyboard.isDown @controls.right
                dx += 1
            if love.keyboard.isDown @controls.up
                dy -= 1
            if love.keyboard.isDown @controls.down
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

    player.draw = =>
        with love.graphics
            .setColor 1, 1, 1
            .draw game.sprites.player, @x, @y, 0, 1, 1

    player

{
    :make
}
