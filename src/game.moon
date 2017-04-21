export state = {
    angle: 0
    x: 0
}

with state
    .update = (dt) =>
        .angle += dt
        .x     += dt * 10
        love.window.setTitle "#{love.timer.getFPS!}"

        if love.keyboard.isDown "left"
            for p in *cube.vertices
                p[1] -= dt * 25
        
        if love.keyboard.isDown "right"
            for p in *cube.vertices
                p[1] += dt * 25

        if love.keyboard.isDown "down"
            for p in *cube.vertices
                p[3] -= dt * 25

        if love.keyboard.isDown "up"
            for p in *cube.vertices
                p[3] += dt * 25

        if love.keyboard.isDown "lshift"
            for p in *cube.vertices
                p[2] += dt * 25

        if love.keyboard.isDown "space"
            for p in *cube.vertices
                p[2] -= dt * 25

    .draw = =>
        cube\debug_draw!

state