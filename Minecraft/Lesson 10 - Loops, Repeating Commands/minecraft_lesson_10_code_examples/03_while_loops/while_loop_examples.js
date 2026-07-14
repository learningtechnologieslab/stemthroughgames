// ============================================================
// DAY 10 — While Loop Examples
// STEM Through Games Program | Minecraft Education + MakeCode
// ============================================================
//
// PURPOSE:
//   Demonstrates while loops as shown in Slide 6 (Direct Instruction).
//   While loops are introduced AFTER for loops because they require
//   students to manage the counter variable themselves — a common
//   source of bugs (and the infinite loop danger).
//
//   Example A — Basic while loop (chat output only, safe demo)
//   Example B — While loop that stops based on a world condition
//   Example C — The DANGEROUS version: infinite loop (read-only, do not run)
//
// HOW TO USE:
//   Type in Minecraft chat:
//     "whilecount"  — counts up using a while loop
//     "filldown"    — places blocks downward until it hits y=60
//
// TEACHER TIP:
//   Show Example A first to prove while loops work.
//   Then display Example C (on screen / projector) WITHOUT running it.
//   Ask: "What is missing? Why would this run forever?"
//   Answer: mobsSpawned never increases, so the condition never becomes false.
// ============================================================


// ── EXAMPLE A: Basic While Loop Counter ───────────────────
// This is the direct equivalent of the for loop from Example A.
// Students can compare the two side by side.
//
// KEY DIFFERENCE from for loop:
//   - The variable (count) is declared BEFORE the loop
//   - The condition is checked at the TOP of each iteration
//   - The increment (count++) must be written INSIDE the loop manually

player.onChat("whilecount", function () {

    // Step 1: Declare and initialize the counter variable BEFORE the loop
    let count = 0

    player.say("While loop starting...")

    // Step 2: The loop runs as long as this condition is TRUE
    while (count < 5) {

        player.say("count is: " + count)

        // Step 3: CRITICAL — we MUST update the variable here.
        //         If we forget this line, the loop runs forever.
        count++  // same as: count = count + 1
    }

    // This line only runs after the while condition becomes false (count >= 5)
    player.say("While loop done! count is now: " + count)
})


// ── EXAMPLE B: While Loop With a Real Condition ────────────
// A more realistic use: keep placing blocks DOWNWARD
// until we reach y=60 (approximate ground level).
// The condition checks something that changes each iteration.

player.onChat("filldown", function () {

    // Start at the player's current Y position
    let currentY = Math.round(player.position().getValue(Axis.Y))
    let fixedX   = Math.round(player.position().getValue(Axis.X))
    let fixedZ   = Math.round(player.position().getValue(Axis.Z))

    let blocksPlaced = 0

    // Keep going down while we are above ground level
    while (currentY > 60) {
        blocks.place(DIRT, world(fixedX, currentY, fixedZ))
        currentY--      // move down one block
        blocksPlaced++
    }

    player.say("Filled down " + blocksPlaced + " blocks to reach y=60.")
})


// ── EXAMPLE C: THE INFINITE LOOP — DO NOT RUN ─────────────
// Show this on the projector for the class discussion.
// This code is commented out so it CANNOT accidentally run.
//
// QUESTION FOR STUDENTS: Why does this run forever?
// ANSWER: mobsSpawned is declared but NEVER incremented.
//         The condition (mobsSpawned < 3) never becomes false.
//         Minecraft will freeze/crash.
//
//   let mobsSpawned = 0
//   while (mobsSpawned < 3) {
//       mobs.spawn(ZOMBIE, pos(0, 0, 0))
//       // BUG: mobsSpawned is never increased!
//       // The condition stays true forever → infinite loop
//   }
//
// THE FIX:
//   let mobsSpawned = 0
//   while (mobsSpawned < 3) {
//       mobs.spawn(ZOMBIE, pos(0, 0, 0))
//       mobsSpawned++   // ← this line MUST be here
//   }


// ============================================================
// CHALLENGE FOR STUDENTS:
//   1. In "whilecount": change the condition to (count < 10).
//      How many lines does it now print?
//   2. In "whilecount": what happens if you start count at 3?
//      How many times does it run?
//   3. Can you rewrite "whilecount" using a FOR loop instead?
//      They should produce identical output.
//   4. HARD: Write a while loop that counts DOWN from 10 to 1.
//      (Hint: start at 10, use count-- and condition count > 0)
// ============================================================
