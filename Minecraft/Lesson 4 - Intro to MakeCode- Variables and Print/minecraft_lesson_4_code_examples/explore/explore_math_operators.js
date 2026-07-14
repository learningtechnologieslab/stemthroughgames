// ============================================================
//  MATH OPERATORS DEMO
//  STEM Through Games · Day 4 · Minecraft Education Edition
// ============================================================
//
//  This script demonstrates ALL FIVE math operators (+, -, *, /, %)
//  using real Minecraft game scenarios.
//
//  Run this to see each operator in action!
//
// ============================================================

// --- Starting values ---
let health = 100
let score = 0
let speed = 5
let coins = 20
let potions = 10

// ============================================================
//  OPERATOR 1: + (Addition) — Earning XP
// ============================================================
player.say("=== ADDITION ===")
player.say("Score before: " + score)
score = score + 10          // Picked up a diamond
player.say("Score after +10: " + score)
// Math: 0 + 10 = 10


// ============================================================
//  OPERATOR 2: - (Subtraction) — Taking Damage
// ============================================================
player.say("=== SUBTRACTION ===")
player.say("Health before: " + health)
health = health - 25        // Got hit by a zombie
player.say("Health after -25: " + health)
// Math: 100 - 25 = 75


// ============================================================
//  OPERATOR 3: * (Multiplication) — Speed Boost Potion
// ============================================================
player.say("=== MULTIPLICATION ===")
player.say("Speed before: " + speed)
speed = speed * 2           // Drank a Speed II potion
player.say("Speed after *2: " + speed)
// Math: 5 * 2 = 10


// ============================================================
//  OPERATOR 4: / (Division) — Splitting Loot with Friends
// ============================================================
player.say("=== DIVISION ===")
player.say("Coins before: " + coins)
coins = coins / 4           // Split equally among 4 players
player.say("Each player gets: " + coins)
// Math: 20 / 4 = 5


// ============================================================
//  OPERATOR 5: % (Modulo) — Every 10th Point Milestone
// ============================================================
//  The % operator gives you the REMAINDER after division.
//  Use it to check if something has happened every N times.
player.say("=== MODULO ===")
let currentScore = 30
let remainder = currentScore % 10
player.say("30 % 10 = " + remainder)
// Math: 30 divided by 10 = 3 with remainder 0
// When remainder is 0, the player hit an exact milestone!

let currentScore2 = 33
let remainder2 = currentScore2 % 10
player.say("33 % 10 = " + remainder2)
// Math: 33 divided by 10 = 3 with remainder 3
// Not a milestone — no bonus yet.

// ============================================================
//  FINAL SUMMARY
// ============================================================
player.say("--- FINAL STATS ---")
player.say("Health: " + health)
player.say("Score: " + score)
player.say("Speed: " + speed)
player.say("My coins: " + coins)

// ============================================================
//  EXPECTED OUTPUT:
//  === ADDITION ===
//  Score before: 0
//  Score after +10: 10
//  === SUBTRACTION ===
//  Health before: 100
//  Health after -25: 75
//  === MULTIPLICATION ===
//  Speed before: 5
//  Speed after *2: 10
//  === DIVISION ===
//  Coins before: 20
//  Each player gets: 5
//  === MODULO ===
//  30 % 10 = 0
//  33 % 10 = 3
//  --- FINAL STATS ---
//  Health: 75
//  Score: 10
//  Speed: 10
//  My coins: 5
// ============================================================
