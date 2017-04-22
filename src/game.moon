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

        dy, dz = 0, 0
        s      = 35

        if love.keyboard.isDown "down"
            dz = -s
        if love.keyboard.isDown "up"
            dz = s
        if love.keyboard.isDown "space"
            dy = -s
        if love.keyboard.isDown "lshift"
            dy = s

        for l in *.absolutes
            for cube in *l
                for v in *(cube.vertices or cube.model.vertices)
                    v[2] += dy * dt
                    v[3] += dz * dt
        
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