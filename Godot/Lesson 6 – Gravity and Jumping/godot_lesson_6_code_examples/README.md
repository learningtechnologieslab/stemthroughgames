# STEM Through Games — Day 6: Gravity & Jumping
## Godot 4 Project Files

---

## 🚀 Quick Start

1. **Open Godot 4** (version 4.2 or later recommended)
2. Click **Import** and navigate to this folder
3. Select `project.godot` and click **Import & Edit**
4. Press **F5** (or the Play button) to run the main scene
5. Move with **Arrow keys / A D**, Jump with **Space / W / Up Arrow**

---

## 📁 Project Structure

```
godot_day6/
├── project.godot              ← Godot project settings & input map
├── icon.svg                   ← Project icon
│
├── scenes/
│   ├── Main.tscn              ← Main lesson scene (run this first!)
│   └── ExperimentScene.tscn   ← Experiment sandbox with Inspector tweaks
│
└── scripts/
    ├── Player.gd              ← ⭐ CORE LESSON SCRIPT (start here)
    ├── PlayerExperiment.gd    ← @export variables for Inspector tweaking
    ├── PlayerChallenge.gd     ← Extension challenges with TODO gaps
    ├── PhysicsHUD.gd          ← Live velocity/state debug overlay
    ├── JumpTracer.gd          ← Draws the parabola arc as a trail
    └── solutions/
        └── PlayerChallengeSolution.gd   ← Full solutions (teacher only!)
```

---

## 📝 Scripts — What Each File Does

### `Player.gd` ⭐ Start Here
The core script for the lesson. Heavily commented to explain every line.
Covers gravity, jumping, and horizontal movement.
**This is what students type during Phase 2 of the main activity.**

### `PlayerExperiment.gd`
The same logic as `Player.gd`, but all the key values are `@export` variables.
This means students can tweak `jump_velocity`, `gravity`, and `max_jumps`
directly in Godot's Inspector panel — no code editing needed.
**Use this for the Phase 3 experimentation activity.**

To switch to this script:
1. Click the `Player` node in the Scene panel
2. In the Inspector, click the Script slot
3. Load `scripts/PlayerExperiment.gd`

### `PlayerChallenge.gd`
Contains four extension challenges with `# TODO` gaps:
- ★     **Challenge 1** — Variable jump height (short-hop mechanic)
- ★★    **Challenge 2** — Double jump
- ★★★   **Challenge 3** — Coyote time (ledge grace period)
- ★★★★  **Challenge 4** — Wall jump

### `PhysicsHUD.gd`
Displays a live overlay showing:
- `velocity.x` and `velocity.y` (updates every frame)
- `is_on_floor()` state
- Current movement state (RISING / FALLING / ON FLOOR)

**Pedagogical purpose:** Watching `velocity.y` count up from -500 toward 0
then past 0 into positive values is the best demonstration of gravity as
constant acceleration.

### `JumpTracer.gd`
Draws cyan dots tracing the player's path through the air.
The resulting arc is visually a **parabola** — directly demonstrating the
math connection `y(t) = v₀t + ½gt²`.
A gold dot marks the peak of each jump.

---

## 🧪 Experiment Guide (Phase 3)

Use `ExperimentScene.tscn` which has `PlayerExperiment.gd` attached.
Select the `Player` node and find these values in the Inspector:

| Variable | Default | Try This |
|---|---|---|
| `jump_velocity` | -500 | -200 (tiny hop), -800 (huge leap) |
| `speed` | 250 | 100 (slow), 500 (fast) |
| `max_jumps` | 1 | 2 (double jump!) |
| `coyote_frames` | 6 | 0 (no grace), 15 (very forgiving) |
| `override_gravity` | false | true (then try custom_gravity) |
| `custom_gravity` | 980 | 300 (moon), 2500 (heavy planet) |

**Journal prompt:** For each setting you change, write:
1. What value you used
2. What you observed
3. What kind of game world or character this would suit

---

## 🔢 Math Connection

The jump arc is a **parabola** because of kinematic equations:

```
y(t) = v₀ × t + ½ × g × t²
```

Where:
- `y(t)` = vertical position at time t
- `v₀`   = initial velocity (your `JUMP_VELOCITY`, e.g. -500)
- `g`    = gravity (980 px/s²)
- `t`    = time in seconds

Because `t²` appears in the equation, position is a **quadratic function
of time** — and the graph of a quadratic is a parabola!

**The peak of the jump** happens when vertical velocity = 0:
```
0 = v₀ + g × t_peak
t_peak = -v₀ / g
t_peak = -(-500) / 980 ≈ 0.51 seconds
```

---

## 🎮 Controls

| Action | Keys |
|---|---|
| Move Left | ← Arrow, A |
| Move Right | → Arrow, D |
| Jump | Space, W, ↑ Arrow |

---

## ⚙️ Godot Version

Built for **Godot 4.2+**. Uses:
- `CharacterBody2D` (not KinematicBody2D from Godot 3)
- `get_gravity()` built-in method
- `move_and_slide()` (no argument needed in Godot 4)
- `@export` and `@export_group` annotations

---

## 🗂️ Lesson Context

**Program:** STEM Through Games  
**Day:** 6 of 15  
**Topic:** Gravity & Jumping — Forces in Action  
**Focus:** Gravity as constant acceleration  
**Engine:** Godot 4 · GDScript  
**Grade Level:** Middle School (Grades 6–8)
