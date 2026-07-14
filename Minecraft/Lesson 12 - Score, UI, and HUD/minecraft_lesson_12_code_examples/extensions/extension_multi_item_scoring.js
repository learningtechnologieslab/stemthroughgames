// ============================================================
// STEM Through Games — Day 12: Score, UI & HUD
// FILE: extension_multi_item_scoring.js
//
// PURPOSE: Advanced extension — different items are worth
//          different point values, demonstrating arrays,
//          objects, and lookup tables.
//
// RECOMMENDED FOR: Early finishers / advanced students
//
// NEW CONCEPTS:
//   • Objects as lookup tables (key → value maps)
//   • Multiplier systems
//   • Modular function design
// ============================================================

// ── SCORING TABLE ────────────────────────────────────────────
// This object maps item names to their point values.
// Adding a new item is as simple as adding one line here —
// no other code needs to change. This is called a "lookup table".
//
// TEACHER NOTE: Item constants in MakeCode use ALL_CAPS names.
// Common ones: DIRT=1, GRAVEL=3, SAND=4, IRON_ORE, GOLD_ORE,
//              DIAMOND, EMERALD, NETHERITE_SCRAP

const SCORE_TABLE = {
    "dirt":     10,
    "gravel":   25,
    "iron_ore": 50,
    "gold_ore": 75,
    "diamond":  150,
    "emerald":  200
}

// ── STATE ────────────────────────────────────────────────────
let playerScore = 0
let playerHealth = 20
let itemsCollected = 0      // Bonus: track how many items found

// ── INITIALIZATION ───────────────────────────────────────────
player.onChat("start", function () {
    playerScore = 0
    playerHealth = 20
    itemsCollected = 0
    refreshDisplay()
    player.say("Collect items to score! Rarer = more points.")
})

// ── ITEM PICKUP EVENTS ───────────────────────────────────────
// Each item type needs its own onItemPickedUp handler.
// We call the shared addPoints() function to keep code DRY
// (Don't Repeat Yourself).

player.onItemPickedUp(DIRT, function () {
    addPoints("dirt")
})

player.onItemPickedUp(GRAVEL, function () {
    addPoints("gravel")
})

player.onItemPickedUp(IRON_ORE, function () {
    addPoints("iron_ore")
})

player.onItemPickedUp(GOLD_ORE, function () {
    addPoints("gold_ore")
})

player.onItemPickedUp(DIAMOND, function () {
    addPoints("diamond")
})

player.onItemPickedUp(EMERALD, function () {
    addPoints("emerald")
})

// ── HEALTH EVENT ─────────────────────────────────────────────
player.onEntityHurt(PLAYER, function () {
    playerHealth -= 5
    if (playerHealth < 0) { playerHealth = 0 }
    updateHealthDisplay()
})

// ── SHARED SCORING FUNCTION ──────────────────────────────────
// addPoints() does the work for ALL item types.
// It looks up the point value, adds it, and updates the display.
//
// This is called a "helper function" — it avoids repeating the
// same logic six times (once per item type).

function addPoints(itemName) {
    let points = SCORE_TABLE[itemName]  // Look up value in table

    if (points !== undefined) {         // Safety check: item exists in table
        playerScore += points
        itemsCollected += 1
        updateScoreDisplay()

        // Show a brief feedback message
        player.say("+" + points + " pts (" + itemName + ") — Total: " + playerScore)
    }
}

// ── DISPLAY HELPERS ──────────────────────────────────────────
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

function refreshDisplay() {
    updateScoreDisplay()
    updateHealthDisplay()
}

// ── DISCUSSION QUESTIONS ─────────────────────────────────────
// 1. What is SCORE_TABLE["diamond"] equal to? (150)
// 2. Why is it better to store point values in SCORE_TABLE
//    than to hard-code 150 inside the diamond handler?
//    (Hint: what if we want to change all the values at once?)
// 3. What does "DRY" mean in programming? Why does it matter?
// 4. CHALLENGE: Add a "streak bonus" — if the player collects
//    3 items in a row without taking damage, double the next score.
