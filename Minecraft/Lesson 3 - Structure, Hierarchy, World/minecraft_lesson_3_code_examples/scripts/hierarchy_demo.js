// ============================================================
// STEM through Games — Day 3: Structure, Hierarchy & the World
// FILE: scripts/hierarchy_demo.js
//
// PURPOSE:
//   A Minecraft Education / Bedrock scripting example that
//   demonstrates parent-child hierarchy concepts in code.
//
//   Uses the @minecraft/server API (Bedrock Scripting API v2).
//
// CONCEPTS COVERED:
//   - Reading entity (X, Y, Z) positions from the world
//   - Calculating local offsets (child pos relative to parent)
//   - Logging the full hierarchy with indentation
//   - Verifying the math: world_pos = parent_pos + local_offset
//
// HOW TO USE:
//   1. Place this file in your behavior pack:
//      /behavior_packs/stem_day3/scripts/hierarchy_demo.js
//   2. Ensure manifest.json lists "scripts" with this entry point
//   3. Load the world — the script runs automatically
//   4. Use the chat commands to trigger demos:
//        !hierarchy    → print the compound hierarchy
//        !mypos        → show YOUR current position
//        !offset       → calculate your offset from origin
//        !math <name>  → show math for a named structure
// ============================================================

import * as mc from "@minecraft/server";

// ─────────────────────────────────────────────────────────────
// PART 1: The Compound Hierarchy
// We define the compound as a data structure — exactly like
// a scene tree. Each node has a name, a parent, and a
// LOCAL OFFSET from its parent's origin.
// ─────────────────────────────────────────────────────────────

/**
 * The hierarchy of structures in our compound.
 * This mirrors the table from the lesson plan exactly.
 *
 * local_offset: {x, y, z} measured from the PARENT's NW corner.
 * parent: name of the parent node (null = root).
 */
const COMPOUND_HIERARCHY = [
  {
    name: "Outer Wall",
    type: "Root / World Container",
    parent: null,
    world_pos: { x: -10, y: 66, z: -10 },   // absolute world position
    local_offset: { x: 0, y: 0, z: 0 },      // root has no parent offset
  },
  {
    name: "Player House",
    type: "Main Building (oak planks)",
    parent: "Outer Wall",
    local_offset: { x: 2, y: 0, z: 2 },      // 2 blocks in from the SW corner
  },
  {
    name: "Chest Room",
    type: "Interior Storage (child of Player House)",
    parent: "Player House",
    local_offset: { x: 1, y: 1, z: 1 },
  },
  {
    name: "NameTag Sign",
    type: "Door Sign (child of Player House)",
    parent: "Player House",
    local_offset: { x: 0, y: 2, z: 0 },      // 2 blocks UP from house floor
  },
  {
    name: "Enemy Fortress",
    type: "Stone Brick Structure",
    parent: "Outer Wall",
    local_offset: { x: 12, y: 0, z: 2 },
  },
  {
    name: "Enemy Chest",
    type: "Interior Chest (child of Fortress)",
    parent: "Enemy Fortress",
    local_offset: { x: 1, y: 1, z: 1 },
  },
  {
    name: "Ground Plane",
    type: "Bedrock / Dirt Layer",
    parent: "Outer Wall",
    local_offset: { x: 0, y: -1, z: 0 },     // 1 block BELOW the wall base
  },
];

// ─────────────────────────────────────────────────────────────
// PART 2: Math Helpers
// These functions perform the position calculations from the
// lesson's Math Connection section.
// ─────────────────────────────────────────────────────────────

/**
 * Adds two (x, y, z) position vectors together.
 * This is the core operation: world_pos = parent_pos + local_offset
 *
 * @param {Object} posA - { x, y, z }
 * @param {Object} posB - { x, y, z }
 * @returns {Object} - { x, y, z }
 */
function addVectors(posA, posB) {
  return {
    x: posA.x + posB.x,
    y: posA.y + posB.y,
    z: posA.z + posB.z,
  };
}

/**
 * Subtracts posB from posA. Used to find a local offset:
 *   local_offset = child_world_pos - parent_world_pos
 *
 * @param {Object} childPos  - { x, y, z } child's world position
 * @param {Object} parentPos - { x, y, z } parent's world position
 * @returns {Object} - { x, y, z } local offset
 */
function getLocalOffset(childPos, parentPos) {
  return {
    x: childPos.x - parentPos.x,
    y: childPos.y - parentPos.y,
    z: childPos.z - parentPos.z,
  };
}

/**
 * Formats a position object as a readable string.
 * Example: { x: -7, y: 67, z: -7 } → "(X:-7, Y:67, Z:-7)"
 */
function posToString(pos) {
  return `(X:${pos.x}, Y:${pos.y}, Z:${pos.z})`;
}

// ─────────────────────────────────────────────────────────────
// PART 3: Calculate World Positions for All Nodes
// Walk the tree and compute absolute world coordinates by
// chaining parent + local_offset at every level.
// This is the "chained vector addition" from the extension.
// ─────────────────────────────────────────────────────────────

/**
 * Builds a lookup map: node name → world position.
 * Walks the hierarchy and computes world_pos for every node
 * using: world_pos = parent_world_pos + local_offset
 */
function buildWorldPositions(hierarchy) {
  const worldPositions = {};

  // First pass: add root node
  const root = hierarchy.find(node => node.parent === null);
  worldPositions[root.name] = root.world_pos;

  // Second pass: resolve children (repeat until all are resolved)
  let unresolved = hierarchy.filter(node => node.parent !== null);
  let maxPasses = hierarchy.length; // safety limit

  while (unresolved.length > 0 && maxPasses-- > 0) {
    const stillUnresolved = [];

    for (const node of unresolved) {
      const parentPos = worldPositions[node.parent];
      if (parentPos !== undefined) {
        // Parent is known — calculate this node's world position
        worldPositions[node.name] = addVectors(parentPos, node.local_offset);
      } else {
        // Parent not resolved yet — try again next pass
        stillUnresolved.push(node);
      }
    }

    unresolved = stillUnresolved;
  }

  return worldPositions;
}

// ─────────────────────────────────────────────────────────────
// PART 4: Print the Hierarchy Tree
// ─────────────────────────────────────────────────────────────

/**
 * Prints the full hierarchy as an indented tree,
 * showing each node's world position and local offset.
 */
function printHierarchy(player) {
  const worldPositions = buildWorldPositions(COMPOUND_HIERARCHY);

  player.sendMessage("=== COMPOUND HIERARCHY ===");
  player.sendMessage("");

  // Find and print each level
  function printNode(name, indent) {
    const node = COMPOUND_HIERARCHY.find(n => n.name === name);
    if (!node) return;

    const prefix = "  ".repeat(indent) + (indent > 0 ? "└─ " : "");
    const worldPos = worldPositions[name];

    player.sendMessage(`${prefix}${name}`);
    player.sendMessage(`${"  ".repeat(indent + 1)}Type: ${node.type}`);
    player.sendMessage(`${"  ".repeat(indent + 1)}World: ${posToString(worldPos)}`);

    if (node.parent !== null) {
      player.sendMessage(
        `${"  ".repeat(indent + 1)}Local offset from ${node.parent}: ${posToString(node.local_offset)}`
      );
    }
    player.sendMessage("");

    // Recursively print children
    const children = COMPOUND_HIERARCHY.filter(n => n.parent === name);
    for (const child of children) {
      printNode(child.name, indent + 1);
    }
  }

  // Start from the root
  const root = COMPOUND_HIERARCHY.find(n => n.parent === null);
  printNode(root.name, 0);
}

// ─────────────────────────────────────────────────────────────
// PART 5: "What If" Simulation — Moving the Parent
// This is the math challenge: if a parent moves, where do
// all its children end up?
// ─────────────────────────────────────────────────────────────

/**
 * Simulates moving a parent structure and recalculates
 * where all its children (and their children) end up.
 *
 * @param {string} parentName  - name of the structure to move
 * @param {Object} movement    - { x, y, z } how far to move it
 * @param {Object} player      - Minecraft player to send messages to
 */
function simulateMove(parentName, movement, player) {
  const worldPositions = buildWorldPositions(COMPOUND_HIERARCHY);
  const oldParentPos = worldPositions[parentName];

  if (!oldParentPos) {
    player.sendMessage(`Unknown structure: ${parentName}`);
    return;
  }

  const newParentPos = addVectors(oldParentPos, movement);

  player.sendMessage(`=== MOVE SIMULATION ===`);
  player.sendMessage(`Moving "${parentName}" by ${posToString(movement)}`);
  player.sendMessage(`Old position: ${posToString(oldParentPos)}`);
  player.sendMessage(`New position: ${posToString(newParentPos)}`);
  player.sendMessage("");
  player.sendMessage("Affected children (new world positions):");

  // Find all descendants and update their world positions
  function getDescendants(name) {
    const children = COMPOUND_HIERARCHY.filter(n => n.parent === name);
    let all = [...children];
    for (const child of children) {
      all = all.concat(getDescendants(child.name));
    }
    return all;
  }

  const affected = getDescendants(parentName);

  for (const node of affected) {
    const oldPos = worldPositions[node.name];
    // The child shifts by the same amount as the parent
    const newPos = addVectors(oldPos, movement);
    player.sendMessage(
      `  ${node.name}: ${posToString(oldPos)} → ${posToString(newPos)}`
    );
  }

  if (affected.length === 0) {
    player.sendMessage("  (no children)");
  }
}

// ─────────────────────────────────────────────────────────────
// PART 6: Chat Command Handler
// Students type these commands in the Minecraft chat window.
// ─────────────────────────────────────────────────────────────

mc.world.beforeEvents.chatSend.subscribe((event) => {
  const message = event.message.trim();
  const player = event.sender;

  // Only handle commands starting with !
  if (!message.startsWith("!")) return;

  // Cancel the default chat broadcast so it's cleaner
  event.cancel = true;

  const parts = message.slice(1).split(" ");
  const command = parts[0].toLowerCase();
  const args = parts.slice(1);

  switch (command) {

    // !hierarchy — print the full compound tree
    case "hierarchy": {
      printHierarchy(player);
      break;
    }

    // !mypos — show the player's current world position
    case "mypos": {
      const pos = player.location;
      player.sendMessage("=== YOUR POSITION ===");
      player.sendMessage(`World: (X:${Math.floor(pos.x)}, Y:${Math.floor(pos.y)}, Z:${Math.floor(pos.z)})`);
      player.sendMessage("Tip: This is an ABSOLUTE coordinate — measured from (0, 0, 0).");
      break;
    }

    // !offset — calculate your offset from the world origin
    case "offset": {
      const pos = player.location;
      const origin = { x: 0, y: 64, z: 0 };
      const offset = getLocalOffset(
        { x: Math.floor(pos.x), y: Math.floor(pos.y), z: Math.floor(pos.z) },
        origin
      );
      player.sendMessage("=== YOUR LOCAL OFFSET FROM ORIGIN ===");
      player.sendMessage(`Origin: ${posToString(origin)}`);
      player.sendMessage(`Your position: (X:${Math.floor(pos.x)}, Y:${Math.floor(pos.y)}, Z:${Math.floor(pos.z)})`);
      player.sendMessage(`Local offset: ${posToString(offset)}`);
      player.sendMessage("Formula: offset = your_pos - origin");
      break;
    }

    // !math <structure_name> — show math for a named structure
    case "math": {
      const structName = args.join(" ");
      const node = COMPOUND_HIERARCHY.find(
        n => n.name.toLowerCase() === structName.toLowerCase()
      );

      if (!node) {
        player.sendMessage(`Unknown structure: "${structName}"`);
        player.sendMessage("Try: Outer Wall, Player House, Chest Room, NameTag Sign, Enemy Fortress, Enemy Chest, Ground Plane");
        break;
      }

      const worldPositions = buildWorldPositions(COMPOUND_HIERARCHY);
      const worldPos = worldPositions[node.name];

      player.sendMessage(`=== MATH: ${node.name} ===`);

      if (node.parent === null) {
        player.sendMessage("This is the ROOT — it has no parent.");
        player.sendMessage(`World position: ${posToString(worldPos)}`);
      } else {
        const parentPos = worldPositions[node.parent];
        player.sendMessage(`Parent: ${node.parent}`);
        player.sendMessage(`Parent world pos: ${posToString(parentPos)}`);
        player.sendMessage(`Local offset:     ${posToString(node.local_offset)}`);
        player.sendMessage("Formula: world = parent_pos + local_offset");
        player.sendMessage(
          `= (${parentPos.x}+${node.local_offset.x}, ${parentPos.y}+${node.local_offset.y}, ${parentPos.z}+${node.local_offset.z})`
        );
        player.sendMessage(`= ${posToString(worldPos)}`);
      }
      break;
    }

    // !move <structure> <dx> <dy> <dz> — simulate moving a structure
    case "move": {
      if (args.length < 4) {
        player.sendMessage("Usage: !move <structure_name> <dx> <dy> <dz>");
        player.sendMessage("Example: !move 'Player House' 10 0 0");
        break;
      }
      // Last 3 args are the movement, everything before is the name
      const dz = parseInt(args[args.length - 1]);
      const dy = parseInt(args[args.length - 2]);
      const dx = parseInt(args[args.length - 3]);
      const name = args.slice(0, args.length - 3).join(" ");
      simulateMove(name, { x: dx, y: dy, z: dz }, player);
      break;
    }

    // !help — list available commands
    case "help": {
      player.sendMessage("=== STEM Day 3 Commands ===");
      player.sendMessage("!hierarchy           — show the full compound tree");
      player.sendMessage("!mypos               — show your current world position");
      player.sendMessage("!offset              — show your offset from the origin");
      player.sendMessage("!math <name>         — show position math for a structure");
      player.sendMessage("!move <name> dx dy dz — simulate moving a structure");
      player.sendMessage("!help                — show this message");
      break;
    }

    default: {
      player.sendMessage(`Unknown command: !${command}. Type !help for a list.`);
    }
  }
});

// ─────────────────────────────────────────────────────────────
// PART 7: Auto-greeting when a player joins
// ─────────────────────────────────────────────────────────────
mc.world.events.playerSpawn.subscribe((event) => {
  if (event.initialSpawn) {
    const player = event.player;
    // Small delay so the player is fully loaded
    mc.system.runTimeout(() => {
      player.sendMessage("Welcome to STEM Day 3: Structure, Hierarchy & the World!");
      player.sendMessage("Type !help in chat to see available commands.");
      player.sendMessage("Type !hierarchy to see the compound tree.");
    }, 40); // 40 ticks = 2 seconds
  }
});
