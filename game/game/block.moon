make = (x, y) ->
    block =
        :x, :y
        w: game.size
        h: game.size

    block.draw = =>
        with love.graphics
            .setColor 0, 0, 0
            .rectangle 'fill', @x, @y, @w, @h

    block

{
    :make
}