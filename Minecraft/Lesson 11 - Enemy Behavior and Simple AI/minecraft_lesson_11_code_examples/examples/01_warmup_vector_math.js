// ============================================================
// Day 11 — Example 01: Warm-Up Vector Math
// STEM Through Games · Minecraft Education Edition
// ============================================================
//
// PURPOSE:
//   This example does NOT move anything in the world.
//   It prints the vector math steps to the Minecraft chat
//   so students can see the numbers and verify their
//   warm-up worksheet answers.
//
// HOW TO USE:
//   1. Open Code Builder (press C).
//   2. Switch to JavaScript mode.
//   3. Paste this code and click Play.
//   4. Type "vector" in chat to run the calculation.
//
// WARM-UP QUESTION:
//   Zombie is at (10, 64, 10). Player is at (16, 64, 15).
//   Which direction should the zombie move?
// ============================================================

// --- Trigger: type "vector" in Minecraft chat to run ---
player.onChat("vector", function () {

    // Step 1: Define positions (from warm-up question)
    let enemyX = 10;
    let enemyZ = 10;
    let playerX = 16;
    let playerZ = 15;

    // Step 2: Calculate the difference vector
    //   This points FROM the enemy TOWARD the player.
    //   We subtract enemy from player (not the other way around!).
    let dx = playerX - enemyX;   // 16 - 10 = 6
    let dz = playerZ - enemyZ;   // 15 - 10 = 5

    player.say("=== VECTOR MATH WALKTHROUGH ===");
    player.say("Enemy position:  X=" + enemyX + "  Z=" + enemyZ);
    player.say("Player position: X=" + playerX + "  Z=" + playerZ);
    player.say("Difference (dx, dz) = (" + dx + ", " + dz + ")");

    // Step 3: Calculate magnitude (the length of the vector)
    //   This tells us HOW FAR apart they are.
    //   Formula: |v| = sqrt(dx^2 + dz^2)
    let magnitude = Math.sqrt(dx * dx + dz * dz);
    let magRounded = Math.round(magnitude * 100) / 100; // 2 decimal places

    player.say("Magnitude = sqrt(" + dx + "^2 + " + dz + "^2)");
    player.say("Magnitude = sqrt(" + (dx * dx) + " + " + (dz * dz) + ")");
    player.say("Magnitude = sqrt(" + (dx * dx + dz * dz) + ") ≈ " + magRounded);

    // Step 4: Normalize (divide each component by magnitude)
    //   This gives us a DIRECTION with length exactly 1.0.
    //   We can then multiply by any speed we want.
    let nx = dx / magnitude;
    let nz = dz / magnitude;

    // Round to 3 decimal places for display
    let nxDisplay = Math.round(nx * 1000) / 1000;
    let nzDisplay = Math.round(nz * 1000) / 1000;

    player.say("Normalized: (" + nxDisplay + ", " + nzDisplay + ")");
    player.say("Check: length = sqrt(" + nxDisplay + "^2 + " + nzDisplay + "^2) ≈ 1.0");

    // Step 5: Apply speed and round for Minecraft blocks
    //   Minecraft blocks are integers — we MUST round.
    let speed = 1; // blocks per tick
    let moveX = Math.round(nx * speed);
    let moveZ = Math.round(nz * speed);

    player.say("At speed=" + speed + ": move (" + moveX + " blocks in X, " + moveZ + " blocks in Z)");
    player.say("=== END ===");
});

// --- Bonus: try different positions ---
// Type "custom 5 3 12 9" to test enemy at (5,3) vs player at (12,9)
player.onChat("custom", function (enemyX, enemyZ, playerX, playerZ) {
    let dx = playerX - enemyX;
    let dz = playerZ - enemyZ;
    let mag = Math.sqrt(dx * dx + dz * dz);

    if (mag === 0) {
        player.say("Enemy and player are at the same position!");
        return;
    }

    let nx = Math.round((dx / mag) * 1000) / 1000;
    let nz = Math.round((dz / mag) * 1000) / 1000;
    let magR = Math.round(mag * 100) / 100;

    player.say("Difference: (" + dx + ", " + dz + ")  Magnitude: " + magR);
    player.say("Normalized direction: (" + nx + ", " + nz + ")");
});
