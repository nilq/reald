project = (fov, ...) ->
    point = {...}

    scale = fov / (fov + point[#point])

    _point = {}

    for c in *point
        _point[#_point + 1] = c * scale

        if #_point - (#point - 1) == 0
            return _point, scale

project_to = (n, fov, ...) ->
    a, scale = project fov, ...
    if n - #a == 0
        return a, scale
    else
        project_to n, fov, unpack a

line = (fov, p1, p2) ->
    a, s   = project_to 2, fov, unpack p1
    a2, s2 = project_to 2, fov, unpack p2

    with love.graphics
        .line a[1] * s, a[2] * s, a2[1] * s2, a2[2] * s2

circle = (fov, mode, p1, radius, segments) ->
    a, s = project_to 2, fov, unpack p1

    with love.graphics
        .circle mode, a[1] * s, a[2] * s, radius * s, segments

triangle = (fov, mode, p1, p2, p3) ->
    a, s   = project_to 2, fov, unpack p1
    a2, s2 = project_to 2, fov, unpack p2
    a3, s3 = project_to 2, fov, unpack p3

    with love.graphics
        .polygon mode, a[1], a[2], a2[1], a2[2], a3[1], a3[2]

{
    :project
    :project_to

    graphics: {
        :line
        :circle
        :triangle
    }
}