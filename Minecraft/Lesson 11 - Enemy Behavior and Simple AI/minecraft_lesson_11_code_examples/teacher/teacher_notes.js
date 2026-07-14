// ============================================================
// Day 11 — Teacher Reference: Fully Commented Solution
// STEM Through Games · Minecraft Education Edition
// ============================================================
//
// PURPOSE:
//   This is the complete, production-quality version of the
//   state machine with annotations explaining EVERY decision.
//   Keep this open on your teacher machine during class.
//
//   It includes:
//     - All four states: PATROL, WAIT, CHASE, RETURN
//     - Line of sight check
//     - Speed scaling (enemy gets faster as player gets closer)
//     - Full chat command interface
//     - Detailed inline notes for anticipated student questions
//
// DURING LIVE CODING:
//   Start with 02_basic_chase.js and build up.
//   Only show this file if a student asks "but WHY does that work?"
// ============================================================

// ── Why use constants instead of 0, 1, 2? ────────────────────
//   If you wrote:  if (currentState === 1) { ... }
//   ...that 1 means nothing to a reader. Constants give the
//   number a meaningful name. This is called "avoid magic numbers"
//   and is a real software engineering best practice.
const PATROL = 0;
const WAIT   = 1;
const CHASE  = 2;
const RETURN = 3;

// ── Why separate config from logic? ──────────────────────────
//   Game designers tweak these numbers constantly during testing.
//   Keeping them at the top means you never have to hunt through
//   the code to find "that 8 somewhere."
const CONFIG = {
    detectRange:   8,     // blocks — PATROL activates WAIT
    loseRange:     14,    // blocks — CHASE gives up (> detectRange avoids flicker)
    fleeRange:     0,     // blocks — set > 0 to enable FLEE behavior
    speed:         1,     // blocks per tick (base speed)
    speedScale:    true,  // if true, agent speeds up as it gets closer
    maxSpeed:      3,     // blocks per tick (maximum when speed scaling)
    waitTicks:     30,    // ticks to pause in WAIT before chasing (~1.5 seconds)
    patrolRange:   8,     // blocks left/right from spawn
    showDebug:     true   // print state changes to chat
};

// ── State variables — these change during gameplay ────────────
let currentState  = PATROL;
let patrolDir     = 1;     // 1 = rightward (+X), -1 = leftward (-X)
let isRunning     = false;
let waitTicksLeft = 0;     // countdown for WAIT state
let spawnX = 0, spawnY = 0, spawnZ = 0;

// ── Spawn ──────────────────────────────────────────────────────
player.onChat("spawn", function () {
    spawnX = player.position().getValue(Axis.X) + 10;
    spawnY = player.position().getValue(Axis.Y);
    spawnZ = player.position().getValue(Axis.Z);
    agent.teleport(pos(spawnX, spawnY, spawnZ), CompassDirection.West);
    currentState  = PATROL;
    patrolDir     = 1;
    waitTicksLeft = 0;
    debugLog("Agent spawned at (" + spawnX + ", " + spawnY + ", " + spawnZ + ")");
    debugLog("Commands: start | stop | status | range N | speed N");
});

player.onChat("start",  function () { isRunning = true;  debugLog("Started."); });
player.onChat("stop",   function () { isRunning = false; debugLog("Stopped."); });
player.onChat("range",  function (n) { CONFIG.detectRange = n; debugLog("detectRange = " + n); });
player.onChat("speed",  function (n) { CONFIG.speed = n; debugLog("speed = " + n); });

// ── Main update loop ───────────────────────────────────────────
game.onGameUpdate(function () {

    if (!isRunning) return;

    // ── 1. Read current positions ─────────────────────────────
    let px = player.position().getValue(Axis.X);
    let pz = player.position().getValue(Axis.Z);
    let ex = agent.getPosition().getValue(Axis.X);
    let ey = agent.getPosition().getValue(Axis.Y);
    let ez = agent.getPosition().getValue(Axis.Z);

    // ── 2. Compute direction vector (agent → player) ──────────
    //   Subtracting in this order (player minus agent) gives a
    //   vector that points FROM the agent TOWARD the player.
    //   Reversing this gives a vector pointing AWAY (useful for FLEE).
    let ddx  = px - ex;
    let ddz  = pz - ez;

    // ── 3. Compute distances ──────────────────────────────────
    //   distP = distance to player
    //   distS = distance to spawn (used in RETURN state)
    let distP = Math.sqrt(ddx * ddx + ddz * ddz);
    let distS = Math.sqrt((spawnX - ex) * (spawnX - ex) + (spawnZ - ez) * (spawnZ - ez));

    // ── 4. Line of sight check ────────────────────────────────
    //   Sample the midpoint between agent and player.
    //   If that position contains air, nothing is blocking the view.
    //   STUDENT QUESTION: "Why just the midpoint?"
    //   Answer: It's a trade-off between accuracy and performance.
    //   A full raycast checks many points but is slower to compute.
    //   For this lesson, midpoint sampling is accurate enough.
    let midX = Math.round((ex + px) / 2);
    let midY = Math.round((ey + player.position().getValue(Axis.Y)) / 2);
    let midZ = Math.round((ez + pz) / 2);
    let canSeePlayer = blocks.testForBlock(AIR, world(midX, midY, midZ));

    // ── 5. State Transitions ──────────────────────────────────
    //   Rule: Only change state, don't do movement here.
    //   Keeping transitions and behaviors separate makes the
    //   code easier to debug and extend.

    let prevState = currentState;  // track for debug logging

    if (currentState === PATROL) {
        if (distP < CONFIG.detectRange && canSeePlayer) {
            currentState  = WAIT;
            waitTicksLeft = CONFIG.waitTicks;
        }
    }
    else if (currentState === WAIT) {
        waitTicksLeft--;
        if (waitTicksLeft <= 0) {
            currentState = CHASE;
        }
        // No movement during WAIT
    }
    else if (currentState === CHASE) {
        if (distP > CONFIG.loseRange || !canSeePlayer) {
            currentState = RETURN;
        }
        // Optional FLEE: if player gets too close
        if (CONFIG.fleeRange > 0 && distP < CONFIG.fleeRange) {
            currentState = FLEE;
        }
    }
    else if (currentState === RETURN) {
        if (distS <= 1) {
            currentState = PATROL;
            patrolDir    = 1;
        }
        // Re-detect player even during return
        if (distP < CONFIG.detectRange && canSeePlayer) {
            currentState  = WAIT;
            waitTicksLeft = CONFIG.waitTicks;
        }
    }

    // Log state change
    if (currentState !== prevState) {
        debugLog(stateLabel(prevState) + " → " + stateLabel(currentState));
    }

    // ── 6. State Behaviors ────────────────────────────────────

    if (currentState === PATROL) {
        // Patrol back and forth along X axis
        let newX = ex + patrolDir * CONFIG.speed;
        if (newX >= spawnX + CONFIG.patrolRange) patrolDir = -1;
        if (newX <= spawnX - CONFIG.patrolRange) patrolDir =  1;
        agent.teleport(pos(newX, ey, ez), CompassDirection.West);
    }
    else if (currentState === WAIT) {
        // Stand still — no teleport call
        // The state transition block above handles the countdown
    }
    else if (currentState === CHASE) {
        if (distP <= 1) return;

        // ── Speed scaling ─────────────────────────────────────
        //   Optional feature: agent speeds up as it gets closer.
        //   Math.max ensures speed doesn't go below base speed.
        //   Math.min ensures it doesn't exceed maxSpeed.
        //   STUDENT QUESTION: "What does this feel like?"
        //   Answer: A creeper that gradually accelerates as it
        //   approaches — much scarier than constant speed!
        let actualSpeed = CONFIG.speed;
        if (CONFIG.speedScale) {
            // Scale from CONFIG.speed up to CONFIG.maxSpeed
            // as distance shrinks from detectRange to 0
            let t = 1 - (distP / CONFIG.detectRange);      // 0 far, 1 close
            t = Math.max(0, Math.min(1, t));               // clamp 0–1
            actualSpeed = Math.round(CONFIG.speed + t * (CONFIG.maxSpeed - CONFIG.speed));
        }

        let nx    = ddx / distP;
        let nz    = ddz / distP;
        let moveX = Math.round(nx * actualSpeed);
        let moveZ = Math.round(nz * actualSpeed);
        agent.teleport(pos(ex + moveX, ey, ez + moveZ), CompassDirection.West);
    }
    else if (currentState === RETURN) {
        if (distS <= 1) return;
        let nx    = (spawnX - ex) / distS;
        let nz    = (spawnZ - ez) / distS;
        let moveX = Math.round(nx * CONFIG.speed);
        let moveZ = Math.round(nz * CONFIG.speed);
        agent.teleport(pos(ex + moveX, ey, ez + moveZ), CompassDirection.West);
    }
});

// ── Status command ─────────────────────────────────────────────
player.onChat("status", function () {
    let ex   = agent.getPosition().getValue(Axis.X);
    let ez   = agent.getPosition().getValue(Axis.Z);
    let px   = player.position().getValue(Axis.X);
    let pz   = player.position().getValue(Axis.Z);
    let dist = Math.round(Math.sqrt((px-ex)*(px-ex) + (pz-ez)*(pz-ez)));
    player.say("State: " + stateLabel(currentState) +
               " | dist=" + dist + "blks" +
               " | detect=" + CONFIG.detectRange +
               " | speed=" + CONFIG.speed +
               (currentState === WAIT ? " | wait=" + waitTicksLeft + "ticks" : ""));
});

// ── Helper functions ───────────────────────────────────────────
function stateLabel(state) {
    if (state === PATROL) return "PATROL";
    if (state === WAIT)   return "WAIT";
    if (state === CHASE)  return "CHASE";
    if (state === RETURN) return "RETURN";
    return "UNKNOWN(" + state + ")";
}

function debugLog(msg) {
    if (CONFIG.showDebug) {
        player.say("[AI] " + msg);
    }
}

// ── ANTICIPATED STUDENT QUESTIONS ────────────────────────────
//
//  Q: "Why is loseRange bigger than detectRange?"
//  A: To prevent "state flickering." If they were equal, the
//     agent would switch CHASE → PATROL → CHASE every tick when
//     the player stands exactly at the boundary. Making loseRange
//     larger creates a "hysteresis gap" — a buffer zone where
//     neither transition fires. Real game designers always add
//     this buffer to any condition-based switch.
//
//  Q: "What's the WAIT state for? Why not just chase immediately?"
//  A: Pause before chasing makes the enemy feel like it's making
//     a decision — it sees you, thinks for a moment, then acts.
//     This creates more tension than instant chase. Many horror
//     games use this deliberate pause as a scare technique.
//
//  Q: "Why Math.round() and not Math.floor() or Math.ceil()?"
//  A: Math.round() gives the closest integer, which means the
//     agent moves in the direction closest to the true normalized
//     vector. Math.floor() would bias toward negative coordinates;
//     Math.ceil() toward positive. Try them and observe.
//
//  Q: "What happens if mag is 0?"
//  A: Division by zero gives Infinity or NaN. The 'if (dist <= 1)'
//     guard prevents us from trying to normalize a zero vector.
//     In production code you'd also check 'if (dist === 0) return'.
// ============================================================
