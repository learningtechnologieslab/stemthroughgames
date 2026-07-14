// ============================================================
//  COMMON ERRORS & FIXES
//  STEM Through Games · Day 4 · Minecraft Education Edition
//
//  Teacher reference: paste these into MakeCode to show
//  students what errors look like and how to fix them.
//
//  Each section shows a BROKEN version followed by the FIX.
// ============================================================


// ============================================================
//  ERROR 1: Missing quotes around a string
// ============================================================

// ❌ BROKEN — MakeCode will underline 'Hero' in red
// let playerName = Hero

// ✅ FIXED — wrap text values in double quotes
let playerName = "Hero"
player.say("Error 1 fixed: " + playerName)


// ============================================================
//  ERROR 2: Using 'let' when updating (not declaring)
// ============================================================

let score = 0
player.say("Score starts at: " + score)

// ❌ BROKEN — 'let' creates a BRAND NEW variable, shadowing the old one
// let score = score + 10    // This causes a conflict error

// ✅ FIXED — no 'let' when updating an existing variable
score = score + 10
player.say("Score after update: " + score)

// RULE: Use 'let' ONCE per variable (when you first create it).
//       After that, update it WITHOUT 'let'.


// ============================================================
//  ERROR 3: Missing + when joining text and variables
// ============================================================

let health = 100

// ❌ BROKEN — MakeCode will show a red error
// player.say("Health: " health)

// ✅ FIXED — always use + between text and variables
player.say("Health: " + health)
player.say("Error 3 fixed: Health is " + health)


// ============================================================
//  ERROR 4: Variable names are case-sensitive
// ============================================================

let enemyCount = 5

// ❌ BROKEN — these would cause "variable not found" errors:
// player.say("Enemies: " + EnemyCount)      // capital E
// player.say("Enemies: " + enemycount)      // all lowercase
// player.say("Enemies: " + enemy_count)     // underscore version

// ✅ FIXED — use the EXACT same name as when declared
player.say("Enemies: " + enemyCount)         // exact match ✓


// ============================================================
//  ERROR 5: Trying to do math on a string
// ============================================================

let healthString = "100"    // This is TEXT, not a number
let healthNumber = 100      // This is a NUMBER

// ❌ PROBLEM — adding a number to a string "joins" them
//    instead of doing math
player.say("String + 10: " + (healthString + 10))  // "10010" !

// ✅ CORRECT — use numbers (no quotes) for math
player.say("Number + 10: " + (healthNumber + 10))   // 110 ✓

// RULE: Use quotes "" for text/words. No quotes for numbers.


// ============================================================
//  SUMMARY: Quick reference for students
//
//  let variableName = "text"    → declare a string variable
//  let variableName = 100       → declare a number variable
//  variableName = newValue      → UPDATE (no 'let')
//  player.say("text" + var)     → display output in game
//  variable + 10                → addition
//  variable - 25                → subtraction
//  variable * 2                 → multiplication
//  variable / 4                 → division
//  variable % 10                → modulo (remainder)
// ============================================================
