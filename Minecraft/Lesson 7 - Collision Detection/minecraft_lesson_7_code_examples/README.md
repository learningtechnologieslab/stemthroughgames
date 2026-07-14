# Day 7 — Collision Detection: Code Examples
### STEM Through Games | Minecraft Education Edition | Middle School

This folder contains all the code and command examples for **Day 7: When Objects Meet**.
Each file is tied directly to a part of the lesson so students and teachers can find
exactly what they need.

---

## What's in this folder

```
day7_code/
├── aabb_math.py              ← Python: AABB math explained and simulated
├── aabb_visualizer.html      ← Interactive browser tool: drag zones, see collisions live
├── README.md                 ← This file
└── commands/
    ├── 01_setup_scoreboard.mcfunction   ← Run once to prepare the world
    ├── 02_coin_zone_detect.mcfunction   ← The /testfor detection loop (Repeat block)
    ├── 03_coin_zone_collect.mcfunction  ← Chain blocks: score + remove + feedback
    ├── 04_display_score.mcfunction      ← Show score in sidebar and title
    ├── 05_multi_zone_template.mcfunction ← Full 3-coin summative activity
    └── 06_extension_danger_zone.mcfunction ← Challenge: safe vs. dangerous zones
```

---

## Quick start by role

### For students (in order during class)

| Step | What to do | File |
|------|-----------|------|
| 1 | Open the visualizer in a browser and explore AABB before touching Minecraft | `aabb_visualizer.html` |
| 2 | Set up your world's scoreboards — run once at the start | `commands/01_setup_scoreboard.mcfunction` |
| 3 | Build the first coin detector (Repeat Command Block) | `commands/02_coin_zone_detect.mcfunction` |
| 4 | Add chain blocks to score and remove the coin | `commands/03_coin_zone_collect.mcfunction` |
| 5 | Make the score visible on screen | `commands/04_display_score.mcfunction` |
| 6 | Build all three coins for the summative activity | `commands/05_multi_zone_template.mcfunction` |
| Extension | Add dangerous zones — safe vs. hazard navigation | `commands/06_extension_danger_zone.mcfunction` |

### For teachers

- All `.mcfunction` files are plain text. You can open them in any text editor (Notepad, TextEdit, VS Code).
- The `#` lines are comments — they explain every command but are ignored by Minecraft.
- The Python script does **not** require Minecraft. It runs stand-alone and is useful for:
  - Demonstrating AABB math on a projector before students open their worlds
  - Letting fast finishers explore and modify the logic
  - Students who finish early or want to go deeper into the math

---

## aabb_math.py — Python script

**Requires:** Python 3 (any version from 3.6+). No extra libraries.

**Run it:**
```bash
python aabb_math.py
```

**What it shows:**

1. **Lesson Example** — the exact Zone A / Zone B from the Day 7 slides, with a step-by-step overlap check printed for each axis.
2. **Class Exercise** — a non-overlapping pair so students can find which axis check fails.
3. **Coin Collection Simulation** — a simulated player walking east through three coin zones, with the /testfor command and scoreboard output printed for each collection.
4. **Extension: Safe vs. Dangerous Zones** — the same player path, but now some zones are safe (add to `score`) and one is dangerous (adds to `damage`).
5. **Hitbox Size Study** — compares a 1-block-exact hitbox vs. a padded 3-block hitbox and shows which player positions each detects.

**Experiment ideas for students:**
- Change `zone_b`'s `x` value in `run_lesson_example()` — at what x does the collision disappear?
- In `run_coin_collection_simulation()`, change `dx=2` to `dx=0`. What happens?
- Add a fourth coin zone. What coordinates would place it between Coin 2 and Coin 3?

---

## aabb_visualizer.html — Interactive browser tool

**Requires:** Any modern web browser (Chrome, Firefox, Edge, Safari). No internet needed.

**Open it:**
Double-click the file, or drag it into a browser window.

**What it does:**
- Two colored zones (green = Zone A, orange = Zone B) drawn on a block grid
- Live step-by-step AABB check shown for all three axes (X, Y, Z)
- The overlap region highlighted in gold when a collision is detected
- The exact Minecraft `/testfor` commands generated automatically
- Switch between top-down (X/Z) and side (X/Y) views

**Classroom use:**
Display this on a projector while teaching the AABB math section (10 minutes).
Start with the default values (collision), then ask a student to change one value
until the collision disappears. Ask: "Which axis check failed?"

---

## commands/ — Minecraft mcfunction files

These are plain-text files containing Minecraft commands.
Each command is written on its own line (one command per line is required by Minecraft).
Lines starting with `#` are comments — paste only the command lines into Command Blocks.

### How to use them in Minecraft Education Edition

**Method A — Type commands from the file into chat:**
1. Open the file in a text editor.
2. Copy one command at a time.
3. In Minecraft, press `T` to open chat, paste, press Enter.

**Method B — Command Blocks (recommended for the main activity):**
1. Give yourself a Command Block: `/give @s command_block`
2. Place it, then right-click to open the interface.
3. Copy the command from the file (just the command line, no `#` comments).
4. Paste it into the Command Input field.
5. Set the Block Type, Condition, and Redstone as noted in each file.

**Method C — mcfunction files (advanced, Minecraft Bedrock Add-On):**
If your school has Add-On support enabled, you can place these `.mcfunction` files
in a behavior pack's `functions/` folder and call them with `/function day7/filename`.

---

## Command Block settings cheat sheet

Every Command Block has three settings you must configure:

| Setting | Options | When to use each |
|---------|---------|-----------------|
| **Block Type** | Impulse / Repeat / Chain | **Impulse** = runs once when powered. **Repeat** = runs every tick. **Chain** = runs after the previous block if it succeeded. |
| **Condition** | Unconditional / Conditional | **Unconditional** = always runs (if the block type allows). **Conditional** = only runs if the previous block in the chain succeeded. |
| **Redstone** | Needs Redstone / Always Active | **Needs Redstone** = requires a redstone signal to be powered. **Always Active** = runs without any redstone. Use this for continuous detection. |

**The standard coin detection setup:**

```
[REPEAT, Unconditional, Always Active]
  /testfor @a[x=10,y=64,z=10,dx=3,dy=2,dz=3]
       ↓ (output face →)
[CHAIN, Conditional, Always Active]
  /scoreboard players add @a[...same selector...] score 1
       ↓
[CHAIN, Conditional, Always Active]
  /fill 11 64 11 11 64 11 barrier
       ↓
[CHAIN, Conditional, Always Active]
  /title @a[...same selector...] actionbar "Coin collected! +1"
```

---

## Understanding /testfor coordinates

`/testfor @a[x=10,y=64,z=10,dx=3,dy=2,dz=3]`

| Parameter | Meaning | Example |
|-----------|---------|---------|
| `x, y, z` | Corner of the detection box with the **lowest** coordinates | `x=10` → western/southern/bottom edge |
| `dx` | How many extra blocks extend **East** | `dx=3` → zone covers x=10, 11, 12, 13 (4 blocks total) |
| `dy` | How many extra blocks extend **Up** | `dy=2` → zone covers y=64, 65, 66 (3 blocks tall) |
| `dz` | How many extra blocks extend **South** | `dz=3` → zone covers z=10, 11, 12, 13 (4 blocks deep) |

> **Common mistake:** `dx=3` does NOT mean 3 blocks wide. It means the zone extends
> 3 blocks BEYOND the corner, so the total width is dx + 1 = 4. This is the same
> off-by-one that appears in the AABB formula: `A.x < B.x + B.width` (not `≤`).

---

## The AABB formula (quick reference)

Two zones A and B overlap **if and only if** all three of these are true:

```
A.x < B.x + B.dx + 1   AND   B.x < A.x + A.dx + 1   ← X (East-West)
A.y < B.y + B.dy + 1   AND   B.y < A.y + A.dy + 1   ← Y (Up-Down)
A.z < B.z + B.dz + 1   AND   B.z < A.z + A.dz + 1   ← Z (North-South)
```

When all three axes overlap → **COLLISION** → /testfor succeeds → chain blocks fire.

---

## Troubleshooting common issues

| Problem | Likely cause | Fix |
|---------|-------------|-----|
| Player walks through zone, nothing happens | Repeat block not set to Always Active | Right-click block → set Redstone to Always Active |
| Score goes up but coin doesn't disappear | /fill coordinates wrong | Press F3 while standing on the coin to get exact coordinates |
| Score increments multiple times per second | No barrier block placed after collection | Add `/fill ... barrier` as the last chain block (see file 03) |
| Chain blocks fire even when player isn't in zone | Chain blocks set to Unconditional | Change all chain blocks after the /testfor to Conditional |
| /testfor works in chat but not in Command Block | Selector copied incorrectly | Re-type the command; don't copy from a source with smart quotes (" ") |
| Nothing happens and no error message | Command Block not powered | Set to Always Active, or check that it has a redstone signal |

---

## Standards connections

| File | Math/CS concept | Standard |
|------|----------------|----------|
| `aabb_math.py` | Coordinate plane, range overlap | CCSS 6.NS.C.6, 6.G.A.3 |
| `aabb_visualizer.html` | Visual geometry, 2D/3D space | CCSS 6.G.A.3 |
| `commands/02–03` | Decompose problem into steps, named variables | CSTA 2-AP-11, 2-AP-13 |
| `commands/06` | Conditional logic, multiple outputs | CSTA 2-AP-12 |
| `aabb_math.py` `ScoreboardSimulator` | Algorithm simulation | CSTA 2-AP-10 |

---

*STEM Through Games Curriculum | Day 7 of 20 | Do not reproduce without program permission*
