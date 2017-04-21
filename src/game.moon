state = {
    x: 0
}

with state
    .update = (dt) =>
        .x += dt * 25

    .draw = =>
        love.graphics.circle "fill", .x, 100, 100

state