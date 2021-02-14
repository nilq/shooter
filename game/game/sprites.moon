int2bin = (n) ->
    result = {}

    while n ~= 0
        if n % 2 == 0
            result[#result]

    table.concat result

walls = (path) ->
    {
        '0000': love.graphics.newImage path .. '0000.png'
        '0001': love.graphics.newImage path .. '0001.png'
        '0010': love.graphics.newImage path .. '0010.png'
        '0011': love.graphics.newImage path .. '0011.png'
        '0100': love.graphics.newImage path .. '0100.png'
        '0101': love.graphics.newImage path .. '0101.png'
        '0110': love.graphics.newImage path .. '0110.png'
        '0111': love.graphics.newImage path .. '0111.png'
        '1000': love.graphics.newImage path .. '1000.png'
        '1001': love.graphics.newImage path .. '1001.png'
        '1010': love.graphics.newImage path .. '1010.png'
        '1011': love.graphics.newImage path .. '1011.png'
        '1100': love.graphics.newImage path .. '1100.png'
        '1101': love.graphics.newImage path .. '1101.png'
        '1110': love.graphics.newImage path .. '1110.png'
        '1111': love.graphics.newImage path .. '1111.png'
    }

sprites =
    stones: walls 'sprites/wall/stone/'
    floor:
        grass: love.graphics.newImage 'sprites/floor/grass.png'
    enemy:
        fucker: love.graphics.newImage 'sprites/enemy/fucker.png'
    environment:
        flower1: love.graphics.newImage 'sprites/environment/flower1.png'
        flower2: love.graphics.newImage 'sprites/environment/flower2.png'
        flower3: love.graphics.newImage 'sprites/environment/flower3.png'
        flower4: love.graphics.newImage 'sprites/environment/flower4.png'
        grass1:  love.graphics.newImage 'sprites/environment/grass1.png'
        grass2:  love.graphics.newImage 'sprites/environment/grass2.png'
        grass3:  love.graphics.newImage 'sprites/environment/grass3.png'
        grass4:  love.graphics.newImage 'sprites/environment/grass4.png'
        grass5:  love.graphics.newImage 'sprites/environment/grass5.png'
        grass6:  love.graphics.newImage 'sprites/environment/grass6.png'
        rocks1:  love.graphics.newImage 'sprites/environment/rocks1.png'
        rocks2:  love.graphics.newImage 'sprites/environment/rocks2.png'
        rocks3:  love.graphics.newImage 'sprites/environment/rocks3.png'
        rocks4:  love.graphics.newImage 'sprites/environment/rocks4.png'
    player:
        idle: love.graphics.newImage 'sprites/player/player_idle.png'
        walk: {
            love.graphics.newImage 'sprites/player/player_walk1.png',
            love.graphics.newImage 'sprites/player/player_walk2.png',
            love.graphics.newImage 'sprites/player/player_walk3.png',
            love.graphics.newImage 'sprites/player/player_walk4.png'
        }
    gun:
        handgun: love.graphics.newImage 'sprites/gun/handgun.png'
    bullet:
        pill_lg: love.graphics.newImage 'sprites/projectile/pill_large.png'

sprites