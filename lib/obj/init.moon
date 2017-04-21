lines = (file) ->
    assert (love.filesystem.isFile file), "#{file} doesn't exist!"
    [line for line in love.filesystem.lines file]

split = (inp, sep="%s") ->
    [t for t in string.gmatch inp, "([^#{sep}]+)"]

class
    new: (file) =>
        @vertices = {}
        @faces    = {}

        @r, @g, @b = (math.random 0, 255), (math.random 0, 255), math.random 0, 255

        for i, v in ipairs lines file
            if "v " == string.sub v, 1, 2
                v_line = split (v\sub 3), " "

                table.insert @vertices, [(tonumber a) for a in *v_line]

            if "f " == string.sub v, 1, 2
                v_line = split (v\sub 3), " "

                table.insert @faces, [(tonumber a) for a in *v_line]

    debug_draw: =>
        love.graphics.push!
        love.graphics.translate love.graphics.getWidth! / 2, love.graphics.getHeight! / 2

        for p in *@faces
            love.graphics.setColor @r, @g, @b
            reald.graphics.triangle 250, "fill", @vertices[p[1]], @vertices[p[2]], @vertices[p[3]]

        love.graphics.pop!
