// ============================================================
// Day 11 — Debug Helpers
// STEM Through Games · Minecraft Education Edition
// ============================================================
//
// PURPOSE:
//   Standalone utility commands for inspecting and testing
//   the enemy AI during class. These work independently of
//   any example file.
//
//   Paste this alongside your main example code (at the bottom)
//   or run it separately in a second Code Builder tab.
//
// COMMANDS:
//   "where"          → prints agent and player positions
//   "dist"           → prints current distance between them
//   "mark"           → places a wool block at agent position
//   "trail on/off"   → drops green wool blocks as agent moves
//   "vector"         → prints full vector math for current positions
//   "simulate X Z"   → simulates a move from current pos toward (X, Z)
//   "reset"          → teleports agent back to player +10 X
// ============================================================

// ── Print positions ────────────────────────────────────────────
player.onChat("where", function () {
    let px = player.position().getValue(Axis.X);
    let py = player.position().getValue(Axis.Y);
    let pz = player.position().getValue(Axis.Z);
    let ex = agent.getPosition().getValue(Axis.X);
    let ey = agent.getPosition().getValue(Axis.Y);
    let ez = agent.getPosition().getValue(Axis.Z);

    player.say("Player:  X=" + px + "  Y=" + py + "  Z=" + pz);
    player.say("Agent:   X=" + ex + "  Y=" + ey + "  Z=" + ez);
});

// ── Print distance ─────────────────────────────────────────────
player.onChat("dist", function () {
    let px = player.position().getValue(Axis.X);
    let pz = player.position().getValue(Axis.Z);
    let ex = agent.getPosition().getValue(Axis.X);
    let ez = agent.getPosition().getValue(Axis.Z);

    let dx   = px - ex;
    let dz   = pz - ez;
    let dist = Math.sqrt(dx * dx + dz * dz);

    player.say("Distance (X/Z plane): " + Math.round(dist * 10) / 10 + " blocks");
    player.say("Raw: dx=" + dx + "  dz=" + dz);
});

// ── Place a wool marker at agent's current position ───────────
player.onChat("mark", function () {
    let ex = agent.getPosition().getValue(Axis.X);
    let ey = agent.getPosition().getValue(Axis.Y);
    let ez = agent.getPosition().getValue(Axis.Z);

    // Place a lime wool block one block below the agent
    blocks.place(LIME_WOOL, world(ex, ey - 1, ez));
    player.say("Marked agent position: (" + ex + ", " + ey + ", " + ez + ")");
});

// ── Trail: drop wool blocks as the agent moves ────────────────
let trailActive = false;

player.onChat("trail", function (onOrOff) {
    if (onOrOff === "on") {
        trailActive = true;
        player.say("Trail ON — green wool blocks will mark the agent's path.");
    } else {
        trailActive = false;
        player.say("Trail OFF.");
    }
});

game.onGameUpdate(function () {
    if (!trailActive) return;

    let ex = agent.getPosition().getValue(Axis.X);
    let ey = agent.getPosition().getValue(Axis.Y);
    let ez = agent.getPosition().getValue(Axis.Z);

    // Place a light-green block below the agent each tick
    // This creates a visible trail of where the agent has been
    blocks.place(LIME_WOOL, world(ex, ey - 1, ez));
});

// ── Full vector math printout for current positions ───────────
player.onChat("vector", function () {
    let px = player.position().getValue(Axis.X);
    let pz = player.position().getValue(Axis.Z);
    let ex = agent.getPosition().getValue(Axis.X);
    let ez = agent.getPosition().getValue(Axis.Z);

    let dx  = px - ex;
    let dz  = pz - ez;
    let mag = Math.sqrt(dx * dx + dz * dz);

    player.say("── Vector Math Debug ──");

    if (mag === 0) {
        player.say("Agent and player are at the same position! (mag = 0)");
        return;
    }

    let nx    = dx / mag;
    let nz    = dz / mag;
    let moveX = Math.round(nx);
    let moveZ = Math.round(nz);

    // Display with 3 decimal places
    let r = function(n) { return Math.round(n * 1000) / 1000; };

    player.say("Difference:  dx=" + dx + "  dz=" + dz);
    player.say("Magnitude:   " + r(mag) + " blocks");
    player.say("Normalized:  nx=" + r(nx) + "  nz=" + r(nz));
    player.say("Move (speed=1): moveX=" + moveX + "  moveZ=" + moveZ);
    player.say("New agent pos: (" + (ex + moveX) + ", " + (ez + moveZ) + ")");
});

// ── Simulate: show where agent WOULD move toward a target ─────
//   Type "simulate 25 18" to see the math for agent moving toward (25, _, 18)
player.onChat("simulate", function (targetX, targetZ) {
    let ex = agent.getPosition().getValue(Axis.X);
    let ez = agent.getPosition().getValue(Axis.Z);

    let dx  = targetX - ex;
    let dz  = targetZ - ez;
    let mag = Math.sqrt(dx * dx + dz * dz);

    if (mag < 0.01) {
        player.say("Agent is already at that position.");
        return;
    }

    let nx    = dx / mag;
    let nz    = dz / mag;
    let moveX = Math.round(nx);
    let moveZ = Math.round(nz);

    let r = function(n) { return Math.round(n * 1000) / 1000; };

    player.say("Simulate: agent at (" + ex + ", " + ez + ") → target (" + targetX + ", " + targetZ + ")");
    player.say("Normalized: (" + r(nx) + ", " + r(nz) + ")");
    player.say("Agent would move to: (" + (ex + moveX) + ", " + (ez + moveZ) + ")");
});

// ── Reset: teleport agent back to a position near the player ──
player.onChat("reset", function () {
    let px = player.position().getValue(Axis.X);
    let py = player.position().getValue(Axis.Y);
    let pz = player.position().getValue(Axis.Z);

    agent.teleport(pos(px + 10, py, pz), CompassDirection.West);
    player.say("Agent reset to player X+10.");
});

// ── Help command ───────────────────────────────────────────────
player.onChat("help", function () {
    player.say("=== Debug Commands ===");
    player.say("where       — print positions");
    player.say("dist        — print distance");
    player.say("mark        — drop wool at agent");
    player.say("trail on/off— wool trail mode");
    player.say("vector      — print vector math");
    player.say("simulate X Z— preview a move");
    player.say("reset       — move agent to start");
});
