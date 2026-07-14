// ============================================================
// Day 8 — Level Design Principles Checker
// Minecraft Education Edition  |  JavaScript (Scripting API)
// File: scripts/designChecker.js
// ============================================================
// This script lets students run a self-assessment of their
// level against the four design principles taught in the lesson.
// Type  /checkdesign  in chat to get a report.
//
// Principles checked:
//   1. Clear Signposting  — Is there a visible path of collectibles?
//   2. Gradual Challenge  — Does difficulty increase over the level?
//   3. Fair but Difficult — Are hazards visible before you reach them?
//   4. Pacing & Breathing Room — Is there a safe zone after hard areas?
// ============================================================

import * as mc from "@minecraft/server";

const world = mc.world;
const OVERWORLD = world.getDimension("overworld");

// ════════════════════════════════════════════════════════════
// DESIGN PRINCIPLE 1 — Clear Signposting
// ════════════════════════════════════════════════════════════

/**
 * Checks for a "breadcrumb trail" — collectible blocks placed
 * at regular intervals guiding the player toward the goal.
 *
 * Looks for gold blocks spaced no more than 16 blocks apart
 * along the X axis (the direction of travel in this level).
 *
 * @param {number} startX  - X coord of level start
 * @param {number} endX    - X coord of level end
 * @param {number} surfaceY - Y level to scan
 * @param {number} z       - Z coord to scan along
 * @returns {{ passed: boolean, message: string, count: number }}
 */
function checkSignposting(startX, endX, surfaceY, z) {
  const collectibleBlock = "minecraft:gold_block";
  const maxGap = 16;  // blocks between collectibles

  const found = [];
  for (let x = startX; x <= endX; x++) {
    const block = OVERWORLD.getBlock({ x, y: surfaceY, z });
    if (block?.typeId === collectibleBlock) {
      found.push(x);
    }
  }

  if (found.length === 0) {
    return { passed: false, message: "✗ No gold block collectibles found. Add a trail to guide players.", count: 0 };
  }

  // Check for large gaps between collectibles
  let maxFoundGap = 0;
  for (let i = 1; i < found.length; i++) {
    maxFoundGap = Math.max(maxFoundGap, found[i] - found[i - 1]);
  }

  if (maxFoundGap > maxGap) {
    return {
      passed: false,
      message: `✗ Largest gap between collectibles: ${maxFoundGap} blocks (aim for ≤${maxGap}).`,
      count: found.length,
    };
  }

  return {
    passed: true,
    message: `✓ ${found.length} collectibles found, largest gap = ${maxFoundGap} blocks. Good signposting!`,
    count: found.length,
  };
}


// ════════════════════════════════════════════════════════════
// DESIGN PRINCIPLE 2 — Gradual Challenge
// ════════════════════════════════════════════════════════════

/**
 * Checks that hazards (lava, void gaps) don't appear in the
 * first 20% of the level.
 *
 * Early hazards before the player understands the mechanics
 * = bad design (not gradual).
 *
 * @param {number} startX
 * @param {number} endX
 * @param {number} surfaceY
 * @param {number} z
 * @returns {{ passed: boolean, message: string }}
 */
function checkGradualChallenge(startX, endX, surfaceY, z) {
  const hazardBlocks = ["minecraft:lava", "minecraft:fire"];
  const safeZoneEnd = startX + Math.floor((endX - startX) * 0.2);  // first 20%

  for (let x = startX; x <= safeZoneEnd; x++) {
    for (let dy = -3; dy <= 1; dy++) {
      const block = OVERWORLD.getBlock({ x, y: surfaceY + dy, z });
      if (block && hazardBlocks.includes(block.typeId)) {
        return {
          passed: false,
          message: `✗ Hazard at X=${x} — that's in the first 20% of the level (safe zone ends at X=${safeZoneEnd}). Move it further along.`,
        };
      }
    }
  }

  return {
    passed: true,
    message: `✓ No hazards in the first 20% of the level (X=${startX}–${safeZoneEnd}). Gradual challenge achieved!`,
  };
}


// ════════════════════════════════════════════════════════════
// DESIGN PRINCIPLE 3 — Fair but Difficult
// ════════════════════════════════════════════════════════════

/**
 * Checks that every lava block or drop has at least 4 blocks
 * of approach space — enough runway for the player to see it
 * coming and decide whether to jump.
 *
 * "Visible hazard with enough room to stop" = fair design.
 *
 * @param {number} startX
 * @param {number} endX
 * @param {number} surfaceY
 * @param {number} z
 * @returns {{ passed: boolean, message: string, issues: string[] }}
 */
function checkFairDesign(startX, endX, surfaceY, z) {
  const MIN_APPROACH = 4;  // solid blocks before a hazard
  const issues = [];

  for (let x = startX + MIN_APPROACH; x <= endX; x++) {
    const block = OVERWORLD.getBlock({ x, y: surfaceY - 1, z });
    const isHazard = block?.typeId === "minecraft:lava" ||
                     block?.typeId === "minecraft:air";  // void gap

    if (isHazard) {
      // Count solid approach blocks leading up to this hazard
      let solidApproach = 0;
      for (let lookBack = 1; lookBack <= MIN_APPROACH; lookBack++) {
        const approachBlock = OVERWORLD.getBlock({ x: x - lookBack, y: surfaceY - 1, z });
        if (approachBlock?.isSolid) solidApproach++;
      }

      if (solidApproach < MIN_APPROACH) {
        issues.push(`X=${x}: hazard with only ${solidApproach} approach block(s) (need ${MIN_APPROACH})`);
      }
    }
  }

  if (issues.length > 0) {
    return {
      passed: false,
      message: `✗ ${issues.length} hazard(s) don't give enough warning:\n  ${issues.join("\n  ")}`,
      issues,
    };
  }

  return {
    passed: true,
    message: "✓ All hazards have at least 4 blocks of visible approach. Fair design!",
    issues: [],
  };
}


// ════════════════════════════════════════════════════════════
// DESIGN PRINCIPLE 4 — Pacing & Breathing Room
// ════════════════════════════════════════════════════════════

/**
 * Looks for at least one "rest platform" — a stretch of 8+
 * consecutive safe blocks placed AFTER a hazard zone.
 * A gold block collectible on that platform is a bonus.
 *
 * @param {number} startX
 * @param {number} endX
 * @param {number} surfaceY
 * @param {number} z
 * @returns {{ passed: boolean, message: string }}
 */
function checkPacing(startX, endX, surfaceY, z) {
  const MIN_REST_LENGTH = 8;
  let consecutiveSafe = 0;
  let afterHazard = false;
  let foundRestZone = false;

  for (let x = startX; x <= endX; x++) {
    const below = OVERWORLD.getBlock({ x, y: surfaceY - 1, z });
    const isHazard = below?.typeId === "minecraft:lava" || below?.typeId === "minecraft:air";

    if (isHazard) {
      consecutiveSafe = 0;
      afterHazard = true;
    } else if (below?.isSolid) {
      consecutiveSafe++;
      if (afterHazard && consecutiveSafe >= MIN_REST_LENGTH) {
        foundRestZone = true;
        break;
      }
    }
  }

  if (!foundRestZone) {
    return {
      passed: false,
      message: `✗ No rest zone found after a hazard (need ${MIN_REST_LENGTH}+ consecutive safe blocks). Add a flat recovery platform.`,
    };
  }

  return {
    passed: true,
    message: "✓ Rest zone found after a hazard. Good pacing!",
  };
}


// ════════════════════════════════════════════════════════════
// FULL REPORT — combines all four checks
// ════════════════════════════════════════════════════════════

/**
 * Runs all four design principle checks and sends a formatted
 * report to the player in chat.
 *
 * @param {mc.Player} player
 * @param {object} levelBounds - { startX, endX, surfaceY, z }
 */
function runDesignReport(player, levelBounds) {
  const { startX, endX, surfaceY, z } = levelBounds;

  player.sendMessage("§6━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
  player.sendMessage("§e  Day 8 — Level Design Checker");
  player.sendMessage("§6━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

  const checks = [
    { name: "1. Clear Signposting",    fn: () => checkSignposting(startX, endX, surfaceY, z) },
    { name: "2. Gradual Challenge",    fn: () => checkGradualChallenge(startX, endX, surfaceY, z) },
    { name: "3. Fair but Difficult",   fn: () => checkFairDesign(startX, endX, surfaceY, z) },
    { name: "4. Pacing & Breathing",   fn: () => checkPacing(startX, endX, surfaceY, z) },
  ];

  let score = 0;

  checks.forEach(({ name, fn }) => {
    const result = fn();
    const colour = result.passed ? "§a" : "§c";
    player.sendMessage(`${colour}${name}`);
    player.sendMessage(`§7  ${result.message}`);
    if (result.passed) score++;
  });

  player.sendMessage("§6━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
  player.sendMessage(`§b  Score: ${score}/4 principles met`);

  if (score === 4) {
    player.sendMessage("§a  Excellent! All four principles applied. 🎉");
  } else if (score >= 2) {
    player.sendMessage("§e  Good start — fix the ✗ items above.");
  } else {
    player.sendMessage("§c  Keep going — review the design slides.");
  }

  player.sendMessage("§6━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
}


// ════════════════════════════════════════════════════════════
// CHAT COMMAND — /checkdesign
// ════════════════════════════════════════════════════════════

mc.world.afterEvents.chatSend.subscribe((event) => {
  if (!event.message.trim().startsWith("/checkdesign")) return;

  const player = event.sender;

  // Default: scan the standard lesson level footprint
  // Students can edit these numbers to match their own level
  const levelBounds = {
    startX:   0,
    endX:    80,
    surfaceY: 64,
    z:        6,   // middle of the 12-block-deep platform
  };

  player.sendMessage("§7Scanning your level...");
  runDesignReport(player, levelBounds);
});
