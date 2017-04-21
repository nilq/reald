export state = {
    cubes: {}
}

with state
    .load = =>
        for x = 0, 10
            for z = 0, 10
                cube = OBJ "res/cube.obj"

                for v in *cube.vertices
                    v[1] += x * 2
                    v[3] += z * 2

                table.insert .cubes, cube

    .update = (dt) =>
        love.window.setTitle "#{love.timer.getFPS!}"

        dx, dy, dz = 0, 0, 0
        s      = 35

        if love.keyboard.isDown "right"
            dx = s
        if love.keyboard.isDown "left"
            dx = -s
        if love.keyboard.isDown "down"
            dz = -s
        if love.keyboard.isDown "up"
            dz = s
        if love.keyboard.isDown "space"
            dy = -s
        if love.keyboard.isDown "lshift"
            dy = s
        
        for cube in *.cubes
            for v in *cube.vertices
                v[1] += dx * dt
                v[2] += dy * dt
                v[3] += dz * dt

    .draw = =>
        for cube in *.cubes
            cube\debug_draw!

state