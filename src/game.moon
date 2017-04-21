export state = {
    x: 0, z: 0, angle: 0, radius: 200
}

with state
    .update = (dt) =>
        .angle += dt

        .x = .radius * math.cos .angle
        .z = .radius * math.sin .angle

    .draw = =>
        reald.graphics.line 300, {.x + 400, 300, .z}, {400, 0, 0}

state