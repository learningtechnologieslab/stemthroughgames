// ============================================================
//  STEM Through Games — Day 5  |  Part B — Main Activity
//  Basic Agent Movement with Vectors
// ============================================================
//
//  HOW TO USE:
//    1. Open Minecraft Education Edition
//    2. Pause → Code → New Project → JavaScript
//    3. Paste this entire file into the editor
//    4. Click "Play" to run it in your world
//    5. Type chat commands (listed below) to move the Agent
//
//  CHAT COMMANDS:
//    moveEast   → Agent moves East  (+X direction)
//    moveWest   → Agent moves West  (−X direction)
//    moveNorth  → Agent moves North (−Z direction)
//    moveSouth  → Agent moves South (+Z direction)
//    moveDiag   → Agent moves diagonally (East + South)
//    teleport   → Teleports Agent to your location
//    showPos    → Prints Agent's current coordinates
//
//  WHAT IT TEACHES:
//    • Direction as a unit vector (each SixDirection is a (dx,dy,dz))
//    • Speed as a scalar multiplied against direction
//    • How the for-loop makes the agent travel "speed" blocks
//    • Diagonal movement combining two perpendicular directions
// ============================================================

// ── SPEED VARIABLE ──────────────────────────────────────────
//
//  This is the KEY variable for today's lesson.
//  Change this number and observe how the Agent behaves.
//
//  Try:   speed = 1    → very slow, one block per command
//         speed = 3    → natural, responsive feel  (default)
//         speed = 10   → fast, exciting
//         speed = 20   → extremely fast — is it still fun?

let speed = 3    // blocks per command

// ── CARDINAL DIRECTIONS ─────────────────────────────────────
//
//  Each direction is like a unit vector on the X/Z plane:
//
//    East  → direction vector (+1,  0,  0)
//    West  → direction vector (−1,  0,  0)
//    South → direction vector ( 0,  0, +1)
//    North → direction vector ( 0,  0, −1)
//
//  Multiplying by speed gives us total displacement.

player.onChat("moveEast", function () {
    for (let i = 0; i < speed; i++) {
        agent.move(SixDirection.East, 1)
    }
})

player.onChat("moveWest", function () {
    for (let i = 0; i < speed; i++) {
        agent.move(SixDirection.West, 1)
    }
})

player.onChat("moveNorth", function () {
    for (let i = 0; i < speed; i++) {
        agent.move(SixDirection.North, 1)
    }
})

player.onChat("moveSouth", function () {
    for (let i = 0; i < speed; i++) {
        agent.move(SixDirection.South, 1)
    }
})

// ── DIAGONAL MOVEMENT ───────────────────────────────────────
//
//  Diagonal = East + South combined each step.
//
//  MATH ALERT: Moving East 1 AND South 1 each iteration
//  gives a straight-line distance of:
//      √(1² + 1²) = √2 ≈ 1.41 blocks per step
//
//  After "speed" steps, total straight-line distance ≈ speed × 1.41
//  Compare to a straight cardinal move: speed × 1.0
//  That's 41% FARTHER for the same number of loop iterations!
//
//  → This is the Pythagorean Theorem at work in game code.

player.onChat("moveDiag", function () {
    for (let i = 0; i < speed; i++) {
        agent.move(SixDirection.East,  1)   // +X
        agent.move(SixDirection.South, 1)   // +Z
    }
})

// ── UTILITY COMMANDS ────────────────────────────────────────

// Teleport the Agent to stand in front of the player
player.onChat("teleport", function () {
    agent.teleportToPlayer()
    player.say("Agent teleported to your location!")
})

// Print the Agent's current coordinates in chat
player.onChat("showPos", function () {
    let pos = agent.getPosition()
    player.say("Agent position →")
    player.say("  X = " + pos.getValue(Axis.X))
    player.say("  Y = " + pos.getValue(Axis.Y))
    player.say("  Z = " + pos.getValue(Axis.Z))
})

// Show current speed value
player.onChat("showSpeed", function () {
    player.say("Current speed = " + speed + " blocks per command")
})
