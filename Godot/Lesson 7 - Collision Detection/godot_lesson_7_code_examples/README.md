# STEM Through Games — Day 7 Godot Project
## Collision Detection: When Objects Meet

---

## 📁 Project Structure

```
Day7_CollisionDetection/
├── project.godot          ← Open this in Godot 4 to load the project
│
├── scripts/
│   ├── Player.gd          ← CharacterBody2D movement + score tracking
│   ├── Coin.gd            ← Area2D collectible with body_entered signal
│   ├── Obstacle.gd        ← StaticBody2D platform/hazard
│   ├── Main.gd            ← Scene controller, HUD, win condition
│   ├── AABBDemo.gd        ← Standalone AABB math visualizer (educational)
│   └── HitboxVisualizer.gd ← Debug tool: draws hitboxes over sprites
│
└── scenes/
    ├── Main.tscn          ← Main game scene (set as project's main scene)
    ├── Player.tscn        ← Player character scene
    ├── Coin.tscn          ← Collectible coin scene
    └── AABBDemo.tscn      ← AABB visualization scene
```

---

## 🚀 Getting Started

### Prerequisites
- **Godot 4.2** or later (download free from [godotengine.org](https://godotengine.org))
- No additional plugins required

### Opening the Project
1. Launch Godot 4
2. Click **Import** in the Project Manager
3. Navigate to this folder and select `project.godot`
4. Click **Import & Edit**
5. Press **F5** to run

### Controls
| Key | Action |
|-----|--------|
| A / ← | Move left |
| D / → | Move right |
| W / ↑ | Jump |
| H | Toggle hitbox visualizer |
| Enter | Restart (after winning) |

---

## 🎯 Lesson Objectives (Day 7)

This project covers:
1. **CollisionShape2D** — adding collision shapes to CharacterBody2D and StaticBody2D
2. **Area2D** — using a sensor node as a collectible with `body_entered` signal
3. **Signal connection** — both in code (`body_entered.connect(...)`) and via the editor Node panel
4. **AABB Math** — the Axis-Aligned Bounding Box overlap algorithm
5. **Hitbox design** — understanding why hitboxes differ from visible sprites

---

## 📋 Lesson Activities

### Warm-Up (10 min) — Paper Exercise
Draw two overlapping rectangles. Identify what math determines overlap.
Then run `AABBDemo.tscn` to see the answer animated.

### Part 1 — Adding Collision Shapes (10 min)
1. Open `scenes/Main.tscn`
2. Click the **Player** node in the Scene panel
3. Expand it — find the `CollisionShape2D` child
4. Click it to see the orange hitbox outline in the viewport
5. In the Inspector, expand **Shape** → change size to see the effect
6. Do the same for each Platform node under **Platforms/**

### Part 2 — The Area2D Coin (15 min)
1. Open `scenes/Coin.tscn`
2. Examine the node tree: `Area2D → CollisionShape2D + Sprite2D`
3. Open `scripts/Coin.gd` and read through `_on_body_entered()`
4. In the editor: select the **Coin** node → **Node panel** → **Signals**
5. See that `body_entered` is connected (green dot = connected)
6. Run the game — walk into coins and watch the Output panel

### Part 3 — Testing & Debugging (10 min)
Run the game and test these common issues intentionally:

| Problem | How to cause it | What happens |
|---------|----------------|--------------|
| Layer mismatch | Set Coin's `collision_mask` to 0 | Coins never collected |
| Shape disabled | Check "Disabled" on CollisionShape2D | Player passes through coins |
| Signal disconnected | Remove the `connect()` line in Coin.gd | No output, no score |

### Math Connection (10 min) — AABB
Run `scenes/AABBDemo.tscn` (change main scene temporarily in Project Settings).

Watch the Output panel for the step-by-step overlap checks on 5 test cases.

Key formula:
```
Two rectangles A and B overlap when:
  A.x < B.x + B.width   AND   B.x < A.x + A.width   ← X ranges overlap
  A.y < B.y + B.height  AND   B.y < A.y + A.height   ← Y ranges overlap
```

---

## 🧩 Student Challenges

### Starter (everyone)
- [ ] Collect all 4 coins and see the win screen
- [ ] Change a coin's `point_value` to 5 in the Inspector
- [ ] Toggle the hitbox visualizer with **H** — compare hitbox to sprite

### Intermediate
- [ ] Add a 5th coin at a new position in `Main.tscn`
- [ ] Make the player's hitbox smaller than the sprite — does it feel better?
- [ ] Add a "Coins Left: X" label to the HUD (see challenge notes in `Main.gd`)

### Advanced (Challenge)
- [ ] Add a shrink-and-vanish animation before `queue_free()` in `Coin.gd`
- [ ] Implement a timer — display elapsed time in the win message
- [ ] Create a hazard obstacle that resets the score when touched
- [ ] Build a separate HurtBox (smaller) and HurtZone (larger magnet) for coins

---

## 📐 Key Godot Concepts Used

| Concept | Where to find it |
|---------|-----------------|
| `CharacterBody2D` + `move_and_slide()` | `scripts/Player.gd` |
| `CollisionShape2D` + `RectangleShape2D` | `scenes/Player.tscn`, `scenes/Main.tscn` |
| `Area2D` + `body_entered` signal | `scenes/Coin.tscn`, `scripts/Coin.gd` |
| `StaticBody2D` | `scenes/Main.tscn` — Platform nodes |
| `collision_layer` / `collision_mask` | Inspector on Area2D and body nodes |
| `queue_free()` | `scripts/Coin.gd` — removes the node |
| `signal` + `emit()` | `scripts/Coin.gd` — `coin_collected` signal |
| `CanvasLayer` + `Label` (HUD) | `scenes/Main.tscn` — HUD node |
| `_draw()` + `draw_rect()` | `scripts/AABBDemo.gd`, `scripts/HitboxVisualizer.gd` |

---

## 🔗 Connecting Signals — Two Methods

### Method A: In the Editor (recommended for beginners)
1. Select the `Coin` (Area2D) node
2. Open the **Node** panel (right side, next to Inspector)
3. Click **Signals**
4. Double-click `body_entered`
5. Choose the script to connect to and click **Connect**
6. Godot creates the `_on_body_entered(body)` function automatically

### Method B: In Code (in `Coin.gd`)
```gdscript
func _ready() -> void:
    body_entered.connect(_on_body_entered)
```

Both achieve the same result. The editor method adds a green plug icon in the Scene panel to show a signal is connected.

---

## 🔮 What's Coming Next

| Day | Topic | Preview |
|-----|-------|---------|
| Day 8 | Gravity & Jumping | Constant acceleration, velocity vectors, physics loop |
| Day 9 | Scoring & UI | CanvasLayer, Label nodes, global variables |
| Day 10 | Enemy Behavior | State machines, patrol AI, aggro zones |

---

*STEM Through Games Curriculum — Day 7 of 20*
*Do not redistribute without program permission*
