// ============================================================
// DAY 10 — Activity 2: Timed Mob Spawning with game.runInterval()
// STEM Through Games Program | Minecraft Education + MakeCode
// ============================================================
//
// PURPOSE:
//   Sets up a repeating interval (like Godot's Timer node) that
//   spawns a zombie every 3 seconds (60 game ticks). Students
//   experience how timed loops create escalating pressure in games.
//   This is the main Activity 2 from Slide 8.
//
// HOW TO USE:
//   1. Open MakeCode for your Minecraft Education world.
//   2. Switch to JavaScript view.
//   3. Paste this entire file into the editor.
//   4. Click "Play" to sync with Minecraft.
//   5. Type "startwave" in Minecraft chat to begin mob spawning.
//   6. Type "stopwave" to stop the interval.
//   7. Switch to Survival or Adventure mode to feel the danger!
//      (In Creative mode, mobs cannot harm you.)
//
// TIMING REFERENCE:
//   Minecraft runs at ~20 ticks per second.
//   60 ticks ÷ 20 ticks/sec = 3 seconds between spawns.
//
// IMPORTANT — WORLD SETUP:
//   The spawn zone uses coordinates x: 5–15, z: 5–15, y: 64.
//   Make sure this area is clear before starting.
//   Type "clearzone" to remove any blocks there first.
// ============================================================


// ── INTERVAL HANDLE ───────────────────────────────────────
// game.runInterval() returns an ID we can use to STOP it later.
// We store it in a variable so "stopwave" can cancel it.
// null means "no interval is running yet."

let spawnIntervalId: number = null


// ── BASE ACTIVITY: Start Spawning (matches Slide 8) ───────
// Type "startwave" in chat to begin.

player.onChat("startwave", function () {

    // Safety check: don't start a second interval if one is already running
    if (spawnIntervalId !== null) {
        player.say("Wave is already running! Type 'stopwave' first.")
        return
    }

    player.say("Wave starting! A zombie will spawn every 3 seconds.")
    player.say("Type 'stopwave' to end the wave.")

    // game.runInterval(callback, tickDelay)
    //   callback   = the function to run each time the interval fires
    //   tickDelay  = how many ticks to wait between runs (60 = ~3 seconds)

    spawnIntervalId = game.runInterval(function () {

        // Pick a random X and Z within the spawn zone
        let x = Math.randomRange(5, 15)
        let z = Math.randomRange(5, 15)

        // mobs.spawn(mobType, position)
        mobs.spawn(ZOMBIE, world(x, 64, z))

    }, 60)  // ← 60 ticks between each spawn
})


// ── STOP THE WAVE ─────────────────────────────────────────
// Type "stopwave" in chat to cancel the interval.
// Without this, zombies spawn forever (or until the world closes).

player.onChat("stopwave", function () {

    if (spawnIntervalId === null) {
        player.say("No wave is running.")
        return
    }

    // Cancel the interval using its ID
    game.clearRun(spawnIntervalId)
    spawnIntervalId = null

    player.say("Wave stopped!")
})


// ── VARIANT: Faster Spawn Rate ────────────────────────────
// Type "fastwave" to start a wave with a 1-second interval.
// Students can compare the tension between 3-second and 1-second waves.

let fastIntervalId: number = null

player.onChat("fastwave", function () {

    if (fastIntervalId !== null) {
        player.say("Fast wave is already running! Type 'stopfastwave' first.")
        return
    }

    player.say("FAST WAVE! Zombie every 1 second. Survive if you can!")

    fastIntervalId = game.runInterval(function () {
        let x = Math.randomRange(5, 15)
        let z = Math.randomRange(5, 15)
        mobs.spawn(ZOMBIE, world(x, 64, z))
    }, 20)  // ← 20 ticks = 1 second
})

player.onChat("stopfastwave", function () {
    if (fastIntervalId === null) {
        player.say("No fast wave is running.")
        return
    }
    game.clearRun(fastIntervalId)
    fastIntervalId = null
    player.say("Fast wave stopped!")
})


// ── VARIANT: Spawn Multiple Mobs Per Tick ─────────────────
// Type "multiwave" to spawn 3 zombies at once every 3 seconds.
// This combines the for loop (Activity 1) with the interval (Activity 2).

let multiIntervalId: number = null

player.onChat("multiwave", function () {

    if (multiIntervalId !== null) {
        player.say("Multi wave already running! Type 'stopmultiwave' to stop.")
        return
    }

    player.say("Multi-wave! 3 zombies every 3 seconds.")

    multiIntervalId = game.runInterval(function () {

        // A for loop INSIDE the interval callback — combines both skills
        for (let i = 0; i < 3; i++) {
            let x = Math.randomRange(5, 15)
            let z = Math.randomRange(5, 15)
            mobs.spawn(ZOMBIE, world(x, 64, z))
        }

    }, 60)
})

player.onChat("stopmultiwave", function () {
    if (multiIntervalId !== null) {
        game.clearRun(multiIntervalId)
        multiIntervalId = null
        player.say("Multi-wave stopped!")
    }
})


// ── UTILITY: Clear the Spawn Zone ─────────────────────────
player.onChat("clearzone", function () {
    blocks.fill(AIR, world(4, 63, 4), world(16, 66, 16))
    player.say("Spawn zone cleared.")
})


// ── UTILITY: Stop ALL intervals at once ───────────────────
player.onChat("stopall", function () {
    if (spawnIntervalId !== null) { game.clearRun(spawnIntervalId); spawnIntervalId = null }
    if (fastIntervalId !== null)  { game.clearRun(fastIntervalId);  fastIntervalId  = null }
    if (multiIntervalId !== null) { game.clearRun(multiIntervalId); multiIntervalId = null }
    player.say("All waves stopped.")
})


// ============================================================
// REFLECTION QUESTIONS (from Slide 13):
//   1. What is the difference between "startwave" and "fastwave"?
//      Which number in the code controls the speed?
//   2. In "multiwave", there is a for loop INSIDE the interval.
//      How many total zombies spawn after 30 seconds?
//      (Answer: 30 sec ÷ 3 sec/wave × 3 mobs/wave = 30 mobs)
//   3. How would you make the game HARDER over time?
//      (Preview of Extension 1 — dynamic difficulty)
// ============================================================
