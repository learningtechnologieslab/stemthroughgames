// ============================================================
// DAY 10 — Extension 2: Wave System
// STEM Through Games Program | Minecraft Education + MakeCode
// ============================================================
//
// PURPOSE:
//   Tracks waves explicitly. Every 5th wave is a "boss wave"
//   that doubles the mob count. Students see how a counter
//   variable and the modulo operator (%) create structured
//   escalation — a core game design pattern.
//   This is Extension Challenge 2 from Slide 11.
//
// HOW TO USE:
//   Type in Minecraft chat:
//     "startwave2"   — begin the wave system
//     "stopwave2"    — stop all waves
//     "wavestatus2"  — display current wave and mob count
//
// WAVE STRUCTURE:
//   Normal wave (waves 1-4, 6-9, ...): 2 zombies
//   Boss wave   (waves 5, 10, 15, ...): 4 zombies + 1 skeleton archer
//
// WHAT IS MODULO (%)?
//   waveCount % 5 gives the REMAINDER after dividing by 5.
//   Examples: 5 % 5 = 0, 10 % 5 = 0, 3 % 5 = 3
//   When the result is 0, we know it's a multiple of 5 → boss wave!
// ============================================================


let waveIntervalId: number = null
let waveCount: number = 0
const WAVE_TICK_DELAY: number = 60     // Normal wave: every 3 seconds
const NORMAL_MOB_COUNT: number = 2
const BOSS_MOB_MULTIPLIER: number = 2  // Boss waves spawn 2× the normal mobs


player.onChat("startwave2", function () {

    if (waveIntervalId !== null) {
        player.say("Wave system already running. Type 'stopwave2' first.")
        return
    }

    waveCount = 0
    player.say("Wave system starting! Boss waves every 5th wave.")

    waveIntervalId = game.runInterval(function () {

        waveCount++

        // ── Determine wave type ──────────────────────────────────
        // The modulo operator (%) checks if waveCount is divisible by 5.
        // If waveCount % 5 === 0, it's a boss wave (every 5th wave).
        let isBossWave = (waveCount % 5 === 0)

        let mobsThisWave = isBossWave
            ? NORMAL_MOB_COUNT * BOSS_MOB_MULTIPLIER  // Boss: 4 mobs
            : NORMAL_MOB_COUNT                         // Normal: 2 mobs

        // ── Announce the wave ──────────────────────────────────
        if (isBossWave) {
            player.say("⚠ BOSS WAVE " + waveCount + "! " + mobsThisWave + " mobs incoming!")
        } else {
            player.say("Wave " + waveCount + ": " + mobsThisWave + " mobs")
        }

        // ── Spawn the mobs ─────────────────────────────────────
        for (let i = 0; i < mobsThisWave; i++) {
            let x = Math.randomRange(5, 15)
            let z = Math.randomRange(5, 15)

            if (isBossWave && i === 0) {
                // First mob on a boss wave is a skeleton (ranged threat)
                mobs.spawn(SKELETON, world(x, 64, z))
            } else {
                mobs.spawn(ZOMBIE, world(x, 64, z))
            }
        }

    }, WAVE_TICK_DELAY)
})


player.onChat("stopwave2", function () {

    if (waveIntervalId === null) {
        player.say("No wave system is running.")
        return
    }

    game.clearRun(waveIntervalId)
    waveIntervalId = null

    let bossWavesSurvived = Math.floor(waveCount / 5)
    player.say("Wave system stopped after wave " + waveCount + ".")
    player.say("Boss waves survived: " + bossWavesSurvived)
})


player.onChat("wavestatus2", function () {

    if (waveIntervalId === null) {
        player.say("Wave system not running.")
        return
    }

    let nextBossIn = 5 - (waveCount % 5)
    player.say("Current wave: " + waveCount)
    player.say("Next boss wave in: " + nextBossIn + " wave(s)")
})


// ── UTILITY: Clear zone ──────────────────────────────────
player.onChat("clearzone2", function () {
    blocks.fill(AIR, world(4, 63, 4), world(16, 66, 16))
    player.say("Zone cleared.")
})


// ============================================================
// MATH EXTENSION:
//   After N total waves, how many boss waves have occurred?
//   Answer: Math.floor(N / 5)
//   After N total waves, how many TOTAL mobs have spawned?
//   Normal waves: (N - Math.floor(N/5)) × 2
//   Boss waves:   Math.floor(N/5) × 4
//   Total = 2N + 2 × Math.floor(N/5)
//
//   Example after 20 waves:
//     Normal: (20 - 4) × 2 = 32 mobs
//     Boss:   4 × 4       = 16 mobs
//     Total:  48 mobs
//
// CHALLENGE: Can you add a wave completion check?
//   (Check when all mobs are defeated before starting the next wave)
//   This requires the on-mob-killed event — a preview of Day 11!
// ============================================================
