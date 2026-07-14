# Day 12: Score, UI & HUD
### STEM Through Games – Godot 4.x Starter Project

---

## 📁 Project Structure

```
Day12_HUD/
├── project.godot          ← Open this in Godot to load the project
├── icon.svg
├── scenes/
│   ├── Main.tscn          ← Root scene (run this to play)
│   ├── HUD.tscn           ← Reusable HUD scene template
│   └── Coin.tscn          ← Collectible coin scene
└── scripts/
    ├── Main.gd            ← Connects signals; handles test key input
    ├── Player.gd          ← Player movement + score/health signals
    ├── HUD.gd             ← Score label, HP label, countdown timer
    └── Coin.gd            ← Area2D collectible that awards points
```

---

## 🚀 Getting Started

1. **Open Godot 4.x** (download free at https://godotengine.org)
2. Click **"Import"** and navigate to the `Day12_HUD/` folder
3. Select `project.godot` and click **"Import & Edit"**
4. Press **F5** (or the ▶ Play button) to run the project
5. Use the controls below to test the HUD live

### Test Controls
| Key | Action | What updates |
|-----|--------|-------------|
| ← → (or A D) | Move player | — |
| Space | Jump | — |
| **C** | Collect coin (+10 pts) | ScoreLabel |
| **H** | Take a hit (−25 HP) | HealthLabel (turns yellow → red) |
| **R** | Heal (+25 HP) | HealthLabel |
| **F1** | Print debug state | Godot Output panel |

---

## 🧠 Lesson Concepts

### What is a HUD?
A **Heads-Up Display** is the layer of UI drawn on top of the game world showing the player's current stats. In Godot, a `CanvasLayer` node ensures HUD elements stay fixed on screen regardless of camera movement.

### Scene Tree (HUD)
```
HUD  (CanvasLayer)  ←  Script: HUD.gd
└── HBoxContainer   ←  Automatically arranges children horizontally
      ├── ScoreLabel   (Label)  ←  "Score: 0"
      ├── HealthLabel  (Label)  ←  "HP: 100"
      └── TimerLabel   (Label)  ←  "Time: 60"
```

### The `str()` Function
```gdscript
# score is an integer:   42
# "Score: " is a string: "Score: "
# You CANNOT concatenate them directly — types must match!

# ❌ This causes an error:
$ScoreLabel.text = "Score: " + 42

# ✅ str() converts the integer to a string first:
$ScoreLabel.text = "Score: " + str(42)   # → "Score: 42"
```

### Signals: Decoupled Communication
```
Player  ──── score_changed(n) ────►  HUD.update_score(n)
Player  ── health_changed(n) ────►  HUD.update_health(n)
Player  ──── player_died() ──────►  HUD.stop_timer()
```
The Player doesn't know the HUD exists. The HUD doesn't know the Player exists.
They communicate through signals, which keeps the code modular and reusable.

### Connection in Main.gd
```gdscript
func _ready() -> void:
    $Player.score_changed.connect($HUD.update_score)
    $Player.health_changed.connect($HUD.update_health)
    $Player.player_died.connect($HUD.stop_timer)
```

### Countdown Timer Math
```gdscript
# In HUD._process(delta):
elapsed_time += delta                          # accumulate time
var remaining_time = MAX_TIME - elapsed_time   # y = 60 − x
$TimerLabel.text = "Time: " + str(int(remaining_time))
```
This is a **linear function**: `y = b − x`
- `b` = 60 (the starting value / y-intercept)
- `x` = `elapsed_time` (increases each frame)
- `y` = `remaining_time` (decreases toward 0)

---

## ⭐ Challenge Extensions

### 1. Change the starting time
In `HUD.gd`, find line:
```gdscript
const MAX_TIME: float = 60.0
```
Change `60.0` to `90.0` or `120.0`. How does the formula still work?

### 2. MM:SS display format (Bonus Math)
Replace the `$TimerLabel.text` line in `_process()` with:
```gdscript
var total: int = int(remaining_time)
var minutes: int = total / 60       # integer division
var seconds: int = total % 60       # modulo (remainder)
var sec_str: String = str(seconds)
if seconds < 10:
    sec_str = "0" + sec_str         # zero-pad: 5 → "05"
$TimerLabel.text = "Time: " + str(minutes) + ":" + sec_str
```
**Math connection**: Division and modulo decompose a number into parts —
the same idea as converting 65 minutes into "1 hour 5 minutes".

### 3. Coin scene placement
Drag `Coin.tscn` into `Main.tscn` from the FileSystem panel. Place coins on
the platform. Run the game and walk into them — the score should update!

### 4. Add a kill zone
Create an `Area2D` below the floor. When the player falls into it, call
`$Player.take_damage(100)` to trigger the death signal.

---

## 🔧 Troubleshooting

| Problem | Likely cause | Fix |
|---------|-------------|-----|
| HUD labels don't update | Signal not connected | Check `Main._ready()` — node paths must match the scene tree |
| Error: "Invalid get index 'text' on 'null'" | Label node name mismatch | HUD.gd uses `$ScoreLabel` — make sure your Label is named exactly `ScoreLabel` (case-sensitive) |
| Error: "Invalid operands: String + int" | Missing `str()` call | Wrap the integer: `str(score)` |
| Timer keeps running after death | `stop_timer()` not connected | Add `$Player.player_died.connect($HUD.stop_timer)` in `Main._ready()` |
| Player falls through floor | CollisionShape2D missing | Select the StaticBody2D and add a CollisionShape2D child |

---

## 📚 GDScript Quick Reference

```gdscript
# Variable types
var score: int = 0          # whole number
var health: float = 100.0   # decimal number
var name: String = "Hero"   # text

# Type conversion
str(42)        # int → String  →  "42"
int(3.7)       # float → int   →  3   (truncates)
float(5)       # int → float   →  5.0

# String concatenation
"Score: " + str(score)    # "Score: " + "42"  →  "Score: 42"

# Signals
signal my_signal(value: int)          # define
emit_signal("my_signal", 42)          # send
my_signal.connect(some_function)      # receive
```

---

*STEM Through Games – Day 12 of 20 | Next: Day 13 – Game States & Game Over*
