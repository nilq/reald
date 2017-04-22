lines = (file) ->
    assert (love.filesystem.isFile file), "#{file} doesn't exist!"
    [line for line in love.filesystem.lines file]

split = (inp, sep="%s") ->
    [t for t in string.gmatch inp, "([^#{sep}]+)"]

class
    new: (file, @r=100, @g=100, @b=0, s=1) =>
        @vertices = {}
        @faces    = {}

        for i, v in ipairs lines file
            if "v " == string.sub v, 1, 2
                v_line = split (v\sub 3), " "

                table.insert @vertices, [(s * tonumber a) for a in *v_line]

            if "f " == string.sub v, 1, 2
                v_line = split (v\sub 3), " "

                table.insert @faces, [(tonumber a) for a in *v_line]
        
        @width, @height = 0, 0
        for v in *@vertices
            @width  = v[1] if v[1] > @width
            @height = v[2] if v[2] > @height

    move: (...) =>
        d = {...}
        for v in *@vertices
            for i = 1, #d
                v[i] += d[i]

    draw: =>
        love.graphics.push!
        love.graphics.translate 0, 0

        for p in *@faces
            love.graphics.setColor @r, @g, @b
            reald.graphics.triangle fov or 250, "fill", @vertices[p[1]], @vertices[p[2]], @vertices[p[3]]

        love.graphics.pop!
