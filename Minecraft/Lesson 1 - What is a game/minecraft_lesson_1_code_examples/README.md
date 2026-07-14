# STEM Through Games — Day 2 Code Examples
## Spatial Thinking & 3D Coordinates (Minecraft Edition)

This folder contains six sets of code examples that accompany the Day 2
lesson plan. They are organized by activity, from simplest to most
advanced, and map directly to the lesson's three main activities.

---

## Requirements

| Tool | Used By | How to Get |
|---|---|---|
| Minecraft Education Edition | All `.txt` examples | School licence or [education.minecraft.net](https://education.minecraft.net) |
| Python 3.8+ | Examples 4 & 6 | [python.org/downloads](https://python.org/downloads) — free |
| Any text editor | All files | Notepad, TextEdit, VS Code, etc. |

No special libraries are needed — the Python scripts use only the
standard library (`math`, `sys`).

---

## Folder Structure

```
examples/
│
├── 01_basic_teleport/
│   └── teleport_commands.txt       ← Absolute /tp commands, Parts A–C
│
├── 02_relative_coords/
│   └── relative_teleport.txt       ← Tilde ~ notation, Parts A–D
│
├── 03_setblock/
│   └── setblock_commands.txt       ← Place blocks by coordinate, Parts A–D
│
├── 04_distance_calculator/
│   └── distance_calculator.py      ← Python: 3D distance formula
│
├── 05_scavenger_hunt/
│   ├── scavenger_hunt.txt          ← Student hunt sheet (6 stops + extension)
│   └── teacher_setup.txt          ← Teacher: place markers before class
│
└── 06_coordinate_converter/
    └── coordinate_converter.py     ← Python: graph paper ↔ Minecraft converter
```

---

## Example 1 — Basic Teleport Commands
**File:** `01_basic_teleport/teleport_commands.txt`
**Lesson section:** Main Activity, Part 2 (10 min)
**Difficulty:** ⭐ Beginner

### What it covers
Absolute `/tp` commands — teleporting to a specific X Y Z location in the
world. Students see that typing coordinates in chat is a form of programming.

### How to use in class
1. Open the starter world in Minecraft Education Edition.
2. Press **T** to open chat.
3. Type commands from **Part A** one at a time, pressing Enter after each.
4. After each teleport, press **F3** and confirm the coordinates on screen.
5. Students record observations in the notebook column (Part C).

### Key commands
```
/tp @s 0 64 0       ← World origin (X=0, Y=64, Z=0)
/tp @s 100 64 0     ← 100 blocks East
/tp @s 0 20 0       ← Underground (Y drops below sea level 64)
/tp @s 0 255 0      ← Sky limit
/tp @s -100 64 -100 ← West AND North (both negative)
```

### Classroom tip
Ask students to predict which direction they'll move *before* pressing Enter.
This turns passive command-running into active hypothesis testing.

---

## Example 2 — Relative Coordinates (Tilde Notation)
**File:** `02_relative_coords/relative_teleport.txt`
**Lesson section:** Main Activity, Part 3 (enrichment)
**Difficulty:** ⭐⭐ Intermediate

### What it covers
The `~` (tilde) symbol means "from where I am right now." This introduces
relative vs. absolute positioning — a concept that appears in every game
engine and programming language students will encounter later.

### How to use in class
1. Stand anywhere interesting in the world (not at origin).
2. Work through **Part A** — one axis at a time.
3. Watch the F3 screen after each command to see which number changed.
4. **Part C** has three fill-in challenges; teacher answers are in Part D.

### Key commands
```
/tp @s ~10 ~ ~      ← Move 10 blocks East from current position
/tp @s ~ ~10 ~      ← Move 10 blocks UP from current position
/tp @s ~ ~ ~10      ← Move 10 blocks South from current position
/tp @s ~-10 ~ ~     ← Move 10 blocks West (negative = opposite direction)
/tp @s ~5 ~ ~5      ← Move diagonally: 5 East AND 5 South
```

### Discussion question
> "If `/tp @s 0 64 0` always goes to the same place, when would you
> prefer to use `~` instead? When would you prefer absolute numbers?"

---

## Example 3 — Placing Blocks with /setblock
**File:** `03_setblock/setblock_commands.txt`
**Lesson section:** Main Activity, Part 2 + Enrichment
**Difficulty:** ⭐⭐ Intermediate

### What it covers
`/setblock` places a single block at an exact coordinate without the
player needing to be there. This directly extends the coordinate placement
concept from `/tp` into *building* — the core Minecraft mechanic.

**Part B** is especially powerful: it takes the five points students
plotted on graph paper in the warm-up and converts them into
`/setblock` commands, so the abstract graph comes to life in 3D.

### How to use in class
1. Start with **Part A** to establish the command format.
2. Move to **Part B** after the warm-up: have students read the graph
   coordinates they plotted and predict what the `/setblock` commands will be.
3. Run the commands together and walk to each coloured wool block.
4. **Part C** builds a row of blocks along the X axis — a visual proof
   that "only X changes" when moving East.
5. **Part D** (extension) builds a complete 5×5 square outline.

### Key commands
```
/setblock 0 64 0 glowstone          ← Place glowstone at world origin
/setblock 2 64 3 lime_wool          ← Warm-up Point A(2,3) → Minecraft (2,64,3)
/setblock 0 64 0 air                ← Delete a block (replace with air)
```

### Math connection
Point A on graph paper is `(2, 3)`. In Minecraft, that becomes
`/setblock 2 64 3`. The graph's Y value maps to Minecraft's Z axis
(both go "North/South" or "up/down" on a flat plane). See Example 6
for an interactive converter.

---

## Example 4 — Distance Calculator (Python)
**File:** `04_distance_calculator/distance_calculator.py`
**Lesson section:** Math Connection / Enrichment
**Difficulty:** ⭐⭐⭐ Advanced (requires Python)

### What it covers
Implements the 3D distance formula in Python and walks students through
every step — differences, squaring, adding, and the square root — with
the actual numbers filled in. Connects the formula from class to a
real calculation tool.

```
d = √( (x2−x1)² + (y2−y1)² + (z2−z1)² )
```

### How to run

**Interactive mode** (students enter two locations):
```bash
python distance_calculator.py
```

**Preset mode** (five lesson-plan examples, good for projection):
```bash
python distance_calculator.py --presets
```

**Quick single calculation** (pass 6 numbers directly):
```bash
python distance_calculator.py 0 64 0 100 64 200
```

### Sample output
```
=======================================================
  From: World Origin  (0, 64, 0)
  To:   Village B     (100, 64, 200)
-------------------------------------------------------
  Step 1 — Differences:
    ΔX = 100 - 0 = 100
    ΔY = 64 - 64 = 0
    ΔZ = 200 - 0 = 200

  Step 2 — Square each difference:
    ΔX² = 100² = 10000
    ΔY² = 0²   = 0
    ΔZ² = 200² = 40000

  Step 3 — Add and take the square root:
    √(10000 + 0 + 40000) = √50000

  ✅ Straight-line distance:  223.61 blocks
  🗺  Horizontal distance:    223.61 blocks  (ignoring elevation)
=======================================================
```

### Classroom tip
Before running the script, have students work out one calculation by hand
on graph paper. Then run `--presets` to check their work. The step-by-step
output mirrors the math notebook layout exactly.

---

## Example 5 — Coordinate Scavenger Hunt
**Files:** `05_scavenger_hunt/scavenger_hunt.txt` (students)
           `05_scavenger_hunt/teacher_setup.txt` (teacher, run before class)
**Lesson section:** Guided Practice / Bonus
**Difficulty:** ⭐⭐ Intermediate

### What it covers
Six teleport stops, each with written reflection questions, covering all
four quadrants of the coordinate plane, underground navigation, the sky
limit, and the extension builds a square using coordinates.

### Teacher setup (before students arrive)
Run the commands in `teacher_setup.txt` in Creative Mode to place
coloured markers at each stop. Students see a wool block or glowing
block when they arrive, confirming they typed the right coordinates.

```bash
# In Minecraft chat (Creative Mode, cheats on):
/setblock 0 64 0 glowstone
/setblock 100 64 0 gold_block
# ... (see teacher_setup.txt for all commands)
```

### Student flow
1. Start at spawn — record starting X, Y, Z in notebook.
2. Run Stop 1 command → answer questions → run Stop 2 → etc.
3. After Stop 6, attempt the extension square-building challenge.

### Stop summary
| Stop | Coordinates | Concept Tested |
|---|---|---|
| 1 | (0, 64, 0) | World origin, comparing to graph paper |
| 2 | (100, 64, 0) | Positive X = East |
| 3 | (0, 20, 0) | Y = elevation, below sea level |
| 4 | (0, 255, 0) | Sky limit, Y range |
| 5 | (50, 64, −50) | Negative Z = North |
| 6 | (75, 64, 75) | Diagonal movement, distance formula |

---

## Example 6 — Coordinate Converter (Python)
**File:** `06_coordinate_converter/coordinate_converter.py`
**Lesson section:** Math Connection
**Difficulty:** ⭐⭐⭐ Advanced (requires Python)

### What it covers
Converts between 2D math graph paper coordinates and Minecraft world
coordinates, exposing the key mapping:

```
Graph (x, y)  →  Minecraft (X=x,  Y=64,  Z=y)
```

The math Y axis and Minecraft Z axis both describe "horizontal depth"
on a flat surface, making this a natural bridge to discussion about
why different systems choose different conventions.

### How to run

**Interactive mode** (three sub-modes with a menu):
```bash
python coordinate_converter.py
```

**Batch mode** (all five warm-up points at once — great for projecting):
```bash
python coordinate_converter.py --batch
```

**Single point** (pass a graph paper coordinate directly):
```bash
python coordinate_converter.py --single 2 3
```

### Sample output (`--batch`)
```
Point    Graph (x,y)    Minecraft (X,Y,Z)    Command
-------- -------------- -------------------- ---------------------
A        (2, 3)         (2, 64, 3)           /setblock 2 64 3 lime_wool
B        (-1, 4)        (-1, 64, 4)          /setblock -1 64 4 cyan_wool
C        (-3, -2)       (-3, 64, -2)         /setblock -3 64 -2 yellow_wool
D        (4, -1)        (4, 64, -1)          /setblock 4 64 -1 orange_wool
E        (0, 0)         (0, 64, 0)           /setblock 0 64 0 white_wool
```

Students can copy these `/setblock` commands directly into Minecraft and
walk to each coloured wool block to find the shape they drew on paper.

---

## Suggested Classroom Flow

```
Warm-Up (10 min)
  └─ Students draw shape on graph paper
  └─ Example 6 --batch: project the coordinate conversion on screen

Main Activity Part 1 — Editor Orientation (8 min)
  └─ Teacher demo: F3 screen, axes (no example file needed)

Main Activity Part 2 — Teleport (10 min)
  └─ Example 1: absolute /tp commands
  └─ Example 3 Part A–B: setblock warm-up shape

Main Activity Part 3 — Code (7 min)
  └─ Example 2: relative ~ coordinates

Guided Practice / Fast Finishers
  └─ Example 5: scavenger hunt
  └─ Example 4: distance calculator (Python, projected or individual)

Enrichment (homework or extended session)
  └─ Example 3 Part D: square outline build
  └─ Example 6 interactive: students enter their own points
```

---

## Common Student Questions

**"Why does /tp use X Y Z but on graph paper it's just x and y?"**
Graph paper is 2D — you only need two numbers to describe a position on a
flat surface. Minecraft is 3D, so you need a third number (Z) for
North/South depth. The `/tp` command always needs all three.

**"Which way is positive Z again?"**
Positive Z goes South. A useful memory trick: imagine holding a compass.
North is negative Z (away from you on a south-facing map), South is positive Z.
The F3 screen shows "Facing: south" when you're walking toward positive Z.

**"Why is sea level Y=64 and not Y=0?"**
Y=0 is bedrock (the very bottom of the world). The world has 64 layers
of underground before you reach the surface. Y=64 is just where the
ground usually is — like "floor 64" of a building where ground = floor 1.

**"The distance calculator gave a decimal. Can there be half-blocks?"**
In Minecraft, blocks are always whole-number sized, but your *position*
can be a decimal (you stand somewhere inside a block). The distance
formula gives an exact mathematical distance, which is often not a
whole number — just like a diagonal on graph paper isn't a whole number.

---

## Credits
Created for STEM Through Games, Day 2 — Spatial Thinking & 3D Coordinates.
Requires Minecraft Education Edition and/or Python 3.8+.
