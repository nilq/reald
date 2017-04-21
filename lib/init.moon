export state = require "lib/state"

with love
    .graphics.setDefaultFilter "nearest", "nearest"

    .run = ->
        dt = 0

        update_time  = 0
        target_delta = 1 / 60

        .math.setRandomSeed os.time! if .math
        .load!                       if .load
        .timer.step!                 if .timer

        state\switch "src/game"

        while true
            update_time += dt

            for name, a, b, c, d, e, f in .event.poll!
                if "quit" == name
                    return a unless .quit or not .quit!
                
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

                state\draw!

                .graphics.present!
            
            .timer.sleep 0.001 if .timer