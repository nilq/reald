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
    }
    world\add p, p.x, p.y, p.model.width * 2, p.model.height * 2
    p.draw = =>
        @model\draw!

        love.graphics.setColor 255, 0, 0
        love.graphics.rectangle "fill", @x, @y, @model.width, @model.height
    
    p.update = (dt) =>
        @grounded = false
        with love
            if .keyboard.isDown "left"
                @dx -= @acc * dt
            if .keyboard.isDown "right"
                @dx += @acc * dt

        @dy += @grav * dt unless @grounded
            
        @dx -= (@dx / @frcx) * dt
        @dy -= (@dy / @frcy) * dt

        @x, @y, @cols = @move @dx * dt, @dy * dt

        for c in *@cols
            if c.normal.y != 0
                @dy = 0
                if c.normal.y = -1
                    @grounded = true

            if c.normal.x != 0
                @dx = 0
        
        if @grounded and love.keyboard.isDown "space"
            @dy = -@jump

    p.move = (x, y) =>
        nx, ny, cols = world\move @, @x + x, @y + y
        for v in *@model.vertices
            v[1] += nx - @x
            v[2] += ny - @y
        nx, ny, cols
    p

player