// ============================================================
//  EXPLORE D — Take Damage!
//  STEM Through Games · Day 4 · Minecraft Education Edition
// ============================================================
//
//  GOAL: Subtract from health to simulate taking damage,
//  just like getting hit by a zombie in Minecraft.
//
//  QUESTION TO THINK ABOUT:
//    What number does your character say after taking damage?
//    How does health = health - 25 connect to real
//    Minecraft combat mechanics?
//
// ============================================================

let playerName = "Hero"
let health = 100
let score = 0

// Show health BEFORE taking damage
player.say("Health before: " + health)

// Take damage — subtract 25 hit points
health = health - 25

// Show health AFTER taking damage
player.say("Health after: " + health)

// What if we get hit AGAIN?
health = health - 25
player.say("After 2nd hit: " + health)

// Show all variables
player.say(playerName + " final health: " + health)
player.say("Score: " + score)

// ============================================================
//  WHAT SHOULD HAPPEN:
//  "Health before: 100"
//  "Health after: 75"
//  "After 2nd hit: 50"
//  "Hero final health: 50"
//  "Score: 0"
//
//  KEY IDEA:
//  health = health - 25  is SUBTRACTION.
//  Every time a Minecraft mob hits you, the game is running
//  code exactly like this behind the scenes!
//
//  MATH CONNECTION:
//    100 - 25 = 75   (first hit)
//     75 - 25 = 50   (second hit)
//
//  CHALLENGE: How many hits of 25 damage does it take
//             to reach 0 health? Write it out as math.
// ============================================================
