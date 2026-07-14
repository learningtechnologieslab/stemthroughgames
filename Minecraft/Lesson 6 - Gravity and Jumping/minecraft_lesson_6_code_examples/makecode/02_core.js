// ============================================================
//  DAY 6 — GRAVITY & JUMPING  |  Level: CORE (On-Level)
//  STEM through Games — Minecraft Education Edition
// ============================================================
//
//  WHO THIS IS FOR:
//    Most students. Type this code yourself — don't copy/paste!
//    Typing it line by line helps you understand what each
//    part does.
//
//  WHAT THIS DOES:
//    Simulates the same gravity physics that Minecraft uses
//    internally, but built by YOU in MakeCode JavaScript.
//
//  HOW TO USE:
//    Paste into the MakeCode JavaScript editor inside your
//    Minecraft Education starter world. Then type /jump in chat.
//
// ============================================================

// ── CONSTANTS ────────────────────────────────────────────────
//  These are the "dials" you can tune to change how the jump feels.
//  Notice: in Minecraft, Y increases UPWARD, so:
//    • JUMP_FORCE is POSITIVE  (upward = positive Y)
//    • GRAVITY    is NEGATIVE  (downward = negative Y)
//  This is the OPPOSITE of Godot, where Y increases downward!

const JUMP_FORCE   = 10      // upward velocity burst (blocks/tick)
const GRAVITY      = -0.6    // downward acceleration per tick (blocks/tick²)
const GROUND_LEVEL = 64      // Y coordinate of the floor

// ── STATE VARIABLES ──────────────────────────────────────────
//  These change as the agent moves. Don't set them as constants!

let velocityY = 0            // current vertical speed (+ = up, - = down)
let posY      = GROUND_LEVEL // current height of the agent
let onGround  = true         // whether the agent is on the floor

// ── JUMP COMMAND ─────────────────────────────────────────────
//  Triggered when the player types "/jump" in Minecraft chat.
//  Only works when the agent is on the ground — just like a
//  real jump, and just like is_on_floor() in Godot.

player.onChat("jump", function () {
    if (onGround) {
        velocityY = JUMP_FORCE
        onGround  = false
    }
})

// ── PHYSICS TICK ─────────────────────────────────────────────
//  This runs every 50 milliseconds — our "physics frame."
//  In Godot this would be _physics_process(delta).
//  In Minecraft Education, loops.everyInterval is the equivalent.

loops.everyInterval(50, function () {

    // GRAVITY: add gravity to velocity every tick.
    //  This is what makes gravity an ACCELERATION (not just movement):
    //  each tick, velocity CHANGES by a fixed amount.
    //  Compare to Godot:  velocity += get_gravity() * delta
    velocityY += GRAVITY

    // POSITION: update position based on current velocity.
    //  Velocity is "how much position changes per tick."
    posY += velocityY

    // GROUND COLLISION: if we've hit or gone below ground, stop.
    //  Compare to Godot:  is_on_floor() inside move_and_slide()
    if (posY <= GROUND_LEVEL) {
        posY      = GROUND_LEVEL
        velocityY = 0
        onGround  = true
    }

    // MOVE THE AGENT: teleport it to the calculated position.
    //  In a full game engine, the physics engine handles this.
    //  Here we do it manually so you can see every step.
    let agentPos = agent.getPosition()
    agent.teleport(
        positions.create(
            agentPos.getValue(Axis.X),
            posY,
            agentPos.getValue(Axis.Z)
        ),
        agent.getOrientation()
    )
})

// ── EXPERIMENT COMMANDS ──────────────────────────────────────
//  Type these in Minecraft chat to test different settings.

player.onChat("high", function () {
    // High-jump world (low gravity, strong jump)
    // Feels like the End dimension or a space world.
    // Useful for: fantasy adventure maps, sky islands
    // (You'd normally put these at the top as constants —
    //  this is just for quick experimenting!)
    velocityY = 25
    onGround  = false
})

player.onChat("heavy", function () {
    // Heavy world (strong gravity) — single big jump
    // Feels like a cave world or high-pressure environment.
    velocityY = 10
    onGround  = false
    // NOTE: gravity is still -0.6 — the jump just FEELS heavier
    // because the arc is shorter. To change gravity feel permanently,
    // change the GRAVITY constant at the top.
})

player.onChat("status", function () {
    // Prints current physics state to chat — useful for debugging!
    player.say("posY: "      + Math.round(posY))
    player.say("velocityY: " + Math.round(velocityY * 100) / 100)
    player.say("onGround: "  + onGround)
})
