lines = (file) ->
    assert (love.filesystem.isFile file), "#{file} doesn't exist!"
    [line for line in love.filesystem.lines file]

split = (inp, sep="%s") ->
    [t for t in string.gmatch inp, "([^#{sep}]+)"]

class
    new: (file) =>
        @vertices = {}

        for i, v in ipairs lines file
            if "v " == string.sub v, 1, 2
                v_line = split (v\sub 3), " "

                table.insert @vertices, [(tonumber a) for a in *v_line]

    debug_draw: =>
        love.graphics.push!
        love.graphics.translate 100, 100

        for p in *@vertices
            love.graphics.setColor 255, 255, 255
            reald.graphics.circle 500, "fill", p, 2

        love.graphics.pop!
