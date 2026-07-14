# Day 6 — Gravity & Jumping: Forces in Action
## Code Examples Package
### STEM through Games · Minecraft Education Edition · Middle School (Grades 6–8)

---

## What's in This Package

```
day6-gravity-jumping/
│
├── README.md                          ← You are here
│
├── makecode/
│   ├── 01_scaffold.js                 ← Scaffold level (support students)
│   ├── 02_core.js                     ← Core level (most students)
│   └── 03_extension.js                ← Extension level (challenge)
│
├── visualizer/
│   └── physics_visualizer.html        ← Interactive physics simulator
│
└── teacher-demo/
    ├── parabola_grapher.html           ← Projector-ready parabola demo
    └── experiment_log.html             ← Printable/digital student log
```

---

## Quick Start — 5 Minutes Before Class

**MakeCode files** → Open Minecraft Education → Press **C** → paste code into the **JavaScript** tab.

**HTML files** → Double-click any `.html` file to open it in a web browser. No internet required.

That's it. No installs, no accounts, no build steps.

---

## The MakeCode Files

These three files all teach the same physics. Choose the right one for each student.

---

### `01_scaffold.js` — Scaffold (Support Level)

**Who:** Students who need extra support, are newer to coding, or have IEPs requiring additional structure.

**What they do:** The entire physics loop is pre-written and working. Students only change two numbers at the top and observe what happens.

**How to use:**
1. Open Minecraft Education and load the starter world.
2. Press **C** to open the MakeCode editor.
3. Click the **JavaScript** tab at the top.
4. Delete any existing code.
5. Paste the full contents of `01_scaffold.js`.
6. Click **Done** (the checkmark) to save.
7. In Minecraft, type `/jump` in chat to make the agent jump.

**Student task:** Change `JUMP_FORCE` and `GRAVITY` at the top of the file and fill in the observation table in their Game Design Journal (or use `experiment_log.html`).

**The two constants to change:**
```javascript
const JUMP_FORCE = 10    // try: 5, 20, 30
const GRAVITY    = -0.6  // try: -0.3, -1.5
```

**Common issue:** Students may not understand why GRAVITY is negative. Remind them: in our simulation, positive Y = up, so a force that pulls *down* must be negative.

---

### `02_core.js` — Core (On-Level)

**Who:** Most students. They should type this code themselves — not copy/paste. Typing line by line builds understanding.

**What they do:** Build the full physics simulation from scratch, then experiment with the values and use the extra chat commands.

**How to use:**
1. Same steps as above — paste into the MakeCode JavaScript editor.
2. Type `/jump` in chat to jump.
3. Also try `/high`, `/heavy`, and `/status`.

**Chat commands in this file:**

| Command   | What it does |
|-----------|-------------|
| `/jump`   | Normal jump using current JUMP_FORCE |
| `/high`   | Quick high-jump test (big velocity burst) |
| `/heavy`  | Quick single jump to feel the arc without changing GRAVITY |
| `/status` | Prints current posY, velocityY, and onGround to chat |

**The key code to walk through with students (line by line):**

```javascript
// Each tick, gravity CHANGES the velocity — this is acceleration:
velocityY += GRAVITY

// Velocity tells us how much position changes each tick:
posY += velocityY

// If we've landed, reset everything:
if (posY <= GROUND_LEVEL) {
    posY = GROUND_LEVEL
    velocityY = 0
    onGround = true
}
```

**Discussion points during the walk-through:**

- *Why do we add GRAVITY to velocityY, not to posY directly?*  
  Because gravity is an acceleration — it changes *speed*, not *position* directly. This is the core physics concept.

- *What would happen if we set GRAVITY to 0?*  
  The agent would float forever — no force pulling it back down.

- *Why is `loops.everyInterval(50, ...)` similar to `_physics_process(delta)` in Godot?*  
  Both run repeatedly on a fixed schedule and are where you apply forces each frame/tick.

---

### `03_extension.js` — Extension (Challenge)

**Who:** Students who finish the core activity early and want to go deeper. Strong coders or students especially interested in game design.

**What they do:** Implement four advanced game-feel techniques used in real commercial games:

| Technique | What it does | Games that use it |
|-----------|-------------|-------------------|
| **Double jump** | Jump again while in the air | Super Mario 64, Celeste |
| **Coyote time** | Brief window to jump after walking off a ledge | Celeste, Hollow Knight, almost all modern platformers |
| **Variable jump height** | Tap = small jump, hold = big jump | Super Mario Bros (all versions), Ori and the Blind Forest |
| **Jump buffering** | Pressing jump just before landing still registers | Most modern platformers |
| **Asymmetric gravity** | Fall faster than you rise — feels more natural | Celeste, Hollow Knight |

**Chat commands:**

| Command    | What it does |
|------------|-------------|
| `/jump`    | Starts a jump (hold jump then `/release` to test variable height) |
| `/release` | Simulates releasing the jump button (for variable height testing) |
| `/debug`   | Prints full physics state to chat |

**Challenge questions are built into the file comments.** Students should answer them in their Game Design Journal.

**Teacher note:** The coyote time and jump buffering techniques are genuinely used in professional game development. If students are interested, the Celeste postmortem by Maddy Thorson is a great read that discusses these exact mechanics.

---

## The HTML Files

These run entirely in a web browser — no Minecraft required. Great for:
- **The classroom projector** during the physics concepts phase
- **Students who don't have Minecraft** access
- **Homework** or independent study
- **Demonstrating the math connection** (parabola formula)

---

### `visualizer/physics_visualizer.html` — Interactive Physics Simulator

**Best used during:** Phase 1 (Physics Concepts) and Phase 3 (Experimentation)

**What it does:**
- Runs the same physics loop as the MakeCode files, in real time
- Shows an animated Minecraft-style agent jumping with a velocity arrow
- Plots the Y position graph (the parabola!) live as the agent jumps
- Plots the velocity graph (linear change = constant acceleration)
- Shows live stats: posY, velocityY, onGround, peak height, air ticks
- Includes 6 world presets (Normal, Low Gravity, Moon, Nether Brutal, etc.)

**How to open:** Double-click `physics_visualizer.html` in your file browser, or drag it into a Chrome/Firefox/Edge/Safari window.

**Suggested classroom use:**

1. Open on the projector before class starts so it's ready.
2. During the warm-up, ask: *"When the agent jumps, what shape does the position graph make?"*
3. During Phase 1, use the sliders to show:
   - What happens when GRAVITY → 0 (agent floats)
   - What happens when JUMP_FORCE is very large (tall arc)
   - What happens when GRAVITY is very strong (barely gets off the ground)
4. Use the **world presets** to illustrate the narrative connection: Low Gravity = dream-like, High Gravity = punishing, Moon = weightless.
5. Point to the position graph and ask: *"What math shape is this? Why?"*

**The velocity graph** is especially powerful for the math connection: it's a straight line sloping downward, proving gravity is a *constant* rate of change — that's what makes position quadratic (a parabola).

---

### `teacher-demo/parabola_grapher.html` — Parabola Demonstration

**Best used during:** The Math Connection section (8 minutes)

**What it does:**
- Plots the theoretical parabola y(t) = v₀t + ½gt²
- Updates live as you move the sliders
- Shows the formula dynamically with current values filled in
- "Add Trace" button lets you overlay multiple parabolas for comparison
- Shows peak height, tick at peak, total air time, landing velocity

**Suggested use:**

1. Set JUMP_FORCE = 10, GRAVITY = −0.6. Show the parabola.
2. Ask: *"What kind of function has a t² term?"* (Quadratic → parabola)
3. Click **Add Trace**, then change JUMP_FORCE to 20. Click Add Trace again.
4. Ask students to compare the two curves: *"What happened to the peak height when we doubled JUMP_FORCE? Did it double too?"*
5. For the extension challenge: can students find a JUMP_FORCE + GRAVITY combination with the **same peak height** but a **different air time**?

**The formula displayed** updates live to show the actual numbers:
```
y = 10t − 0.30t²   (with JUMP_FORCE=10, GRAVITY=−0.6)
```
This connects the MakeCode simulation directly to the algebra they've seen in math class.

---

### `teacher-demo/experiment_log.html` — Student Experiment Log

**Best used during:** Phase 3 (Student Experimentation) and exit ticket

**Two options:**
- **Print it** (click the Print button) for a paper worksheet
- **Open it on student devices** and fill in digitally (data is not saved — students should screenshot or print when done)

**What it contains:**

| Section | Description |
|---------|-------------|
| Part 1  | Change JUMP_FORCE, keep GRAVITY fixed — observe peak height |
| Part 2  | Change GRAVITY, keep JUMP_FORCE fixed — observe air time |
| Part 3  | Free exploration — design your own world |
| Part 4  | Math challenge — calculate peak height using the formula |
| Exit Ticket | Three written reflection questions |

**The math challenge questions** use the formula:
```
y(t) = v₀ × t + ½ × g × t²
```
Students can calculate expected peak height and compare to what they observe in the simulation — connecting algebra to their code.

---

## Physics Reference

### Key Concepts

**Gravity as Acceleration**
```
Each tick:  velocityY += GRAVITY
```
Gravity changes *velocity*, not position directly. This is why it's an *acceleration* — the rate of change of velocity. After each tick, the agent moves a little differently than the tick before.

**Jump as Velocity Burst**
```
On jump:  velocityY = JUMP_FORCE
```
Jumping sets velocity to a large upward value all at once. Gravity then chips away at this velocity each tick until the agent falls.

**The Parabola**
```
y(t) = v₀ × t + ½ × g × t²
```
Because position is a *quadratic* function of time (t² term), the jump arc is always a parabola. This is true in real life too — projectile motion on Earth follows the same formula.

### Minecraft vs. Godot — Sign Convention

A common source of confusion: the two platforms use opposite Y-axis conventions.

| | Minecraft | Godot |
|---|---|---|
| **Y direction** | Y increases upward | Y increases downward (screen space) |
| **Jump force sign** | **Positive** (`JUMP_FORCE = 10`) | **Negative** (`JUMP_VELOCITY = -500`) |
| **Gravity sign** | **Negative** (`GRAVITY = -0.6`) | **Positive** (`get_gravity()` returns positive) |
| **Physics loop** | `loops.everyInterval(50, ...)` | `_physics_process(delta)` |

The physics are identical. Only the sign convention differs. Use the visualizer's side-by-side comparison (the blue box in the controls panel) to show students both at once.

### Suggested Values by World Concept

| World Feel | JUMP_FORCE | GRAVITY | Example in Minecraft |
|------------|-----------|---------|----------------------|
| Normal Overworld | 10 | −0.6 | Standard survival |
| Low Gravity / Sky | 18 | −0.25 | End dimension, sky islands |
| Moon / Space | 28 | −0.15 | Sci-fi adventure map |
| High Gravity / Cave | 10 | −1.8 | Deep cave dungeon map |
| Nether Brutal | 6 | −2.5 | Hardcore Nether map |
| Feather-Light | 8 | −0.1 | Dream / magic world |

---

## Differentiation Guide

| Level | File to use | HTML tools | Teacher move |
|-------|------------|------------|--------------|
| **Scaffold** | `01_scaffold.js` | `physics_visualizer.html` (presets) | Pre-fill the experiment log; pair with a coding buddy |
| **Core** | `02_core.js` | `physics_visualizer.html` (full) + `experiment_log.html` | Students type code and complete the log independently |
| **Extension** | `03_extension.js` | `parabola_grapher.html` | Challenge questions in the file; encourage journal research |

---

## Troubleshooting

**Agent doesn't move when I type `/jump`**
- Check that the MakeCode code was saved (click the checkmark / Done button).
- Make sure you're in the correct world with the agent spawned.
- Try reloading the world.

**Agent falls through the floor**
- The `GROUND_LEVEL` constant in the code is set to `64`. If your world's floor is at a different Y level, change that constant to match.
- Check using the `/status` command in `02_core.js` — it prints the current posY.

**Agent floats and never falls**
- GRAVITY is probably 0 or was accidentally set to a positive number.
- Remember: GRAVITY must be *negative* to pull downward in this simulation.

**Jump only works once, then stops responding**
- The `onGround` flag may be stuck at `false`. Type `/resetworld` or reload to reset state.

**Students are confused about why JUMP_FORCE is positive (opposite of Godot)**
- Use `physics_visualizer.html` — the blue comparison box in the controls panel shows both systems side by side.
- Draw both coordinate diagrams on the whiteboard: in Minecraft, Y increases upward; in Godot, Y increases downward (screen space).

**HTML files don't open**
- Try a different browser (Chrome, Firefox, or Edge are recommended).
- On some school networks, local HTML files may be blocked. Copy them to the desktop and open from there.

---

## Connecting to the Lesson Plan

| Lesson Phase | Recommended Code/Tool |
|-------------|----------------------|
| Warm-Up (10 min) | None — physical ball drop demo |
| Phase 1: Physics Concepts (10 min) | `physics_visualizer.html` on projector |
| Phase 2: Code Walk-Through (15 min) | `02_core.js` on projector + student devices |
| Phase 3: Experimentation (10 min) | MakeCode files + `experiment_log.html` |
| Math Connection (8 min) | `parabola_grapher.html` on projector |
| Game Narrative (5 min) | `physics_visualizer.html` world presets |
| Reflection / Exit Ticket (7 min) | `experiment_log.html` exit ticket section |

---

## Looking Ahead — Day 7

In Day 7, students will extend their MakeCode physics to add **horizontal movement**. They will add:
- Left/right velocity using keyboard input
- Friction and deceleration
- Their first adventure map level layout

The variables they'll need from today: `velocityY`, `onGround`, and the physics tick structure in `loops.everyInterval`. Students who understand today's vertical physics will be ready to add a `velocityX` alongside it.

---

*STEM through Games Program · Day 6 of 15 · Gravity & Jumping: Forces in Action*  
*Minecraft Education Edition · Middle School*
