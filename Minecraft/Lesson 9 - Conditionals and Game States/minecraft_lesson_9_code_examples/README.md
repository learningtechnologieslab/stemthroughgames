# Day 9 Code Examples — Conditionals & Game States
## STEM Through Games | Minecraft Education Edition

These files are the Python code examples for Day 9 of the STEM Through Games program. Each file matches a section of the Day 9 lesson plan and slide deck.

---

## What You Need

- **Minecraft Education Edition** (any recent version)
- A Minecraft world open and ready
- Access to **Code Builder** (press **C** in-game)
- Select **Python** mode in Code Builder

---

## File Overview

```
day9_minecraft/
├── examples/
│   ├── 01_warmup_if_else.py          Warm-Up activity (7–10 min)
│   ├── 02_health_system.py           Main Activity (25–30 min)
│   ├── 03_comparison_operators.py    Math Connection (8–10 min)
│   ├── 04_boolean_logic.py           Math Connection continued
│   ├── 05_challenge_win_condition.py Challenge activity (10–12 min)
│   └── 06_complete_game.py           All concepts combined
└── reference/
    └── quick_reference.py            Student cheat sheet
```

---

## How to Run Code in Minecraft Education

1. Open your Minecraft Education world.
2. Press **C** to open Code Builder.
3. Click **Code** and select **Python**.
4. Copy the contents of a `.py` file and paste into the editor.
5. Click **Run** (the green play button).
6. Watch the output appear in the Minecraft chat panel.

> **Tip:** You can also type code directly in Code Builder without copy-pasting — great for the guided walk-through portions.

---

## Lesson Sequence

Work through the files in order during class. Each one builds on the last.

### 01 · Warm-Up — `01_warmup_if_else.py`

**When to use:** Opening activity, first 7–10 minutes.

Introduces the basic `if / else` structure using simple Minecraft scenarios (lava, score, zombies). No functions or variables needed — students just read and predict the output before running.

**Teaching move:** Have students call out "True" or "False" for each condition before clicking Run. Then verify together.

---

### 02 · Health System — `02_health_system.py`

**When to use:** Main coding activity, 25–30 minutes.

This is the core Day 9 example. Students build a health tracking system step by step:

- Variables (`health`, `score`) to store game state
- `take_damage(amount)` function with `if / elif / else`
- `player.say()` for in-world feedback
- `mobs.spawn()` as a visual Game Over signal

**Walk-through approach:** Project this file and talk through each section using the Code Walk-Through slide. Then have students type it themselves.

**Test sequence:**
```python
take_damage(50)    # → "Health remaining: 50"
take_damage(30)    # → "Warning: Low health!" (health now 20)
take_damage(25)    # → "Game Over!" + Zombie spawns (health ≤ 0)
```

---

### 03 · Comparison Operators — `03_comparison_operators.py`

**When to use:** Math Connection segment, 8–10 minutes.

Demonstrates all six comparison operators (`==`, `!=`, `<`, `>`, `<=`, `>=`) with individual Minecraft game examples for each. Links directly to the math operators table in the slides.

**Teaching move:** Have students change the values at the top of the file (`score`, `health`, `weapon`, etc.) and predict which `if` branches will now trigger.

---

### 04 · Boolean Logic — `04_boolean_logic.py`

**When to use:** Continues the Math Connection segment.

Shows how to combine conditions with `and`, `or`, and `not`. Each operator has two worked examples showing real Minecraft use cases.

**Discussion prompt built in:** The file ends with a class discussion challenge about writing a combined win condition.

---

### 05 · Challenge — `05_challenge_win_condition.py`

**When to use:** Challenge activity, 10–12 minutes.

Contains the base challenge (win at score 10) plus all four extension challenges:

| Extension | Concept |
|-----------|---------|
| Two win tiers (`elif`) | Chaining conditions |
| Win requires health > 0 | `and` logic |
| "Close call" message | Nested conditions |
| Custom game states | String-based state machine |

**Differentiation:** Struggling students do the base function only. On-track students tackle extensions 1–2. Advanced students work through extensions 3–4 and design their own state.

---

### 06 · Complete Game — `06_complete_game.py`

**When to use:** Optional — for advanced students, fast finishers, or as a Day 10 preview.

All Day 9 concepts integrated into one coherent script: health, scoring, item collection, a locked door mechanic, win/loss detection, and a named game state machine. Four pre-built test scenarios are included (commented out).

**Advanced challenge:** Have students add a `PAUSED` state that ignores all input until unpaused.

---

### Quick Reference — `reference/quick_reference.py`

**When to use:** Any time, throughout the lesson.

A single-file cheat sheet students can keep open alongside their work. Covers:

- All comparison operators with `print()` examples
- Boolean logic operators with examples
- `if / elif / else` template
- Minecraft Education built-ins used in Day 9
- The `global` keyword explained
- Five common mistakes with correct versions shown

**For struggling students:** Print this file one page per student before class.

---

## Minecraft Education Built-Ins Used

| Function | What It Does |
|----------|--------------|
| `player.say("text")` | Displays a message in the Minecraft chat |
| `agent.stop()` | Stops the Agent from moving |
| `agent.move(FORWARD, n)` | Moves the Agent n blocks forward |
| `mobs.spawn(ZOMBIE, pos(x,y,z))` | Spawns a mob at world coordinates |
| `pos(x, y, z)` | Creates a world position |

---

## Python Concepts Covered

| Concept | Example |
|---------|---------|
| Variable assignment | `health = 100` |
| Arithmetic assignment | `health -= amount` |
| `if` statement | `if health <= 0:` |
| `elif` clause | `elif health < 30:` |
| `else` clause | `else:` |
| Comparison operators | `==  !=  <  >  <=  >=` |
| Boolean `and` | `if score >= 10 and health > 0:` |
| Boolean `or` | `if is_jumping or is_crouching:` |
| Boolean `not` | `if not is_game_over:` |
| Functions | `def take_damage(amount):` |
| `global` keyword | `global health` |
| String conversion | `str(health)` |
| String concatenation | `"Health: " + str(health)` |
| Early return | `return` |

---

## Troubleshooting

**"Name 'player' is not defined"**
You are running the code outside of Minecraft Education (e.g., in a regular Python interpreter). These scripts require the Minecraft Education Code Builder environment. The `player`, `agent`, and `mobs` objects are provided automatically inside Code Builder.

**"SyntaxError: invalid syntax" on an `if` line**
Check for a missing colon (`:`) at the end of the `if`, `elif`, or `else` line.

**"IndentationError"**
Python requires consistent indentation. Use 4 spaces (not a mix of tabs and spaces). Code Builder handles this automatically if you use the Tab key.

**"UnboundLocalError: local variable 'health' referenced before assignment"**
You are modifying a variable inside a function without declaring it `global` first. Add `global health` (or whichever variable) at the top of that function.

**The Agent doesn't stop / the Zombie doesn't spawn**
Make sure your Minecraft world has cheats enabled, and that you have an Agent spawned in the world before running scripts that call `agent.stop()`.

---

## Preview — Day 10

Day 10 covers **Loops & Repetition** (`for` and `while` loops). Students will use loops to:

- Spawn multiple mobs automatically
- Have the Agent build repeating structures
- Animate objects that cycle through states

The `game_state` variable pattern introduced in Example 06 of this lesson will return in Day 10 as the basis for a game loop.

---

*STEM Through Games | Day 9 of 20 | Minecraft Education Edition | Python*
