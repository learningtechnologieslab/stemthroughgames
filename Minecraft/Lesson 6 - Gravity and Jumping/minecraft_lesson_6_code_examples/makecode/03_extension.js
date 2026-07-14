// ============================================================
//  DAY 6 — GRAVITY & JUMPING  |  Level: EXTENSION (Challenge)
//  STEM through Games — Minecraft Education Edition
// ============================================================
//
//  WHO THIS IS FOR:
//    Students who finished the core activity early and want
//    to explore advanced game-feel techniques used in real
//    commercial games.
//
//  WHAT'S NEW IN THIS VERSION:
//    1. Double Jump   — jump again while in the air (Mario 64-style)
//    2. Coyote Time   — brief grace period to jump after walking
//                       off a ledge (used in Celeste, Hollow Knight)
//    3. Variable Jump Height — tap = small jump, hold = big jump
//                              (used in most modern platformers)
//    4. Jump Buffering  — press jump just before landing and it
//                         still registers (reduces frustration)
//
//  CHALLENGE QUESTIONS at the bottom of each section.
//
// ============================================================

// ── CONSTANTS ────────────────────────────────────────────────

const JUMP_FORCE       = 12      // initial upward velocity
const DOUBLE_JUMP_FORCE= 9       // slightly weaker second jump
const GRAVITY          = -0.55   // gravity per tick
const GRAVITY_FALLING  = -0.85   // faster fall (asymmetric arc — feels snappier)
const GROUND_LEVEL     = 64

// Coyote time: how many ticks after leaving a ledge can you still jump?
const COYOTE_TICKS     = 6       // ~300ms at 50ms/tick — standard in platformers

// Jump buffer: how many ticks before landing does a jump input "remember"?
const BUFFER_TICKS     = 5       // ~250ms

// Variable jump: holding jump longer = higher jump
// After this many ticks, holding jump no longer adds height
const HOLD_JUMP_TICKS  = 12

// ── STATE ────────────────────────────────────────────────────

let velocityY       = 0
let posY            = GROUND_LEVEL
let onGround        = true

let jumpsRemaining  = 2          // 2 = double jump available
let coyoteCounter   = 0          // counts down after leaving ground
let wasOnGround     = true       // tracks previous frame's ground state

let jumpBufferCounter = 0        // counts down after pressing jump in air
let jumpHeldTicks   = 0          // how long jump has been held this jump
let jumpHeld        = false      // is jump currently being held?

// ── JUMP INPUT ───────────────────────────────────────────────
//  Pressing jump: either jumps immediately, or stores a buffer.

player.onChat("jump", function () {
    jumpHeld = true
    tryJump()
})

player.onChat("release", function () {
    // Simulates releasing the jump button.
    // In a real game this would be detected automatically each frame.
    // In MakeCode we use a separate chat command for demonstration.
    jumpHeld      = false
    jumpHeldTicks = 0
})

function tryJump() {
    // Regular jump (on ground or in coyote window)
    if (onGround || coyoteCounter > 0) {
        velocityY       = JUMP_FORCE
        onGround        = false
        jumpsRemaining  = 1          // first jump used; one left for double
        coyoteCounter   = 0
        jumpHeldTicks   = 0
        player.say("Jump! (grounded)")

    // Double jump (in the air, still have a jump left)
    } else if (jumpsRemaining > 0) {
        velocityY       = DOUBLE_JUMP_FORCE
        jumpsRemaining -= 1
        jumpHeldTicks   = 0
        player.say("Double jump!")

    // No jumps left — store a buffer so landing triggers a jump
    } else {
        jumpBufferCounter = BUFFER_TICKS
        player.say("Jump buffered...")
    }
}

// ── PHYSICS TICK ─────────────────────────────────────────────

loops.everyInterval(50, function () {
    wasOnGround = onGround

    // ── COYOTE TIME ──────────────────────────────────────────
    //  If the agent just walked off a ledge, start the coyote window.
    if (wasOnGround && !onGround) {
        coyoteCounter = COYOTE_TICKS
    }
    if (coyoteCounter > 0 && !onGround) {
        coyoteCounter -= 1
    }

    // ── VARIABLE JUMP HEIGHT ─────────────────────────────────
    //  While jump is held AND we're still going up AND within
    //  the hold window: reduce gravity's effect.
    //  This lets a tap = small jump, hold = big jump.
    if (jumpHeld && velocityY > 0 && jumpHeldTicks < HOLD_JUMP_TICKS) {
        velocityY += GRAVITY * 0.4   // gravity partially cancelled while held
        jumpHeldTicks += 1
    } else {
        // ── ASYMMETRIC GRAVITY ───────────────────────────────
        //  Fall faster than you rise — feels more satisfying and
        //  gives the player more control. Used in almost every
        //  modern platformer (Celeste, Hollow Knight, Ori).
        if (velocityY < 0) {
            velocityY += GRAVITY_FALLING  // fast fall
        } else {
            velocityY += GRAVITY          // normal rise
        }
    }

    // ── POSITION ─────────────────────────────────────────────
    posY += velocityY

    // ── GROUND COLLISION ─────────────────────────────────────
    if (posY <= GROUND_LEVEL) {
        posY          = GROUND_LEVEL
        velocityY     = 0
        onGround      = true
        jumpsRemaining= 2            // reset double jump on landing
        jumpHeldTicks = 0

        // ── JUMP BUFFERING ───────────────────────────────────
        //  If there's a buffered jump input, fire it now.
        if (jumpBufferCounter > 0) {
            jumpBufferCounter = 0
            tryJump()
            player.say("Buffered jump fired on landing!")
        }
    } else {
        onGround = false
    }

    // Count down buffer window
    if (jumpBufferCounter > 0) {
        jumpBufferCounter -= 1
    }

    // ── MOVE THE AGENT ───────────────────────────────────────
    let agentPos = agent.getPosition()
    agent.teleport(
        positions.create(
            agentPos.getValue(Axis.X),
            Math.round(posY),
            agentPos.getValue(Axis.Z)
        ),
        agent.getOrientation()
    )
})

// ── DEBUG COMMAND ────────────────────────────────────────────

player.onChat("debug", function () {
    player.say("─── Physics State ───")
    player.say("posY:           " + Math.round(posY))
    player.say("velocityY:      " + (Math.round(velocityY * 100) / 100))
    player.say("onGround:       " + onGround)
    player.say("jumpsRemaining: " + jumpsRemaining)
    player.say("coyoteTicks:    " + coyoteCounter)
    player.say("bufferTicks:    " + jumpBufferCounter)
    player.say("jumpHeld:       " + jumpHeld)
})

// ── CHALLENGE QUESTIONS ──────────────────────────────────────
//
//  1. DOUBLE JUMP MATH:
//     If JUMP_FORCE=12 and DOUBLE_JUMP_FORCE=9, why might you want
//     the second jump to be weaker? What would happen if they were equal?
//
//  2. COYOTE TIME:
//     COYOTE_TICKS=6 at 50ms per tick = 300ms of grace.
//     Is this fair or unfair? What number feels best to you?
//     Try 2 (very strict), 6 (standard), 12 (very forgiving).
//
//  3. ASYMMETRIC GRAVITY:
//     The code uses GRAVITY_FALLING (-0.85) on the way DOWN and
//     GRAVITY (-0.55) on the way UP. What does this feel like vs.
//     using the same gravity both ways? Why do designers do this?
//
//  4. JUMP BUFFERING:
//     Try commenting out the buffer section (lines with jumpBufferCounter).
//     Does the jump feel more frustrating? Why do games include this?
//
//  5. EXTENSION: Can you add a WALL JUMP?
//     Hint: you'd need to detect when the agent is touching a wall
//     and give it horizontal + vertical velocity when jump is pressed.
