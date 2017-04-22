level = {
    grid_size: 2
    player: false
    default: {
        "dirt":  {0, 0, 0}
        "grass": {0, 255, 0}
        "dude":  {255, 255, 0}
    }
}

with level
    .load = (path, make_entity=.make_entity) =>
        image = love.image.newImageData path

        for x = 1, image\getWidth!
            row = {}
            for y = 1, image\getHeight!

                rx, ry = x - 1, y - 1
                r, g, b = image\getPixel rx, ry

                for k, v in pairs .default
                    if r == v[1] and g == v[2] and b == v[3]
                        .make_entity k, .grid_size * rx, .grid_size * ry, -660

    .make_entity = (k, x, y, z) ->
        ox, oy = -20, 0
        switch k
            when "grass"
                cube = OBJ "res/cube.obj", 0, 255, 0

                for v in *cube.vertices
                    v[1] += x + ox
                    v[2] += y + oy
                    v[3] += z

                b = entity.block.new cube, x, y
                state\spawn_absolute b, y / .grid_size

            when "dirt"
                cube = OBJ "res/cube.obj", 130, 80, 8

                for v in *cube.vertices
                    v[1] += x + ox
                    v[2] += y + oy
                    v[3] += z

                state\spawn_absolute cube, y / .grid_size

            when "dude"
                return if .player
                cube = OBJ "res/cube.obj", 255, 255, 0

                for v in *cube.vertices
                    v[1] += x + ox
                    v[2] += y + oy
                    v[3] += z

                p = entity.player.new cube, x, y
                state\spawn p
                state\spawn_absolute p, y / .grid_size
                .player = true

level