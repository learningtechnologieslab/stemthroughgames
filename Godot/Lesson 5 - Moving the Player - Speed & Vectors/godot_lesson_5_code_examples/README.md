# STEM Through Games — Day 5: Moving the Player
# GDScript Example Files — README
# ============================================================

## Overview

This folder contains 8 GDScript example files for Day 5 of the
STEM Through Games program. They are designed to be used in order,
starting with the simplest and building up to a complete, professional
movement system.

---

## Files & Progression

| File | Level | Purpose |
|------|-------|---------|
| 01_basic_movement.gd     | Starter      | The core lesson script — follow along with teacher |
| 02_vectors_explained.gd  | Math Explorer | Same movement, but prints vector math to Output panel |
| 03_normalized_movement.gd | Bonus Challenge | Fixes the diagonal speed bug with .normalized() |
| 04_speed_experiment.gd   | Design Explorer | Change speed with number keys 1–5 while the game runs |
| 05_movement_with_hud.gd  | Visual Learner | Displays live vector data as a HUD overlay |
| 06_acceleration.gd       | Extension     | Adds smooth acceleration and friction (lerp) |
| 07_complete_movement.gd  | Putting It All Together | Production-ready script combining all concepts |
| 08_math_worksheet.gd     | Math Practice | Runs a vector math worksheet in the Output panel |

---

## Quick Start (File 01)

1. Open Godot 4
2. Create a new 2D scene
3. Add a CharacterBody2D as the root node
4. Add a CollisionShape2D child → assign a RectangleShape2D
5. Add a ColorRect child (size: 48×48, color: any bright color)
6. Select the CharacterBody2D and click "Attach Script"
7. Click the folder icon and select 01_basic_movement.gd
8. Press F5 to run — use arrow keys to move!

---

## Scene Setup (same for files 01–07)

    CharacterBody2D        ← attach the .gd script here
    ├── CollisionShape2D   ← add a RectangleShape2D (48×48)
    └── ColorRect          ← set size to 48×48 (so you can see it)

For File 08 (math worksheet):

    Node                   ← attach 08_math_worksheet.gd here
    (no children needed)

---

## Learning Objectives Covered

### Mathematics
- Vector2 notation and component decomposition
- Scalar × vector multiplication
- Vector magnitude (length) using Pythagorean theorem
- Vector normalization
- Linear interpolation (lerp) — Extension
- Speed × time = distance relationships

### Physics
- Velocity as a vector quantity (speed + direction)
- Coordinate systems and the screen Y-axis
- Acceleration, deceleration, and friction — Extension

### Computer Science / GDScript
- Variables (var, @export)
- Functions (_physics_process, _ready, _input)
- Conditional statements (if)
- Built-in types (Vector2, float, bool)
- Input detection (Input.is_action_pressed)
- CharacterBody2D and move_and_slide()
- Debugging with print()

### Game Design
- Speed as a design decision affecting game feel
- The relationship between mechanics and genre
- "Game feel" / juiciness concepts

---

## Godot 4 Notes

- These scripts require Godot 4.x (not Godot 3)
- move_and_slide() in Godot 4 reads from the built-in `velocity` property
  automatically — do NOT pass velocity as a parameter (that's Godot 3 syntax)
- Default input actions used: ui_right, ui_left, ui_up, ui_down
  (these are built into every Godot project)

---

## Suggested Lesson Flow

1. Teacher live-codes 01_basic_movement.gd with students following along
2. Students run 02_vectors_explained.gd and observe the Output panel
3. Students try changing `var speed` and discuss what they notice
4. Class discussion: diagonal speed bug (observed in step 2)
5. Students open 03_normalized_movement.gd and compare behavior
6. Students use 04_speed_experiment.gd for the design activity
7. Exit ticket: students run 08_math_worksheet.gd and check their answers

Extension (fast finishers):
- 06_acceleration.gd — experiment with acceleration/friction values
- 07_complete_movement.gd — read and discuss "what makes this professional?"
