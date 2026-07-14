# STEM through Games — Day 3 Code Examples
## Structure, Hierarchy & the World (Minecraft Education)

This folder contains all the code examples for Day 3 of the STEM through
Games program. Every file maps directly to a section of the lesson plan and
is annotated with the concept it teaches.

---

## Folder Structure

```
stem-games-day3/
│
├── commands/                  Minecraft command (.mcfunction) files
│   ├── 01_setup_world         Set up the flat creative world for class
│   ├── 02_build_outer_wall    Build the root / parent structure
│   ├── 03_build_player_house  Build the first child structure
│   ├── 04_add_children        Complete the full compound hierarchy
│   ├── 05_teleport_demo       Absolute vs. relative coordinate demos
│   └── 06_math_challenges     Interactive versions of the 5 math problems
│
├── scripts/                   Minecraft Bedrock Scripting API (JavaScript)
│   └── hierarchy_demo.js      Chat commands that show hierarchy math live
│
├── math/                      Stand-alone Python tools (no Minecraft needed)
│   └── coordinate_visualizer.py   Interactive coordinate calculator
│
└── teacher-tools/
    └── answer_key.py          Answer key + randomized quiz generator
```

---

## Quick Start: Which Files Do I Need?

| If you want to...                              | Use this file                         |
|------------------------------------------------|---------------------------------------|
| Set up the classroom world before students arrive | `01_setup_world.mcfunction`        |
| Demo the lesson live, step by step             | `02` → `03` → `04` in order          |
| Show the teleport / coordinate demo            | `05_teleport_demo.mcfunction`         |
| Run the math challenge questions interactively | `06_math_challenges.mcfunction`       |
| Give students chat commands to explore the math| `scripts/hierarchy_demo.js`           |
| Run the math section without Minecraft open    | `math/coordinate_visualizer.py`       |
| Print answer keys or randomized quizzes        | `teacher-tools/answer_key.py`         |

---

## Part 1: Minecraft Command Files (`.mcfunction`)

These are plain text files. Each line is one Minecraft command. Use them
by pasting commands into the chat window, or by loading them as a function
pack (see "Loading a Function Pack" below).

### File-by-file guide

**`01_setup_world.mcfunction`** — Run this once before students arrive.
Clears a 40×40 area at spawn, lays the ground plane, gives every player
their building materials, and sets time/weather. Think of it as your
classroom setup script.

```
/function stem_day3/01_setup_world
```

**`02_build_outer_wall.mcfunction`** — Builds the stone Outer Wall (the
root / World node). Run this to demo it, or let students build by hand
first and run it to check their work. The wall has a labeled sign and
a doorway cut in the south face.

**`03_build_player_house.mcfunction`** — Builds the oak-plank Player House
inside the wall (first child node). Signs explain its position relative to
its parent. After running this, ask:

> "The wall corner is at (-10, 66, -10). The house starts at (-8, 66, -8).
> What is the local offset? How did we get from -10 to -8?"

**`04_add_children.mcfunction`** — Completes the full hierarchy by adding:
- Chest Room (child of Player House)
- NameTag Sign (already placed by step 3)
- Enemy Fortress (sibling of Player House)
- Enemy Chest (child of Enemy Fortress)

After running this, broadcast the hierarchy diagram and ask students to
match each structure they see to its place in the tree.

**`05_teleport_demo.mcfunction`** — Eight `/tp` commands for the Step 4
"Teleport & Observe" activity. Copy and paste **one command at a time**
into the chat and discuss after each one. The file has a discussion prompt
above every command. Key moments:

- Demo 1 vs Demo 3: absolute (`/tp 50 66 0`) vs relative (`/tp ~5 ~0 ~0`)
- Demo 6: teleport to the Chest Room using the math formula
- Demo 8: teleport to where the Chest Room *would be* if the house had moved

**`06_math_challenges.mcfunction`** — The five lesson plan challenge
questions made interactive. Students solve the math first, then run the
`/tp` command. If they land in the right spot, their answer was correct.
Each command has the full worked solution in the comment above it.

---

### Loading a Function Pack (optional, advanced)

To load all files as `/function` commands rather than pasting manually:

1. Create a behavior pack folder:
   ```
   com.example.stemday3/
   └── functions/
       └── stem_day3/
           ├── 01_setup_world.mcfunction
           ├── 02_build_outer_wall.mcfunction
           └── (etc.)
   ```

2. Add a `manifest.json`:
   ```json
   {
     "format_version": 2,
     "header": {
       "name": "STEM Day 3",
       "uuid": "YOUR-UUID-HERE",
       "version": [1, 0, 0]
     },
     "modules": [{ "type": "data", "uuid": "YOUR-MODULE-UUID", "version": [1, 0, 0] }]
   }
   ```

3. Copy the pack to:
   - **Windows**: `%localappdata%\Packages\Microsoft.MinecraftEducationEdition_...\LocalState\games\com.mojang\behavior_packs\`
   - **Mac/iPad**: Use the "Import" option in Minecraft Education Edition

4. Enable the pack in your world settings, then run:
   ```
   /function stem_day3/01_setup_world
   ```

---

## Part 2: Bedrock Scripting API — `scripts/hierarchy_demo.js`

This JavaScript file runs inside Minecraft Education and adds chat commands
that let students explore the hierarchy math interactively during class.

### What it does

The script models the compound as a JavaScript data structure (a list of
nodes, each with a `parent`, `local_offset`, and calculated `world_pos`).
This is intentionally close to how a real game engine like Godot stores a
scene tree.

### Chat commands (type in Minecraft chat)

| Command                    | What it does                                        |
|----------------------------|-----------------------------------------------------|
| `!hierarchy`               | Prints the full compound tree with world positions  |
| `!mypos`                   | Shows your current (X, Y, Z) world position         |
| `!offset`                  | Shows your offset from the world origin (0, 64, 0)  |
| `!math Chest Room`         | Shows the step-by-step position math for any node   |
| `!move Player House 10 0 0`| Simulates moving a structure, shows where children go|
| `!help`                    | Lists all available commands                        |

### Key concepts in the code

```javascript
// The core formula from the lesson plan, written as code:
function addVectors(posA, posB) {
  return {
    x: posA.x + posB.x,   // X: East/West
    y: posA.y + posB.y,   // Y: Up/Down
    z: posA.z + posB.z,   // Z: North/South
  };
}
// world_pos = parent_pos + local_offset
worldPositions[node.name] = addVectors(parentPos, node.local_offset);
```

This is the **same formula** students write on paper in the Math Connection
section, just expressed as a function.

### How to install the script

1. Copy `hierarchy_demo.js` into your behavior pack's `scripts/` folder
2. Add a scripts entry to `manifest.json`:
   ```json
   "modules": [{
     "type": "script",
     "language": "javascript",
     "uuid": "YOUR-UUID",
     "version": [1, 0, 0],
     "entry": "scripts/hierarchy_demo.js"
   }]
   ```
3. The `@minecraft/server` module is built in — no npm install needed

> **Note:** Scripting requires Minecraft Education Edition version 1.19.60
> or higher. If scripting is not available on your school's devices, all
> functionality is covered by the `.mcfunction` files instead.

---

## Part 3: Python Math Tools

These run on any computer with Python 3 — no Minecraft, no installation.
Useful for the math segment on a projector, homework, or a computer lab
without Minecraft.

### `math/coordinate_visualizer.py`

An interactive menu-driven tool. Students can:

1. View the full hierarchy with calculated world positions
2. See the step-by-step math for any structure
3. Work through the five challenge questions interactively
4. Simulate moving any structure (shows where all children go)
5. Enter their own parent position and offset to calculate freely

**How to run:**
```bash
python coordinate_visualizer.py
```
No extra libraries needed. Works on Windows, Mac, and Linux.

**Sample output (option 1 — hierarchy view):**
```
Outer Wall  (Root / World Container)
  World position :  (X:-10.0,  Y: 66.0,  Z:-10.0)

  └─ Player House  (Main Building)
       World position :  (X: -8.0,  Y: 66.0,  Z: -8.0)
       Local offset   :  (X:  2.0,  Y:  0.0,  Z:  2.0)  from Outer Wall

      └─ Chest Room  (Interior storage)
           World position :  (X: -7.0,  Y: 67.0,  Z: -7.0)
           Local offset   :  (X:  1.0,  Y:  1.0,  Z:  1.0)  from Player House
```

**Classroom tip:** Use option 4 (Move Simulation) on the projector to show
how a parent moving 100 blocks east causes every child to shift by the same
amount. This is the visual bridge between the `/tp` teleport demo and the
written math.

---

### `teacher-tools/answer_key.py`

Generates answer keys and student quiz sheets for the math challenges.

**Standard answer key:**
```bash
python answer_key.py
```

**Randomized variation (different numbers, same concepts):**
```bash
python answer_key.py --random
```
Useful when you want multiple versions for different class periods or to
prevent answer-sharing. Each run with a different seed produces a unique
set of coordinates.

**Student quiz sheet (no answers, 3 questions):**
```bash
python answer_key.py --quiz 3
```
Prints a clean student-facing worksheet with "show your work" space.
Combine with `--random` to generate unique versions:
```bash
python answer_key.py --random --seed 101 --quiz 5 > quiz_period1.txt
python answer_key.py --random --seed 202 --quiz 5 > quiz_period2.txt
```

---

## Concept Map: Lesson Plan → Code

| Lesson Plan Section              | Corresponding Code                          |
|----------------------------------|---------------------------------------------|
| Warm-Up: hierarchies in real life | (discussion only — no code needed)          |
| Step 1: Tour the world / F3      | `01_setup_world.mcfunction` (sets spawn)    |
| Step 2: Build the compound       | `02_`, `03_`, `04_` .mcfunction files       |
| Step 3: Hierarchy deep-dive      | `hierarchy_demo.js` → `!hierarchy` command  |
| Step 4: Teleport & observe       | `05_teleport_demo.mcfunction`               |
| Math Connection: formula         | `math/coordinate_visualizer.py` option 2   |
| Math Connection: challenge Qs    | `06_math_challenges.mcfunction` + option 3 |
| Vocabulary                       | Comments throughout all files               |
| Extensions & early finishers     | `hierarchy_demo.js` → `!move` command      |
| Exit ticket                      | `teacher-tools/answer_key.py --quiz`        |

---

## Key Vocabulary (in the code)

Every concept from the lesson's vocabulary table appears in the code:

| Term              | Where it appears in the code                            |
|-------------------|---------------------------------------------------------|
| Absolute coordinate | `/tp 50 66 0` in `05_teleport_demo`, `world_pos` in JS |
| Relative offset   | `/tp ~5 ~0 ~0` in `05_teleport_demo`, `local_offset` in JS |
| Entity            | `@s`, `@a` selectors in all `.mcfunction` files         |
| Parent structure  | `parent_name` field in `hierarchy_demo.js`             |
| Child structure   | Any node with a non-null `parent_name`                 |
| Local position    | `local_offset` in JS, offset params in Python          |

---

## Troubleshooting

**Commands aren't working in Minecraft.**
Make sure cheats are enabled for the world. In Minecraft Education: open
World Settings → toggle "Activate Cheats" to on.

**Signs have garbled text.**
The `setblock` sign commands use the raw JSON text format. If your version
doesn't support JSON signs, remove the `{Text1:...}` part — the structure
will still be built, just without the label.

**The JavaScript script doesn't load.**
Check that your `manifest.json` lists `"type": "script"` and that your
Minecraft Education version is 1.19.60+. You can verify by running
`/script debugger connect` in the chat — if it's not recognized, scripting
isn't supported on this device.

**Python visualizer shows garbled characters (colors).**
The visualizer uses ANSI color codes. On Windows, run it in Windows
Terminal or PowerShell 7+ for best results. If colors don't work, you can
remove the color constant definitions at the top of the file (set them all
to empty strings `""`).

---

## Credits

STEM through Games Program — Lesson 3 of series.
Code examples created to accompany the Day 3 lesson plan:
*Structure, Hierarchy & the World* (Minecraft Education Edition).
