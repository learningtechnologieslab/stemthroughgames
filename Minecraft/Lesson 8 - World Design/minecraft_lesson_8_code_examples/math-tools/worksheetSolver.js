// ============================================================
// Day 8 — Math Worksheet Solver
// Standalone Node.js script (runs outside Minecraft)
// File: math-tools/worksheetSolver.js
// ============================================================
// Run this in a terminal to check your answers to the
// Day 8 math worksheet:
//
//   node math-tools/worksheetSolver.js
//
// Students can also edit the numbers at the bottom of the file
// and re-run to explore how the formulas work.
// ============================================================

// ── FORMULA 1: Sketch cell → World coordinates ──────────────

function sketchToWorld(col, row, cellSize) {
  const worldX = col * cellSize;
  const worldZ = row * cellSize;
  return { worldX, worldZ };
}

// ── FORMULA 2: Manhattan distance between two blocks ─────────

function blockDistance(x1, z1, x2, z2) {
  return Math.abs(x2 - x1) + Math.abs(z2 - z1);
}

// ── FORMULA 3: Chunk from block coordinate ───────────────────

function blockToChunk(blockCoord) {
  return Math.floor(blockCoord / 16);
}

// ── FORMULA 4: Number of chunks across a distance ────────────

function chunksAcross(blockWidth) {
  return Math.ceil(blockWidth / 16);
}

// ════════════════════════════════════════════════════════════
// WORKSHEET PROBLEMS
// ════════════════════════════════════════════════════════════

console.log("╔══════════════════════════════════════════════╗");
console.log("║    Day 8 Math Worksheet — Worked Answers     ║");
console.log("╚══════════════════════════════════════════════╝\n");

// ── LESSON EXAMPLE ──────────────────────────────────────────
console.log("── Lesson Example ─────────────────────────────");
console.log("Spawn: (0, 64, 0)   |   Goal: (48, 64, 32)");
const exampleDist = blockDistance(0, 0, 48, 32);
console.log(`Distance = |48−0| + |32−0| = ${exampleDist} blocks`);
console.log(`Answer: ${exampleDist} blocks ✓\n`);

// ── EXTENSION QUESTION 1 ────────────────────────────────────
console.log("── Extension Q1 ────────────────────────────────");
console.log("Collectible at sketch (col=7, row=3), cellSize=4");
const q1 = sketchToWorld(7, 3, 4);
console.log(`world_X = 7 × 4 = ${q1.worldX}`);
console.log(`world_Z = 3 × 4 = ${q1.worldZ}`);
console.log(`Answer: Block (${q1.worldX}, 64, ${q1.worldZ}) ✓\n`);

// ── EXTENSION QUESTION 2 ────────────────────────────────────
console.log("── Extension Q2 ────────────────────────────────");
console.log("Spawn at X=−16, how far from origin (X=0)?");
const q2 = blockDistance(-16, 0, 0, 0);
console.log(`Distance = |0 − (−16)| = |16| = ${q2} blocks`);
console.log(`Answer: ${q2} blocks ✓\n`);

// ── EXTENSION QUESTION 3 ────────────────────────────────────
console.log("── Extension Q3 ────────────────────────────────");
console.log("Level is 20 cells wide, cellSize=4 blocks per cell");
const levelWidthBlocks = 20 * 4;
console.log(`Total width = 20 × 4 = ${levelWidthBlocks} blocks`);
console.log(`Answer: ${levelWidthBlocks} blocks ✓\n`);

// ── CHALLENGE QUESTION ──────────────────────────────────────
console.log("── Challenge Question ──────────────────────────");
console.log("80-block level — how many chunks does it span?");
const challengeChunks = chunksAcross(80);
const exactDiv = 80 / 16;
console.log(`80 ÷ 16 = ${exactDiv} → ${challengeChunks} chunk(s)`);
console.log(`Answer: ${challengeChunks} chunks ✓\n`);

// ── HOMEWORK EXTENSION ──────────────────────────────────────
console.log("── Homework Extension ──────────────────────────");
console.log("128×128 block world — how many chunks total?");
const chunksPerSide = chunksAcross(128);
const totalChunks = chunksPerSide * chunksPerSide;
console.log(`Chunks per side = 128 ÷ 16 = ${chunksPerSide}`);
console.log(`Total chunks = ${chunksPerSide} × ${chunksPerSide} = ${totalChunks}`);
console.log(`Total ground blocks = 128 × 128 = ${128 * 128}`);
console.log(`Answer: ${totalChunks} chunks, ${128 * 128} ground blocks ✓\n`);

// ════════════════════════════════════════════════════════════
// INTERACTIVE SECTION — edit these numbers!
// ════════════════════════════════════════════════════════════

console.log("╔══════════════════════════════════════════════╗");
console.log("║    Try Your Own Numbers Below                ║");
console.log("╚══════════════════════════════════════════════╝\n");

// ── YOUR SPAWN AND GOAL (edit these) ──
const MY_SPAWN = { x: 0,  z: 0  };
const MY_GOAL  = { x: 64, z: 16 };
const MY_CELL_SIZE = 4;

const myDist = blockDistance(MY_SPAWN.x, MY_SPAWN.z, MY_GOAL.x, MY_GOAL.z);
console.log(`My spawn: (${MY_SPAWN.x}, 64, ${MY_SPAWN.z})`);
console.log(`My goal:  (${MY_GOAL.x}, 64, ${MY_GOAL.z})`);
console.log(`Distance from my spawn to goal: ${myDist} blocks\n`);

// ── YOUR SKETCH COLLECTIBLES (edit the (col, row) pairs) ──
const myCollectibles = [
  { col: 2, row: 2 },
  { col: 5, row: 2 },
  { col: 9, row: 2 },
];

console.log(`My collectible block positions (cellSize = ${MY_CELL_SIZE}):`);
myCollectibles.forEach(({ col, row }, i) => {
  const { worldX, worldZ } = sketchToWorld(col, row, MY_CELL_SIZE);
  console.log(`  Collectible ${i + 1}: sketch(${col},${row}) → block(${worldX}, 64, ${worldZ})`);
});

// ── WHAT CHUNK AM I IN? ──
console.log(`\nChunk for my goal block (${MY_GOAL.x}, ${MY_GOAL.z}):`);
console.log(`  chunkX = floor(${MY_GOAL.x} / 16) = ${blockToChunk(MY_GOAL.x)}`);
console.log(`  chunkZ = floor(${MY_GOAL.z} / 16) = ${blockToChunk(MY_GOAL.z)}`);
