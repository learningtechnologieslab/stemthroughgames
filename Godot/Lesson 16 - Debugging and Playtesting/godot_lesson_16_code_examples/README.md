# Day 16 – Debugging & Playtesting
## STEM Through Games | Godot Game Design Program | Middle School

---

## 📦 What's In This Package

```
Day16_GodotProject/
├── project.godot                    ← Open this in Godot to load the project
├── README.md                        ← You are here
│
├── BuggyScenes/                     ← STUDENT VERSIONS (intentionally broken)
│   ├── Bug01_NullReference/         ← Bug: typo in node path → null crash
│   ├── Bug02_MovementBroken/        ← Bug: wrong node type → method missing
│   ├── Bug03_CollisionNotFiring/    ← Bug: layer/mask mismatch → no overlap
│   └── Bug04_ScoreNotUpdating/      ← Bug: signal not connected → silent fail
│
├── FixedScenes/                     ← INSTRUCTOR REFERENCE (working versions)
│   ├── Fix01_NullReference/         ← Fix: corrected node path + @onready
│   ├── Fix02_MovementFixed/         ← Fix: CharacterBody2D + CollisionShape2D
│   ├── Fix03_CollisionFixed/        ← Fix: Coin mask = 1 (matches player layer)
│   └── Fix04_ScoreFixed/            ← Fix: signal.connect() added in _ready()
│
└── SharedAssets/
    ├── PlayerMovement.gd            ← Reusable movement script
    └── icon.svg                     ← Project icon
```

---

## 🚀 How to Open This Project

1. Download and install **Godot Engine 4.2+** from https://godotengine.org
2. Open Godot → click **"Import"**
3. Navigate to this folder and select **`project.godot`**
4. Click **"Import & Edit"**
5. The project opens with Bug01 as the default scene

---

## 🐛 The Four Bugs — Student Guide

### Bug 01 — Null Reference Error
**File:** `BuggyScenes/Bug01_NullReference/Bug01_NullReference.gd`

**What happens:** Press SPACE → game crashes immediately.

**Error you'll see:**
```
Invalid get index 'position' (on base: 'Nil')
```

**Your task:**
- Read the error and find the line number it points to
- Look at the `get_node()` call — compare it to the Scene tree
- Add `print(player)` after the `get_node()` line — what does it print?
- Fix the typo so the node is found correctly

**Concept:** `get_node()` searches by name. Wrong name = `null`. Using `null` crashes.

---

### Bug 02 — Movement Not Working
**File:** `BuggyScenes/Bug02_MovementBroken/Bug02_MovementBroken.gd`

**What happens:** Arrow keys do nothing. Error appears in the Output panel.

**Error you'll see:**
```
Invalid call. Nonexistent function 'move_and_slide' in base 'Node2D'
```

**Your task:**
- Read the error — what "base" does it mention?
- Look at the first line of the script: `extends Node2D`
- Look at the Player node type in the Scene panel
- Change the node type and the `extends` line to `CharacterBody2D`
- Add a `CollisionShape2D` child with a `RectangleShape2D`

**Concept:** Methods belong to specific classes. `move_and_slide()` only exists on `CharacterBody2D`.

---

### Bug 03 — Collision Not Firing
**Files:** `BuggyScenes/Bug03_CollisionNotFiring/`

**What happens:** Player walks through the yellow coin. Nothing happens.

**No crash** — this is a *silent* bug. The Output panel may not show any error.

**Your task:**
- Run the scene and check what the `print()` statements say about layers/masks
- Select the **Coin** node → Inspector → **Collision** section
- Compare the Layer and Mask values for Player vs Coin
- Change Coin's **Mask** to include Layer 1 (enable bit 1)

**Concept:**
- Layer = "I exist on channel X"
- Mask = "I listen to channel Y"
- For overlap to fire: one object's mask must include the other's layer

```
BEFORE:  Player layer=1  mask=1    Coin layer=2  mask=2   ← no overlap
AFTER:   Player layer=1  mask=1    Coin layer=2  mask=1   ← Coin can see Player ✓
```

---

### Bug 04 — Score Not Updating
**Files:** `BuggyScenes/Bug04_ScoreNotUpdating/`

**What happens:** Walking into the green target shows "Score is now: 1" in Output — but the label on screen stays at "SCORE: 0" forever.

**Your task:**
- Add `print("_on_score_changed called!")` at the top of `_on_score_changed()`
- Run the scene and check if that line ever prints
- If it never prints, the signal is not connected
- In `_ready()`, add: `$ScoreTarget.score_changed.connect(_on_score_changed)`
- OR: select ScoreTarget → **Node tab** → connect `score_changed` signal in the editor

**Concept:** Signals require an explicit connection. Emitting a signal nobody is listening to does nothing. One missing `connect()` = one invisible wall between event and response.

---

## 🔧 Debugging Strategies Reference

### The Debug Loop

| Step | Strategy | How |
|------|-----------|-----|
| 1. READ | Read the full error | Debugger panel (bottom of Godot) — note file + line number |
| 2. PRINT | Add print() statements | `print("variable value: ", my_var)` before and after the problem |
| 3. INSPECT | Use the Debugger panel | Run → Pause on error → hover variables in the Debugger |
| 4. ASK | Get a fresh perspective | Describe the bug out loud to a partner — this alone often reveals it |

### Useful print() patterns

```gdscript
# Check if a node reference is valid
print("player is: ", player)  # prints "Null" if get_node() failed

# Check what class/type a node is
print("node class: ", get_class())

# Check signal connections
print($Target.score_changed.get_connections())

# Check collision settings
print("layer: ", collision_layer, "  mask: ", collision_mask)

# Trace execution flow
print("--- reached line 42 ---")
```

---

## 📐 Math & Physics Connections

| Bug | Math/Physics Concept |
|-----|----------------------|
| Null Reference | Variables as named references; null as an "undefined" state |
| Wrong Node Type | Inheritance hierarchies; a method's signature includes its owning class |
| Collision Layers | Boolean bitmasks; binary AND operation; set membership |
| Signals | Event-driven programming; the Observer pattern; function references (callables) |

**Collision Layer Math:**
- Layer 1 = binary `0001` = decimal `1`
- Layer 2 = binary `0010` = decimal `2`
- Both = binary `0011` = decimal `3`
- Overlap check = `(A.layer & B.mask) != 0` — bitwise AND

---

## 🎮 Peer Playtesting — Quick Reference

After debugging, swap games with a partner. Use these prompts:

1. **What was fun?** Be specific — what moment, mechanic, or visual felt satisfying?
2. **What was confusing?** Where did you not know what to do?
3. **One suggestion:** Frame as "What if..." or "It might help if..."

**Designer rule:** Stay silent while your partner plays. Watch. Don't explain or coach.

**Playtester rule:** Narrate your thoughts out loud: "I'm not sure what this does..." "I keep dying here..."

---

## 📋 Instructor Notes

### Recommended sequence
1. Assign Bug 01 to all students (10 min) → class debrief
2. Assign Bug 02 individually (5–8 min)
3. Assign Bug 03 — most challenging; allow peer collaboration (8–10 min)
4. Assign Bug 04 (5–8 min)
5. Peer playtesting of students' own projects (15–20 min)

### Common stuck points
- **Bug 01:** Students look at the script but not the Scene tree. Prompt: "Check the Scene panel — what is the exact node name?"
- **Bug 02:** Students change the script but forget to change the node type. Both must match.
- **Bug 03:** Students may not know where to find the Collision Inspector section. Show `Select Coin → Inspector → scroll to Collision`.
- **Bug 04:** Students may try to fix ScoreTarget instead of the main scene. The target script was never broken.

### Fixed scenes
The `FixedScenes/` folder contains instructor reference implementations. Share them after the debugging activity, not before.

---

*STEM Through Games | Day 16 | Godot 4.2+*
