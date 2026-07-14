// ============================================================
//  EXTENSION ★★★ — Narrative Challenge
//  STEM Through Games · Day 4 · Minecraft Education Edition
// ============================================================
//
//  CHALLENGE: Write variables that tell a character's
//  story. Use those variables to have your character
//  narrate an intro scene — like the opening cutscene
//  of a Minecraft adventure map!
//
//  This combines:
//    • String variables (text/words)
//    • Number variables (stats/data)
//    • String concatenation (joining text + variables)
//
// ============================================================

// --- Character Setup Variables ---
let heroName = "Alex"
let heroClass = "Explorer"      // String: words, not numbers
let maxHealth = 100
let startingWeapon = "Wooden Sword"
let enemyName = "The Ender Dragon"
let questName = "The Lost Key of Overgrown Temple"
let goldCoins = 50
let questLevel = 3

// ============================================================
//  YOUR INTRO SCENE — Character narrates using variables
// ============================================================

player.say("=== A NEW ADVENTURE BEGINS ===")
player.say("")

// Introduce the hero
player.say("My name is " + heroName + ", a brave " + heroClass + ".")
player.say("I start with " + maxHealth + " health and a " + startingWeapon + ".")
player.say("")

// Set the scene
player.say("My quest: " + questName)
player.say("I must face " + enemyName + " — the most feared creature in the land.")
player.say("")

// Show the stakes
player.say("Difficulty: Level " + questLevel + " — this will not be easy.")
player.say("Starting gold: " + goldCoins + " coins.")
player.say("")

player.say("Let the adventure begin!")

// ============================================================
//  EXPECTED OUTPUT:
//  === A NEW ADVENTURE BEGINS ===
//
//  My name is Alex, a brave Explorer.
//  I start with 100 health and a Wooden Sword.
//
//  My quest: The Lost Key of Overgrown Temple
//  I must face The Ender Dragon — the most feared creature in the land.
//
//  Difficulty: Level 3 — this will not be easy.
//  Starting gold: 50 coins.
//
//  Let the adventure begin!
//
// ============================================================
//
//  NOW MAKE IT YOUR OWN:
//  Change every variable to describe YOUR dream adventure.
//  • What is your hero's name and class?
//  • What weapon do you start with?
//  • Who is the villain? What is the quest called?
//  • Add more variables: sidekickName, magicItem, hometown
//  • Can you add a variable for the reward if you win?
//
//  BONUS CHALLENGE:
//  Add a variable called reward and print a final line:
//    "If I succeed, I will earn " + reward + "!"
//
// ============================================================
