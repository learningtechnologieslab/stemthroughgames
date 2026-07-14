// ============================================================
// Day 8 — Teacher Tools
// Minecraft Education Edition  |  JavaScript (Scripting API)
// File: scripts/teacherTools.js
// ============================================================
// Utility scripts for the instructor. Provides:
//   /coords      — students see their own coordinates on-screen
//   /highlight   — draws a visible grid overlay for discussion
//   /reset       — rebuilds the level from scratch
//   /tpall       — teleports all students to a gather point
//   /freeze / /unfreeze — pauses all non-operator players
// ============================================================

import * as mc from "@minecraft/server";

const world = mc.world;
const OVERWORLD = world.getDimension("overworld");

// ── Operator tag: anyone with this tag can use teacher commands ──
const TEACHER_TAG = "teacher";

function isTeacher(player) {
  return player.hasTag(TEACHER_TAG) || player.isOp();
}

function onlyTeacher(player, commandName) {
  if (!isTeacher(player)) {
    player.sendMessage(`§c/${commandName} is for teachers only. Ask your instructor.`);
    return false;
  }
  return true;
}


// ════════════════════════════════════════════════════════════
// FEATURE 1 — Coordinate HUD
// Shows every player their own (X, Y, Z) and chunk in the
// action bar (the text above the hotbar) — updated each tick.
// ════════════════════════════════════════════════════════════

// Keep a set of players who have opted in to the HUD
const coordHudEnabled = new Set();

mc.system.runInterval(() => {
  for (const player of world.getPlayers()) {
    if (!coordHudEnabled.has(player.name)) continue;

    const { x, y, z } = player.location;
    const bx = Math.floor(x);
    const by = Math.floor(y);
    const bz = Math.floor(z);
    const chunkX = Math.floor(bx / 16);
    const chunkZ = Math.floor(bz / 16);

    player.onScreenDisplay.setActionBar(
      `§eBlock: (${bx}, ${by}, ${bz})  §bChunk: (${chunkX}, ${chunkZ})`
    );
  }
}, 10);  // update every 10 ticks (0.5 seconds)


// ════════════════════════════════════════════════════════════
// FEATURE 2 — Grid Overlay
// Places coloured wool blocks at chunk boundaries so students
// can see where chunks start and end while building.
// Run /highlight to toggle on/off.
// ════════════════════════════════════════════════════════════

let gridVisible = false;
const gridBlocks = [];  // track placed markers so we can remove them

function drawChunkGrid(centreX, centreZ, surfaceY, radius = 3) {
  // Radius = number of chunks to mark in each direction from centre chunk
  const startChunkX = Math.floor(centreX / 16) - radius;
  const startChunkZ = Math.floor(centreZ / 16) - radius;

  for (let cx = 0; cx <= radius * 2; cx++) {
    for (let cz = 0; cz <= radius * 2; cz++) {
      const blockX = (startChunkX + cx) * 16;
      const blockZ = (startChunkZ + cz) * 16;

      // Place a glowstone marker at the corner of each chunk
      const pos = { x: blockX, y: surfaceY + 1, z: blockZ };
      OVERWORLD.getBlock(pos)?.setType("minecraft:glowstone");
      gridBlocks.push(pos);

      // Label the chunk with a sign (placed 1 block up from glowstone)
      // Note: sign text requires a separate block entity update
    }
  }
}

function removeChunkGrid() {
  gridBlocks.forEach(pos => {
    OVERWORLD.getBlock(pos)?.setType("minecraft:air");
  });
  gridBlocks.length = 0;
}


// ════════════════════════════════════════════════════════════
// FEATURE 3 — Teleport All Students to Teacher
// ════════════════════════════════════════════════════════════

function tpAllToTeacher(teacher) {
  const { x, y, z } = teacher.location;
  let count = 0;
  for (const player of world.getPlayers()) {
    if (player.name === teacher.name) continue;
    player.teleport({ x: x + count * 2, y, z });
    count++;
  }
  teacher.sendMessage(`§a[Teacher] Teleported ${count} student(s) to you.`);
}


// ════════════════════════════════════════════════════════════
// FEATURE 4 — Freeze / Unfreeze (for class attention)
// Gives all non-teacher players the Slowness 255 effect,
// which prevents movement without kicking them.
// ════════════════════════════════════════════════════════════

function freezeAll(teacher) {
  let count = 0;
  for (const player of world.getPlayers()) {
    if (isTeacher(player)) continue;
    // Apply maximum slowness — effectively immobilises the player
    player.addEffect("slowness", 600 * 20, { amplifier: 255, showParticles: false });
    player.onScreenDisplay.setActionBar("§c⏸ Your instructor needs your attention!");
    count++;
  }
  teacher.sendMessage(`§e[Teacher] Froze ${count} student(s). Type /unfreeze when ready.`);
}

function unfreezeAll(teacher) {
  let count = 0;
  for (const player of world.getPlayers()) {
    if (isTeacher(player)) continue;
    player.removeEffect("slowness");
    player.onScreenDisplay.setActionBar("§a▶ You're free to continue building!");
    count++;
  }
  teacher.sendMessage(`§a[Teacher] Unfroze ${count} student(s).`);
}


// ════════════════════════════════════════════════════════════
// FEATURE 5 — Student Coordinate Snapshot
// When the teacher types /snapshot, it logs every student's
// current position to chat so the teacher can see who is where.
// ════════════════════════════════════════════════════════════

function snapshotStudentPositions(teacher) {
  teacher.sendMessage("§6━━━━━━━━━━━━━━━━━━━━━━━━");
  teacher.sendMessage("§e  Student Positions Snapshot");
  teacher.sendMessage("§6━━━━━━━━━━━━━━━━━━━━━━━━");

  for (const player of world.getPlayers()) {
    if (isTeacher(player)) continue;
    const { x, y, z } = player.location;
    const bx = Math.floor(x);
    const bz = Math.floor(z);
    const chunkX = Math.floor(bx / 16);
    const chunkZ = Math.floor(bz / 16);
    teacher.sendMessage(
      `§b${player.name.padEnd(16)} §7→ §eBlock(${bx},${Math.floor(y)},${bz}) §7Chunk(${chunkX},${chunkZ})`
    );
  }
  teacher.sendMessage("§6━━━━━━━━━━━━━━━━━━━━━━━━");
}


// ════════════════════════════════════════════════════════════
// CHAT COMMAND ROUTER
// ════════════════════════════════════════════════════════════

mc.world.afterEvents.chatSend.subscribe((event) => {
  const msg = event.message.trim();
  const player = event.sender;

  // ── /coords  (any player can use this one) ──
  if (msg === "/coords") {
    if (coordHudEnabled.has(player.name)) {
      coordHudEnabled.delete(player.name);
      player.sendMessage("§7Coordinate HUD turned off.");
    } else {
      coordHudEnabled.add(player.name);
      player.sendMessage("§aCoordinate HUD turned on! Your coords appear above the hotbar.");
    }
    return;
  }

  // ── Teacher-only commands ──
  if (msg === "/highlight") {
    if (!onlyTeacher(player, "highlight")) return;
    if (gridVisible) {
      removeChunkGrid();
      gridVisible = false;
      player.sendMessage("§7Chunk grid hidden.");
    } else {
      const { x, z } = player.location;
      drawChunkGrid(Math.floor(x), Math.floor(z), 64);
      gridVisible = true;
      player.sendMessage("§aChunk grid shown (glowstone at chunk corners).");
    }
    return;
  }

  if (msg === "/tpall") {
    if (!onlyTeacher(player, "tpall")) return;
    tpAllToTeacher(player);
    return;
  }

  if (msg === "/freeze") {
    if (!onlyTeacher(player, "freeze")) return;
    freezeAll(player);
    return;
  }

  if (msg === "/unfreeze") {
    if (!onlyTeacher(player, "unfreeze")) return;
    unfreezeAll(player);
    return;
  }

  if (msg === "/snapshot") {
    if (!onlyTeacher(player, "snapshot")) return;
    snapshotStudentPositions(player);
    return;
  }
});
