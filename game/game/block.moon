make = (x, y, sprite, shadow=false) ->
    block =
        :x, :y
        w: game.size
        h: game.size - 11
        :sprite
        :shadow

    block.draw = =>
        with love.graphics
            if @shadow
                .setColor 0, 0, 0, 0.1
                .draw @sprite, @x, @y + @h / 2.5, 0, 1, 1

            .setColor 0.8, 0.8, 0.8
            .draw @sprite, @x, @y, 0, 1, 1

    block

{
    :make
}