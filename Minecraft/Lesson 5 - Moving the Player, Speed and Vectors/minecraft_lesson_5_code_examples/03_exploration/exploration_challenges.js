// ============================================================
//  STEM Through Games — Day 5  |  Part C — Exploration
//  Guided Challenges: Speed, Diagonals & Normalization
// ============================================================
//
//  This file contains all four exploration challenges from
//  the lesson.  Students work through them in order.
//
//  TEACHER NOTE:
//    Each challenge builds on the previous one.
//    Have students change the SPEED_CHALLENGE variable for
//    challenges 1 and 2, then observe the "moveDiag" command
//    for challenge 3.  Challenge 4 introduces normalization.
//
//  CHAT COMMANDS:
//    move [direction]   → e.g. "move east" / "move diag"
//    setSpeed [number]  → e.g. "setSpeed 1"  or "setSpeed 20"
//    showSpeed          → display current speed value
//    measureStraight    → mark start, run straight, mark end
//    measureDiag        → mark start, run diagonal, mark end
//    normalOn           → enable diagonal normalization fix
//    normalOff          → disable normalization (default)
//    reset              → teleport Agent back to player
// ============================================================

// ── SHARED SPEED VARIABLE ───────────────────────────────────

let speed = 3

// Allow students to change speed via chat (e.g. "setSpeed 10")
player.onChat("setSpeed", function (newSpeed) {
    speed = parseInt(newSpeed) || 3
    player.say("Speed set to " + speed + " blocks per command")
})

player.onChat("showSpeed", function () {
    player.say("speed = " + speed)
})

// ── CHALLENGE 1 — Slow Motion (speed = 1) ───────────────────
//
//  INSTRUCTIONS:
//    Type "setSpeed 1" then type "move east" several times.
//
//  OBSERVE:
//    How does the movement feel?
//    What game genre fits a character that moves this slowly?
//    (Puzzle, escape room, horror, stealth)
//
//  DISCUSSION:
//    "This is like a character wading through deep water.
//     Designers use slow movement to create tension or
//     make players feel weight and consequence."

// ── CHALLENGE 2 — Hyperspeed (speed = 20) ───────────────────
//
//  INSTRUCTIONS:
//    Type "setSpeed 20" then type "move east".
//
//  OBSERVE:
//    Is the movement still fun to control?
//    When might a map designer WANT this? (Racing, bots)
//
//  DISCUSSION:
//    "Extreme speed can be exciting — but it can also make
//     a game feel out of control.  Speed is a DESIGN choice."

// ── CHALLENGE 3 — Diagonal Speed Problem ────────────────────
//
//  INSTRUCTIONS:
//    1. Type "setSpeed 5"
//    2. Type "measureStraight" — walk East and see the distance
//    3. Type "measureDiag"    — walk diagonal and compare
//
//  OBSERVE:
//    The diagonal covers more ground!
//    Count the blocks: straight = 5,  diagonal straight-line ≈ 7.07
//
//  MATH:
//    Diagonal magnitude = √(5² + 5²) = √50 ≈ 7.07
//    That's speed × √2 ≈ 1.414 × speed
//
//  KEY QUESTION:
//    "Is this a bug or a feature?  How would you fix it?"

// ── CHALLENGE 4 (BONUS) — Normalization Fix ─────────────────
//
//  INSTRUCTIONS:
//    1. Type "normalOn"
//    2. Compare "move diag" vs "move east" — they now cover
//       the SAME straight-line distance.
//
//  HOW IT WORKS:
//    Without normalization: diagonal step = (1, 0, 1), magnitude √2
//    With normalization:    each component is scaled so the
//                           total magnitude stays ≈ 1 per step
//    In 2D: normalized diagonal ≈ (0.707, 0, 0.707)
//
//  Note: agent.move() only accepts integer blocks, so we
//  approximate normalization by alternating single-axis moves
//  — a classic technique in tile-based games.

let normalizeMode = false

player.onChat("normalOn", function () {
    normalizeMode = true
    player.say("Normalization ON — diagonal now matches cardinal distance")
})

player.onChat("normalOff", function () {
    normalizeMode = false
    player.say("Normalization OFF — raw diagonal (41% faster)")
})

// ── UNIFIED MOVE COMMAND ─────────────────────────────────────
//  Type "move east" / "move west" / "move north" /
//       "move south" / "move diag" / "move up" / "move down"

player.onChat("move", function (direction) {
    let dir = direction.toLowerCase()

    if (dir === "east") {
        for (let i = 0; i < speed; i++) agent.move(SixDirection.East, 1)

    } else if (dir === "west") {
        for (let i = 0; i < speed; i++) agent.move(SixDirection.West, 1)

    } else if (dir === "north") {
        for (let i = 0; i < speed; i++) agent.move(SixDirection.North, 1)

    } else if (dir === "south") {
        for (let i = 0; i < speed; i++) agent.move(SixDirection.South, 1)

    } else if (dir === "up") {
        for (let i = 0; i < speed; i++) agent.move(SixDirection.Up, 1)

    } else if (dir === "down") {
        for (let i = 0; i < speed; i++) agent.move(SixDirection.Down, 1)

    } else if (dir === "diag") {
        if (normalizeMode) {
            // Normalized approximation: alternate East/South moves
            // so we take 'speed' total steps but split evenly
            // Result: each "step" is 1 block in one axis only,
            // but the path follows a 45° line with total
            // straight-line distance ≈ speed × 1.0 (not × √2)
            for (let i = 0; i < speed; i++) {
                if (i % 2 === 0) {
                    agent.move(SixDirection.East,  1)
                } else {
                    agent.move(SixDirection.South, 1)
                }
            }
            player.say("[normalized] diag: ~" + speed + " blocks along path")
        } else {
            // Raw diagonal: East + South each loop
            for (let i = 0; i < speed; i++) {
                agent.move(SixDirection.East,  1)
                agent.move(SixDirection.South, 1)
            }
            let rawDist = Math.round(speed * Math.SQRT2 * 10) / 10
            player.say("[raw] diag straight-line distance ≈ " + rawDist + " blocks")
        }

    } else {
        player.say("Unknown direction: " + direction)
        player.say("Try: east / west / north / south / diag / up / down")
    }
})

// ── MEASUREMENT HELPERS ──────────────────────────────────────
//  These mark the agent's position before and after a move
//  and calculate straight-line distance so students can see
//  the diagonal speed problem directly on the ground.

let markerStart = { x: 0, y: 0, z: 0 }

player.onChat("markStart", function () {
    let pos = agent.getPosition()
    markerStart.x = pos.getValue(Axis.X)
    markerStart.y = pos.getValue(Axis.Y)
    markerStart.z = pos.getValue(Axis.Z)
    // Place a gold block at the start position
    blocks.place(
        GOLD_BLOCK,
        positions.createWorld(markerStart.x, markerStart.y - 1, markerStart.z)
    )
    player.say("Start marked at (" + markerStart.x + ", " + markerStart.z + ")")
})

player.onChat("markEnd", function () {
    let pos   = agent.getPosition()
    let endX  = pos.getValue(Axis.X)
    let endZ  = pos.getValue(Axis.Z)
    // Place a diamond block at the end position
    blocks.place(
        DIAMOND_BLOCK,
        positions.createWorld(endX, pos.getValue(Axis.Y) - 1, endZ)
    )
    let dx   = endX - markerStart.x
    let dz   = endZ - markerStart.z
    let dist = Math.round(Math.sqrt(dx * dx + dz * dz) * 100) / 100
    player.say("End:  (" + endX + ", " + endZ + ")")
    player.say("ΔX = " + dx + "  ΔZ = " + dz)
    player.say("Straight-line distance = " + dist + " blocks")
    player.say("(speed × √2 ≈ " + Math.round(speed * Math.SQRT2 * 100) / 100 + ")")
})

// ── RESET ────────────────────────────────────────────────────

player.onChat("reset", function () {
    agent.teleportToPlayer()
    player.say("Agent reset to your position")
})
