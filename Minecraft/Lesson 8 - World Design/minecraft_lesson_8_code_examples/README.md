# Day 8 — Chunk Coordinates & World Design
## Code Examples for Minecraft Education Edition

**STEM Through Games Program · Middle School (6–8) · 60–90 min**

This folder contains all the code examples for Day 8 of the STEM Through Games
program. Every file maps directly to a section of the lesson plan so you can
pick up whichever piece you need.

---

## 📁 Folder Structure

```
day8-minecraft-examples/
│
├── README.md                       ← you are here
├── manifest.json                   ← behaviour pack config
│
├── commands/
│   └── day8_commands.mcfunction    ← all /slash commands, annotated
│
├── scripts/
│   ├── levelBuilder.js             ← auto-builds the starter level
│   ├── coordinateMath.js           ← coordinate & distance math + /mathcheck
│   ├── designChecker.js            ← /checkdesign: rates your level design
│   └── teacherTools.js             ← /coords, /freeze, /tpall, /snapshot
│
└── math-tools/
    └── worksheetSolver.js          ← Node.js script: works through every
                                       math problem from the lesson
```

---

## 🗺️ Which File Goes with Which Part of the Lesson?

| Lesson Section | File(s) to Use |
|---|---|
| Direct Instruction — Chunks & Coordinates | `commands/day8_commands.mcfunction` §1–2 |
| Main Activity Step 1–4 | `commands/day8_commands.mcfunction` §3–6, or `scripts/levelBuilder.js` |
| Math Connection — Distance Formula | `math-tools/worksheetSolver.js`, `scripts/coordinateMath.js` |
| Game Design Principles | `scripts/designChecker.js` |
| Teacher classroom management | `scripts/teacherTools.js` |
| Extension (command blocks) | `commands/day8_commands.mcfunction` §8 |

---

## ⚡ Quickstart: Just Type Commands

The fastest way to use these examples is to copy commands from
`commands/day8_commands.mcfunction` directly into the Minecraft chat bar.

1. Open Minecraft Education and load your world.
2. Press **T** to open the chat bar.
3. Paste any `/command` line from `day8_commands.mcfunction`.

No setup needed. Great for live demos during Direct Instruction.

**Commands covered in that file:**
- `/tp` — teleport to coordinates
- `/setworldspawn` — set the player's spawn point
- `/fill` — place a rectangular region of blocks *(the main one!)*
- `/setblock` — place a single block
- `/gamemode` — switch between creative, adventure, and survival
- `/fill ... barrier` — invisible boundary walls
- Chunk math reference comments

---

## 🔧 Quickstart: Run the Math Worksheet (No Minecraft Needed)

The file `math-tools/worksheetSolver.js` runs in Node.js and works through
every math problem from the lesson. Students can open it on any computer —
no Minecraft required.

**Requirements:** [Node.js](https://nodejs.org) 18 or later.

```bash
# From the day8-minecraft-examples folder:
node math-tools/worksheetSolver.js
```

You'll see step-by-step working for:
- The lesson example (spawn → goal distance)
- All four extension questions
- The homework chunk-count problem

**To try your own numbers**, open the file and edit the section at the bottom
labelled `INTERACTIVE SECTION — edit these numbers!`.

---

## 🎮 Full Setup: Behaviour Pack (Scripts in Minecraft)

The `scripts/` folder contains the full scripting API examples. Installing
them as a behaviour pack makes them run live inside your Minecraft world.

### Step 1 — Copy the pack into Minecraft Education

**Windows:**
```
%APPDATA%\Minecraft Education Edition\games\com.mojang\development_behavior_packs\
```

**macOS:**
```
~/Library/Application Support/minecraftpe/games/com.mojang/development_behavior_packs/
```

**iPad:** Use the Files app to navigate to the `minecraftpe` folder via the
Minecraft Education app, then drop the pack folder there.

Copy the entire `day8-minecraft-examples/` folder into `development_behavior_packs/`.

### Step 2 — Activate the pack in your world

1. Open Minecraft Education.
2. Edit the world settings → **Behaviour Packs** → find "Day 8 — Chunk Coordinates & World Design" → **Activate**.
3. Make sure **Enable Cheats** is turned on (required for `/fill`, `/tp`, etc.).

### Step 3 — Enter the world

The `levelBuilder.js` script runs automatically when the world loads and
builds the starter level. Watch the chat for messages like:

```
[Day8] Ground layer ready.
[Day8] Platforms built.
[Day8] Level build complete! ✓
```

---

## 📋 Script Reference

### `scripts/levelBuilder.js` — Auto-builds the starter level

Runs on world load. Builds the full sample level from the lesson in four
functions that mirror the lesson's four-step main activity.

| Function | What it does | Lesson Step |
|---|---|---|
| `prepareGroundLayer()` | Clears area, lays grass base | Step 1 |
| `buildPlatforms()` | Builds 3 platforms with elevation changes | Step 2 |
| `addHazardsAndBoundaries()` | Lava pit, void gap, barrier walls | Step 3 |
| `placeSpawnAndCollectibles()` | Spawn point, 5 gold collectibles, beacon goal | Step 4 |

**Key concept shown:** The `sketchToWorld(col, row)` helper converts your
graph-paper sketch coordinates to real block coordinates — exactly the math
from the lesson's Math Connection slide.

**To customise the level:** Edit the `CONFIG` object at the top of the file:

```javascript
const CONFIG = {
  CELL_SIZE: 4,    // ← change this to scale the entire level up or down
  GROUND_Y: 63,    // ← change this if your world has a different surface
  ORIGIN_X: 0,     // ← change this to shift the level east or west
  ORIGIN_Z: 0,     // ← change this to shift the level north or south
};
```

Changing `CELL_SIZE` from `4` to `2` is a great live demo of the exit-ticket
reflection question: *"What happens to your level if the cell size changes?"*

---

### `scripts/coordinateMath.js` — Live math tools + `/mathcheck`

Contains all the coordinate math functions with full worked examples. Also
registers a chat command students can use to check their own calculations.

**`/mathcheck` usage (type in Minecraft chat):**

```
/mathcheck dist X1 Z1 X2 Z2   → distance between two blocks
/mathcheck cell col row        → sketch cell → world coordinates
/mathcheck chunk blockX blockZ → which chunk is this block in?
```

**Examples:**
```
/mathcheck dist 0 0 48 32      → 80 blocks  (lesson example)
/mathcheck cell 7 3            → X=28, Z=12  (extension Q1)
/mathcheck chunk 48 32         → chunkX=3, chunkZ=2
```

**Functions exported for use in other scripts:**

| Function | What it does |
|---|---|
| `sketchCellToBlockCoord(col, row, cellSize)` | Sketch → block coordinate |
| `blockDistance(pointA, pointB)` | Manhattan distance |
| `blockToChunk(blockX, blockZ)` | Block → chunk number |
| `chunkToBlockOrigin(chunkX, chunkZ)` | Chunk → first block in that chunk |
| `chunksAcross(blockWidth)` | How many chunks fit in a width |
| `compareScales(points, oldSize, newSize)` | Show effect of changing cell size |

---

### `scripts/designChecker.js` — `/checkdesign`

After students finish building, they type `/checkdesign` and receive a
report scoring their level against all four design principles from the lesson.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Day 8 — Level Design Checker
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓  1. Clear Signposting
     5 collectibles found, largest gap = 12 blocks. Good signposting!
✗  2. Gradual Challenge
     Hazard at X=6 — that's in the first 20% of the level. Move it further.
✓  3. Fair but Difficult
     All hazards have at least 4 blocks of visible approach. Fair design!
✓  4. Pacing & Breathing Room
     Rest zone found after a hazard. Good pacing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Score: 3/4 principles met
  Good start — fix the ✗ items above.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**To point the checker at a different level footprint**, edit the
`levelBounds` object inside the `/checkdesign` handler at the bottom of
`designChecker.js`:

```javascript
const levelBounds = {
  startX:   0,   // ← X where your level begins
  endX:    80,   // ← X where your level ends
  surfaceY: 64,  // ← surface Y (64 for flat worlds)
  z:         6,  // ← Z to scan along (middle of your platform)
};
```

---

### `scripts/teacherTools.js` — Classroom management commands

These are for the **instructor only**. Assign yourself the `teacher` tag once:

```
/tag @s add teacher
```

| Command | Who can use | What it does |
|---|---|---|
| `/coords` | Everyone | Toggles a coordinate HUD above the hotbar (updates 2×/sec) |
| `/highlight` | Teacher | Places glowstone markers at chunk corners near you |
| `/tpall` | Teacher | Teleports all students to your position for a group discussion |
| `/freeze` | Teacher | Gives all students Slowness 255 — pauses movement for attention |
| `/unfreeze` | Teacher | Removes slowness and lets students continue |
| `/snapshot` | Teacher | Prints every student's current block position and chunk to chat |

**Tip for Direct Instruction:** Use `/coords` + `/highlight` at the same time.
Students can see their own coordinates scrolling, and the glowstone grid makes
chunk boundaries physically visible in the world.

---

## 📐 Core Math Reference

All the formulas from the lesson, in one place.

### Sketch → World Coordinates
```
world_X = origin_X + col × cell_size
world_Z = origin_Z + row × cell_size
```

### Manhattan Distance (block distance)
```
distance = |X₂ − X₁| + |Z₂ − Z₁|
```

### Block → Chunk
```
chunk_X = floor(block_X / 16)
chunk_Z = floor(block_Z / 16)
```

### Chunk → First Block in That Chunk
```
block_X = chunk_X × 16
block_Z = chunk_Z × 16
```

### Chunks Across a Width
```
chunks = ceil(block_width / 16)
```

### Lesson Answer Key

| Problem | Answer |
|---|---|
| Distance: spawn (0,0,0) → goal (48,64,32) | **80 blocks** |
| Sketch (col=7, row=3), cellSize=4 → world coords | **X=28, Z=12** |
| Spawn at X=−16, distance from origin | **16 blocks** |
| 20-cell level × 4 blocks/cell = ? blocks wide | **80 blocks** |
| 80-block level ÷ 16 blocks/chunk = ? chunks | **5 chunks** |
| 128×128 world ÷ 16 = ? chunks per side; total? | **8 per side, 64 total** |

---

## 🌱⭐🚀 Differentiation

| Tier | Recommended files |
|---|---|
| **Support** | `commands/day8_commands.mcfunction` §1–4 only. Use pre-built commands, skip scripting. |
| **Core** | All commands file + `math-tools/worksheetSolver.js` |
| **Extension** | Full behaviour pack, edit `CONFIG.CELL_SIZE` in `levelBuilder.js`, run `/checkdesign`, add command blocks from §8 |

---

## 🔭 Day 9 Preview

The `levelBuilder.js` script lays the foundation for Day 9 (Redstone Logic &
Automated Systems). The goal zone is already wired for a command block trigger
— students will connect a pressure plate at the beacon to a command block that
fires a `/title` message and plays a level-complete sound.

---

## 🛟 Troubleshooting

**Scripts don't run / chat commands not recognised**
→ Check `manifest.json` lists the correct entry file. Enable cheats in world
settings. Confirm `@minecraft/server` version matches your Minecraft Education
version (1.20+).

**`/fill` command says "too many blocks"**
→ The default limit is 32,768 blocks per `/fill`. Split large fills into
smaller sections or use the `levelBuilder.js` script which handles this
automatically.

**`/checkdesign` always fails Gradual Challenge**
→ Edit the `levelBounds.startX` and `levelBounds.endX` values in
`designChecker.js` to match your level's actual footprint.

**Worksheet solver gives wrong answers**
→ Make sure you're running Node.js 18+: `node --version`. The file uses
`Math.floor` and `Math.abs` — standard JavaScript, no external libraries
needed.
