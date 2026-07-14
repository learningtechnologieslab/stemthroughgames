// ============================================================
// STEM Through Games — Day 12: Score, UI & HUD
// FILE: step3_countdown_timer.js
//
// PURPOSE: Challenge extension — adds a countdown timer to
//          the HUD. Builds on step2_basic_hud.js by adding
//          a third scoreboard objective (timer).
//
// HOW TO USE:
//   This file is the COMPLETE script (replaces step2).
//   Paste it into MakeCode → JavaScript and click Play.
//   Type "start" in chat to begin. Type "pause" to pause.
//
// MATH FOCUS:
//   remaining_seconds = MAX_SECONDS - elapsed_seconds
//   This is the linear function: y = b - x
//   where b = 60 (the starting value) and x grows over time.
//
// CONCEPTS COVERED:
//   • Everything from step2_basic_hud.js
//   • loops.everyInterval() — runs code on a schedule
//   • Math.floor() — truncate decimals (like int() in Python)
//   • Boolean flag (timerRunning) to pause/resume
//   • Conditional: game-over when timer reaches zero
// ============================================================

// ── CONSTANTS ────────────────────────────────────────────────
// const = a value that NEVER changes after initialization.
// 60 seconds × 20 ticks/second = 1200 ticks total.
// Minecraft runs at 20 game ticks per second.

const MAX_SECONDS = 60      // Change this to adjust game length

// ── VARIABLES ────────────────────────────────────────────────
let playerScore = 0
let playerHealth = 20
let elapsedSeconds = 0      // Counts UP from 0
let timerRunning = false    // Starts paused until "start" chat command

// ── INITIALIZATION ───────────────────────────────────────────
player.onChat("start", function () {
    playerScore = 0
    playerHealth = 20
    elapsedSeconds = 0
    timerRunning = true

    updateScoreDisplay()
    updateHealthDisplay()
    updateTimerDisplay()

    player.say("Game started! You have " + MAX_SECONDS + " seconds. Good luck!")
})

// Pause command — useful for demos and debugging
player.onChat("pause", function () {
    timerRunning = !timerRunning     // Toggle: true → false, false → true
    if (timerRunning) {
        player.say("Timer resumed.")
    } else {
        player.say("Timer paused.")
    }
})

// ── SCORE EVENT ──────────────────────────────────────────────
player.onItemPickedUp(DIRT, function () {
    playerScore += 10
    updateScoreDisplay()
})

// ── HEALTH EVENT ─────────────────────────────────────────────
player.onEntityHurt(PLAYER, function () {
    playerHealth -= 5
    if (playerHealth < 0) { playerHealth = 0 }
    updateHealthDisplay()

    // BONUS CHALLENGE: pause the timer if player dies
    if (playerHealth === 0) {
        timerRunning = false
        player.say("You ran out of health! Final score: " + playerScore)
    }
})

// ── TIMER LOOP ───────────────────────────────────────────────
// loops.everyInterval(1000) runs the function every 1000 ms = 1 second.
// This is more readable for students than tracking ticks manually.
//
// MATH BREAKDOWN:
//   elapsedSeconds += 1              ← x grows by 1 each second
//   remaining = MAX_SECONDS - elapsed ← y = b - x  (linear function!)
//   When elapsed = 60, remaining = 0  ← zero condition = game over

loops.everyInterval(1000, function () {
    if (timerRunning) {
        elapsedSeconds += 1

        let remainingSeconds = MAX_SECONDS - elapsedSeconds

        // Clamp: can't go below zero
        if (remainingSeconds <= 0) {
            remainingSeconds = 0
            timerRunning = false
            onTimerExpired()
        }

        // Update the scoreboard display
        gameplay.executeCommand(
            "/scoreboard players set @p timer " + remainingSeconds
        )

        // BONUS CHALLENGE: warn player when time is running low
        if (remainingSeconds === 10) {
            gameplay.executeCommand(
                "/title @p title §c10 seconds left!"
            )
        }
    }
})

// ── GAME OVER ────────────────────────────────────────────────
// Called when the timer reaches zero.
// Uses the /title command to show a big message on screen.

function onTimerExpired() {
    gameplay.executeCommand("/title @p title §6Time's Up!")
    gameplay.executeCommand(
        "/title @p subtitle §eFinal Score: " + playerScore
    )
    player.say("Game over! Final score: " + playerScore)
}

// ── HELPER FUNCTIONS ─────────────────────────────────────────
function updateScoreDisplay() {
    gameplay.executeCommand(
        "/scoreboard players set @p score " + playerScore
    )
}

function updateHealthDisplay() {
    gameplay.executeCommand(
        "/scoreboard players set @p health " + playerHealth
    )
}

function updateTimerDisplay() {
    gameplay.executeCommand(
        "/scoreboard players set @p timer " + MAX_SECONDS
    )
}

// ── MATH EXTENSION: BONUS TIMER FORMAT (MM:SS) ───────────────
// CHALLENGE: Uncomment the function below and call it instead of
// the plain number display. It shows "1:05" instead of "65".
//
// function formatTime(totalSeconds) {
//     let minutes = Math.floor(totalSeconds / 60)
//     let seconds = totalSeconds % 60
//     // Pad seconds with a leading zero if needed (e.g. "05" not "5")
//     let paddedSeconds = seconds < 10 ? "0" + seconds : "" + seconds
//     return minutes + ":" + paddedSeconds
// }
//
// DISCUSSION:
//   • What does Math.floor(65 / 60) return? (1)
//   • What does 65 % 60 return? (5)  ← the % operator is "modulo"
//   • What is modulo useful for in game design?
