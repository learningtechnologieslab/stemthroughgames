// ============================================================
//  STEM Through Games — Day 5  |  Extension Challenges
//  Sprint, Acceleration & Shape Tracing
// ============================================================
//
//  For students who finish early or want an extra challenge.
//  Three independent extensions — each can be used on its own.
//
//  EXTENSION A — Sprint System
//    Demonstrates multiplying speed by a scalar factor.
//    Real games do this for "run" vs "walk" states.
//
//  EXTENSION B — Acceleration (speed increases over time)
//    Each command call makes the Agent a little faster.
//    Models real physics: Δv per time step = acceleration.
//
//  EXTENSION C — Shape Tracer
//    Uses vectors to draw squares, rectangles, and L-shapes.
//    Demonstrates how complex paths are just repeated vectors.
//
//  CHAT COMMANDS — Extension A:
//    walk [dir]      → normal speed
//    sprint [dir]    → 2× speed
//    sneak [dir]     → 0.5× speed (rounds down)
//    resetSpeed      → set speed back to base
//
//  CHAT COMMANDS — Extension B:
//    accelMove [dir] → move and accelerate by 1 each call
//    showAccel       → print current speed and acceleration
//    resetAccel      → reset speed and acceleration to base
//
//  CHAT COMMANDS — Extension C:
//    traceSquare [size]       → draw a square path
//    traceRect [width] [depth]→ draw a rectangle path
//    traceLShape [arm]        → draw an L-shaped path
//    traceCustom [e] [s] [w] [n] → custom sides (blocks each)
// ============================================================

// ── SHARED STATE ─────────────────────────────────────────────

let baseSpeed    = 3     // starting "walk" speed
let currentSpeed = 3     // modified by sprint/sneak/acceleration
let acceleration = 1     // added to speed each accelMove call

// ── EXTENSION A — SPRINT SYSTEM ──────────────────────────────
//
//  Real games multiply a base speed by a "state" scalar:
//    sneak  → base × 0.5   (slower)
//    walk   → base × 1.0   (normal)
//    sprint → base × 2.0   (faster)
//
//  This is exactly velocity = direction × (baseSpeed × state)

player.onChat("walk", function (direction) {
    currentSpeed = baseSpeed
    moveInDirection(direction, currentSpeed)
    player.say("[walk] speed = " + currentSpeed)
})

player.onChat("sprint", function (direction) {
    currentSpeed = baseSpeed * 2
    moveInDirection(direction, currentSpeed)
    player.say("[sprint] speed = " + currentSpeed + " (2× walk)")
})

player.onChat("sneak", function (direction) {
    currentSpeed = Math.max(1, Math.floor(baseSpeed * 0.5))
    moveInDirection(direction, currentSpeed)
    player.say("[sneak] speed = " + currentSpeed + " (0.5× walk)")
})

player.onChat("resetSpeed", function () {
    currentSpeed = baseSpeed
    player.say("Speed reset to base: " + baseSpeed)
})

// ── EXTENSION B — ACCELERATION ───────────────────────────────
//
//  Each call to "accelMove" adds 'acceleration' to the speed.
//  This models Δv per frame — the speed variable itself
//  increases over time, just like in a physics engine.
//
//  DISCUSS:
//    "After how many commands does the Agent feel out of control?"
//    "How would you add a maximum speed cap? (hint: Math.min)"
//    "How would you add friction to slow it down?"

player.onChat("accelMove", function (direction) {
    moveInDirection(direction, currentSpeed)
    player.say("Speed: " + currentSpeed + " → " + (currentSpeed + acceleration))
    currentSpeed = currentSpeed + acceleration
})

player.onChat("showAccel", function () {
    player.say("Current speed:    " + currentSpeed)
    player.say("Acceleration:     +" + acceleration + " per move")
    player.say("Next move speed:  " + (currentSpeed + acceleration))
})

player.onChat("resetAccel", function () {
    currentSpeed = baseSpeed
    acceleration = 1
    player.say("Acceleration reset — speed = " + baseSpeed)
})

// ── EXTENSION C — SHAPE TRACER ───────────────────────────────
//
//  Moving along a path = applying a sequence of direction vectors.
//  A square = East N, South N, West N, North N.
//  Each side is a vector; the full shape is a vector sequence.

// Square: East → South → West → North
player.onChat("traceSquare", function (sizeStr) {
    let size = parseInt(sizeStr) || 5
    player.say("Tracing " + size + "×" + size + " square...")

    for (let i = 0; i < size; i++) agent.move(SixDirection.East,  1)
    for (let i = 0; i < size; i++) agent.move(SixDirection.South, 1)
    for (let i = 0; i < size; i++) agent.move(SixDirection.West,  1)
    for (let i = 0; i < size; i++) agent.move(SixDirection.North, 1)

    player.say("Square complete! Perimeter = " + (4 * size) + " blocks")
    player.say("Vectors: E" + size + " S" + size + " W" + size + " N" + size)
})

// Rectangle: different East/West vs North/South lengths
player.onChat("traceRect", function (widthStr, depthStr) {
    let w = parseInt(widthStr) || 6
    let d = parseInt(depthStr) || 3
    player.say("Tracing " + w + "×" + d + " rectangle...")

    for (let i = 0; i < w; i++) agent.move(SixDirection.East,  1)
    for (let i = 0; i < d; i++) agent.move(SixDirection.South, 1)
    for (let i = 0; i < w; i++) agent.move(SixDirection.West,  1)
    for (let i = 0; i < d; i++) agent.move(SixDirection.North, 1)

    player.say("Rectangle complete! Perimeter = " + (2 * w + 2 * d) + " blocks")
})

// L-shape: two rectangles joined at a corner
player.onChat("traceLShape", function (armStr) {
    let arm = parseInt(armStr) || 4
    player.say("Tracing L-shape (arm = " + arm + ")...")

    // Long vertical part
    for (let i = 0; i < arm * 2; i++) agent.move(SixDirection.East,  1)
    for (let i = 0; i < arm;     i++) agent.move(SixDirection.South, 1)
    // Short horizontal part
    for (let i = 0; i < arm;     i++) agent.move(SixDirection.West,  1)
    for (let i = 0; i < arm;     i++) agent.move(SixDirection.South, 1)
    // Return home
    for (let i = 0; i < arm;     i++) agent.move(SixDirection.West,  1)
    for (let i = 0; i < arm * 2; i++) agent.move(SixDirection.North, 1)

    player.say("L-shape complete!")
    player.say("Notice: a complex path is just a LIST of direction vectors.")
})

// Custom 4-sided path
player.onChat("traceCustom", function (eStr, sStr, wStr, nStr) {
    let e = parseInt(eStr) || 5
    let s = parseInt(sStr) || 5
    let w = parseInt(wStr) || 5
    let n = parseInt(nStr) || 5
    player.say("Custom path: E" + e + " S" + s + " W" + w + " N" + n)

    for (let i = 0; i < e; i++) agent.move(SixDirection.East,  1)
    for (let i = 0; i < s; i++) agent.move(SixDirection.South, 1)
    for (let i = 0; i < w; i++) agent.move(SixDirection.West,  1)
    for (let i = 0; i < n; i++) agent.move(SixDirection.North, 1)

    player.say("Done!")
})

// ── SHARED HELPER ────────────────────────────────────────────

function moveInDirection(direction, steps) {
    let dir = direction.toLowerCase()
    if      (dir === "east")  { for (let i = 0; i < steps; i++) agent.move(SixDirection.East,  1) }
    else if (dir === "west")  { for (let i = 0; i < steps; i++) agent.move(SixDirection.West,  1) }
    else if (dir === "north") { for (let i = 0; i < steps; i++) agent.move(SixDirection.North, 1) }
    else if (dir === "south") { for (let i = 0; i < steps; i++) agent.move(SixDirection.South, 1) }
    else if (dir === "up")    { for (let i = 0; i < steps; i++) agent.move(SixDirection.Up,    1) }
    else if (dir === "down")  { for (let i = 0; i < steps; i++) agent.move(SixDirection.Down,  1) }
    else player.say("Unknown direction: " + dir)
}
