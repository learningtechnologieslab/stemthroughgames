// ============================================================
// Day 11 — Example 02: Basic Chase Behavior
// STEM Through Games · Minecraft Education Edition
// ============================================================
//
// PURPOSE:
//   The Minecraft Agent acts as an enemy that chases the
//   player using vector math. Every game tick, it calculates
//   the direction to the player, normalizes it, and teleports
//   one block closer.
//
// HOW TO USE:
//   1. Open Code Builder (press C) → JavaScript mode.
//   2. Paste this code and click Play.
//   3. Type "spawn" in chat to place the agent near you.
//   4. Type "startchase" to begin the chase loop.
//   5. Type "stopchase" to stop.
//   6. Walk around — the agent will follow!
//
// WHAT TO OBSERVE:
//   - The agent always moves toward you, regardless of angle.
//   - Remove Math.round() and watch what breaks.
//   - Change 'speed' to 2 and compare the feel.
// ============================================================

// --- Configuration ---
let speed = 1;          // blocks per tick (try 1, 2, or 3)
let isChasing = false;  // tracks whether the loop is running

// --- Spawn: place agent 5 blocks in front of the player ---
player.onChat("spawn", function () {
    // Teleport agent to a fixed starting position near the player
    let startX = player.position().getValue(Axis.X) + 10;
    let startY = player.position().getValue(Axis.Y);
    let startZ = player.position().getValue(Axis.Z) + 10;

    agent.teleport(
        pos(startX, startY, startZ),
        CompassDirection.West
    );
    player.say("Agent spawned at (" + startX + ", " + startY + ", " + startZ + ")");
    player.say("Type 'startchase' to begin!");
});

// --- Start the chase loop ---
player.onChat("startchase", function () {
    isChasing = true;
    player.say("Chase started! Run!");
});

// --- Stop the chase loop ---
player.onChat("stopchase", function () {
    isChasing = false;
    player.say("Chase stopped.");
});

// --- Main game loop: runs every tick while the game is active ---
game.onGameUpdate(function () {

    // Only run if chasing is active
    if (!isChasing) {
        return;
    }

    // ── Step 1: Get current positions ────────────────────────
    let playerX = player.position().getValue(Axis.X);
    let playerY = player.position().getValue(Axis.Y);
    let playerZ = player.position().getValue(Axis.Z);

    let enemyX = agent.getPosition().getValue(Axis.X);
    let enemyY = agent.getPosition().getValue(Axis.Y);
    let enemyZ = agent.getPosition().getValue(Axis.Z);

    // ── Step 2: Calculate the direction vector ────────────────
    //   Subtract enemy FROM player — this points toward player.
    //   If you reversed this (enemy - player), the agent would
    //   run AWAY from you instead!
    let dx = playerX - enemyX;
    let dz = playerZ - enemyZ;

    // ── Step 3: Calculate magnitude (distance) ───────────────
    //   We only use X and Z — ignoring Y (height) so the agent
    //   stays on the ground even if you go up a hill.
    let mag = Math.sqrt(dx * dx + dz * dz);

    // ── Step 4: Guard against zero distance ──────────────────
    //   If the agent is already on the player, mag is ~0.
    //   Dividing by 0 would give NaN — we skip movement instead.
    if (mag <= 1) {
        return; // close enough — stop moving
    }

    // ── Step 5: Normalize the direction vector ────────────────
    //   Dividing by magnitude gives a vector of length exactly 1.
    //   This separates DIRECTION from SPEED.
    let nx = dx / mag;
    let nz = dz / mag;

    // ── Step 6: Apply speed and round for block grid ──────────
    //   Minecraft positions are integers.
    //   Math.round() converts the float (e.g. 0.77) to 1.
    //   Without this, agent.teleport() would receive a fractional
    //   coordinate and Minecraft would silently floor it — which
    //   often means the agent doesn't move at all!
    let moveX = Math.round(nx * speed);
    let moveZ = Math.round(nz * speed);

    // ── Step 7: Teleport agent to new position ────────────────
    //   We keep Y the same so the agent stays at ground level.
    agent.teleport(
        pos(enemyX + moveX, enemyY, enemyZ + moveZ),
        CompassDirection.West
    );
});

// ============================================================
// DISCUSSION QUESTIONS (for class):
//
//  1. What happens if you delete the 'if (mag <= 1)' guard?
//     Try it — what does the agent do when it reaches you?
//
//  2. What happens if you remove Math.round() from moveX/moveZ?
//     Why doesn't the agent move?
//
//  3. Change speed to 3. How does the game feel different?
//     What real game uses fast vs. slow enemies to create
//     different emotions?
//
//  4. Advanced: Make speed increase as the agent gets closer.
//     Hint: speed = Math.max(1, Math.round(8 - mag / 4));
// ============================================================
