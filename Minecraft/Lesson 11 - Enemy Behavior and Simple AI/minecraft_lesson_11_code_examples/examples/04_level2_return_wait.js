// ============================================================
// Day 11 — Example 04: Challenge Level 2
//           Three States — Patrol + Chase + Return + Wait
// STEM Through Games · Minecraft Education Edition
// ============================================================
//
// PURPOSE:
//   Extends the state machine from Example 03 with two new
//   states:
//     WAIT   — agent pauses briefly before chasing (builds
//               suspense; like a predator deciding to pounce)
//     RETURN — after losing sight of the player, the agent
//               walks back to its spawn point before resuming
//               patrol (makes the world feel more "alive")
//
//   Full state diagram:
//
//   PATROL ──(dist < detectRange)──▶ WAIT
//     ▲                               │
//     │                               │ (after waitTime ms)
//     │                               ▼
//     │         RETURN ◀──────── CHASE
//     └─────────(reached spawn)   (dist > loseRange)
//
// HOW TO USE:
//   1. Type "spawn" to place the agent.
//   2. Type "start" to begin.
//   3. Walk toward the agent to trigger the WAIT → CHASE sequence.
//   4. Back away past loseRange to trigger RETURN.
//   5. Watch the agent walk home before patrolling again.
//   6. Type "status" anytime to see the current state.
// ============================================================

// ── State constants ───────────────────────────────────────────
const PATROL = 0;
const WAIT   = 1;  // NEW: pause before chasing
const CHASE  = 2;
const RETURN = 3;  // NEW: go back to spawn

// ── Configuration ─────────────────────────────────────────────
let detectRange = 8;    // blocks — PATROL → WAIT trigger
let loseRange   = 14;   // blocks — CHASE → RETURN trigger (must be > detectRange)
let speed       = 1;    // blocks per tick
let waitTime    = 1500; // milliseconds to pause in WAIT state (1.5 seconds)
let patrolMin   = -8;
let patrolMax   =  8;

// ── State variables ───────────────────────────────────────────
let currentState  = PATROL;
let patrolDir     = 1;
let isRunning     = false;
let waitUntil     = 0;      // game time (ms) when WAIT should end
let spawnX        = 0;
let spawnY        = 0;
let spawnZ        = 0;

// ── Spawn ──────────────────────────────────────────────────────
player.onChat("spawn", function () {
    spawnX = player.position().getValue(Axis.X) + 10;
    spawnY = player.position().getValue(Axis.Y);
    spawnZ = player.position().getValue(Axis.Z);

    agent.teleport(pos(spawnX, spawnY, spawnZ), CompassDirection.West);
    currentState = PATROL;
    patrolDir    = 1;

    player.say("Spawned! States: PATROL → WAIT → CHASE → RETURN → PATROL");
});

player.onChat("start", function () {
    isRunning = true;
    player.say("Running. Approach the agent to trigger WAIT state...");
});

player.onChat("stop", function () {
    isRunning = false;
    player.say("Stopped. State was: " + stateLabel(currentState));
});

// ── Main game loop ─────────────────────────────────────────────
game.onGameUpdate(function () {

    if (!isRunning) return;

    // ── Read positions ────────────────────────────────────────
    let px = player.position().getValue(Axis.X);
    let pz = player.position().getValue(Axis.Z);
    let ex = agent.getPosition().getValue(Axis.X);
    let ey = agent.getPosition().getValue(Axis.Y);
    let ez = agent.getPosition().getValue(Axis.Z);

    // Distance from agent to player
    let ddxP  = px - ex;
    let ddzP  = pz - ez;
    let distP = Math.sqrt(ddxP * ddxP + ddzP * ddzP);

    // Distance from agent to spawn point
    let ddxS  = spawnX - ex;
    let ddzS  = spawnZ - ez;
    let distS = Math.sqrt(ddxS * ddxS + ddzS * ddzS);

    // ── State Transitions ─────────────────────────────────────
    //   Note: we only allow certain transitions to prevent
    //   the agent from flip-flopping state every tick.

    if (currentState === PATROL) {
        if (distP < detectRange) {
            // Player entered detection range → start waiting
            currentState = WAIT;
            waitUntil    = getGameTime() + waitTime;
            player.say("[ENEMY] I see you...");
        }
    }
    else if (currentState === WAIT) {
        if (getGameTime() >= waitUntil) {
            // Wait time expired → begin chase
            currentState = CHASE;
            player.say("[ENEMY] Charge!");
        }
        // No movement during WAIT — stay still
        return;
    }
    else if (currentState === CHASE) {
        if (distP > loseRange) {
            // Player escaped → return to spawn
            currentState = RETURN;
            player.say("[ENEMY] Lost you... heading back.");
        }
    }
    else if (currentState === RETURN) {
        if (distS <= 1) {
            // Reached spawn → resume patrol
            currentState = PATROL;
            patrolDir    = 1;
            player.say("[ENEMY] Back on patrol.");
        }
    }

    // ── State Behaviors ───────────────────────────────────────

    if (currentState === PATROL) {
        // Move along X axis, bounce at boundaries
        let newX = ex + patrolDir * speed;
        if (newX >= spawnX + patrolMax) patrolDir = -1;
        if (newX <= spawnX + patrolMin) patrolDir =  1;

        agent.teleport(pos(newX, ey, ez), CompassDirection.West);
    }
    else if (currentState === CHASE) {
        // Vector math chase toward player
        if (distP <= 1) return;

        let nx    = ddxP / distP;
        let nz    = ddzP / distP;
        let moveX = Math.round(nx * speed);
        let moveZ = Math.round(nz * speed);

        agent.teleport(pos(ex + moveX, ey, ez + moveZ), CompassDirection.West);
    }
    else if (currentState === RETURN) {
        // Walk back toward spawn point using same vector math
        if (distS <= 1) return;

        let nx    = ddxS / distS;
        let nz    = ddzS / distS;
        let moveX = Math.round(nx * speed);
        let moveZ = Math.round(nz * speed);

        agent.teleport(pos(ex + moveX, ey, ez + moveZ), CompassDirection.West);
    }
    // WAIT: no movement (handled in transition block above)
});

// ── Helpers ───────────────────────────────────────────────────

// Returns current game time in milliseconds
// (MakeCode doesn't expose a real clock, so we use a tick counter
//  approximation: each onGameUpdate fires ~20 times per second)
let tickCount = 0;
function getGameTime() {
    tickCount++;
    return tickCount * 50; // ~50ms per tick
}

function stateLabel(state) {
    if (state === PATROL) return "PATROL";
    if (state === WAIT)   return "WAIT";
    if (state === CHASE)  return "CHASE";
    if (state === RETURN) return "RETURN";
    return "UNKNOWN";
}

player.onChat("status", function () {
    let ex   = agent.getPosition().getValue(Axis.X);
    let ez   = agent.getPosition().getValue(Axis.Z);
    let px   = player.position().getValue(Axis.X);
    let pz   = player.position().getValue(Axis.Z);
    let dist = Math.round(Math.sqrt((px-ex)*(px-ex) + (pz-ez)*(pz-ez)));

    player.say("State: " + stateLabel(currentState) + " | Player dist: " + dist + "blks | Spawn dist: " +
        Math.round(Math.sqrt((spawnX-ex)*(spawnX-ex) + (spawnZ-ez)*(spawnZ-ez))) + "blks");
});

// ============================================================
// EXTENSION IDEAS FOR STUDENTS:
//
//  1. Change waitTime to 3000 (3 seconds). Does the longer
//     pause make the agent feel more menacing or less?
//
//  2. Add a "PATROL says something" line: when the agent
//     bounces off a wall, call player.say("[ENEMY] ...").
//
//  3. What if the agent could re-detect the player during RETURN?
//     Add: if (currentState === RETURN && distP < detectRange)
//          { currentState = WAIT; ... }
//
//  4. What does it feel like if loseRange === detectRange?
//     (The agent would flip between CHASE and RETURN rapidly —
//      this is called "state flickering" and is a real game bug!)
//     Fix it by making loseRange larger than detectRange.
// ============================================================
