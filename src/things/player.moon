player = {}

player.new = (model, x, y) ->
    p = {
        :model
        :x, :y

        dx: 0
        dy: 0
        acc: 10
        frcx: 0.5
        frcy: 1.5
        grav: 25
        grounded: false
        jump: 17

        wall: 0
    }
    world\add p, p.x, p.y, p.model.width * 2, p.model.height * 2
    p.draw = =>
        @model\draw!
    
    p.update = (dt) =>
        @wall     = 0
        @grounded = false
        with love
            if .keyboard.isDown "a"
                @dx -= @acc * dt
            if .keyboard.isDown "d"
                @dx += @acc * dt

        @dy += @grav * dt unless @grounded
            
        @dx -= (@dx / @frcx) * dt
        @dy -= (@dy / @frcy) * dt

        @x, @y, @cols = @move @dx * dt, @dy * dt

        for c in *@cols
            if c.normal.y != 0
                if c.normal.y = -1
                    @grounded = true
                @dy = 0

            if c.normal.x != 0
                @dx = 0
                @wall = c.normal.x
            
            if c.other.tag == "hurtful"
                love.event.quit!

        state.cam.dx = (avgn @, 1)
        state.cam.dy = (avgn @, 2)

    p.press = (key) =>
        if key == "space"
            if @grounded
                @dy = -@jump
            elseif @wall != 0
                @dy = -@jump * 0.75
                @dx = @wall * @jump
        

    p.move = (x, y) =>
        nx, ny, cols = world\move @, @x + x, @y + y
        for v in *@model.vertices
            v[1] += nx - @x
            v[2] += ny - @y
        nx, ny, cols
    p

player