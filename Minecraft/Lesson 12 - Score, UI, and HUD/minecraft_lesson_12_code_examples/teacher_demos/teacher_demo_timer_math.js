// ============================================================
// STEM Through Games — Day 12: Score, UI & HUD
// FILE: teacher_demo_timer_math.js
//
// PURPOSE: Live demonstration of the countdown timer math.
//          Shows the linear function y = b - x in action
//          and explores the Minecraft tick system.
//
// HOW TO USE:
//   Paste into MakeCode → JavaScript.
//   Type "mathshow" in chat to start the walkthrough.
//   Type "tickdemo" to see Minecraft's tick rate in action.
// ============================================================

// ── MATH WALKTHROUGH ─────────────────────────────────────────
// Type "mathshow" to print a series of values showing how
// remaining_seconds = MAX_SECONDS - elapsed_seconds changes.

player.onChat("mathshow", function () {
    const MAX = 60

    player.say("=== Timer Math: y = " + MAX + " - x ===")
    player.say("")

    // Print the formula at several points in time
    let checkpoints = [0, 10, 30, 50, 59, 60]

    for (let i = 0; i < checkpoints.length; i++) {
        let elapsed = checkpoints[i]
        let remaining = MAX - elapsed
        if (remaining < 0) { remaining = 0 }

        player.say("  elapsed=" + elapsed + "s → remaining=" + remaining + "s")
    }

    player.say("")
    player.say("When elapsed=60, remaining=0 → GAME OVER!")
    player.say("This is y = 60 - x (linear function, slope = -1)")
})

// ── TICK RATE DEMO ───────────────────────────────────────────
// Type "tickdemo" to see how Minecraft's 20-tick/second
// system converts to seconds using integer division.

player.onChat("tickdemo", function () {
    player.say("=== Minecraft Tick System ===")
    player.say("20 ticks = 1 second")
    player.say("")

    let tickValues = [20, 100, 400, 1200, 1800]

    for (let i = 0; i < tickValues.length; i++) {
        let ticks = tickValues[i]
        let seconds = Math.floor(ticks / 20)
        let minutes = Math.floor(seconds / 60)
        let remainSecs = seconds % 60

        player.say("  " + ticks + " ticks = " + seconds + "s = " + minutes + "m " + remainSecs + "s")
    }

    player.say("")
    player.say("Math.floor() truncates: Math.floor(3.7) = 3")
    player.say("Modulo (%): 65 % 60 = 5 (the remainder)")
})

// ── LIVE TIMER DEMO ──────────────────────────────────────────
// Type "livedemo" to run a 10-second countdown that prints
// each value to chat. Great for showing the math update live.

let liveDemoRunning = false
let liveElapsed = 0
const LIVE_MAX = 10

player.onChat("livedemo", function () {
    liveElapsed = 0
    liveDemoRunning = true
    player.say("Starting 10-second live demo...")
    player.say("Watch remaining = " + LIVE_MAX + " - elapsed")
})

loops.everyInterval(1000, function () {
    if (liveDemoRunning) {
        liveElapsed += 1
        let remaining = LIVE_MAX - liveElapsed

        player.say("elapsed=" + liveElapsed + " → remaining=" + remaining)

        if (remaining <= 0) {
            liveDemoRunning = false
            player.say("Done! The formula reached zero at elapsed=" + liveElapsed)
        }
    }
})

// ── BONUS: SLOPE DISCUSSION ──────────────────────────────────
// Type "slope" to show how changing MAX_SECONDS changes the slope.
// (It doesn't — the slope is always -1. What changes is the y-intercept.)

player.onChat("slope", function () {
    player.say("=== Linear Function Analysis ===")
    player.say("remaining = MAX - elapsed")
    player.say("")
    player.say("MAX=60:  y = 60 - x  (y-intercept: 60, slope: -1)")
    player.say("MAX=90:  y = 90 - x  (y-intercept: 90, slope: -1)")
    player.say("MAX=120: y = 120 - x (y-intercept: 120, slope: -1)")
    player.say("")
    player.say("The SLOPE is always -1 (one second lost per second).")
    player.say("MAX changes the Y-INTERCEPT (starting value).")
    player.say("Both lines hit 0 at x = MAX. Different x values!")
})

// ── TEACHER NOTES ────────────────────────────────────────────
// SEQUENCE: mathshow → tickdemo → livedemo → slope
//
// mathshow: prints a table — draw the equivalent on the board
//           as a coordinate table (x=elapsed, y=remaining).
//
// tickdemo: connects game ticks to real time. Ask: "Why does
//           Minecraft use ticks instead of seconds?"
//           (Precision — events need sub-second timing.)
//
// livedemo: the most impactful. Students watch the number
//           count down in real time while the formula runs.
//
// slope: algebra connection. The game timer IS a linear
//        function — slope -1, y-intercept = MAX_SECONDS.
//        Ask: "What would slope -2 mean for a game timer?"
//        (Time would run out twice as fast.)
