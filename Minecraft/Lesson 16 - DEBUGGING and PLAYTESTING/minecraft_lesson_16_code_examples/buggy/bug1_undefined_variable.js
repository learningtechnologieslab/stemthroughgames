// ============================================================
// BUG 1 – UNDEFINED VARIABLE ERROR  (BUGGY VERSION)
// MakeCode JavaScript for Minecraft Education Edition
// ============================================================
//
// WHAT THIS IS SUPPOSED TO DO:
//   - Player collects diamonds by walking over gold blocks
//   - Score increases by 1 each time
//   - Current score is announced in chat
//
// WHAT ACTUALLY HAPPENS:
//   - Score always shows 0 or prints "undefined"
//   - The counter never actually goes up
//
// YOUR DEBUGGING CHALLENGE:
//   1. Run the world and step on a gold block
//   2. What does the chat say? What did you expect?
//   3. Add a say() block to find out what "score" equals BEFORE
//      the event fires — what do you find?
//   4. Where is the bug?
// ============================================================

// ❌ THE BUG: score is declared INSIDE the event handler.
//    Every time the player steps on a block, JavaScript
//    creates a brand-new variable called "score" starting at 0,
//    adds 1 to it (making it 1), prints 1, then throws it away.
//    The variable never survives between steps.

player.onTravelled(TravelMethod.Walk, function () {
    let score = 0;           // ← BUG IS HERE: this resets every time!
    
    if (player.isOnBlock(blocks.gold_block)) {
        score = score + 1;
        player.say("Score: " + score);
    }
});
