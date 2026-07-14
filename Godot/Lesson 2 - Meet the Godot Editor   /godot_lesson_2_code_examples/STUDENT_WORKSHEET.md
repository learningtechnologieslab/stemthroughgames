# Day 2 — Coordinate Explorer: Student Worksheet
**Name:** _______________________   **Date:** _______________   **Period:** _______

---

## Part 1 — Warm-Up Review (before opening Godot)

Draw a coordinate plane in the box below. Plot these five points and connect them:

```
A(2, 3)    B(−1, 4)    C(−3, −2)    D(4, −1)    E(0, 0)
```

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│                              ↑ Y                             │
│                              │                               │
│                              │                               │
│                              │                               │
│  ──────────────────────────(0,0)──────────────────────────→  │
│                              │                          X    │
│                              │                               │
│                              │                               │
│                              │                               │
└──────────────────────────────────────────────────────────────┘
```

**Q1.** What is the point (0, 0) called? _______________________

**Q2.** If you moved point A one unit to the RIGHT, its new coordinates would be: ( _____ , _____ )

---

## Part 2 — Exploring Godot (open `main.tscn` and run)

### Section A — The Four Panels

Label each panel with its name: *Scene Panel, Inspector, Viewport, FileSystem*

```
┌──────────┬──────────────────────────────┬──────────────┐
│          │                              │              │
│          │                              │              │
│  (1)___  │          (2) ___             │  (3) ___     │
│          │                              │              │
│          │                              │              │
├──────────┴──────────────────────────────┤              │
│                                         │              │
│  (4) _______________________________    │              │
└─────────────────────────────────────────┴──────────────┘
```

### Section B — Position Experiments

Move the robot to each position below. Record what you observe.

| Position | How to get there | What do you see? | Which part of the screen? |
|----------|-----------------|-----------------|--------------------------|
| (0, 0) | Press 0 key | | |
| (512, 300) | Press R key | | |
| (1024, 600) | Click bottom-right | | |
| (0, 600) | Click bottom-left | | |
| Your choice: ( ___ , ___ ) | | | |

**Q3.** In Godot, the origin (0, 0) is in the _________________ corner of the screen.
In math class, the origin is usually _________________.

**Q4.** When you pressed the **DOWN arrow**, did the Y value go UP or DOWN? __________
Is this the same or different from math class? _________________________

---

## Part 3 — Vector2 Code

Open `scripts/sandbox.gd`. Find the line that says:
```
my_sprite.position = Vector2(512, 300)
```

Change it to each value below, press **F5**, and record the result.

| Code | Where did the sprite appear? |
|------|------------------------------|
| `Vector2(0, 0)` | |
| `Vector2(1024, 0)` | |
| `Vector2(0, 600)` | |
| `Vector2(512, 300)` | |
| `Vector2(256, 150)` | |
| Your own choice: `Vector2( ___ , ___ )` | |

**Q5.** Write the `Vector2` code to place the sprite **exactly in the center** of the screen.
(The screen is 1024 pixels wide and 600 pixels tall.)

```gdscript
my_sprite.position = Vector2( _______ , _______ )
```

Show your math: Center X = 1024 ÷ 2 = _______    Center Y = 600 ÷ 2 = _______

---

## Part 4 — Coordinate Grid Investigation

Use the Coordinate Explorer (main scene) and press **G** to toggle the grid.

**Q6.** The grid lines are spaced **50 pixels** apart. If the screen is 1024 pixels wide,
how many vertical grid lines fit on the screen?

```
1024 ÷ 50 = _________ (approximately)
```

**Q7.** A star is at position (800, 100). Without moving the robot, describe where on
the screen you would expect to find it:

_____________________________________________________________________________

**Q8.** The robot is at (200, 400). Another object is at (500, 400).
What is the horizontal distance between them? (Hint: they have the same Y!)

```
Distance = 500 − 200 = _________  pixels
```

---

## Part 5 — Comparison: Math vs. Godot

Complete this table based on what you discovered today:

| Feature | Math Coordinate Plane | Godot Screen |
|---------|----------------------|--------------|
| Where is (0, 0)? | | |
| Y increases toward... | ↑ UP | |
| X increases toward... | → RIGHT | |
| Can Y be negative? | Yes | |

---

## Part 6 — Exit Ticket

Answer these three questions on your exit slip before you leave:

**1.** In Godot, which corner of the screen is position (0, 0)?

___________________________________________________________________________

**2.** A sprite is at position (200, 100). You add 50 to its Y value.
Does the sprite move UP or DOWN on the screen? Why?

___________________________________________________________________________

___________________________________________________________________________

**3.** Write one line of GDScript that places a sprite at the center
of a 1024 × 600 screen:

```gdscript


```

---

## Extension (Fast Finisher)

Open `sandbox.gd` and complete **Extension Challenge A**:

Add this code to the `_process()` function and see what happens:
```gdscript
func _process(delta):
    my_sprite.position.x += 80 * delta
```

**Q9.** What happens when the sprite reaches the right edge? ___________________

**Q10.** How would you modify the code to make the sprite bounce back?
(Hint: what would you need to check about its `position.x` value?)

___________________________________________________________________________

___________________________________________________________________________
