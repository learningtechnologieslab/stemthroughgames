# STEM Through Games — Day 11: Enemy Behavior & Simple AI
### Minecraft Education Edition · MakeCode Examples

---

## Overview

This folder contains all MakeCode JavaScript examples for **Day 11: Enemy Behavior & Simple AI**. Each file corresponds to a stage of the lesson, building from a simple chase script up through a full multi-state enemy AI.

Students will use **Minecraft Education Edition's built-in Code Builder** (press `C` in-game) to enter and run these examples. No external tools or installs are required.

---

## Folder Structure

```
minecraft-day11/
├── README.md                        ← You are here
│
├── examples/
│   ├── 01_warmup_vector_math.js     ← Warm-up: vector math in the chat
│   ├── 02_basic_chase.js            ← Part 1: agent chases the player
│   ├── 03_state_machine.js          ← Part 2: PATROL + CHASE state machine
│   ├── 04_level2_return_wait.js     ← Challenge Level 2: RETURN + WAIT states
│   └── 05_level3_line_of_sight.js   ← Challenge Level 3: line-of-sight + FLEE
│
└── teacher/
    ├── teacher_notes.js             ← Fully-commented reference solution
    └── debug_helpers.js             ← Utilities for displaying state + distance
```

---

## How to Use These Files in Minecraft Education

### Option A — Type directly into Code Builder
1. Open Minecraft Education Edition and load your world.
2. Press **C** to open Code Builder.
3. Select **JavaScript** mode (top-right toggle).
4. Copy the contents of the example file and paste it into the editor.
5. Click **Play** (▶) to run.

### Option B — Import via URL (if your school has file sharing enabled)
1. Host the `.js` files on a shared drive or paste into a GitHub Gist.
2. In Code Builder, use **File → Import URL** and paste the link.

### Option C — MakeCode for Minecraft (browser version)
1. Go to [makecode.com/minecraft](https://minecraft.makecode.com).
2. Create a new project.
3. Click the **JavaScript** tab at the top.
4. Paste the example code in.
5. Connect to Minecraft Edu via the **Connect** button.

> **Teacher tip:** Keep a copy of `teacher/teacher_notes.js` open on your projector machine. It has full inline comments for every line — useful when students ask "why does this work?"

---

## Lesson Progression

| File | Lesson Stage | Time | Concepts |
|------|-------------|------|----------|
| `01_warmup_vector_math.js` | Warm-Up | 5–8 min | Coordinate subtraction, magnitude, normalization |
| `02_basic_chase.js` | Part 1 | 10 min | Direction vector, Math.round(), agent.teleport() |
| `03_state_machine.js` | Part 2 | 20–25 min | Constants, state transitions, distance trigger |
| `04_level2_return_wait.js` | Challenge L2 | Extension | Third state, loops.pause(), player.say() |
| `05_level3_line_of_sight.js` | Challenge L3 | Extension | Block detection, FLEE state, two enemies |

---

## Minecraft Coordinate System — Quick Reference

Minecraft uses a **3D Cartesian coordinate system**:

```
    Y (up/down — height)
    |
    |
    +---------- X (east/west)
   /
  Z (north/south)
```

- **X** — increases going East, decreases going West
- **Y** — increases going Up, decreases going Down (we ignore Y for ground movement)
- **Z** — increases going South, decreases going North

> **Key difference from 2D game engines:** Minecraft uses X and **Z** for horizontal movement, not X and Y. Always ask "Am I on the ground?" before deciding whether to include Y in your distance formula.

---

## The Vector Math Behind the AI

Every chase example uses this 4-step formula:

```
Step 1 — Difference vector:   dx = playerX - enemyX
                               dz = playerZ - enemyZ

Step 2 — Magnitude:           mag = Math.sqrt(dx*dx + dz*dz)

Step 3 — Normalize:           nx = dx / mag    (length is now exactly 1.0)
                               nz = dz / mag

Step 4 — Apply speed + round: moveX = Math.round(nx * speed)
                               moveZ = Math.round(nz * speed)
```

The `Math.round()` step is **unique to Minecraft** — because blocks are whole-number positions, we must convert the normalized float (e.g. `0.768`) to a whole number (`1`) before teleporting the agent.

---

## Common Bugs & Fixes

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| Agent doesn't move | Agent not spawned, or `mag === 0` | Add `if (mag > 1)` guard before teleporting |
| Agent oscillates back and forth | `Math.round()` alternating between 0 and 1 | Increase speed to 2, or add a minimum-distance threshold |
| Agent moves in wrong direction | X and Z swapped | Double-check `Axis.X` vs `Axis.Z` in each `getValue()` call |
| State never changes | `detectRange` too small for world scale | Increase `detectRange`; print `dist` to chat to debug |
| `player.position()` is undefined | Code running before world loads | Wrap in `player.onChat("start", ...)` to trigger manually |

---

## Extending the Examples

Once students complete the core lesson, here are natural next steps:

- **Day 12 preview:** Add a `health` variable and reduce it when the agent reaches the player — the foundation for tomorrow's lesson.
- **Multiple enemies:** Copy the state machine into a second agent (Minecraft Edu supports Agent 1 and Agent 2).
- **Sound cues:** Use `music.playSound()` to play a sound when the enemy switches to CHASE state.
- **Visual indicators:** Use `blocks.place()` to drop a colored wool block at the enemy's last position — creates a visible trail.

---

*STEM Through Games Program · Day 11 of 20 · Module 3: Enemies & AI*
*Minecraft Education Edition · MakeCode JavaScript*
