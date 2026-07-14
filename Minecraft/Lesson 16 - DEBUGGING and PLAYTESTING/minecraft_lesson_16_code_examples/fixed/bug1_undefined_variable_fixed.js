// ============================================================
// BUG 1 – UNDEFINED VARIABLE ERROR  (FIXED VERSION)
// MakeCode JavaScript for Minecraft Education Edition
// ============================================================
//
// THE FIX:
//   Move "score" to the TOP LEVEL — outside the event handler.
//   Now it's declared once when the program starts, and every
//   event handler can read and update the same variable.
//
// KEY CONCEPT:
//   Variables declared inside a function only exist while that
//   function is running. Variables declared at the top level
//   ("global scope") persist for the entire program.
//
// DEBUGGING STRATEGY USED:
//   say("score before = " + score) was added before the
//   increment to reveal that score was always 0 at that point.
//   That proved the variable was being re-declared each time.
// ============================================================

// ✅ FIX: declare score at the top level, outside the event
let score = 0;   // ← declared once; survives between events

player.onTravelled(TravelMethod.Walk, function () {
    
    // say("DEBUG: score before = " + score)  // ← the diagnostic that revealed the bug
    
    if (player.isOnBlock(blocks.gold_block)) {
        score = score + 1;
        player.say("💎 Score: " + score);
    }
});

// EXTENSION: Reset score on player death
player.onDied(function () {
    player.say("You died! Final score: " + score);
    score = 0;
});
