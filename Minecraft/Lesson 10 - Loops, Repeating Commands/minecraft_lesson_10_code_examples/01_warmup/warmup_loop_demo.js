// ============================================================
// DAY 10 WARM-UP — Loop Demo
// STEM Through Games Program | Minecraft Education + MakeCode
// ============================================================
//
// PURPOSE:
//   Demonstrates the most basic loop concept to students.
//   The player types "jump" in chat and Minecraft prints
//   "JUMP!" five times — making the idea of a loop concrete
//   before any coding happens.
//
// HOW TO USE:
//   1. Open MakeCode for your Minecraft Education world.
//   2. Switch to JavaScript view.
//   3. Paste this entire file into the editor.
//   4. Click "Play" to sync with Minecraft.
//   5. In Minecraft chat, type:  jump
//   6. Watch the output appear five times in chat.
//
// DISCUSSION PROMPT (after running):
//   "What if you changed 5 to 10? Or 100?"
//   "What part of this code controls HOW MANY times it runs?"
// ============================================================

// When the player types "jump" in Minecraft chat, this runs:
player.onChat("jump", function () {

    // This loop runs 5 times.
    // Each time, the variable 'i' increases by 1.
    //   i = 0 on the first run
    //   i = 1 on the second run
    //   ...
    //   i = 4 on the fifth (last) run
    for (let i = 0; i < 5; i++) {

        // player.say() prints a message in the Minecraft chat.
        // We use "i + 1" so it shows 1, 2, 3, 4, 5 — not 0, 1, 2, 3, 4.
        player.say("JUMP! (count: " + (i + 1) + ")")
    }

    // This runs AFTER the loop finishes — not inside it.
    player.say("That was a loop! It ran 5 times.")
})


// ============================================================
// CHALLENGE FOR STUDENTS:
//   1. Change 5 to a different number. How does the output change?
//   2. Add a second player.say() INSIDE the loop that prints i*i.
//      What pattern do you see? (0, 1, 4, 9, 16 — perfect squares!)
//   3. What happens if you change "i < 5" to "i <= 5"?
//      How many times does it run now?
// ============================================================
