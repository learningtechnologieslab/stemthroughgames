# STEM Through Games — Day 10: Loops, Timers & Spawning
### Godot 4 Project Files

---

## 📁 Project Structure

```
STEM_Games_Day10/
├── project.godot          ← Open this in Godot to load the project
├── README.md              ← You are here
├── scenes/
│   ├── MainGame.tscn      ← Main scene (set as run/main_scene)
│   ├── CoinPickup.tscn    ← Collectible coin scene
│   └── Enemy.tscn         ← Enemy scene
└── scripts/
    ├── MainGame.gd        ← Core game logic: loops, timer, spawning
    ├── CoinPickup.gd      ← Coin behaviour: signals, groups, animation
    ├── Enemy.gd           ← Enemy movement: CharacterBody2D, boundary
    ├── Player.gd          ← Player movement: input, physics
    └── SpawnManager.gd    ← Standalone spawn utility with all 4 snippets
```

---

## 🚀 Getting Started

### Requirements
- **Godot 4.2+** (download free at https://godotengine.org)
- No additional plugins needed

### Opening the Project
1. Open Godot Engine
2. Click **Import**
3. Navigate to the `STEM_Games_Day10/` folder
4. Select `project.godot` and click **Import & Edit**

### Assigning Scenes in the Inspector (Required)
The MainGame scene needs two exported variables set before it will run:

1. Click on the **MainGame** node in the scene tree
2. In the **Inspector** panel on the right:
   - Find **Coin Scene** → drag `scenes/CoinPickup.tscn` here
   - Find **Enemy Scene** → drag `scenes/Enemy.tscn` here
3. Press **F5** (or the Play button) to run

---

## 🎮 Controls

| Key | Action |
|-----|--------|
| **Space** | Start the game |
| **← →** Arrow keys | Move player left / right |

---

## 📚 Script Guide for Students

### MainGame.gd — Start Here
The main script. Read through it in order — every section is labelled with the lesson concept it demonstrates.

**Key functions to find and study:**
- `next_wave()` — the **for loop** that spawns coins
- `_on_spawn_timer_timeout()` — the **Timer signal** handler
- `demo_while_loop_spawn()` — the **while loop** example
- `spawn_coin()` / `spawn_enemy()` — **instantiate() + add_child()**

### SpawnManager.gd — Isolated Snippets
This standalone script contains four clearly labelled code snippets you can copy into your own projects:

| Snippet | Concept |
|---------|---------|
| **SNIPPET A** | `for` loop batch spawn |
| **SNIPPET B** | `while` loop with limit |
| **SNIPPET C** | Timer callback + escalating difficulty |
| **SNIPPET D** | `randi_range()` probability demo |

---

## 🔬 Trying the Probability Demo (SNIPPET D)

While the game is running, open the **Godot debugger** and type in the remote console:

```gdscript
# Run 1000 trials of randi_range(50, 750) and see how many land in 50-119
get_node("/root/MainGame").get_node("SpawnManager").demo_probability(1000)
```

Expected output: approximately 10% (70 out of 701 possible values ≈ 9.99%)

---

## 🧩 Extension Challenges

### Challenge 1 — Dynamic Difficulty
In `MainGame.gd`, find `_on_spawn_timer_timeout()` and modify the rate
at which `wait_time` decreases. Can you make it scale with the wave number?

```gdscript
# Current (fixed reduction):
spawn_timer.wait_time = max(0.6, spawn_timer.wait_time - 0.05)

# Try this (scales with wave):
spawn_timer.wait_time = max(0.6, 3.0 / (1.0 + wave * 0.2))
```

### Challenge 2 — Wave Announcements
After `wave_label.text = "Wave: %d" % wave` in `next_wave()`, add a
temporary banner that fades out using a Tween:

```gdscript
info_label.text = "Wave %d!" % wave
var tween = create_tween()
tween.tween_property(info_label, "modulate:a", 0.0, 1.5)
```

### Challenge 3 — Coin Value Escalation
Make coins worth more on higher waves. In `spawn_coin()`, after instantiating:

```gdscript
coin.value = 10 * wave   # Coins worth more each wave
```

### Challenge 4 — Score Multiplier with While Loop
Add a multiplier that increases while the player hasn't been hit. Practice
writing a while loop that resets the multiplier under certain conditions.

---

## 🔗 Day 11 Preview

Day 11 adds collision detection between the player and enemies using `Area2D`
and the `body_entered` signal. Look for these TODO comments in the code:

```gdscript
# Day 11: add health system here
# Day 11: add game-over screen here
```

---

## 📝 Notes for Teachers

- All scripts are **heavily commented** — every concept from the lesson plan
  appears with a matching section header (e.g., `# ─── FOR LOOP ───`)
- `SpawnManager.gd` can be attached to any scene as a standalone demo node
- The visual placeholders (ColorRect) mean no external art assets are required
- Students can run `demo_probability()` from the debugger to verify the
  math connection from the lesson plan

---

*STEM Through Games Program · Day 10 of 20 · Godot 4 · GDScript*
