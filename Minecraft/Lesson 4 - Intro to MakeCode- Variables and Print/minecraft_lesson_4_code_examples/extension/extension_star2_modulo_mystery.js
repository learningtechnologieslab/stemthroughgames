// ============================================================
//  EXTENSION ★★ — Modulo Mystery
//  STEM Through Games · Day 4 · Minecraft Education Edition
// ============================================================
//
//  CHALLENGE: Explore the % (modulo) operator.
//  Figure out what it does and WHY game developers use it.
//
//  The % operator gives you the REMAINDER after division.
//  Example: 10 % 3 means "what is left over when you
//           divide 10 by 3?"
//           10 ÷ 3 = 3 remainder 1  →  result: 1
//
// ============================================================

// --- Part 1: Discover the pattern ---
player.say("=== MODULO PATTERNS ===")

player.say("10 % 3 = " + (10 % 3))     // What do you get?
player.say("11 % 3 = " + (11 % 3))
player.say("12 % 3 = " + (12 % 3))
player.say("13 % 3 = " + (13 % 3))
player.say("14 % 3 = " + (14 % 3))
player.say("15 % 3 = " + (15 % 3))

// QUESTION: Do you see a pattern? What repeats?


// --- Part 2: Why does this matter in games? ---
// In Minecraft, imagine you want to give the player a bonus
// diamond every 10 points. % lets you check for that!

player.say("=== MILESTONE CHECK ===")

let scores = [10, 15, 20, 23, 30]

// Check each score manually:
player.say("score 10 → 10%10 = " + (10 % 10))   // 0 = milestone!
player.say("score 15 → 15%10 = " + (15 % 10))   // 5 = not yet
player.say("score 20 → 20%10 = " + (20 % 10))   // 0 = milestone!
player.say("score 23 → 23%10 = " + (23 % 10))   // 3 = not yet
player.say("score 30 → 30%10 = " + (30 % 10))   // 0 = milestone!

// When the result is 0, it's a perfect milestone.
// Real games use this for:
//   • Bonus rewards every N points
//   • Spawning enemies every N seconds
//   • Leveling up every N experience points


// --- Part 3: Day/Night Cycle ---
// Minecraft's day/night cycle repeats every 24,000 ticks.
// Modulo lets you find where in the cycle you are!
player.say("=== DAY/NIGHT CYCLE ===")

let gameTick = 36500        // Some point in the game
let timeOfDay = gameTick % 24000
player.say("Time of day: " + timeOfDay)
// This tells you the position within the CURRENT day,
// no matter how many days have passed!

// ============================================================
//  EXPECTED OUTPUT (partial):
//  10 % 3 = 1
//  11 % 3 = 2
//  12 % 3 = 0   ← resets!
//  13 % 3 = 1
//  14 % 3 = 2
//  15 % 3 = 0   ← resets again!
//
//  score 10 → 10%10 = 0   (milestone!)
//  score 15 → 15%10 = 5   (not yet)
//  score 20 → 20%10 = 0   (milestone!)
//  ...
//
//  THINK ABOUT IT:
//  What is the pattern of 10 % 3 results?
//  Why does the result always reset to 0?
//  What does that have to do with repeating events in games?
// ============================================================
