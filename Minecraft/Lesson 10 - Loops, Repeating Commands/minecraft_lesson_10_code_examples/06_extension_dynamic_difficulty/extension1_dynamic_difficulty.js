// ============================================================
// DAY 10 — Extension 1: Dynamic Difficulty System
// STEM Through Games Program | Minecraft Education + MakeCode
// ============================================================
//
// PURPOSE:
//   Each wave spawns faster than the last — the interval shrinks
//   by 5 ticks every wave. Students see how a single variable
//   (intervalDelay) drives escalating tension.
//   This is Extension Challenge 1 from Slide 11.
//
// HOW TO USE:
//   Type in Minecraft chat:
//     "startdynamic"  — begin the dynamic difficulty wave
//     "stopdynamic"   — stop the wave at any time
//     "wavestatus"    — show current wave number and spawn speed
//
// PROGRESSION EXAMPLE:
//   Wave 1:  60 ticks apart (~3.0 sec)
//   Wave 2:  55 ticks apart (~2.75 sec)
//   Wave 3:  50 ticks apart (~2.5 sec)
//   ...
//   Wave 10: 15 ticks apart (~0.75 sec)  ← very intense!
//   Wave 11+: capped at 10 ticks (minimum speed)
//
// NOTE:
//   game.runInterval() cannot change its speed once started.
//   The trick here: we CANCEL the old interval and START a NEW one
//   with the updated delay each wave. This is a common game
//   programming pattern called "restarting the timer."
// ============================================================


let dynamicIntervalId: number = null
let waveNumber: number = 0
let intervalDelay: number = 60       // Starting delay in ticks (3 seconds)
const MIN_DELAY: number = 10         // Fastest we'll ever go (0.5 seconds)
const DELAY_REDUCTION: number = 5    // How many ticks faster each wave gets


// Helper: start (or restart) the spawn interval at the current delay
function startInterval() {

    // Cancel the previous interval if one is running
    if (dynamicIntervalId !== null) {
        game.clearRun(dynamicIntervalId)
    }

    // Start a new interval at the current (possibly faster) delay
    dynamicIntervalId = game.runInterval(function () {

        waveNumber++

        // Spawn mobs — number of mobs increases with wave number too
        let mobCount = 1 + Math.floor(waveNumber / 3)  // 1 mob, then 2 at wave 3, 3 at wave 6...
        for (let i = 0; i < mobCount; i++) {
            let x = Math.randomRange(5, 15)
            let z = Math.randomRange(5, 15)
            mobs.spawn(ZOMBIE, world(x, 64, z))
        }

        player.say("Wave " + waveNumber + " — " + mobCount + " mobs — interval: " + intervalDelay + " ticks")

        // Reduce the delay for the NEXT wave (but don't go below minimum)
        if (intervalDelay > MIN_DELAY) {
            intervalDelay -= DELAY_REDUCTION
        }

        // Restart the interval with the new, faster delay
        // (We schedule this restart one tick later to avoid calling
        //  startInterval() from inside its own callback)
        game.runTimeout(function () {
            if (dynamicIntervalId !== null) {
                startInterval()
            }
        }, 1)

    }, intervalDelay)
}


player.onChat("startdynamic", function () {

    if (dynamicIntervalId !== null) {
        player.say("Dynamic wave already running. Type 'stopdynamic' first.")
        return
    }

    // Reset state for a fresh run
    waveNumber = 0
    intervalDelay = 60

    player.say("Dynamic difficulty starting! Mobs will spawn faster each wave.")
    player.say("Type 'stopdynamic' to stop.")

    startInterval()
})


player.onChat("stopdynamic", function () {

    if (dynamicIntervalId === null) {
        player.say("No dynamic wave is running.")
        return
    }

    game.clearRun(dynamicIntervalId)
    dynamicIntervalId = null

    player.say("Dynamic wave stopped after wave " + waveNumber + ".")
    player.say("Final speed was " + intervalDelay + " ticks between spawns.")
})


player.onChat("wavestatus", function () {
    if (dynamicIntervalId === null) {
        player.say("No wave running. Type 'startdynamic' to begin.")
    } else {
        let secondsBetween = (intervalDelay / 20).toFixed(2)
        player.say("Wave: " + waveNumber + " | Delay: " + intervalDelay + " ticks (" + secondsBetween + "s)")
    }
})


// ── UTILITY: Clear the zone and reset ──────────────────────
player.onChat("resetdynamic", function () {
    if (dynamicIntervalId !== null) {
        game.clearRun(dynamicIntervalId)
        dynamicIntervalId = null
    }
    waveNumber = 0
    intervalDelay = 60
    blocks.fill(AIR, world(4, 63, 4), world(16, 66, 16))
    player.say("Reset! Wave counter and speed are back to start.")
})


// ============================================================
// MATH CONNECTION:
//   Starting at 60 ticks and reducing by 5 each wave:
//     Wave N delay = 60 - (5 × (N-1)) ticks
//     This hits the minimum of 10 at wave: (60 - 10) / 5 + 1 = 11
//
//   Total time to reach maximum speed:
//     Sum of 60 + 55 + 50 + ... + 15 + 10 (first 11 waves)
//     = 10 × (60 + 10) / 2 = 350 ticks ÷ 20 = ~17.5 seconds
//     (An arithmetic sequence! Great tie-in to CCSS 7th grade patterns)
//
// DISCUSSION: "What number would you change to make the game
//   stay at full speed longer? What would you change to make
//   it ramp up faster?"
// ============================================================
