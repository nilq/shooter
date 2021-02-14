-> {
    sprite: game.sprites.gun.handgun
    pivot_x: 8 -- spin around this
    pivot_y: 3 -- ... and this
    off_x: 0  -- relative to player right now :/
    off_y: 4
    ammo: 10
    fire_rate: 0.025 -- second
    spread: 0.1    -- randomly deviate by percent of 90*
    recoil: 5     -- move mother by this much(tm)
    radius: 6      -- the radius of the circle on which the gun orbits the mother
    bullet_sprite: game.sprites.bullet.pill_lg
    bullet_speed: 300
}