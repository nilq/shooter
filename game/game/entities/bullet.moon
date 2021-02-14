make = (sprite, x, y, a, speed) ->
    b =
        :sprite
        :x, :y
        :a
        dx: speed * -math.cos a
        dy: speed * -math.sin a
        w: sprite\getWidth!
        h: sprite\getHeight!

    b.update = (dt) =>
        @x += @dx * dt
        @y += @dy * dt

    b.draw = =>
        with love.graphics
            .setColor 1, 1, 1
            .draw @sprite, @x, @y, @a + math.pi / 2, 1, 1, @w / 2, @h / 2

    b

{
    :make
}