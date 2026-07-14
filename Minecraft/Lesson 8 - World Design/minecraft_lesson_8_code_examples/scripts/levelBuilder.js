// ============================================================
// Day 8 — Level Builder Script
// Minecraft Education Edition  |  JavaScript (Scripting API)
// File: scripts/levelBuilder.js
// ============================================================
// This script runs inside a Minecraft Education behaviour pack.
// It demonstrates how to programmatically build the Day 8
// starter level — each function maps to one step in the lesson.
//
// To use:
//   1. Place this file in your behaviour pack under scripts/
//   2. In manifest.json set "entry": "scripts/levelBuilder.js"
//   3. Load the world — the level builds automatically at start.
// ============================================================

import * as mc from "@minecraft/server";

const world = mc.world;
const OVERWORLD = world.getDimension("overworld");

// ── CONFIGURATION ─────────────────────────────────────────────
// Change these numbers to match your graph-paper sketch.
// Each "cell" on your sketch = CELL_SIZE blocks in the world.
const CONFIG = {
  CELL_SIZE: 4,       // blocks per sketch cell
  GROUND_Y: 63,       // Y level for the ground surface
  ORIGIN_X: 0,        // world X where level starts
  ORIGIN_Z: 0,        // world Z where level starts
};

// ── HELPER: place a filled box of blocks ──────────────────────
/**
 * Fills a rectangular region with a block type.
 * Mirrors the /fill command: /fill x1 y1 z1 x2 y2 z2 blockType
 *
 * @param {number} x1 - west corner X
 * @param {number} y1 - bottom Y
 * @param {number} z1 - north corner Z
 * @param {number} x2 - east corner X
 * @param {number} y2 - top Y
 * @param {number} z2 - south corner Z
 * @param {string} blockType - Minecraft block ID (e.g. "minecraft:stone")
 */
function fillRegion(x1, y1, z1, x2, y2, z2, blockType) {
  // Normalise so x1 <= x2, etc.
  const [minX, maxX] = [Math.min(x1, x2), Math.max(x1, x2)];
  const [minY, maxY] = [Math.min(y1, y2), Math.max(y1, y2)];
  const [minZ, maxZ] = [Math.min(z1, z2), Math.max(z1, z2)];

  for (let x = minX; x <= maxX; x++) {
    for (let y = minY; y <= maxY; y++) {
      for (let z = minZ; z <= maxZ; z++) {
        OVERWORLD.getBlock({ x, y, z })?.setType(blockType);
      }
    }
  }
}

// ── HELPER: place a single block ──────────────────────────────
/**
 * Places one block — equivalent to /setblock x y z blockType
 */
function setBlock(x, y, z, blockType) {
  OVERWORLD.getBlock({ x, y, z })?.setType(blockType);
}

// ── HELPER: sketch-cell to world coordinates ──────────────────
/**
 * Converts a sketch cell (col, row) to real (X, Z) block coords.
 * This is the core math connection from the lesson:
 *   world_X = ORIGIN_X + col * CELL_SIZE
 *   world_Z = ORIGIN_Z + row * CELL_SIZE
 *
 * @param {number} col - column index from your sketch
 * @param {number} row - row index from your sketch
 * @returns {{ x: number, z: number }}
 */
function sketchToWorld(col, row) {
  return {
    x: CONFIG.ORIGIN_X + col * CONFIG.CELL_SIZE,
    z: CONFIG.ORIGIN_Z + row * CONFIG.CELL_SIZE,
  };
}

// ── STEP 1 — Clear and prepare the build area ─────────────────
/**
 * Clears a flat area and lays down a grass base.
 * Called first so students start with a blank canvas.
 */
function prepareGroundLayer() {
  console.log("[Day8] Step 1: Preparing ground layer...");

  // Clear any existing blocks above the ground line
  fillRegion(
    CONFIG.ORIGIN_X,      CONFIG.GROUND_Y + 1, CONFIG.ORIGIN_Z,
    CONFIG.ORIGIN_X + 80, CONFIG.GROUND_Y + 10, CONFIG.ORIGIN_Z + 16,
    "minecraft:air"
  );

  // Lay a flat grass surface (20 cells × 4 cells wide on sketch)
  fillRegion(
    CONFIG.ORIGIN_X,      CONFIG.GROUND_Y, CONFIG.ORIGIN_Z,
    CONFIG.ORIGIN_X + 80, CONFIG.GROUND_Y, CONFIG.ORIGIN_Z + 16,
    "minecraft:grass"
  );

  console.log("[Day8] Ground layer ready.");
}

// ── STEP 2 — Build platforms, walls & floors ──────────────────
/**
 * Builds the main platform sequence from the lesson's sample sketch:
 *   [Spawn] -- platform1 -- GAP -- platform2 -- GAP -- platform3 -- [Goal]
 *
 * Math shown explicitly for each fill so students can trace
 * sketch coordinates → world coordinates.
 */
function buildPlatforms() {
  console.log("[Day8] Step 2: Building platforms...");

  const Y = CONFIG.GROUND_Y;  // shorthand

  // ── Platform 1 (cells 0–3 on sketch) ──
  // sketch: col=0→3, row=0→3
  // world:  X = 0→12, Z = 0→12  (cell_size=4, so 3*4=12)
  const p1 = sketchToWorld(0, 0);
  fillRegion(p1.x, Y, p1.z,  p1.x + 12, Y, p1.z + 12,  "minecraft:stone");

  // ── Gap between platform 1 and 2 (cells 4–4) ──
  // Clear the surface to create a drop-off jump gap
  const gap1 = sketchToWorld(4, 0);
  fillRegion(gap1.x, Y, gap1.z,  gap1.x + 3, Y, gap1.z + 12,  "minecraft:air");

  // ── Platform 2 — slightly elevated (cells 5–9) ──
  // Elevated by 2 blocks to introduce a height-change mechanic
  const p2 = sketchToWorld(5, 0);
  fillRegion(p2.x, Y + 2, p2.z,  p2.x + 16, Y + 2, p2.z + 12,  "minecraft:cobblestone");

  // ── Stair-step connector (cells 5, stepping up) ──
  setBlock(p2.x,     Y,     p2.z + 4,  "minecraft:stone_stairs");
  setBlock(p2.x + 1, Y + 1, p2.z + 4,  "minecraft:stone_stairs");

  // ── Platform 3 — same level as platform 2 (cells 10–15) ──
  const p3 = sketchToWorld(10, 0);
  fillRegion(p3.x, Y + 2, p3.z,  p3.x + 20, Y + 2, p3.z + 12,  "minecraft:stone");

  // ── Final goal platform (cells 16–20) ──
  const goal = sketchToWorld(16, 0);
  fillRegion(goal.x, Y + 2, goal.z,  goal.x + 16, Y + 2, goal.z + 12,  "minecraft:diamond_block");

  console.log("[Day8] Platforms built.");
}

// ── STEP 3 — Add hazards & boundary walls ─────────────────────
/**
 * Places hazards (lava, void gaps) and invisible boundary barriers.
 * Demonstrates the "gradual challenge" design principle:
 *   - First hazard: lava pit with solid ground on both sides (safe to learn)
 *   - Second hazard: void gap (lethal — introduced after the mechanic is learned)
 */
function addHazardsAndBoundaries() {
  console.log("[Day8] Step 3: Adding hazards and boundaries...");

  const Y = CONFIG.GROUND_Y;

  // ── HAZARD 1: Lava pit (safe-context introduction) ──
  // Placed between platform 1 and platform 2
  // The player can clearly see the lava and has room to stop → FAIR
  const lava = sketchToWorld(4, 1);
  fillRegion(lava.x, Y - 2, lava.z,  lava.x + 3, Y - 1, lava.z + 8,  "minecraft:lava");

  // ── HAZARD 2: Void gap (escalated challenge) ──
  // Placed midway across platform 3 — narrower, higher stakes
  const void1 = sketchToWorld(12, 0);
  fillRegion(void1.x, Y - 10, void1.z,  void1.x + 3, Y + 1, void1.z + 12,  "minecraft:air");

  // ── BOUNDARY BARRIERS (invisible walls) ──
  // Keeps players inside the designed play area
  // North wall (Z = ORIGIN_Z - 1)
  fillRegion(
    CONFIG.ORIGIN_X - 1, Y, CONFIG.ORIGIN_Z - 1,
    CONFIG.ORIGIN_X + 85, Y + 6, CONFIG.ORIGIN_Z - 1,
    "minecraft:barrier"
  );
  // South wall (Z = ORIGIN_Z + 17)
  fillRegion(
    CONFIG.ORIGIN_X - 1, Y, CONFIG.ORIGIN_Z + 17,
    CONFIG.ORIGIN_X + 85, Y + 6, CONFIG.ORIGIN_Z + 17,
    "minecraft:barrier"
  );

  console.log("[Day8] Hazards and boundaries placed.");
}

// ── STEP 4 — Place spawn, collectibles & goal zone ────────────
/**
 * Sets the world spawn point and scatters collectibles along the
 * route using the sketch-to-world coordinate conversion.
 *
 * The collectible positions are defined as sketch cells so students
 * can see exactly how (col, row) becomes a real block coordinate.
 */
function placeSpawnAndCollectibles() {
  console.log("[Day8] Step 4: Placing spawn, collectibles, and goal...");

  const Y = CONFIG.GROUND_Y;

  // ── Set world spawn at sketch cell (1, 2) ──
  const spawn = sketchToWorld(1, 2);
  world.setDefaultSpawnLocation({ x: spawn.x, y: Y + 1, z: spawn.z });
  // Mark the spawn with a stone slab so it's visible
  setBlock(spawn.x, Y + 1, spawn.z, "minecraft:stone_slab");

  // ── Collectible gold blocks — breadcrumb trail ──
  // Each entry is a sketch (col, row) that gets converted to world coords
  // This is the "clear signposting" design principle in action
  const collectibleCells = [
    { col: 2, row: 2 },   // early — easy to find
    { col: 5, row: 2 },   // after first gap — reward for crossing
    { col: 8, row: 2 },   // mid-level
    { col: 13, row: 2 },  // after void gap — reward for hard section
    { col: 17, row: 2 },  // near goal
  ];

  collectibleCells.forEach(({ col, row }, index) => {
    const pos = sketchToWorld(col, row);
    // Determine the surface Y at this sketch position
    // (platforms 2 and 3 are Y+2, so adjust accordingly)
    const surfaceY = col >= 5 ? Y + 3 : Y + 1;
    setBlock(pos.x, surfaceY, pos.z, "minecraft:gold_block");
    console.log(
      `[Day8] Collectible ${index + 1}: sketch(${col},${row}) → world(${pos.x}, ${surfaceY}, ${pos.z})`
    );
  });

  // ── Goal zone — beacon tower ──
  const goal = sketchToWorld(18, 2);
  const goalY = Y + 3;  // on top of the diamond platform
  setBlock(goal.x,     goalY,     goal.z,  "minecraft:beacon");
  setBlock(goal.x - 1, goalY - 1, goal.z,  "minecraft:emerald_block");
  setBlock(goal.x + 1, goalY - 1, goal.z,  "minecraft:emerald_block");
  setBlock(goal.x,     goalY - 1, goal.z - 1,  "minecraft:emerald_block");
  setBlock(goal.x,     goalY - 1, goal.z + 1,  "minecraft:emerald_block");

  console.log("[Day8] Spawn, collectibles, and goal zone placed.");
}

// ── BUILD ORDER ───────────────────────────────────────────────
// Run all four steps in sequence when the world loads.
// Each step matches one section of the lesson's Main Activity.
mc.world.afterEvents.worldInitialize.subscribe(() => {
  console.log("[Day8] Starting level build...");
  prepareGroundLayer();   // Step 1
  buildPlatforms();       // Step 2
  addHazardsAndBoundaries(); // Step 3
  placeSpawnAndCollectibles(); // Step 4
  console.log("[Day8] Level build complete! ✓");
});
