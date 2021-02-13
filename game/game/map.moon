math.randomseed os.time!

fill = (width, height) ->
    map = {}
    for x = 0, width
        row = {}

        for y = 0, height
            row[y] = 1 -- wall/background
        
        map[x] = row
    map

clone = (map) ->
    nmap = fill #map, #map[0]

    for x = 0, #map
        for y = 0, #map[0]
            nmap[x][y] = map[x][y]
    nmap

mapper = {}

mapper.automata = (map, config) ->
    nmap = {}

    with config
        nmap = clone map
        auto = (x, y) ->
            sum = 0

            for ix = -1, 1
                for iy = -1, 1
                    unless (ix == 0 and iy == 0)
                        sum += map[x + ix][y + iy]

            switch map[x][y]
                when 0
                    if sum > 4
                        nmap[x][y] = 1 unless x == game.start_x and y == game.start_y
                when 1
                    if sum < 5
                        nmap[x][y] = 0

        for x = 1, #nmap - 1
            for y = 1, #nmap[0] - 1
                auto x, y

        for x = 0, #nmap
            for y = 0, #nmap[0]
                sum = 0
                flag = false

                for ix = -1, 1
                    for iy = -1, 1
                        if x + ix < 0 or x + ix >= #nmap or y + iy < 0 or y + iy >= #nmap[0]
                            sum += 1
                            flag = true

                            continue

                        unless (ix == 0 and iy == 0)
                            sum += map[x + ix][y + iy]

                if nmap[x][y] == 1
                    if sum != 8
                        nmap[x][y] = 2 -- solid
                elseif flag
                    nmap[x][y] = 2 -- solid

        -- for x = 1, #nmap - 1
        --     for y = 1, #nmap[0] - 1
        --         void = false

        --         if nmap[x][y] == 2
        --             for ix = -1, 1
        --                 for iy = -1, 1
        --                     unless (ix == 0 and iy == 0)
        --                         if map[x + ix][y + iy] == 1
        --                             void = true
                
        --             unless void
        --                 nmap[x][y] = 0
                        
                        

    nmap -- the new map

mapper.fraction_of = (map, t) ->
    sum = 0

    for x = 0, #map
        for y = 0, #map[0]
            sum += 1 if map[x][y] == t

    sum / (#map * #map[0])

mapper.gen = (config) ->
    start = os.time!
    map = {}

    with config
        worm =
            x: math.floor  .width / 2
            y: math.floor  .height / 2
            r: math.random 0, 3 -- clocwize 0..3

        map = fill .width, .height
        player_set = false

        while .floor >= mapper.fraction_of map, 0
            if os.time! - start > 1
                return mapper.gen config

            last_r = worm.r
            while worm.r == last_r
                worm.r = math.random 0, 3

            switch worm.r
                when 0
                    worm.y -= 1
                when 1
                    worm.x += 1
                when 2
                    worm.y += 1
                when 3
                    worm.x -= 1

            if map[worm.x] and map[worm.x][worm.y]
                map[worm.x][worm.y] = 0 -- floor

                unless player_set
                    game.start_x = worm.x
                    game.start_y = worm.y

                if worm.r == 0 or worm.r == 2
                    if map[worm.x] and map[worm.x][worm.y + 1]
                        map[worm.x][worm.y + 1] = 0
                else
                    if map[worm.x + 1] and map[worm.x + 1][worm.y]
                        map[worm.x + 1][worm.y] = 0
            else
                worm.x = math.floor .width / 2
                worm.y = math.floor .height / 2

    map

mapper