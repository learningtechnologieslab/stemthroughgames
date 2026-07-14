// ============================================================
// Day 11 — Example 03: State Machine — Patrol + Chase
// STEM Through Games · Minecraft Education Edition
// ============================================================
//
// PURPOSE:
//   The agent now has TWO behaviors (states):
//     PATROL — moves left and right along the X axis,
//               bouncing when it hits the boundary blocks.
//     CHASE  — moves directly toward the player using
//               the vector math from Example 02.
//
//   The agent switches states based on distance to the player:
//     - If the player comes within detectRange blocks → CHASE
//     - If the player moves farther away → back to PATROL
//
// HOW TO USE:
//   1. Build a small arena (a flat area ~20 blocks wide).
//   2. Open Code Builder → JavaScript → paste + Play.
//   3. Type "spawn" to place the agent in the middle.
//   4. Type "start" to begin the state machine.
//   5. Walk toward the agent to trigger CHASE state.
//   6. Back away to watch it return to PATROL.
//   7. Type "stop" to halt everything.
//
// WHAT TO OBSERVE:
//   - The moment the state switches, the agent's movement
//     changes instantly. This is the power of state machines!
//   - Try changing detectRange to see how it changes tension.
// ============================================================

// ── Constants: define state names as numbers ──────────────────
// Using constants (instead of magic numbers) makes the code
// readable. State.PATROL === 0, State.CHASE === 1.
const PATROL = 0;
const CHASE  = 1;

// ── Configuration ─────────────────────────────────────────────
let detectRange = 8;   // blocks — how close before switching to CHASE
let speed       = 1;   // blocks per tick
let patrolMin   = -8;  // leftmost X offset from spawn
let patrolMax   =  8;  // rightmost X offset from spawn

// ── State variables ───────────────────────────────────────────
let currentState  = PATROL; // enemy starts patrolling
let patrolDir     = 1;      // 1 = moving toward +X, -1 = toward -X
let isRunning     = false;  // master on/off switch
let spawnX        = 0;      // agent's spawn X (set when "spawn" is typed)
let spawnY        = 0;      // agent's spawn Y
let spawnZ        = 0;      // agent's spawn Z

// ── Spawn: place agent in a defined starting position ─────────
player.onChat("spawn", function () {
    // Place agent 10 blocks to the east of where the player is standing
    spawnX = player.position().getValue(Axis.X) + 10;
    spawnY = player.position().getValue(Axis.Y);
    spawnZ = player.position().getValue(Axis.Z);

    agent.teleport(
        pos(spawnX, spawnY, spawnZ),
        CompassDirection.West
    );

    currentState = PATROL;
    patrolDir    = 1;

    player.say("Agent spawned. Patrol range: " + spawnX + patrolMin + " to " + (spawnX + patrolMax));
    player.say("Type 'start' to begin.");
});

// ── Start / Stop ──────────────────────────────────────────────
player.onChat("start", function () {
    isRunning = true;
    player.say("State machine started. Get close to trigger CHASE!");
});

player.onChat("stop", function () {
    isRunning = false;
    player.say("State machine stopped. Current state: " + stateLabel(currentState));
});

// ── Main game loop ────────────────────────────────────────────
game.onGameUpdate(function () {

    if (!isRunning) return;

    // ── Read positions ───────────────────────────────────────
    let px = player.position().getValue(Axis.X);
    let pz = player.position().getValue(Axis.Z);

    let ex = agent.getPosition().getValue(Axis.X);
    let ey = agent.getPosition().getValue(Axis.Y);
    let ez = agent.getPosition().getValue(Axis.Z);

    // ── Calculate distance ───────────────────────────────────
    //   2D distance on X/Z plane (ignoring height).
    let ddx  = px - ex;
    let ddz  = pz - ez;
    let dist = Math.sqrt(ddx * ddx + ddz * ddz);

    // ── State Transition ─────────────────────────────────────
    //   This is the heart of the state machine.
    //   We check the condition and update currentState.
    //   The actual movement happens below — keep transition
    //   logic and behavior logic separate!
    if (dist < detectRange) {
        currentState = CHASE;
    } else {
        currentState = PATROL;
    }

    // ── State Behavior ────────────────────────────────────────
    if (currentState === PATROL) {
        // ── PATROL behavior ─────────────────────────────────
        //   Move horizontally along X axis.
        //   When we hit the boundary, flip direction.
        let newX = ex + patrolDir * speed;

        // Boundary check — using spawn-relative bounds
        if (newX >= spawnX + patrolMax) {
            patrolDir = -1;  // hit right wall → go left
        } else if (newX <= spawnX + patrolMin) {
            patrolDir = 1;   // hit left wall → go right
        }

        agent.teleport(
            pos(newX, ey, ez),
            CompassDirection.West
        );

    } else if (currentState === CHASE) {
        // ── CHASE behavior ──────────────────────────────────
        //   Vector math from Example 02 — move toward player.
        if (dist <= 1) return; // already on player, don't move

        let nx    = ddx / dist;
        let nz    = ddz / dist;
        let moveX = Math.round(nx * speed);
        let moveZ = Math.round(nz * speed);

        agent.teleport(
            pos(ex + moveX, ey, ez + moveZ),
            CompassDirection.West
        );
    }
});

// ── Helper: convert state number to readable label ────────────
function stateLabel(state) {
    if (state === PATROL) return "PATROL";
    if (state === CHASE)  return "CHASE";
    return "UNKNOWN";
}

// ── Optional: type "status" to see current state in chat ──────
player.onChat("status", function () {
    let ex   = agent.getPosition().getValue(Axis.X);
    let ez   = agent.getPosition().getValue(Axis.Z);
    let px   = player.position().getValue(Axis.X);
    let pz   = player.position().getValue(Axis.Z);
    let dist = Math.round(Math.sqrt((px-ex)*(px-ex) + (pz-ez)*(pz-ez)));

    player.say("State: " + stateLabel(currentState) + " | Distance: " + dist + " blocks | detectRange: " + detectRange);
});

// ── Optional: change detect range on the fly ──────────────────
// Type "range 12" to change detectRange to 12 blocks
player.onChat("range", function (newRange) {
    detectRange = newRange;
    player.say("Detection range set to " + newRange + " blocks.");
});

// ============================================================
// STATE MACHINE DIAGRAM:
//
//   ┌─────────────────────┐           ┌─────────────────────┐
//   │       PATROL        │──────────▶│        CHASE        │
//   │  move left/right    │ dist <    │  move toward player │
//   │  bounce at edges    │ detectRng │  vector math        │
//   └─────────────────────┘◀──────────└─────────────────────┘
//                           dist >=
//                           detectRng
//
// DISCUSSION QUESTIONS:
//
//  1. What happens to the patrol if you increase 'speed' to 2?
//     Does the agent overshoot the boundary? Why?
//
//  2. Change detectRange to 20. How does the game feel?
//     Change it to 3. What emotion does that create?
//
//  3. Right now, transition is checked every tick. What if you
//     only checked it every 20 ticks? How would that feel?
//
//  4. The agent patrols only along X. How would you make it
//     patrol along Z instead? Along a diagonal?
// ============================================================
