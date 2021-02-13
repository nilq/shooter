make = (x, y, name) ->
    block =
        :x, :y
        w: game.size
        h: game.size - 11
        sprite: game.sprites.stones[name]

    block.draw = =>
        with love.graphics
            .setColor 0.8, 0.8, 0.8
            .draw @sprite, @x, @y, 0, 1, 1

    block

{
    :make
}