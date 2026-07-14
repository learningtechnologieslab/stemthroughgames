// ============================================================
// DAY 10 — Activity 1: Spawn Items with a For Loop
// STEM Through Games Program | Minecraft Education + MakeCode
// ============================================================
//
// PURPOSE:
//   Students type "spawnitems" in chat to scatter 5 diamond blocks
//   at random X/Z positions. This is the main hands-on coding
//   activity from Slide 7.
//
//   After the base activity works, students try the three
//   challenges at the bottom of this file.
//
// HOW TO USE:
//   1. Open MakeCode for your Minecraft Education world.
//   2. Switch to JavaScript view.
//   3. Paste this entire file into the editor.
//   4. Click "Play" to sync with Minecraft.
//   5. In Minecraft chat, type:  spawnitems
//   6. Look around — 5 diamonds should appear at ground level (y=64).
//
// MATH CONNECTION (Slide 9):
//   Math.randomRange(2, 18) picks integers from 2 to 18 inclusive.
//   Total possible values: 18 - 2 + 1 = 17
//   Probability of landing in any single column: 1/17 ≈ 5.9%
//   If we spawn 5 diamonds, ~2 should land in columns 2–8.
// ============================================================


// ── BASE ACTIVITY (matches Slide 7) ───────────────────────

player.onChat("spawnitems", function () {

    // We use a fixed Y of 64 — standard overworld surface level.
    // X and Z are randomized so each run looks different.

    player.say("Spawning 5 diamonds...")

    for (let i = 0; i < 5; i++) {

        // Math.randomRange(min, max) returns a whole number
        // between min and max, INCLUSIVE (both endpoints can appear).
        let x = Math.randomRange(2, 18)
        let z = Math.randomRange(2, 18)

        // blocks.place(blockType, world(x, y, z))
        // world() takes absolute coordinates in the Minecraft world.
        blocks.place(DIAMOND, world(x, 64, z))
    }

    player.say("Done! 5 diamonds placed. Can you find them all?")
})


// ── CHALLENGE 1: Change How Many Items Spawn ──────────────
// Trigger: "spawnmore"
// Students control the count using a variable instead of
// hardcoding the number 5. This teaches parameterization.

player.onChat("spawnmore", function () {

    // Change this number to control how many items spawn.
    let itemCount = 10

    for (let i = 0; i < itemCount; i++) {
        let x = Math.randomRange(2, 18)
        let z = Math.randomRange(2, 18)
        blocks.place(GOLD_BLOCK, world(x, 64, z))
    }

    player.say("Spawned " + itemCount + " gold blocks!")
})


// ── CHALLENGE 2: Spread Items Over a Larger Area ──────────
// Trigger: "spawnwide"
// Widens the random range from 2–18 to 0–50.
// MATH QUESTION: How does this change the probability that any
// two items land on the same block?
// New total values: 50 - 0 + 1 = 51
// Old total values: 18 - 2 + 1 = 17
// The wider range makes collisions less likely.

player.onChat("spawnwide", function () {

    for (let i = 0; i < 5; i++) {
        // Wider range = items spread out more
        let x = Math.randomRange(0, 50)
        let z = Math.randomRange(0, 50)
        blocks.place(EMERALD, world(x, 64, z))
    }

    player.say("Spawned 5 emeralds over a wide area. Spot them?")
})


// ── CHALLENGE 3: Spawn Different Items Each Run ───────────
// Trigger: "spawnmix"
// Uses an array of block types and picks one at random each
// iteration — a preview of arrays and indexing (Day 12+).

player.onChat("spawnmix", function () {

    // An array holds multiple values. We pick one by its index (0, 1, 2, 3).
    let blockTypes = [DIAMOND, GOLD_BLOCK, EMERALD, IRON_BLOCK]

    for (let i = 0; i < 8; i++) {
        let x = Math.randomRange(2, 18)
        let z = Math.randomRange(2, 18)

        // Pick a random index from 0 to 3 (the array has 4 items)
        let randomIndex = Math.randomRange(0, blockTypes.length - 1)
        let chosenBlock = blockTypes[randomIndex]

        blocks.place(chosenBlock, world(x, 64, z))
    }

    player.say("Spawned 8 random treasure blocks!")
})


// ── CLEANUP: Remove All Placed Blocks ─────────────────────
// Trigger: "clearitems"
// Replaces the spawn area with air so students can run the
// activity again with a clean slate. Useful for re-running demos.

player.onChat("clearitems", function () {

    // blocks.fill(blockType, from, to) fills a rectangular region.
    // We fill the entire spawn area (x: 0–55, z: 0–55) at y=64 with air.
    blocks.fill(AIR, world(0, 64, 0), world(55, 64, 55))
    player.say("Cleared the spawn area. Ready for another run!")
})


// ============================================================
// MATH EXTENSION (from Slide 9):
//   With Math.randomRange(2, 18), there are 17 possible values.
//   If we run it 5 times (our loop), the chance that ALL 5 land
//   on DIFFERENT blocks is:
//     17/17 × 16/17 × 15/17 × 14/17 × 13/17 ≈ 55%
//   So about 45% of the time, at least two diamonds share a block!
//   This is related to the famous "birthday problem" in probability.
// ============================================================
