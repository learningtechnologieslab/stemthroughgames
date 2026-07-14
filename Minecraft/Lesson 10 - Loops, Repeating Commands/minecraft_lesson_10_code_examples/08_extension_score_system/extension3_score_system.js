// ============================================================
// DAY 10 — Extension 3: Score System
// STEM Through Games Program | Minecraft Education + MakeCode
// ============================================================
//
// PURPOSE:
//   A score variable tracks how many diamonds the player collects.
//   The scoreboard updates live in the Minecraft HUD.
//   This is Extension Challenge 3 from Slide 11 and a bridge
//   to Day 11 (Player Collision & Score Systems).
//
// HOW TO USE:
//   Type in Minecraft chat:
//     "startgame"    — spawn diamonds and start the score system
//     "collect"      — manually award 1 point (for testing)
//     "showscore"    — display current score in chat
//     "resetscore"   — set score back to 0
//
// NOTE ON DAY 11:
//   In Day 11, students will replace the manual "collect" command
//   with an automatic on-item-pickup event that fires when the
//   player walks over a diamond block. Today, "collect" is a
//   stand-in so students can test the scoring logic right now.
//
// SCOREBOARD:
//   Minecraft Education supports scoreboard objectives.
//   We create one called "Diamonds" and update it each time
//   the player collects an item.
// ============================================================


// ── SCORE STATE ───────────────────────────────────────────
let playerScore: number = 0
let gameRunning: boolean = false
let scoreIntervalId: number = null


// ── SETUP: Initialize the scoreboard objective ────────────
// This runs once when the script loads.
// It creates a scoreboard category called "Diamonds" if it
// doesn't already exist.

gameplay.executeCommand("/scoreboard objectives add Diamonds dummy Diamonds")
gameplay.executeCommand("/scoreboard objectives setdisplay sidebar Diamonds")


// ── START GAME ────────────────────────────────────────────
player.onChat("startgame", function () {

    if (gameRunning) {
        player.say("Game already running! Type 'resetscore' to start fresh.")
        return
    }

    playerScore = 0
    gameRunning = true
    updateScoreboard()

    player.say("Game started! Diamonds will spawn every 5 seconds.")
    player.say("Type 'collect' when you find a diamond. Score: 0")

    // Spawn diamonds every 5 seconds (100 ticks)
    scoreIntervalId = game.runInterval(function () {

        // Spawn 3 diamonds at random positions
        for (let i = 0; i < 3; i++) {
            let x = Math.randomRange(2, 18)
            let z = Math.randomRange(2, 18)
            blocks.place(DIAMOND, world(x, 64, z))
        }

    }, 100)
})


// ── COLLECT (manual stand-in for Day 11 pickup event) ─────
player.onChat("collect", function () {

    if (!gameRunning) {
        player.say("Start the game first! Type 'startgame'.")
        return
    }

    playerScore++
    updateScoreboard()

    // Milestone messages every 5 points
    if (playerScore % 5 === 0) {
        player.say("🏆 Milestone! Score: " + playerScore)
    } else {
        player.say("Collected a diamond! Score: " + playerScore)
    }
})


// ── SHOW SCORE ────────────────────────────────────────────
player.onChat("showscore", function () {
    player.say("Current score: " + playerScore + " diamonds")
    if (!gameRunning) {
        player.say("(Game is not running — type 'startgame' to begin)")
    }
})


// ── RESET SCORE ───────────────────────────────────────────
player.onChat("resetscore", function () {

    // Stop the interval if one is running
    if (scoreIntervalId !== null) {
        game.clearRun(scoreIntervalId)
        scoreIntervalId = null
    }

    playerScore = 0
    gameRunning = false
    updateScoreboard()

    // Clear diamond blocks from the spawn area
    blocks.fill(AIR, world(0, 64, 0), world(20, 64, 20))

    player.say("Score reset to 0. Type 'startgame' to play again.")
})


// ── HELPER: Update the scoreboard display ─────────────────
// This function is called every time the score changes.
// It writes the new score to the Minecraft scoreboard HUD.

function updateScoreboard() {
    // Set the player's score on the "Diamonds" objective
    gameplay.executeCommand(
        "/scoreboard players set @p Diamonds " + playerScore
    )
}


// ── BONUS: Score with penalty ─────────────────────────────
// Type "penalty" to subtract a point (e.g., when hit by a mob).
// In Day 11 this will be triggered automatically by on-mob-hurt.

player.onChat("penalty", function () {

    if (!gameRunning) return

    if (playerScore > 0) {
        playerScore--
        updateScoreboard()
        player.say("Ouch! Lost a point. Score: " + playerScore)
    } else {
        player.say("Score is already 0 — can't go lower!")
    }
})


// ============================================================
// DAY 11 PREVIEW:
//   Right now "collect" is triggered manually.
//   In Day 11, we'll replace this with:
//
//   mobs.onMobKilled(function (mob) {
//       if (mob.type === ZOMBIE) {
//           playerScore += 10
//           updateScoreboard()
//           player.say("Zombie defeated! +" + 10)
//       }
//   })
//
//   And block pickup detection:
//   blocks.onBlockMined(function (pos) {
//       if (blocks.testForBlock(DIAMOND, pos)) {
//           playerScore++
//           updateScoreboard()
//       }
//   })
//
// CHALLENGE:
//   Add a HIGH SCORE variable that persists across runs.
//   Compare playerScore to highScore after each game.
// ============================================================
