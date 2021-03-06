export state = {
    absolutes: {} -- *as in absolutely being drawn*
    entities:  {}

    cam: {x: 0, y: 0, z: 0, dx: 0, dy: 0, dz: 0, pos_x: 0, pos_y: 0}

    level: 1
}

export entity = require "src/things"

level = require "src/level"

-- averages vertice's given axis
export avgn = (a, n) ->
    sum = 0
    for v in *(a.vertices or a.model.vertices)
        sum += v[n]
    sum / #(a.vertices or a.model.vertices)
 
-- list of vertice-based entities
-- being split into two based on comparison thing
flagn = (a, n) ->
    for b in *a
        if state.cam.dx < 0
            b.flag = state.cam.dx < avgn b, n
        else
            b.flag = state.cam.dx > avgn b, n
    a

-- splits flagged list based on flag
splitn = (a, n) ->
    flagn a, n

    l, l1 = {}, {}
    for b in *a
        if b.flag
            table.insert l, b
        else
            table.insert l1, b
    l, l1

-- sorts vertice-based objects avg x
sortx = (a, b) ->
    (avgn a, 1) < avgn b, 1

-- sorts vertice-based objects avg y
sorty = (a, b) ->
    (avgn a, 2) > avgn b, 2

with state    
    .load = =>
        level\load "res/level#{.level}.png"

        for li in *.absolutes
            break unless li
            l, l1 = splitn li, 1

            li.left  = l
            li.right = l1

    .update = (dt) =>
        for e in *.entities
            e\update dt if e.update
        for l in *.absolutes
            break unless l
            for e in *l
                e\update dt if e.update
        
        i1 = 1
        for l in *.absolutes
            break unless l
            i = 1
            for cube in *l
                break unless cube

                for e in *.entities
                    if e == cube
                        y = math.floor e.y / 2
                        unless y < 1 or y > #.absolutes
                            ix = 1
                            for a in *.absolutes[y]
                                break if a == cube
                                if (avgn cube, 1) > avgn a, 1
                                    break
                                ix += 1

                            table.remove l, i
                            table.insert .absolutes[y], ix, cube
                i += 1
            i1 += 1
    
        for li in *.absolutes
            break unless li
            l, l1 = splitn li, 1

            li.left  = l
            li.right = l1

        .cam.x = math.lerp .cam.x, .cam.dx, dt * 30
        .cam.y = math.lerp .cam.y, .cam.dy, dt * 3
        .cam.z = math.lerp .cam.z, .cam.dz, dt * 30

    .spawn_absolute = (entity, y) =>
        .absolutes[y] = {} unless .absolutes[y]
        table.insert .absolutes[y], entity

    .spawn = (entity) =>
        table.insert .entities, entity

    .draw = =>
        love.graphics.push!
        .cam.pos_x, .cam.pos_y = love.graphics.getWidth! / 2 - .cam.x * 10, love.graphics.getHeight! / 2 - .cam.y * 10
        love.graphics.translate .cam.pos_x, .cam.pos_y

        for l = #.absolutes, 1, -1
            li = .absolutes[l]
            break unless li.right
            for e = #li.right, 1, -1
                li.right[e]\draw! if li.right[e].draw
            break unless li.left
            for e = #li.left, 1, -1
                li.left[e]\draw! if li.left[e].draw

        love.graphics.pop!
    
    .press = (key) =>
        for e in *.entities
            e\press key if e.press

state