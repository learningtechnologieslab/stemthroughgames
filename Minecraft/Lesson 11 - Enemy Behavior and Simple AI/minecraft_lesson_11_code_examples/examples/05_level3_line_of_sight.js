// ============================================================
// Day 11 — Example 05: Challenge Level 3
//           Line of Sight + FLEE State + Two Enemy Types
// STEM Through Games · Minecraft Education Edition
// ============================================================
//
// PURPOSE:
//   Mastery-level extensions that make the AI feel much more
//   sophisticated:
//
//   1. LINE OF SIGHT CHECK — the enemy only detects the player
//      if there are no solid blocks between them. This means
//      walls actually provide cover! Uses blocks.testForBlock()
//      to sample a point between agent and player.
//
//   2. FLEE STATE — added to the state machine. If the player
//      gets TOO close (within fleeRange blocks), the agent
//      runs AWAY. This creates a "scared" mob archetype and
//      is used in games like Minecraft's passive mobs.
//
//   3. TWO ENEMY TYPES — shows how the same state machine
//      logic can produce completely different behavior just
//      by tweaking constants. HUNTER is fast and aggressive;
//      COWARD detects from far but flees when cornered.
//
// HOW TO USE:
//   1. Build a room with at least one solid wall dividing it.
//   2. Type "spawnhunter" or "spawncoward" (or both!).
//   3. Type "start" to begin.
//   4. Walk behind the wall — the agent should STOP chasing
//      (line of sight blocked).
//   5. Get very close to the COWARD to trigger FLEE.
// ============================================================

// ── State constants ───────────────────────────────────────────
const PATROL = 0;
const CHASE  = 1;
const FLEE   = 2;

// ── Enemy type definitions ────────────────────────────────────
//   Each "type" is just a set of configuration values.
//   The exact same AI code runs for both — only the numbers differ.
const ENEMY_TYPES = {
    HUNTER: {
        name:         "Hunter",
        detectRange:  10,    // detects from far
        fleeRange:    0,     // never flees (brave)
        speed:        2,     // fast
        patrolRange:  12
    },
    COWARD: {
        name:         "Coward",
        detectRange:  14,    // detects from very far (cautious)
        fleeRange:    4,     // flees if player gets too close
        speed:        1,
        patrolRange:  8
    }
};

// ── Active agent state ────────────────────────────────────────
//   We only have one agent in MakeCode, so we pick one type.
//   Advanced students: duplicate this block for a second world.
let config       = ENEMY_TYPES.HUNTER;  // change to COWARD to try it
let currentState = PATROL;
let patrolDir    = 1;
let isRunning    = false;
let spawnX       = 0;
let spawnY       = 0;
let spawnZ       = 0;

// ── Spawn commands ────────────────────────────────────────────
player.onChat("spawnhunter", function () {
    config = ENEMY_TYPES.HUNTER;
    spawnAgent();
    player.say("Spawned: HUNTER — fast, brave, close-range detection");
});

player.onChat("spawncoward", function () {
    config = ENEMY_TYPES.COWARD;
    spawnAgent();
    player.say("Spawned: COWARD — slow, wide detection, flees when cornered");
});

function spawnAgent() {
    spawnX = player.position().getValue(Axis.X) + 12;
    spawnY = player.position().getValue(Axis.Y);
    spawnZ = player.position().getValue(Axis.Z);
    agent.teleport(pos(spawnX, spawnY, spawnZ), CompassDirection.West);
    currentState = PATROL;
    patrolDir    = 1;
}

player.onChat("start", function () {
    isRunning = true;
    player.say("Running as: " + config.name + " | detectRange=" + config.detectRange + " fleeRange=" + config.fleeRange);
});

player.onChat("stop", function () {
    isRunning = false;
});

// ── Main game loop ─────────────────────────────────────────────
game.onGameUpdate(function () {

    if (!isRunning) return;

    let px = player.position().getValue(Axis.X);
    let py = player.position().getValue(Axis.Y);
    let pz = player.position().getValue(Axis.Z);
    let ex = agent.getPosition().getValue(Axis.X);
    let ey = agent.getPosition().getValue(Axis.Y);
    let ez = agent.getPosition().getValue(Axis.Z);

    let ddx  = px - ex;
    let ddz  = pz - ez;
    let dist = Math.sqrt(ddx * ddx + ddz * ddz);

    // ── LINE OF SIGHT CHECK ───────────────────────────────────
    //   Sample the midpoint between agent and player.
    //   If a solid block exists at that midpoint, sight is blocked.
    //   This is a simplified "one-sample" LOS — real games use
    //   raycasting with many samples, but this works well enough
    //   for a middle school lesson.
    let midX = Math.round((ex + px) / 2);
    let midY = Math.round((ey + py) / 2);
    let midZ = Math.round((ez + pz) / 2);

    // Check if there's a solid block at the midpoint
    // AIR block (id 0) means nothing is blocking the view
    let hasSight = !blocks.testForBlock(AIR, world(midX, midY, midZ));
    //
    // NOTE: testForBlock(AIR, ...) returns TRUE if that position IS air.
    // We want hasSight = true when the midpoint IS air (no wall).
    // So: hasSight = blocks.testForBlock(AIR, world(midX, midY, midZ))
    //
    // If the midpoint has a non-air block → hasSight = false → stay in PATROL.
    let canSeePlayer = blocks.testForBlock(AIR, world(midX, midY, midZ));

    // ── State Transitions ─────────────────────────────────────

    if (currentState === PATROL) {
        // Only switch to CHASE if within range AND has line of sight
        if (dist < config.detectRange && canSeePlayer) {
            currentState = CHASE;
            player.say("[" + config.name + "] I see you!");
        }
    }
    else if (currentState === CHASE) {
        // If player escapes range OR sight is blocked → back to patrol
        if (dist >= config.detectRange || !canSeePlayer) {
            currentState = PATROL;
            player.say("[" + config.name + "] Lost you.");
        }
        // If player gets TOO close and this type flees → switch to FLEE
        if (config.fleeRange > 0 && dist < config.fleeRange) {
            currentState = FLEE;
            player.say("[" + config.name + "] Too close! Running!");
        }
    }
    else if (currentState === FLEE) {
        // Return to CHASE once player is a safe distance away
        if (dist > config.fleeRange * 2) {
            currentState = CHASE;
            player.say("[" + config.name + "] Okay, I'll chase again.");
        }
    }

    // ── State Behaviors ───────────────────────────────────────

    if (currentState === PATROL) {
        // Simple X-axis patrol with bounce
        let newX = ex + patrolDir * config.speed;
        if (newX >= spawnX + config.patrolRange) patrolDir = -1;
        if (newX <= spawnX - config.patrolRange) patrolDir =  1;
        agent.teleport(pos(newX, ey, ez), CompassDirection.West);
    }
    else if (currentState === CHASE) {
        // Move toward player
        if (dist <= 1) return;
        let nx    = ddx / dist;
        let nz    = ddz / dist;
        let moveX = Math.round(nx * config.speed);
        let moveZ = Math.round(nz * config.speed);
        agent.teleport(pos(ex + moveX, ey, ez + moveZ), CompassDirection.West);
    }
    else if (currentState === FLEE) {
        // Move AWAY from player — negate the direction vector!
        //   Chasing: move += normalized direction (toward player)
        //   Fleeing: move -= normalized direction (away from player)
        if (dist <= 0.1) return;
        let nx    = ddx / dist;
        let nz    = ddz / dist;
        // Negate nx and nz to run in the OPPOSITE direction
        let moveX = Math.round(-nx * config.speed);
        let moveZ = Math.round(-nz * config.speed);
        agent.teleport(pos(ex + moveX, ey, ez + moveZ), CompassDirection.West);
    }
});

// ── Status command ────────────────────────────────────────────
player.onChat("status", function () {
    let ex   = agent.getPosition().getValue(Axis.X);
    let ez   = agent.getPosition().getValue(Axis.Z);
    let px   = player.position().getValue(Axis.X);
    let pz   = player.position().getValue(Axis.Z);
    let dist = Math.round(Math.sqrt((px-ex)*(px-ex) + (pz-ez)*(pz-ez)));
    let label = currentState === PATROL ? "PATROL" : currentState === CHASE ? "CHASE" : "FLEE";
    player.say(config.name + " | " + label + " | dist=" + dist + " | detect=" + config.detectRange + " flee=" + config.fleeRange);
});

// ============================================================
// KEY CONCEPTS IN THIS FILE:
//
//  LINE OF SIGHT:
//    We sample ONE point (the midpoint) between agent and player.
//    A real raycast checks many points along the line. For a
//    full implementation, you'd loop from agent to player in
//    small steps and check each block. This single-sample
//    version works for walls that are at least 1 block thick.
//
//  FLEE STATE:
//    The ONLY change from CHASE is negating the direction vector:
//      Chase: move += (nx, nz)   → move TOWARD player
//      Flee:  move += (-nx, -nz) → move AWAY from player
//    This is the elegance of vector math — you get a new
//    behavior by changing just one sign.
//
//  TWO ENEMY TYPES:
//    Same code, different config objects. Notice how the
//    COWARD with fleeRange=4 and detectRange=14 creates a
//    completely different emotional experience from the
//    HUNTER. This is why game designers tune numbers carefully.
//
//  DISCUSSION QUESTIONS:
//    1. What would a "Creeper" look like in this system?
//       (Hint: it shouldn't flee — it should have a 4th state
//        called EXPLODE triggered at very close range.)
//    2. Why is negating the vector enough to make the agent flee?
//       Draw it on graph paper.
//    3. The midpoint LOS check fails for thin walls (1 block).
//       Can you think of a better sampling strategy?
// ============================================================
