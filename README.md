# reald
the multidimensional game engine

## usage 101

`main.moon` | `main.lua`
```moon
require "lib"
```

`src/game.moon` | `src/game.lua`
```moon
state = {}

with state
  .update = (dt) =>
    -- logic here
  
  .draw = =>
    -- arts stuff here

state
```

## projection 101

`somewhere`
```moon
export reald = require "lib/nd"
```

`somwhere else - perhaps same somewhere ..`
```moon
-- field-of-view constant
export fov = 250 -- nice fov

-- in a draw-thread-function
draw = ->
  with reald
    -- draw line between points
    .graphics.line fov, {100, 100, 100, 100}, {200, 200, 200, 200, 200}
```
