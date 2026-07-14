// ============================================================
//  EXPLORE C — Add to the Score
//  STEM Through Games · Day 4 · Minecraft Education Edition
// ============================================================
//
//  GOAL: Use score = score + 10 to update a variable.
//  Watch how the VALUE changes but the NAME stays the same.
//
//  QUESTION TO THINK ABOUT:
//    What is score now after adding 10?
//    What math operation happened? Can you write it as
//    a math equation (e.g., 0 + 10 = ?)?
//
// ============================================================

let playerName = "Hero"
let health = 100
let score = 0

// Show the score BEFORE adding points
player.say("Score before: " + score)

// Update the score — open the chest, add 10, put it back
score = score + 10

// Show the score AFTER adding points
player.say("Score after: " + score)

// Show the other variables too
player.say(playerName)
player.say("Health: " + health)

// ============================================================
//  WHAT SHOULD HAPPEN:
//  "Score before: 0"
//  "Score after: 10"
//  "Hero"
//  "Health: 100"
//
//  KEY IDEA:
//  score = score + 10  is like saying:
//    "Open the score chest, take out what's there,
//     add 10 to it, and put the new total back."
//
//  This is ADDITION — one of the most common operations
//  in every game ever made!
//
//  CHALLENGE: Can you add 10 points THREE separate times?
//             What will the final score be?
// ============================================================
