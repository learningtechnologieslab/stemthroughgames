# STEM Through Games — Day 5: Moving the Player
## Code Examples for Minecraft Education Edition

**Subject:** Speed, Vectors & the Pythagorean Theorem  
**Platform:** Minecraft Education Edition + MakeCode JavaScript  
**Grade Level:** Middle School (Grades 6–8)  
**Duration:** 60 minutes

---

## What's in this folder

```
minecraft-day5/
├── README.md                              ← You are here
│
├── 01_warmup/
│   └── coordinate_practice.js            ← Warm-up: 1D & 2D coordinate math
│
├── 02_basic_movement/
│   └── movement_basic.js                 ← Core lesson: Agent movement with vectors
│
├── 03_exploration/
│   └── exploration_challenges.js         ← Guided challenges: speed, diagonals, normalization
│
├── 04_math_connection/
│   └── vector_visualizer.js              ← Pythagorean theorem visualizer (draws triangles!)
│
└── 05_extension/
    └── extension_challenges.js           ← Bonus: sprint, acceleration, shape tracing
```

---

## How to load code into Minecraft Education Edition

### Step 1 — Open MakeCode
1. Launch Minecraft Education Edition and open (or create) a world
2. Press **Esc** to open the pause menu
3. Click **Code** → **Create Code**
4. When the MakeCode editor opens, click the **JavaScript** tab at the top

### Step 2 — Paste the code
1. Select **all** existing code in the editor (`Ctrl+A` / `Cmd+A`) and delete it
2. Open the `.js` file for your current lesson section in a text editor
3. Copy all the text (`Ctrl+A` then `Ctrl+C`)
4. Paste it into MakeCode (`Ctrl+V`)

### Step 3 — Run it
1. Click the green **Play ▶** button (or press `Enter` in the editor)
2. Close the MakeCode editor to return to your Minecraft world
3. Open the chat box (`T` key) and type one of the commands listed at the top of the file

---

## File guide — when to use each file

### `01_warmup/coordinate_practice.js`
**Use during:** The warm-up activity (first 8–10 minutes)

Reinforces the warm-up math by letting students **see the coordinate change live** on the HUD. Students calculate where they'll land on paper first, then run the command to verify.

| Chat command | What it does |
|---|---|
| `warmup1D` | Prints the 1D number line example (X=5, move +3) |
| `warmup2D` | Prints the 2D coordinate example (start (2,3), move (4,−1)) |
| `tpDemo` | Teleports the player to the landing position so they can see the coordinates |
| `quiz` | Shows the three discussion questions in chat |

**Teacher tip:** Have students write their prediction on paper *before* typing the command, then check.

---

### `02_basic_movement/movement_basic.js`
**Use during:** Part B — Main Activity (the 20-minute coding block)

This is the **primary teaching file**. Students type it in together or paste it, then work through each command. The comments explain every line.

| Chat command | What it does |
|---|---|
| `moveEast` | Agent moves East `speed` blocks |
| `moveWest` | Agent moves West `speed` blocks |
| `moveNorth` | Agent moves North `speed` blocks |
| `moveSouth` | Agent moves South `speed` blocks |
| `moveDiag` | Agent moves diagonally (East + South) |
| `teleport` | Resets Agent to your position |
| `showPos` | Prints Agent's X, Y, Z coordinates |
| `showSpeed` | Prints the current speed value |

**Key teaching moment:** Change `let speed = 3` on line 40 to different values and re-run. Ask students to predict the change before pressing Play.

---

### `03_exploration/exploration_challenges.js`
**Use during:** Part C — Guided Exploration (last 10 minutes of main activity)

Adds two important features over the basic file:
- A **`setSpeed`** chat command so students can change speed without re-opening the editor
- The **`markStart` / `markEnd`** commands that place colored blocks and calculate straight-line distance — making the diagonal speed problem visible as actual numbers

| Chat command | What it does |
|---|---|
| `setSpeed 5` | Change speed to 5 (any number works) |
| `move east` | Move East (or west/north/south/diag/up/down) |
| `markStart` | Place a gold block at Agent's current position |
| `markEnd` | Place a diamond block and print the distance traveled |
| `normalOn` | Enable the normalization fix for diagonal movement |
| `normalOff` | Disable normalization (raw diagonal, 41% faster) |
| `reset` | Teleport Agent back to you |

**Challenge sequence:**
1. `setSpeed 1` → `move east` → observe slow movement
2. `setSpeed 20` → `move east` → observe fast movement  
3. `setSpeed 5` → `markStart` → `move east` → `markEnd` → note distance
4. `reset` → `markStart` → `move diag` → `markEnd` → compare distances
5. `normalOn` → repeat step 4 — distance should now match step 3

---

### `04_math_connection/vector_visualizer.js`
**Use during:** Math Connection section (8–10 minutes)

Makes the **Pythagorean Theorem visible** as actual colored blocks on the ground:
- 🟥 **Red wool** = horizontal leg (East)  
- 🟦 **Blue wool** = vertical leg (South)  
- 🟨 **Gold blocks** = hypotenuse (diagonal path)

Students can walk the triangle, count blocks in each color, and verify a² + b² = c².

| Chat command | What it does |
|---|---|
| `calcMove 3 4` | Calculate straight-line distance for vector (3, 4) → prints 5 |
| `calcMove 1 1` | Proves diagonal: √(1²+1²) = √2 ≈ 1.41 |
| `drawTriangle 4` | Draws a 4-4-√32 right triangle with colored wool |
| `drawTriangle 3` | Classic 3-4-5 triangle if combined with `calcMove 3 4` |
| `vectorTable` | Prints the velocity reference table from the slides |
| `proofDiag` | Moves Agent straight, then diagonal, and prints both distances |
| `clearBlocks` | Shows the /fill command to clean up wool blocks |

**Teacher tip:** Run `drawTriangle 5` on a flat area. Ask students: "Count the red blocks. Count the blue blocks. Now count the gold. Do you notice red² + blue² = gold²?"

---

### `05_extension/extension_challenges.js`
**Use during:** For students who finish early, or as homework enrichment

Three self-contained extensions:

**Extension A — Sprint System**  
Models walk / sprint / sneak states using a speed multiplier.

| Command | Speed multiplier |
|---|---|
| `walk east` | base speed × 1 |
| `sprint east` | base speed × 2 |
| `sneak east` | base speed × 0.5 |

**Extension B — Acceleration**  
Each `accelMove` call adds 1 to the speed, modeling Δv per step.

| Command | What it does |
|---|---|
| `accelMove east` | Move and increase speed by 1 |
| `showAccel` | Show current speed and next speed |
| `resetAccel` | Reset to base speed |

**Extension C — Shape Tracer**  
A path is just a sequence of direction vectors.

| Command | Shape |
|---|---|
| `traceSquare 5` | 5×5 square |
| `traceRect 8 3` | 8-wide × 3-deep rectangle |
| `traceLShape 4` | L-shape with arm length 4 |
| `traceCustom 6 3 6 3` | Any 4-sided path (E S W N blocks) |

---

## Common problems

**"The Agent doesn't move"**  
Make sure you've summoned the Agent first. Type `/summon agent` in chat, or use the `teleport` command in the basic movement file.

**"My code has an error / red underline"**  
MakeCode's JavaScript mode is strict about types. Make sure `speed` is a number (e.g. `let speed = 3`, not `let speed = "3"`).

**"The Agent moves but in the wrong direction"**  
The Agent faces the direction it last moved. `SixDirection.East` always means world-East (positive X), regardless of which way the Agent is facing. If you want relative movement (forward/back), replace `SixDirection.East` with `SixDirection.Forward`.

**"setSpeed isn't working"**  
Type it exactly as `setSpeed 5` (no quotes around the number). If it still fails, check that your code uses `parseInt(newSpeed)` to convert the chat argument from a string.

**"drawTriangle draws on top of existing blocks"**  
Use `/fill ~-20 ~ ~-20 ~20 ~0 ~20 air replace` to clear a flat area first.

---

## Suggested lesson flow

| Time | File to use | Activity |
|---|---|---|
| 0–10 min | `01_warmup` | Coordinate prediction on paper, then verify with `tpDemo` |
| 10–30 min | `02_basic_movement` | Walk through code together, type each command |
| 30–40 min | `03_exploration` | Speed challenges 1–4, measure diagonal vs straight |
| 40–50 min | `04_math_connection` | Draw the triangle, run `proofDiag`, discuss Pythagorean Theorem |
| 50–60 min | Exit ticket + `05_extension` | Early finishers use extension file |

---

## How the code connects to the lesson's math

Every `agent.move(SixDirection.East, 1)` call is equivalent to adding the unit vector **(+1, 0, 0)** to the Agent's position. The `for` loop repeating `speed` times is **scalar multiplication** — the same as writing:

> velocity = direction × speed

When we move East *and* South in the same loop iteration, we're adding **(+1, 0, +1)** per step. The straight-line magnitude of that combined vector is:

> √(1² + 0² + 1²) = √2 ≈ 1.41

This is exactly the **Pythagorean Theorem** — and it's why `drawTriangle` in the math connection file produces a right triangle with a hypotenuse longer than either leg.

---

*STEM Through Games — Day 5 of 10*  
*Next lesson: Day 6 — Gravity, Jumping & Physics (Y-axis vectors)*
