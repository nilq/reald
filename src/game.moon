export state = {
    absolutes: {} -- *as in absolutely being drawn*
    entities:  {}
}

export entity = require "src/things"

level = require "src/level"

-- averages vertice's given axis
avgn = (a, n) ->
    sum = 0
    for v in *(a.vertices or a.model.vertices)
        sum += v[n]
    sum / #(a.vertices or a.model.vertices)
 
-- list of vertice-based entities
-- being split into two based on comparison thing
flagn = (a, n) ->
    for b in *a
        b.flag = 0 > avgn b, n
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
        level\load "res/test.png"

        for li in *.absolutes
            l, l1 = splitn li, 1

            li.left  = l
            li.right = l1

    .update = (dt) =>
        for e in *.entities
            e\update dt if e.update
        for l in *.absolutes
            for e in *l
                e\update dt if e.update

        dy, dx, dz = 0, 0, 0
        s          = 35

        if love.keyboard.isDown "s"
            dz = -s
        if love.keyboard.isDown "w"
            dz = s
        if love.keyboard.isDown "a"
            dx = -s
        if love.keyboard.isDown "d"
            dx = s
        if love.keyboard.isDown "rshift"
            dy = -s
        if love.keyboard.isDown "lshift"
            dy = s
        
        i1 = 1
        for l in *.absolutes
            i = 1
            for cube in *l
                break unless cube

                for v in *(cube.vertices or cube.model.vertices)
                    v[1] += dx * dt
                    v[2] += dy * dt
                    v[3] += dz * dt

                for e in *.entities
                    if e == cube
                        y = math.floor e.y / 2
                        unless y < 1 or y > #.absolutes
                            ix = 1
                            for a in *.absolutes[y]
                                break if a == cube
                                if (avgn cube, 1) < avgn a, 1
                                    break
                                ix += 1

                            table.remove l, i
                            table.insert .absolutes[y], ix, cube
                i += 1
            i1 += 1
        
        if true
            for li in *.absolutes
                l, l1 = splitn li, 1

                li.left  = l
                li.right = l1

    .spawn_absolute = (entity, y) =>
        .absolutes[y] = {} unless .absolutes[y]
        table.insert .absolutes[y], entity

    .spawn = (entity) =>
        table.insert .entities, entity

    .draw = =>
        for l = #.absolutes, 1, -1
            li = .absolutes[l]
            for e = #li.right, 1, -1
                li.right[e]\draw! if li.right[e].draw
            for e = 1, #li.left
                li.left[e]\draw! if li.left[e].draw

state