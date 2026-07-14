// ============================================================
// STEM Through Games — Day 12: Score, UI & HUD
// FILE: extension_multiplayer_leaderboard.js
//
// PURPOSE: Advanced extension — uses the scoreboard sidebar
//          to show a live leaderboard ranking ALL players
//          by score, automatically sorted by Minecraft.
//
// RECOMMENDED FOR: Advanced students / Day 13 preview
//
// KEY INSIGHT:
//   When multiple players have the same scoreboard objective,
//   Minecraft's sidebar AUTOMATICALLY sorts them highest first.
//   This gives us a free leaderboard with zero extra code!
//
// NEW CONCEPTS:
//   • @a selector (all players vs @p nearest player)
//   • Sidebar as a sorted leaderboard
//   • Per-player score tracking
// ============================================================

// ── HOW THE LEADERBOARD WORKS ────────────────────────────────
// Normal HUD:  /scoreboard players set @p score 42
//              (@p = nearest player only)
//
// Leaderboard: /scoreboard players set @p score 42
//              (Each player runs this on THEIR own client)
//              The sidebar shows ALL players, sorted by score.
//
// Minecraft sorts the sidebar automatically — highest score first!
// ─────────────────────────────────────────────────────────────

// ── STATE ────────────────────────────────────────────────────
let myScore = 0
let myHealth = 20

// ── INITIALIZATION ───────────────────────────────────────────
// IMPORTANT: Every player must run the "start" command on their
// own device to register on the scoreboard.

player.onChat("start", function () {
    myScore = 0
    myHealth = 20
    gameplay.executeCommand("/scoreboard players set @p score 0")
    gameplay.executeCommand("/scoreboard players set @p health 20")
    player.say("Joined the game! Collect items to climb the leaderboard!")
})

// ── SCORE EVENT ──────────────────────────────────────────────
// @p targets ONLY this player — critical in multiplayer so
// each player only updates their OWN score.

player.onItemPickedUp(DIRT, function () {
    myScore += 10
    gameplay.executeCommand(
        "/scoreboard players set @p score " + myScore
    )
})

player.onItemPickedUp(DIAMOND, function () {
    myScore += 150
    gameplay.executeCommand(
        "/scoreboard players set @p score " + myScore
    )
})

// ── HEALTH EVENT ─────────────────────────────────────────────
player.onEntityHurt(PLAYER, function () {
    myHealth -= 5
    if (myHealth < 0) { myHealth = 0 }
    gameplay.executeCommand(
        "/scoreboard players set @p health " + myHealth
    )
})

// ── TEACHER: RESET ALL SCORES ────────────────────────────────
// Only the teacher/operator should run this.
// @a = ALL players in the world.
// Type "resetall" in chat to zero out every player's score.

player.onChat("resetall", function () {
    gameplay.executeCommand("/scoreboard players set @a score 0")
    gameplay.executeCommand("/scoreboard players set @a health 20")
    player.say("All scores reset!")
})

// ── SETUP COMMANDS ───────────────────────────────────────────
// Run these ONCE in chat before playing:
//
//   /scoreboard objectives add score dummy Score
//   /scoreboard objectives add health dummy Health
//   /scoreboard objectives setdisplay sidebar score
//
// The sidebar will show all players ranked by score.
// No extra code needed — Minecraft sorts it automatically!

// ── DISCUSSION QUESTIONS ─────────────────────────────────────
// 1. What is the difference between @p and @a?
//    When would you use each?
// 2. Why is it important that each player only updates THEIR
//    OWN score using @p rather than @a?
// 3. How does Minecraft know to sort the leaderboard?
//    (It's automatic — the sidebar always shows highest first.)
// 4. What would happen if two players had the exact same score?
