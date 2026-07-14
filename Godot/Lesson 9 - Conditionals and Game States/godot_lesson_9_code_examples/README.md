# STEM Through Games — Day 9
## Conditionals & Game States | GDScript | Godot 4

---

## 📁 Project Files

```
godot_day9/
├── project.godot          ← Open this in Godot 4
├── icon.svg
├── scenes/
│   ├── Main.tscn          ← Main playable level (run this!)
│   └── Exercises.tscn     ← Standalone coding exercises
└── scripts/
    ├── Player.gd          ⭐ MAIN LESSON SCRIPT — start here
    ├── HUD.gd             ← Health bar & score display
    ├── Collectible.gd     ← Coins the player collects
    ├── Hazard.gd          ← Damage zones (spikes)
    ├── GameManager.gd     ← Game state machine (extension)
    └── Exercises.gd       ← 8 practice exercises with TODO prompts
```

---

## 🚀 How to Open

1. Download and install **Godot 4.3** (free) from https://godotengine.org
2. Open Godot → click **"Import"** → navigate to this folder → select `project.godot`
3. Click **"Import & Edit"**
4. Press **F5** (or the ▶ Play button) to run the game

---

## 🎮 Controls

| Key | Action |
|-----|--------|
| `A` / `←` | Move left |
| `D` / `→` | Move right |
| `Space` / `↑` | Jump |
| `H` | Take 25 damage *(test health conditions)* |
| `E` | Collect 1 point *(test win condition)* |
| `R` | Restart scene |

Walk over the **yellow squares** to collect coins automatically.
Touch the **red squares** to take spike damage.

---

## 📖 Script Reading Order

Start with **Player.gd** — it contains the full lesson code with detailed comments.

### Section Map in Player.gd

| Section | What It Teaches |
|---------|----------------|
| **Section 1** | Variables that track game state |
| **Section 2** | `_physics_process` — movement with conditional guards |
| **Section 3** | `take_damage()` — the core `if/elif/else` chain from the lesson |
| **Section 4** | `add_score()` — the win condition challenge |
| **Section 5** | `heal()` — demonstrates `&&` (AND) and `!` (NOT) |
| **Section 6** | Extension challenges: tiered scoring, combined conditions |

---

## ✏️ Exercises

Open **Exercises.tscn** in Godot and press F5.
All 8 exercises print to the **Output panel** at the bottom of the editor.

Each exercise ends with a `🔧 TRY IT` prompt — a small change to make and observe.

| Exercise | Topic |
|----------|-------|
| 1 | Basic `if` / `else` |
| 2 | `if` / `elif` / `else` chain |
| 3 | All 6 comparison operators |
| 4 | Boolean AND `&&` |
| 5 | Boolean OR `\|\|` |
| 6 | Boolean NOT `!` |
| 7 | Nested conditionals |
| 8 | **Your Turn** — blank template to write your own |

---

## 🏆 Challenges

These are inside **Player.gd** — look for `CHALLENGE` comments:

1. **Basic** — The `add_score()` win condition is already working. Test it!
2. **Tiered scoring** — Edit `add_score_tiered()`: add a "Perfect Score!" for score >= 20
3. **Combined condition** — Edit `check_win_with_health()`: win requires score >= 10 **AND** health > 0
4. **Close call** — Edit `check_close_call_win()`: different message if health < 10 when winning
5. **Custom state** — Add a new value to the `GameState` enum in `GameManager.gd`

---

## 🔑 Key Concepts (Quick Reference)

```gdscript
# Comparison operators — always return true or false
health == 0     # equal to
health != 0     # not equal to
health < 30     # less than
health > 0      # greater than
health <= 0     # less than or equal to
score >= 10     # greater than or equal to

# if / elif / else
if health <= 0:
    print("Game Over!")
elif health < 30:
    print("Warning: Low health!")
else:
    print("Health: ", health)

# Boolean AND — BOTH must be true
if score >= 10 && health > 0:
    print("You Win!")

# Boolean OR — EITHER can be true
if is_jumping || is_crouching:
    print("In the air or crouching")

# Boolean NOT — inverts true/false
if !is_game_over:
    print("Game is still running")
```

---

*STEM Through Games Program | Day 9 of 20 | Godot 4 + GDScript*
