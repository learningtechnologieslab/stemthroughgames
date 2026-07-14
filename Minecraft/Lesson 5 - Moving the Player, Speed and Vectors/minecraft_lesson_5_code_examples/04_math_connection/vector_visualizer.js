// ============================================================
//  STEM Through Games — Day 5  |  Math Connection
//  Vector Calculator & Pythagorean Theorem Visualizer
// ============================================================
//
//  This script makes the math VISIBLE in the Minecraft world.
//  It draws right triangles on the ground using colored blocks
//  so students can see the Pythagorean Theorem as a real
//  shape — not just a formula.
//
//  CHAT COMMANDS:
//    calcMove [dx] [dz]   → calculate distance for any vector
//                           e.g. "calcMove 3 4" → 5 blocks
//    drawTriangle [legs]  → draw a right triangle on the ground
//                           e.g. "drawTriangle 5"
//    vectorTable          → print the velocity table from class
//    proofDiag            → prove the diagonal speed problem live
//    clearBlocks          → remove drawn blocks
// ============================================================

let speed = 3   // shared speed variable

// ── VECTOR CALCULATOR ────────────────────────────────────────
//  Given a direction vector (dx, dz), calculate how far the
//  Agent actually travels and compare to a straight move.
//
//  Usage: "calcMove 3 4"  (East 3, South 4)

player.onChat("calcMove", function (dxStr, dzStr) {
    let dx   = parseInt(dxStr) || 1
    let dz   = parseInt(dzStr) || 0
    let dist = Math.sqrt(dx * dx + dz * dz)

    player.say("=== Vector Calculator ===")
    player.say("Direction: (" + dx + ", " + dz + ")")
    player.say("Magnitude: √(" + dx + "² + " + dz + "²)")
    player.say("         = √(" + (dx*dx) + " + " + (dz*dz) + ")")
    player.say("         = √" + (dx*dx + dz*dz))
    player.say("         ≈ " + (Math.round(dist * 1000) / 1000) + " blocks")

    if (dx !== 0 && dz !== 0) {
        let cardinal = Math.max(Math.abs(dx), Math.abs(dz))
        let pct = Math.round((dist / cardinal - 1) * 100)
        player.say("vs. straight " + cardinal + "-block move: +" + pct + "% farther")
    }
})

// ── PYTHAGOREAN TRIANGLE VISUALIZER ─────────────────────────
//  Draws a right triangle on the ground using colored wool:
//    RED   = horizontal leg  (East, = dx blocks)
//    BLUE  = vertical leg    (South, = dz blocks)
//    GOLD  = hypotenuse      (diagonal path)
//
//  This makes a² + b² = c² visible as actual block counts.
//
//  Usage: "drawTriangle 4"  → draws a 4-4-√32 triangle

player.onChat("drawTriangle", function (legsStr) {
    let legs = parseInt(legsStr) || 4
    let pos  = agent.getPosition()
    let ox   = pos.getValue(Axis.X)
    let oy   = pos.getValue(Axis.Y) - 1  // one block below agent feet
    let oz   = pos.getValue(Axis.Z)

    player.say("Drawing " + legs + "-" + legs + " right triangle...")
    player.say("RED = East leg (" + legs + " blocks)")
    player.say("BLUE = South leg (" + legs + " blocks)")
    player.say("GOLD = Hypotenuse ≈ " + (Math.round(legs * Math.SQRT2 * 10) / 10) + " blocks")

    // Draw horizontal leg (East) in RED wool
    for (let i = 0; i <= legs; i++) {
        blocks.place(RED_WOOL, positions.createWorld(ox + i, oy, oz))
    }

    // Draw vertical leg (South) in BLUE wool
    for (let i = 0; i <= legs; i++) {
        blocks.place(BLUE_WOOL, positions.createWorld(ox, oy, oz + i))
    }

    // Draw hypotenuse approximation in GOLD wool
    // Uses Bresenham's line algorithm for a clean diagonal
    let x0 = 0, z0 = 0
    let x1 = legs, z1 = legs
    let ddx = Math.abs(x1 - x0)
    let ddz = Math.abs(z1 - z0)
    let err = ddx - ddz
    while (true) {
        blocks.place(GOLD_BLOCK, positions.createWorld(ox + x0, oy, oz + z0))
        if (x0 === x1 && z0 === z1) break
        let e2 = 2 * err
        if (e2 > -ddz) { err -= ddz; x0++ }
        if (e2 < ddx)  { err += ddx; z0++ }
    }

    // Corner marker in DIAMOND
    blocks.place(DIAMOND_BLOCK, positions.createWorld(ox + legs, oy, oz + legs))

    player.say("Triangle drawn! Count the blocks in each color.")
    player.say("Formula: RED² + BLUE² = GOLD²  (" + legs + "² + " + legs + "² = " + (2 * legs * legs) + ")")
})

// ── VELOCITY TABLE ───────────────────────────────────────────
//  Prints the full vector × speed table from the lesson slides.

player.onChat("vectorTable", function () {
    player.say("=== Vector × Speed Table (speed=" + speed + ") ===")
    player.say("Direction   | Vector    | Displacement")
    player.say("East   →    | (+1,0, 0) | +" + speed + " X")
    player.say("West   ←    | (−1,0, 0) | −" + speed + " X")
    player.say("South  ↓    | ( 0,0,+1) | +" + speed + " Z")
    player.say("North  ↑    | ( 0,0,−1) | −" + speed + " Z")
    let diagDist = Math.round(speed * Math.SQRT2 * 100) / 100
    player.say("Diagonal ↗  | (+1,0,+1) | ≈" + diagDist + " (√2 × faster!)")
})

// ── LIVE DIAGONAL PROOF ──────────────────────────────────────
//  Moves the Agent East "speed" blocks, then teleports back
//  and moves diagonally "speed" steps so students can SEE
//  the extra distance covered.

player.onChat("proofDiag", function () {
    agent.teleportToPlayer()
    let startPos = agent.getPosition()
    let sx = startPos.getValue(Axis.X)
    let sz = startPos.getValue(Axis.Z)

    // Mark start
    blocks.place(EMERALD_BLOCK, positions.createWorld(sx, startPos.getValue(Axis.Y) - 1, sz))
    player.say("=== Diagonal Proof ===")
    player.say("Start: X=" + sx + "  Z=" + sz)

    // Move straight East (speed blocks)
    for (let i = 0; i < speed; i++) agent.move(SixDirection.East, 1)
    let afterStraight = agent.getPosition()
    let endSX = afterStraight.getValue(Axis.X)
    blocks.place(REDSTONE_BLOCK, positions.createWorld(endSX, afterStraight.getValue(Axis.Y) - 1, afterStraight.getValue(Axis.Z)))
    player.say("After straight East " + speed + " steps → X=" + endSX)

    // Reset and go diagonal
    agent.teleportToPlayer()
    for (let i = 0; i < speed; i++) {
        agent.move(SixDirection.East,  1)
        agent.move(SixDirection.South, 1)
    }
    let afterDiag = agent.getPosition()
    let endDX = afterDiag.getValue(Axis.X)
    let endDZ = afterDiag.getValue(Axis.Z)
    let diagDist = Math.round(Math.sqrt(
        Math.pow(endDX - sx, 2) + Math.pow(endDZ - sz, 2)
    ) * 100) / 100
    blocks.place(GOLD_BLOCK, positions.createWorld(endDX, afterDiag.getValue(Axis.Y) - 1, endDZ))
    player.say("After diagonal " + speed + " steps → X=" + endDX + "  Z=" + endDZ)
    player.say("Straight-line distance: " + diagDist + " blocks")
    player.say("vs. cardinal: " + speed + " blocks")
    player.say("Ratio: " + Math.round(diagDist / speed * 100) / 100 + " (should be ≈√2 = 1.41)")
})

// ── CLEANUP ──────────────────────────────────────────────────

player.onChat("clearBlocks", function () {
    player.say("Tip: use /fill to clear an area, e.g.:")
    player.say("/fill ~-20 ~ ~-20 ~20 ~0 ~20 air replace wool")
    agent.teleportToPlayer()
})
