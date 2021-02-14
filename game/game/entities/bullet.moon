make = (sprite, x, y, a, speed) ->
    b =
        :sprite
        :x, :y
        :a
        dx: speed * -math.cos a
        dy: speed * -math.sin a
        w: sprite\getWidth!
        h: sprite\getHeight!
        dead: false

    b.update = (dt) =>
        unless @dead
            @x, @y, @collisions = game.world\move @, @x + @dx * dt, @y + @dy * dt

        for c in *@collisions
            unless @dead
                game\remove_bullet @

            @dead = true
            break

    b.draw = =>
        with love.graphics
            .setColor 1, 1, 1
            .draw @sprite, @x, @y, @a + math.pi / 2, 1, 1, @w / 2, @h / 2

    b

{
    :make
}