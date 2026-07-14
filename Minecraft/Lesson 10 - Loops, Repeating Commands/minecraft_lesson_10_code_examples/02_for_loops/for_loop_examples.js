// ============================================================
// DAY 10 — For Loop Examples
// STEM Through Games Program | Minecraft Education + MakeCode
// ============================================================
//
// PURPOSE:
//   Three progressively complex for loop examples used during
//   the 15-minute Direct Instruction segment (Slide 6).
//
//   Example A — Basic counter (matches Slide 6 exactly)
//   Example B — Loop places a row of blocks in the world
//   Example C — Loop builds a staircase (loop variable as height)
//
// HOW TO USE:
//   This file contains three separate on-chat commands.
//   Type each trigger word in Minecraft chat to run it:
//     "countme"  — prints 0 through 4 in chat
//     "rowtest"  — places 8 grass blocks in a row
//     "staircase" — builds a 6-step staircase upward
//
// TEACHER TIP:
//   Run "countme" first to show the counter.
//   Run "rowtest" to show the loop acting in the 3D world.
//   Run "staircase" last — the loop variable (i) controls HEIGHT,
//   which is a great bridge to the math concept of a variable.
// ============================================================


// ── EXAMPLE A: Basic Counter ──────────────────────────────
// The simplest for loop. Maps directly to what's on Slide 6.
// Output in chat: "Loop count: 0" through "Loop count: 4"

player.onChat("countme", function () {

    player.say("Starting the loop...")

    for (let i = 0; i < 5; i++) {
        player.say("Loop count: " + i)
    }

    player.say("Loop finished!")
})


// ── EXAMPLE B: Place a Row of Blocks ─────────────────────
// The loop variable 'i' is used as the X offset, so each block
// is placed one step further to the right than the last.
// This visually shows that 'i' is DOING something — not just counting.

player.onChat("rowtest", function () {

    // blocks.place(blockType, position)
    // world(x, y, z) gives us absolute world coordinates.
    // We start at the player's current X position and go right.

    let startX = Math.round(player.position().getValue(Axis.X))
    let startY = Math.round(player.position().getValue(Axis.Y)) - 1 // one block below player feet
    let startZ = Math.round(player.position().getValue(Axis.Z))

    for (let i = 0; i < 8; i++) {
        // Each iteration, X increases by 1 — making a row 8 blocks long
        blocks.place(GRASS, world(startX + i, startY, startZ))
    }

    player.say("Placed a row of 8 grass blocks!")
})


// ── EXAMPLE C: Build a Staircase ──────────────────────────
// Here 'i' controls BOTH the horizontal position AND the height.
// This makes the loop variable's role very visual and concrete.
// Each step goes one block right (+X) and one block up (+Y).

player.onChat("staircase", function () {

    let startX = Math.round(player.position().getValue(Axis.X))
    let startY = Math.round(player.position().getValue(Axis.Y))
    let startZ = Math.round(player.position().getValue(Axis.Z))

    for (let i = 0; i < 6; i++) {
        // i controls BOTH how far right AND how high each step is
        blocks.place(OAK_PLANKS, world(startX + i, startY + i, startZ))
    }

    player.say("Built a 6-step staircase! Count the steps.")
})


// ============================================================
// CHALLENGE FOR STUDENTS:
//   1. In "rowtest": change 8 to 20. What changes in the world?
//   2. In "rowtest": change GRASS to GOLD_BLOCK. What happens?
//   3. In "staircase": make it go 10 steps instead of 6.
//   4. HARD: In "staircase", can you also fill in the blocks
//      BELOW each step so it looks like a solid staircase?
//      Hint: you'll need a second loop inside the first (nested loop).
// ============================================================
