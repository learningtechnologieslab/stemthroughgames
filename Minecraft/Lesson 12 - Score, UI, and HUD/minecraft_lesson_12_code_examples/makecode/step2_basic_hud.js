// ============================================================
// STEM Through Games — Day 12: Score, UI & HUD
// FILE: step2_basic_hud.js
//
// PURPOSE: Core HUD logic. Two event handlers update the
//          scoreboard whenever the player picks up an item
//          or takes damage.
//
// HOW TO USE:
//   1. Open your Minecraft Education Edition world.
//   2. Press Escape → MakeCode → JavaScript tab.
//   3. Delete all existing code and paste this file in.
//   4. Click "Play" and run the chat command "start" to
//      initialize your HUD.
//
// PREREQUISITES:
//   Run step1_setup_scoreboards.mcfunction first!
//
// CONCEPTS COVERED:
//   • Variables (let)
//   • Event handlers
//   • Arithmetic operators (+=, -=)
//   • String concatenation to build scoreboard commands
//   • @p player selector
// ============================================================

// ── VARIABLES ───────────────────────────────────────────────
// Store score and health as INTEGERS for arithmetic.
// We convert them to strings only when building the command.

let playerScore = 0
let playerHealth = 20

// ── INITIALIZATION ───────────────────────────────────────────
// When the teacher types "start" in chat, reset the HUD
// and show starting values on the sidebar.

player.onChat("start", function () {
    playerScore = 0
    playerHealth = 20
    updateScoreDisplay()
    updateHealthDisplay()
    player.say("HUD initialized! Score: 0 | Health: 20")
})

// ── SCORE UPDATE ─────────────────────────────────────────────
// Each time the player picks up a DIRT block, add 10 points.
//
// TEACHER NOTE: Change DIRT to any other block type from the
// Blocks enum (e.g. GRASS, DIAMOND, GOLD_ORE) to match
// your world's game design.

player.onItemPickedUp(DIRT, function () {
    playerScore += 10          // Integer arithmetic
    updateScoreDisplay()       // Update the sidebar
})

// ── HEALTH UPDATE ────────────────────────────────────────────
// Each time ANY entity hurts the player, subtract 5 from health.
//
// TEACHER NOTE: onEntityHurt tracks combat damage. For hunger
// or fall damage, use player.onFallen() or loops.everyInterval().

player.onEntityHurt(PLAYER, function () {
    playerHealth -= 5

    // Clamp: health can't go below zero
    if (playerHealth < 0) {
        playerHealth = 0
    }

    updateHealthDisplay()
})

// ── HELPER FUNCTIONS ─────────────────────────────────────────
// These functions build the /scoreboard command string and
// send it to Minecraft. Notice how we use + to join a string
// and an integer — JavaScript converts the integer to a string
// automatically when one side of + is already a string.
//
//   "/scoreboard players set @p score "  ← string
//   +  42                                ← integer → "42"
//   =  "/scoreboard players set @p score 42"

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

// ── DISCUSSION QUESTIONS ─────────────────────────────────────
// 1. What would happen if we wrote: playerScore = playerScore + "10"
//    instead of playerScore += 10 ? Try it and observe the result!
//
// 2. Why do we need TWO separate variables (playerScore, playerHealth)
//    instead of just one?
//
// 3. What does @p mean? What would @a do differently?
