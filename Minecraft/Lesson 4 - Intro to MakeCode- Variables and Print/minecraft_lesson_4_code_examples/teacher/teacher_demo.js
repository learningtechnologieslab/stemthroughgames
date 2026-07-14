// ============================================================
//  TEACHER DEMO SCRIPT
//  STEM Through Games · Day 4 · Minecraft Education Edition
//
//  Use this script for live classroom demonstration.
//  Run it section by section using the comments as talking
//  points. Students should have their starter script open
//  and be following along.
//
//  ESTIMATED TIME: 10–15 minutes of live demo
// ============================================================


// ============================================================
//  DEMO SECTION 1: What is a variable?
//  TALKING POINT: "A variable is like a labeled chest in
//  Minecraft. The label (name) never changes, but you can
//  put anything you want inside."
// ============================================================

player.say("=== SECTION 1: Variables ===")

let playerName = "Hero"     // String variable (text)
let health = 100            // Number variable (whole number)
let score = 0               // Number variable starting at zero

player.say("Name:   " + playerName)
player.say("Health: " + health)
player.say("Score:  " + score)

// PAUSE & ASK: "What three things did we just create?"
//              "What type of data does each one hold?"


// ============================================================
//  DEMO SECTION 2: Changing a variable's value
//  TALKING POINT: "We can open a chest and change what's
//  inside. The label stays the same — only the value changes."
// ============================================================

player.say("=== SECTION 2: Changing Values ===")

playerName = "MrSmith"      // Reassign — new value, same label
player.say("Name is now: " + playerName)

// PAUSE & ASK: "Did we create a new variable, or change
//               the old one? How do you know?"
//              (Answer: no 'let' keyword = changing existing)


// ============================================================
//  DEMO SECTION 3: Math with variables
//  TALKING POINT: "All game mechanics are math. Adding score,
//  losing health, getting a speed boost — it's all arithmetic."
// ============================================================

player.say("=== SECTION 3: Math ===")

// Addition — gaining points
player.say("Score before: " + score)
score = score + 10
player.say("Score after +10: " + score)

// Subtraction — taking damage
player.say("Health before: " + health)
health = health - 25
player.say("Health after -25: " + health)

// Multiplication — power-up
let speed = 5
player.say("Speed before: " + speed)
speed = speed * 2
player.say("Speed after *2: " + speed)

// Division — sharing loot
let coins = 20
player.say("Coins to split: " + coins)
coins = coins / 4
player.say("Each player gets: " + coins)

// Modulo — milestone check
player.say("Score % 10 = " + (score % 10))
// PAUSE & ASK: "What does a result of 0 mean?"

// PAUSE & ASK: "Which of these happens in real Minecraft?
//               Can you name the game mechanic for each one?"


// ============================================================
//  DEMO SECTION 4: Strings vs Numbers
//  TALKING POINT: "Variables can hold different TYPES of data.
//  'Hero' is text — we call that a String. 100 is a number."
// ============================================================

player.say("=== SECTION 4: Strings vs Numbers ===")

let greeting = "Hello, "       // String (note the quotes)
let lives = 3                  // Number (no quotes)

// Concatenation: joining strings and variables together
player.say(greeting + playerName)        // "Hello, MrSmith"
player.say("You have " + lives + " lives remaining.")

// PAUSE & ASK: "How did we join the greeting and the name?"
//              "What do the quotes do? What happens without them?"
//              (Show: try lives = "three" — what changes?)


// ============================================================
//  DEMO SECTION 5: Full picture — reading the stats
//  TALKING POINT: "Games read all these variables constantly
//  to know what's happening. This is what the game 'knows'."
// ============================================================

player.say("=== FINAL STATS ===")
player.say("Player: " + playerName)
player.say("Health: " + health + " / 100")
player.say("Score:  " + score)
player.say("Speed:  " + speed)
player.say("Coins:  " + coins)
player.say("Lives:  " + lives)

// CLOSING QUESTION:
// "What would happen to the game if it forgot the score?
//  Or lost track of health? Why do variables matter?"

// ============================================================
//  TEACHER NOTES:
//
//  Common mistakes to watch for as students code today:
//
//  1. Missing quotes around strings:
//       let name = Hero        ← ERROR: Hero is not defined
//       let name = "Hero"      ← CORRECT
//
//  2. Using 'let' when updating (not declaring):
//       let score = score + 10   ← creates a NEW score (broken)
//       score = score + 10       ← CORRECT: updates existing
//
//  3. Forgetting the + to concatenate:
//       player.say("Health: " health)   ← ERROR
//       player.say("Health: " + health) ← CORRECT
//
//  4. Typos in variable names (case-sensitive!):
//       playerName vs PlayerName vs playername — all different!
// ============================================================
