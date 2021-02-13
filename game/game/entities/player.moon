make = (x, y) ->
    player =
        :x, :y
        dx: 0
        dy: 0
        speed: 10
        friction: 4
        controls:
            up:    ','
            down:  'o'
            left:  'a'
            right: 'e'

    with player
        .update = (dt) =>
            if love.keyboard.isDown @controls.left
                @dx -= @speed * dt

            if love.keyboard.isDown @controls.right
                @dx += @speed * dt
            
            if love.keyboard.isDown @controls.up
                @dx -= @speed * dt
            
            if love.keyboard.isDown @controls.down
                @dx += @speed * dt

            @x, @y, @collisions = game.world\move @, @x + @dx, @y + @dy

            @dx = math.lerp @dx, 0, dt * @friction
            @dy = math.lerp @dy, 0, dt * @friction


    player

{
    :make
}