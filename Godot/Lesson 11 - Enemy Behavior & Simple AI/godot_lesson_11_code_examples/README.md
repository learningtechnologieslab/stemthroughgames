# Day 11 — Enemy Behavior & Simple AI
## STEM Through Games Program | Godot 4.x Project

---

## 🚀 Quick Start

1. **Open Godot 4** (version 4.2 or later recommended)
2. Click **Import** → navigate to this folder → select `project.godot`
3. Press **F5** (or the ▶ Play button) to run
4. Move with **WASD** or **Arrow Keys**
5. Watch the enemies react!

---

## 📁 Project Structure

```
godot_day11/
├── project.godot            ← Godot project config (open this to import)
├── icon.svg                 ← Project icon
├── scenes/
│   ├── Game.tscn            ← MAIN SCENE: Player + both enemy types
│   └── Challenge.tscn       ← CHALLENGE SCENE: 4-state smart enemy
└── scripts/
    ├── Player.gd             ← Player movement (WASD, arrow keys)
    ├── Enemy_Chase.gd        ← Part 1: Simple chase behavior
    ├── Enemy_StateMachine.gd ← Part 2: Patrol + Chase state machine
    └── Enemy_Challenge.gd    ← Challenge: 4-state machine (Patrol/Wait/Chase/Return)
```

---

## 🎮 What You'll See

### Main Scene (`Game.tscn`)
| Character | Color | Behavior |
|-----------|-------|----------|
| **Player** | 🟢 Green | You! Move with WASD / Arrow Keys |
| **Chaser** | 🔴 Red | Always moves directly toward the player |
| **Patrol/Chase** | 🟠 Orange | Patrols left/right; chases when close |

Yellow text below each enemy shows **live debug info** — direction vector, distance, and current state.

### Challenge Scene (`Challenge.tscn`)
To run this scene: In the **FileSystem** panel, right-click `scenes/Challenge.tscn` → **Run This Scene** (Shift+F6).

| Color | State | Behavior |
|-------|-------|----------|
| 🔵 Blue | PATROL | Walking left/right |
| 🟡 Yellow | WAIT | Spotted you! Pausing before chase |
| 🔴 Red | CHASE | Charging at full speed |
| 🟢 Green | RETURN | Lost sight — going back home |

---

## 📐 Math Concepts in Code

### Vector Subtraction → Direction
```gdscript
var direction = player.global_position - global_position
# If player is at (400, 300) and enemy is at (100, 100):
# direction = (400-100, 300-100) = (300, 200)
# This vector POINTS from the enemy TOWARD the player.
```

### Normalization → Unit Vector
```gdscript
var unit_dir = direction.normalized()
# .normalized() divides by magnitude: v / |v|
# |v| = sqrt(300² + 200²) ≈ 360.6
# unit_dir ≈ (0.832, 0.555)   ← length is now exactly 1.0
```

### Applying Speed → Velocity
```gdscript
velocity = unit_dir * speed
# Unit vector × 120  →  enemy moves exactly 120 px/second
# toward the player, regardless of how far away they are.
```

### Distance Check → State Transition
```gdscript
var dist = global_position.distance_to(player.global_position)
# Equivalent to: sqrt((px-ex)² + (py-ey)²)
# Same as the Pythagorean theorem — straight-line distance in pixels.
if dist < detect_range:
    current_state = State.CHASE
```

---

## 🔧 Experiment Ideas

### Change the numbers (Inspector panel — no code needed!)
- **EnemyStateMachine → speed**: Try 50 (slow) or 250 (fast)
- **EnemyStateMachine → detect_range**: Try 80 (very aware) or 400 (always chasing)
- **EnemyStateMachine → patrol_range**: How wide is the patrol territory?

### Modify the code (try these!)
1. In `Enemy_Chase.gd`, **remove `.normalized()`** on line 62 — what happens? Why?
2. In `Enemy_StateMachine.gd`, make the enemy **speed up** as it gets closer:
   ```gdscript
   # In the CHASE state block, replace:
   velocity = direction * speed
   # With:
   var chase_speed = speed * (detect_range / max(dist, 10.0))
   velocity = direction * chase_speed
   ```
3. Add a **third state** to `Enemy_StateMachine.gd`: `FLEE` — runs away when the
   player is very close (dist < 60). Reverse the direction vector to flee:
   ```gdscript
   State.FLEE:
       var flee_dir = (global_position - player.global_position).normalized()
       velocity = flee_dir * speed * 1.5
   ```

---

## 📚 Lesson Connections

| Script | Lesson Section | Key Concept |
|--------|---------------|-------------|
| `Player.gd` | Setup | Input.get_vector(), move_and_slide() |
| `Enemy_Chase.gd` | Part 1 (10 min) | Vector subtraction, .normalized() |
| `Enemy_StateMachine.gd` | Part 2 (20 min) | enum, match, distance_to(), state machine |
| `Enemy_Challenge.gd` | Challenge Level 2–3 | lerp(), timer logic, multi-state AI |

---

## ⚠️ Troubleshooting

**"Node not found: /root/Game/Player"**
> Your scene tree is named differently. In the script, change the path in `get_node()` to match your actual scene structure. In the FileSystem dock, look at your scene and find the correct path.

**Enemy doesn't move**
> Make sure the enemy node has a **CollisionShape2D** child with a shape assigned, and that the script is attached.

**Enemy moves but goes through walls**
> The wall `StaticBody2D` nodes need **CollisionShape2D** children too. The `.tscn` files include these — make sure you opened the provided scene rather than creating a new one.

---

*STEM Through Games Program · Day 11 of 20 · Module 3: Enemies & AI*
