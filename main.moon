export reald = require "lib/nd"
export util  = require "lib/util"
export OBJ   = require "lib/obj"

export fov   = 700

math.lerp = (a, b, t) ->
    a + (b - a) * t

require "lib"

love.keypressed = (key, isrepeat) =>
    state\press key