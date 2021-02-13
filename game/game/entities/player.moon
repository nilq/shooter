make = (x, y) ->
    player =
        :x, :y
        dx: 0
        dy: 0
        speed: 50
        friction: 10
        controls:
            up:    ','
            down:  'o'
            left:  'a'
            right: 'e'

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

            a = math.atan2 @x - game.x, @y - game.y

            game.start_x = @x
            game.start_y = @y

            game.camera.x = math.lerp game.camera.x, @x * game.camera.sx + (math.cos a) * 100, dt * 3
            game.camera.y = math.lerp game.camera.y, @y * game.camera.sy + (math.sin a) * 100, dt * 3

    player.draw = =>
        with love.graphics
            .setColor 1, 1, 0.5
            .rectangle 'fill', @x, @y, 16, 16

    player

{
    :make
}