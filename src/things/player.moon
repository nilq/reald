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
    }
    world\add p, p.x, p.y, p.model.width * 2, p.model.height * 2
    p.draw = =>
        @model\draw!

        love.graphics.setColor 255, 0, 0
        love.graphics.rectangle "fill", @x, @y, @model.width, @model.height
    
    p.update = (dt) =>
        with love
            if .keyboard.isDown "left"
                @dx -= @acc * dt
            if .keyboard.isDown "right"
                @dx += @acc * dt
            
            if .keyboard.isDown "e"
                @dy += @acc * dt
            if .keyboard.isDown "q"
                @dy -= @acc * dt
            
        @dx -= (@dx / @frcx) * dt
        @dy -= (@dy / @frcy) * dt

        @x, @y = @move @dx * dt, @dy * dt

    p.move = (x, y) =>
        nx, ny = world\move @, @x + x, @y + y
        for v in *@model.vertices
            v[1] += nx - @x
            v[2] += ny - @y
        nx, ny
    p

player