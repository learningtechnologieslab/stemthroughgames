// ============================================================
//  DAY 6 — GRAVITY & JUMPING  |  Level: SCAFFOLD (Support)
//  STEM through Games — Minecraft Education Edition
// ============================================================
//
//  WHO THIS IS FOR:
//    Students who need extra support. The physics loop is
//    already built. Your job: change the numbers and observe
//    what happens!
//
//  HOW TO USE IN MINECRAFT EDUCATION:
//    1. Open your starter world
//    2. Press C (or click the Code button) to open MakeCode
//    3. Click the JavaScript tab at the top
//    4. Delete any existing code and paste this whole file
//    5. Click "Play" to save, then go back to Minecraft
//    6. Type  /jump  in the chat to make the agent jump!
//
// ============================================================

// ── STEP 1: CHANGE THESE VALUES AND SEE WHAT HAPPENS ────────
//
//   Try JUMP_FORCE:   5  →  10  →  20  →  30
//   Try GRAVITY:     -0.3  →  -0.6  →  -1.5
//
//   Write your observations in your Game Design Journal!

const JUMP_FORCE = 10       // How hard the agent jumps upward
const GRAVITY    = -0.6     // How fast gravity pulls down each tick

// ── STEP 2: READ THIS CODE (you don't need to change it) ────

let velocityY = 0           // Current up/down speed (changes every tick)
let posY      = 64          // Current height in blocks
let onGround  = true        // Is the agent touching the ground?

// When you type "/jump" in chat, this runs:
player.onChat("jump", function () {
    if (onGround) {
        velocityY = JUMP_FORCE   // Give the agent upward speed
        onGround  = false        // Agent is now in the air
        player.say("Jumping! velocityY = " + JUMP_FORCE)
    } else {
        player.say("Can't jump — not on the ground!")
    }
})

// This runs every 50 milliseconds (like a game "tick"):
loops.everyInterval(50, function () {

    // ── GRAVITY ──────────────────────────────────────────────
    //  Each tick, gravity CHANGES the velocity (not just position).
    //  This is what makes it ACCELERATION, not just movement.
    velocityY = velocityY + GRAVITY

    // ── POSITION ─────────────────────────────────────────────
    //  Velocity tells us how much position changes each tick.
    posY = posY + velocityY

    // ── GROUND CHECK ─────────────────────────────────────────
    //  If the agent has reached or gone below ground level,
    //  snap it back and reset velocity.
    if (posY <= 64) {
        posY      = 64
        velocityY = 0
        onGround  = true
    }

    // ── MOVE THE AGENT ───────────────────────────────────────
    //  Teleport the agent to the new height.
    //  (In a real game engine like Godot, move_and_slide() does this.)
    let agentPos = agent.getPosition()
    agent.teleport(
        positions.create(agentPos.getValue(Axis.X), posY, agentPos.getValue(Axis.Z)),
        agent.getOrientation()
    )
})

// ── STEP 3: EXPERIMENT LOG ──────────────────────────────────
//
//  Fill this in your journal as you try different values:
//
//  JUMP_FORCE = 5,   GRAVITY = -0.6  → Observation: ___________
//  JUMP_FORCE = 20,  GRAVITY = -0.6  → Observation: ___________
//  JUMP_FORCE = 10,  GRAVITY = -0.3  → Observation: ___________
//  JUMP_FORCE = 10,  GRAVITY = -1.5  → Observation: ___________
//
//  CHALLENGE QUESTION:
//  How many ticks does the agent take to reach the top of its
//  jump when JUMP_FORCE=10 and GRAVITY=-0.6?
//  Hint: the peak is when velocityY reaches 0.
