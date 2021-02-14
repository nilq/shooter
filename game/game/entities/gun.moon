make = (config, mother) ->
    gun =
        r: 0
        x: 0
        y: 0
        :config
        :mother
        w: config.sprite\getWidth!
        h: config.sprite\getHeight!
        radius: 0

    gun.update = (dt) =>
        @x = @mother.x + @mother.w / 2 + @config.off_x * (math.sign (game\real_pos_of @) - game.x) - @radius * math.cos @r
        @y = @mother.y + @mother.h / 2 + @config.off_y - @radius * math.sin @r

        @radius = math.lerp @radius, @config.radius, dt * 4

    gun.draw = =>
        with love.graphics
            .setColor 1, 1, 1
            .draw @config.sprite, @x, @y, @r, 1, @flip, @config.pivot_x, @config.pivot_y

            last_flip = @flip
            @flip = (math.sign (game\real_pos_of @) - game.x)
            @flip = last_flip if @flip == 0

    gun.shoot = =>
        bx = @x - @w * math.cos @r
        by = @y - @w * math.sin @r
        a = @r + math.pi / 2 * @config.spread * 0.01 * math.random -100, 100
        game\spawn_gun entities.bullet.make @config.bullet_sprite, bx, by, a, @config.bullet_speed

        @radius -= @config.recoil

    gun

{
    :make
}