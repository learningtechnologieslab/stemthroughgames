// ============================================================
//  EXTENSION ★ — More Variables
//  STEM Through Games · Day 4 · Minecraft Education Edition
// ============================================================
//
//  CHALLENGE: Create variables for level, lives, and
//  enemyCount. Have your character say them all.
//
//  This is similar to the starter script, but YOU decide
//  the starting values. Think about what makes sense
//  for a Minecraft survival game.
//
// ============================================================

// --- Your game's starting stats ---
let playerName = "Hero"
let health = 100
let score = 0
let level = 1           // Which level are we on?
let lives = 3           // How many lives does the player have?
let enemyCount = 10     // How many enemies are in this level?

// --- Display all variables ---
player.say("=== PLAYER STATS ===")
player.say("Name: " + playerName)
player.say("Health: " + health)
player.say("Score: " + score)
player.say("Level: " + level)
player.say("Lives: " + lives)
player.say("Enemies: " + enemyCount)

// ============================================================
//  EXPECTED OUTPUT:
//  === PLAYER STATS ===
//  Name: Hero
//  Health: 100
//  Score: 0
//  Level: 1
//  Lives: 3
//  Enemies: 10
//
//  TRY THESE VARIATIONS:
//  • Change enemyCount to 20 — harder level!
//  • What would level = 5 look like? Update enemies too.
//  • What if lives = 1? That's "Hardcore Mode" in Minecraft!
// ============================================================
