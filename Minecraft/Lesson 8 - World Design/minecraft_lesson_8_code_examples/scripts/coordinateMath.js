// ============================================================
// Day 8 — Coordinate Math Tools
// Minecraft Education Edition  |  JavaScript (Scripting API)
// File: scripts/coordinateMath.js
// ============================================================
// This file contains pure math functions that mirror everything
// taught in the "Math Connection" section of the lesson.
// It also registers a chat command /mathcheck so students can
// try the functions live inside their Minecraft world.
//
// Concepts covered:
//   • Sketch-cell → block coordinate conversion
//   • Manhattan distance formula
//   • Chunk identification from a block coordinate
//   • Scale changes (what happens when CELL_SIZE changes?)
// ============================================================

import * as mc from "@minecraft/server";

// ════════════════════════════════════════════════════════════
// PART A — COORDINATE CONVERSION
// (Lesson slide 7: "Block Coordinates & Distance Math")
// ════════════════════════════════════════════════════════════

/**
 * Converts a sketch cell (col, row) into real Minecraft block coordinates.
 *
 * Math shown step-by-step so students can follow along:
 *   world_X = originX + col × cellSize
 *   world_Z = originZ + row × cellSize
 *
 * @param {number} col      - column on the sketch (0-indexed, left → right)
 * @param {number} row      - row on the sketch (0-indexed, top → bottom)
 * @param {number} cellSize - how many blocks each sketch square represents
 * @param {number} originX  - world X of the sketch's top-left corner
 * @param {number} originZ  - world Z of the sketch's top-left corner
 * @returns {{ x: number, z: number, workings: string }}
 */
export function sketchCellToBlockCoord(col, row, cellSize = 4, originX = 0, originZ = 0) {
  const x = originX + col * cellSize;
  const z = originZ + row * cellSize;

  // Return the answer AND the full working so students can check their own
  const workings =
    `  world_X = ${originX} + ${col} × ${cellSize} = ${x}\n` +
    `  world_Z = ${originZ} + ${row} × ${cellSize} = ${z}`;

  return { x, z, workings };
}

// ── Example run (matches the lesson's extension question 1) ──
// "A collectible is at (col=7, row=3). If each cell = 4 blocks,
//  what are the real-world X and Z coordinates?"
const q1 = sketchCellToBlockCoord(7, 3, 4);
console.log("Q1 — Collectible at sketch(7,3):");
console.log(q1.workings);
// Expected: X = 28, Z = 12


// ════════════════════════════════════════════════════════════
// PART B — DISTANCE FORMULA
// (Core concept: Distance = |X₂−X₁| + |Z₂−Z₁|)
// ════════════════════════════════════════════════════════════

/**
 * Calculates the Manhattan (block) distance between two points.
 * This matches how Minecraft measures horizontal distance —
 * no diagonal shortcut, you walk blocks one at a time.
 *
 * @param {{ x: number, z: number }} pointA
 * @param {{ x: number, z: number }} pointB
 * @returns {{ distance: number, workings: string }}
 */
export function blockDistance(pointA, pointB) {
  const dx = Math.abs(pointB.x - pointA.x);
  const dz = Math.abs(pointB.z - pointA.z);
  const distance = dx + dz;

  const workings =
    `  |X₂ − X₁| = |${pointB.x} − ${pointA.x}| = ${dx}\n` +
    `  |Z₂ − Z₁| = |${pointB.z} − ${pointA.z}| = ${dz}\n` +
    `  Distance  = ${dx} + ${dz} = ${distance} blocks`;

  return { distance, workings };
}

// ── Example run (matches the lesson's example problem) ──
// Spawn at (0, 64, 0) → Goal at (48, 64, 32)
const example = blockDistance({ x: 0, z: 0 }, { x: 48, z: 32 });
console.log("\nLesson Example — Spawn(0,0) to Goal(48,32):");
console.log(example.workings);
// Expected: 80 blocks


// ── Extension question 2 ──
// "Your spawn is at X=−16. How many blocks from the origin?"
const q2 = blockDistance({ x: -16, z: 0 }, { x: 0, z: 0 });
console.log("\nQ2 — Spawn at X=−16, distance from origin:");
console.log(q2.workings);
// Expected: 16 blocks


// ════════════════════════════════════════════════════════════
// PART C — CHUNK MATH
// (Challenge question: chunks = 16×16 blocks)
// ════════════════════════════════════════════════════════════

/**
 * Finds which chunk a block belongs to.
 * Chunks are always 16 × 16 blocks on the X and Z axes.
 *
 * Math:
 *   chunkX = Math.floor(blockX / 16)
 *   chunkZ = Math.floor(blockZ / 16)
 *
 * @param {number} blockX
 * @param {number} blockZ
 * @returns {{ chunkX: number, chunkZ: number, workings: string }}
 */
export function blockToChunk(blockX, blockZ) {
  const chunkX = Math.floor(blockX / 16);
  const chunkZ = Math.floor(blockZ / 16);

  const workings =
    `  chunkX = floor(${blockX} ÷ 16) = ${chunkX}\n` +
    `  chunkZ = floor(${blockZ} ÷ 16) = ${chunkZ}`;

  return { chunkX, chunkZ, workings };
}

/**
 * Finds the first block coordinate of a chunk.
 * Reverse of blockToChunk.
 *
 * @param {number} chunkX
 * @param {number} chunkZ
 * @returns {{ blockX: number, blockZ: number }}
 */
export function chunkToBlockOrigin(chunkX, chunkZ) {
  return {
    blockX: chunkX * 16,
    blockZ: chunkZ * 16,
  };
}

/**
 * Counts how many chunks fit across a given block distance.
 *
 * @param {number} blockWidth - total width in blocks
 * @returns {{ fullChunks: number, remainder: number, workings: string }}
 */
export function chunksAcross(blockWidth) {
  const fullChunks = Math.floor(blockWidth / 16);
  const remainder = blockWidth % 16;

  const workings =
    `  ${blockWidth} ÷ 16 = ${fullChunks} full chunk(s)` +
    (remainder > 0 ? ` + ${remainder} extra block(s)` : " exactly");

  return { fullChunks, remainder, workings };
}

// ── Challenge question ──
// "An 80-block-wide level — how many chunks does it span?"
const challenge = chunksAcross(80);
console.log("\nChallenge — 80-block level, how many chunks?");
console.log(challenge.workings);
// Expected: 5 full chunks

// ── Homework extension ──
// "A 128×128 block world — how many chunks total?"
const hw = chunksAcross(128);
console.log("\nHomework — 128×128 world, how many chunks per side?");
console.log(hw.workings);
console.log(`  Total chunks = ${hw.fullChunks} × ${hw.fullChunks} = ${hw.fullChunks ** 2}`);
// Expected: 8 × 8 = 64 chunks


// ════════════════════════════════════════════════════════════
// PART D — SCALE CHANGES
// (Reflection question: "what if cellSize changes from 4 to 2?")
// ════════════════════════════════════════════════════════════

/**
 * Shows what happens to all positions when you change the cell size.
 * This is the core of the exit-ticket reflection question.
 *
 * @param {Array<{col: number, row: number, label: string}>} sketchPoints
 * @param {number} oldCellSize
 * @param {number} newCellSize
 */
export function compareScales(sketchPoints, oldCellSize, newCellSize) {
  console.log(`\nScale Change: cellSize ${oldCellSize} → ${newCellSize}`);
  console.log("─".repeat(50));

  sketchPoints.forEach(({ col, row, label }) => {
    const oldCoord = sketchCellToBlockCoord(col, row, oldCellSize);
    const newCoord = sketchCellToBlockCoord(col, row, newCellSize);
    const scaleRatio = newCellSize / oldCellSize;

    console.log(
      `${label.padEnd(18)}: old=(${oldCoord.x}, ${oldCoord.z})  →  ` +
      `new=(${newCoord.x}, ${newCoord.z})  [× ${scaleRatio}]`
    );
  });

  const oldTotal = 20 * oldCellSize;
  const newTotal = 20 * newCellSize;
  console.log(`\nLevel total width: ${oldTotal} blocks → ${newTotal} blocks`);
  console.log(`Everything scales by a factor of ${newCellSize / oldCellSize}.`);
}

// Run the scale comparison for the exit ticket question
compareScales(
  [
    { col: 0, row: 0, label: "Spawn" },
    { col: 7, row: 3, label: "Collectible" },
    { col: 18, row: 2, label: "Goal" },
  ],
  4,  // original cell size
  2   // new cell size (halved — what happens?)
);


// ════════════════════════════════════════════════════════════
// PART E — LIVE /mathcheck CHAT COMMAND
// ════════════════════════════════════════════════════════════
// Students can type in chat:
//   /mathcheck dist 0 0 48 32
//   /mathcheck cell 7 3
//   /mathcheck chunk 48 32

mc.world.afterEvents.chatSend.subscribe((event) => {
  const msg = event.message.trim();
  const player = event.sender;

  if (!msg.startsWith("/mathcheck")) return;

  const parts = msg.split(" ");
  const subCommand = parts[1];

  try {
    if (subCommand === "dist") {
      // /mathcheck dist X1 Z1 X2 Z2
      const [x1, z1, x2, z2] = parts.slice(2).map(Number);
      const result = blockDistance({ x: x1, z: z1 }, { x: x2, z: z2 });
      player.sendMessage(`§a[MathCheck] Distance from (${x1},${z1}) to (${x2},${z2}):`);
      player.sendMessage(`§e${result.workings}`);
      player.sendMessage(`§b= ${result.distance} blocks`);

    } else if (subCommand === "cell") {
      // /mathcheck cell col row
      const [col, row] = parts.slice(2).map(Number);
      const result = sketchCellToBlockCoord(col, row);
      player.sendMessage(`§a[MathCheck] Sketch cell (${col}, ${row}) → world coords:`);
      player.sendMessage(`§e${result.workings}`);

    } else if (subCommand === "chunk") {
      // /mathcheck chunk blockX blockZ
      const [bx, bz] = parts.slice(2).map(Number);
      const result = blockToChunk(bx, bz);
      player.sendMessage(`§a[MathCheck] Block (${bx}, ${bz}) is in:`);
      player.sendMessage(`§e${result.workings}`);

    } else {
      player.sendMessage("§cUsage: /mathcheck [dist|cell|chunk] [numbers...]");
      player.sendMessage("§7Examples:");
      player.sendMessage("§7  /mathcheck dist 0 0 48 32");
      player.sendMessage("§7  /mathcheck cell 7 3");
      player.sendMessage("§7  /mathcheck chunk 48 32");
    }
  } catch {
    player.sendMessage("§cError — check your numbers and try again.");
  }
});
