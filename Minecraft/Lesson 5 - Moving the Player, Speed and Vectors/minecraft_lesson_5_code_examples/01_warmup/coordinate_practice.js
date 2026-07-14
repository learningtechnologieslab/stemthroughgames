// ============================================================
//  STEM Through Games — Day 5  |  Warm-Up Activity
//  Coordinate Practice: Vectors on the Number Line
// ============================================================
//
//  HOW TO USE:
//    Paste this file into the MakeCode JavaScript editor, OR
//    run it in any browser console / Node.js to see the output.
//
//  WHAT IT TEACHES:
//    • Adding a vector to a position (1D and 2D)
//    • How Minecraft's X and Z axes work
//    • Reading coordinate output to verify predictions
// ============================================================

// ── 1D Example ──────────────────────────────────────────────
// "You are at X = 5. You move +3 blocks East. Where do you land?"

let startX = 5
let moveX  = 3          // positive = East

let landX  = startX + moveX
// Expected: 8

player.onChat("warmup1D", function () {
    player.say("=== 1D Warm-Up ===")
    player.say("Start X: " + startX)
    player.say("Move:   +" + moveX + " East")
    player.say("Land X:  " + landX)
    player.say("Correct? " + (landX === 8 ? "YES ✓" : "NO ✗"))
})

// ── 2D Example ──────────────────────────────────────────────
// "You start at (X=2, Z=3). Move by vector (4, -1). Where do you land?"
//
//  In Minecraft's horizontal plane:
//    X axis → East (+) / West (−)
//    Z axis → South (+) / North (−)

let startPos = { x: 2, z: 3 }
let moveVec  = { x: 4, z: -1 }   // (−1 on Z = moving North)

let landPos  = {
    x: startPos.x + moveVec.x,   // 2 + 4  = 6
    z: startPos.z + moveVec.z    // 3 + (−1) = 2
}

player.onChat("warmup2D", function () {
    player.say("=== 2D Warm-Up ===")
    player.say("Start:  (X=" + startPos.x + ", Z=" + startPos.z + ")")
    player.say("Vector: (+" + moveVec.x + ", " + moveVec.z + ")")
    player.say("Land:   (X=" + landPos.x + ", Z=" + landPos.z + ")")
    player.say("Moved " + moveVec.x + " East, " + Math.abs(moveVec.z) + " North")
    player.say("Correct? " + (landPos.x === 6 && landPos.z === 2 ? "YES ✓" : "NO ✗"))
})

// ── Teleport the player to demonstrate ──────────────────────
// (Teleports to landPos on the current Y level so students
//  can see the coordinate change live in the HUD)

player.onChat("tpDemo", function () {
    let here = player.position()
    player.teleport(
        positions.createWorld(landPos.x, here.getValue(Axis.Y), landPos.z)
    )
    player.say("Teleported to (X=" + landPos.x + ", Z=" + landPos.z + ")")
    player.say("Check your coordinates with F3!")
})

// ── Discussion helper ────────────────────────────────────────
// Type "quiz" in chat to get the discussion questions on screen

player.onChat("quiz", function () {
    player.say("--- Discussion Questions ---")
    player.say("Q1: What does a negative Z value mean?")
    player.say("Q2: If moveVec = (0, 0), are you moving?")
    player.say("Q3: Which direction combines X and Z?")
})
