// ============================================================
// BUG 2 – EVENT NOT TRIGGERING  (FIXED VERSION)
// MakeCode JavaScript for Minecraft Education Edition
// ============================================================
//
// THE FIX:
//   Change blocks.diamond_block to blocks.emerald_block to match
//   the actual blocks placed in the world.
//
// KEY CONCEPT:
//   "Silent failure" bugs — where nothing happens and there's
//   no error message — are the hardest to find. The code runs
//   fine; it just never finds what it's looking for.
//
// DEBUGGING STRATEGY USED:
//   Adding say("walk event fired") at the TOP of the handler
//   (before any if-checks) confirmed the event WAS firing.
//   That narrowed the bug to the condition, not the event itself.
//   Then checking each block type individually found the mismatch.
// ============================================================

let checkpointsReached = 0;

player.onTravelled(TravelMethod.Walk, function () {
    
    // Diagnostic line — remove this once the bug is confirmed fixed:
    // say("DEBUG: walk fired, on block = checking...")
    
    // ✅ FIX: emerald_block matches what's actually in the world
    if (player.isOnBlock(blocks.emerald_block)) {
        checkpointsReached = checkpointsReached + 1;
        player.say("✅ Checkpoint " + checkpointsReached + " reached! Keep going!");
        
        // Bonus: give the player a speed boost as a reward
        if (checkpointsReached === 3) {
            player.say("🏆 Final checkpoint! You finished the course!");
        }
    }
});
