// ============================================================
// STEM Through Games — Day 12: Score, UI & HUD
// FILE: teacher_demo_type_conversion.js
//
// PURPOSE: Live classroom demonstration of the integer vs.
//          string distinction. Run this in MakeCode while
//          projecting to the class.
//
// HOW TO USE:
//   Paste into MakeCode → JavaScript.
//   Type each chat command ("demo1" through "demo5") one at
//   a time, pausing after each to discuss the result.
// ============================================================

// ── DEMO 1: Integer arithmetic ───────────────────────────────
// Show: 42 + 10 = 52  (math works on integers)
player.onChat("demo1", function () {
    let a = 42
    let b = 10
    let result = a + b          // 52 — integer addition

    player.say("Integer + Integer:")
    player.say("  42 + 10 = " + result)
    player.say("  Type: number. Works as expected!")
})

// ── DEMO 2: String concatenation "trap" ──────────────────────
// Show: "42" + "10" = "4210"  (strings join, not add!)
player.onChat("demo2", function () {
    let a = "42"
    let b = "10"
    let result = a + b          // "4210" — string concatenation!

    player.say("String + String:")
    player.say("  \"42\" + \"10\" = " + result)
    player.say("  SURPRISE! Strings JOIN, not add.")
    player.say("  This is why we store score as a NUMBER.")
})

// ── DEMO 3: The mixed-type trick ─────────────────────────────
// Show: "" + 42 = "42"  (empty string forces conversion)
// This is how we build scoreboard commands.
player.onChat("demo3", function () {
    let score = 42
    let command = "/scoreboard players set @p score " + score

    player.say("Building a command string:")
    player.say("  score = " + score + "  (it's a number)")
    player.say("  command = " + command)
    player.say("  The + joined the string and number!")
})

// ── DEMO 4: Why we can't skip the variable ───────────────────
// Show what happens when you try to do math on a string score.
player.onChat("demo4", function () {
    // Imagine score was accidentally stored as a string:
    let badScore = "42"         // String (common mistake)
    badScore += 10              // "4210" — NOT what we want!

    let goodScore = 42          // Number (correct)
    goodScore += 10             // 52    — correct!

    player.say("badScore  (string \"42\") += 10  → " + badScore)
    player.say("goodScore (number  42)   += 10  → " + goodScore)
    player.say("Always declare scores as numbers, not strings!")
})

// ── DEMO 5: The bank analogy ─────────────────────────────────
// Balance stored as number; statement displayed as string.
player.onChat("demo5", function () {
    let balance = 1042           // Stored as integer (for math)
    let newBalance = balance + 500   // Adding a deposit

    // Display string for the "statement"
    let display = "Balance: $" + newBalance

    player.say("Bank stores: " + newBalance + " (number for math)")
    player.say("Bank shows:  " + display + " (string for display)")
    player.say("Same idea as our scoreboard!")
})

// ── TEACHER NOTES ────────────────────────────────────────────
// Run demos in order: demo1 → demo2 → demo3 → demo4 → demo5
//
// KEY MOMENT: Demo 2 is the "aha" moment. Students expect
// "42" + "10" to equal "52". When they see "4210" they
// immediately understand WHY we store scores as integers.
//
// After demo4, ask: "So when would you ever want a score
// stored as a string?" (Answer: almost never — only when
// displaying it, which we do temporarily via concatenation.)
