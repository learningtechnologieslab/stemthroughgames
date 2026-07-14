// ============================================================
// BUG 2 – EVENT NOT TRIGGERING  (BUGGY VERSION)
// MakeCode JavaScript for Minecraft Education Edition
// ============================================================
//
// WHAT THIS IS SUPPOSED TO DO:
//   - A checkpoint system for a parkour course
//   - Walking over an EMERALD BLOCK saves your progress
//   - Chat confirms when a checkpoint is reached
//
// WHAT ACTUALLY HAPPENS:
//   - Nothing happens when the player walks over emerald blocks
//   - The checkpoint message never appears
//   - No error — just silence
//
// YOUR DEBUGGING CHALLENGE:
//   1. Build a small test area with both an EMERALD BLOCK and
//      a DIAMOND BLOCK on the ground
//   2. Add say("walk event fired") at the very top of the
//      event handler — does it appear when you walk at all?
//   3. Try stepping on both block types — does either trigger?
//   4. Open the MakeCode editor. Look at what block type the
//      isOnBlock() check uses. Is it correct?
// ============================================================

let checkpointsReached = 0;

player.onTravelled(TravelMethod.Walk, function () {
    
    // ❌ BUG IS HERE: checking for diamond_block instead of emerald_block
    //    The player is supposed to step on EMERALD blocks, but the code
    //    is listening for DIAMOND blocks. Silence is the result.
    if (player.isOnBlock(blocks.diamond_block)) {
        checkpointsReached = checkpointsReached + 1;
        player.say("✅ Checkpoint " + checkpointsReached + " reached!");
    }
});
