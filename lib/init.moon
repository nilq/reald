export state = require "lib/state"
export bump  = require "lib/bump"
export world = bump.newWorld!

export shine = require "lib/shine"

with love
    .graphics.setDefaultFilter "nearest", "nearest"
    .graphics.setBackgroundColor 200, 255, 255

    grain = shine.filmgrain!
    grain.opacity = 0.2
    grain.grainsize = 7

    vignette = shine.vignette!
    vignette.parameters = {radius: 0.9, opacity: 0.7}

    godsray = shine.godsray!

    desaturate = shine.desaturate {
        strength: 0.6
        tint:     {255, 250, 200}
    }

    post_effect = grain\chain shine.separate_chroma!\chain shine.glowsimple!\chain ((shine.crt!\set "x", .15)\set "y", .15)\chain shine.scanlines!

    .run = ->
        dt = 0

        update_time  = 0
        target_delta = 1 / 60

        .math.setRandomSeed os.time! if .math
        .load!                       if .load
        .timer.step!                 if .timer

        state\switch "src/game"

        state\load!

        while true
            update_time += dt

            if love.event
                .event.pump!

                for name, a, b, c, d, e, f in .event.poll!
                    if "quit" == name
                        return a unless .quit or not .event.quit!

                    .handlers[name] a, b, c, d, e, f

            if .timer
                .timer.step!
                dt = .timer.getDelta!
            
            if update_time > target_delta
                state\update dt

            if .graphics and .graphics.isActive!
                .graphics.clear .graphics.getBackgroundColor!
                .graphics.setColor 255, 255, 255

                .graphics.origin!

                post_effect\draw ->
                    state\draw!

                .graphics.present!

            .timer.sleep 0.001 if .timer