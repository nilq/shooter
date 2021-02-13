math.randomseed(os.time())
local fill
fill = function(width, height)
  local map = { }
  for x = 0, width do
    local row = { }
    for y = 0, height do
      row[y] = 1
    end
    map[x] = row
  end
  return map
end
local clone
clone = function(map)
  local nmap = fill(#map, #map[0])
  for x = 0, #map do
    for y = 0, #map[0] do
      nmap[x][y] = map[x][y]
    end
  end
  return nmap
end
local mapper = { }
mapper.automata = function(map, config)
  local nmap = { }
  do
    nmap = clone(map)
    local auto
    auto = function(x, y)
      local sum = 0
      for ix = -1, 1 do
        for iy = -1, 1 do
          if not ((ix == 0 and iy == 0)) then
            sum = sum + map[x + ix][y + iy]
          end
        end
      end
      local _exp_0 = map[x][y]
      if 0 == _exp_0 then
        if sum > 4 then
          nmap[x][y] = 1
        end
      elseif 1 == _exp_0 then
        if sum < 5 then
          nmap[x][y] = 0
        end
      end
    end
    for x = 1, #nmap - 1 do
      for y = 1, #nmap[0] - 1 do
        auto(x, y)
      end
    end
    for x = 0, #nmap do
      for y = 0, #nmap[0] do
        local sum = 0
        local flag = false
        for ix = -1, 1 do
          for iy = -1, 1 do
            local _continue_0 = false
            repeat
              if x + ix < 0 or x + ix >= #nmap or y + iy < 0 or y + iy >= #nmap[0] then
                sum = sum + 1
                flag = true
                _continue_0 = true
                break
              end
              if not ((ix == 0 and iy == 0)) then
                sum = sum + map[x + ix][y + iy]
              end
              _continue_0 = true
            until true
            if not _continue_0 then
              break
            end
          end
        end
        if nmap[x][y] == 1 then
          if sum ~= 8 then
            nmap[x][y] = 2
          end
        elseif flag then
          nmap[x][y] = 2
        end
      end
    end
  end
  return nmap
end
mapper.fraction_of = function(map, t)
  local sum = 0
  for x = 0, #map do
    for y = 0, #map[0] do
      if map[x][y] == t then
        sum = sum + 1
      end
    end
  end
  return sum / (#map * #map[0])
end
mapper.gen = function(config)
  local start = os.time()
  local map = { }
  do
    local worm = {
      x = math.floor(config.width / 2),
      y = math.floor(config.height / 2),
      r = math.random(0, 3)
    }
    map = fill(config.width, config.height)
    while config.floor >= mapper.fraction_of(map, 0) do
      if os.time() - start > 1 then
        return mapper.gen(config)
      end
      local last_r = worm.r
      while worm.r == last_r do
        worm.r = math.random(0, 3)
      end
      local _exp_0 = worm.r
      if 0 == _exp_0 then
        worm.y = worm.y - 1
      elseif 1 == _exp_0 then
        worm.x = worm.x + 1
      elseif 2 == _exp_0 then
        worm.y = worm.y + 1
      elseif 3 == _exp_0 then
        worm.x = worm.x - 1
      end
      if map[worm.x] and map[worm.x][worm.y] then
        map[worm.x][worm.y] = 0
        if worm.r == 0 or worm.r == 2 then
          if map[worm.x] and map[worm.x][worm.y + 1] then
            map[worm.x][worm.y + 1] = 0
          end
        else
          if map[worm.x + 1] and map[worm.x + 1][worm.y] then
            map[worm.x + 1][worm.y] = 0
          end
        end
      else
        worm.x = math.floor(config.width / 2)
        worm.y = math.floor(config.height / 2)
      end
    end
  end
  return map
end
return mapper
