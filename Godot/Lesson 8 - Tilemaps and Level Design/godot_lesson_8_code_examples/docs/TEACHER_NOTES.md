# Teacher Setup Notes — Day 8 Starter Project

## Before Class: One-Time Setup (5 minutes)

1. **Install Godot 4.2+** on all student machines
   - Download free from https://godotengine.org/download
   - No installation needed — it's a single executable file

2. **Distribute the project folder**
   - Copy `Day8_TileMap_Starter/` to each student's Desktop (or shared drive)
   - Students open Godot → Import → navigate to the folder → select `project.godot`

3. **Verify it runs**
   - Press F5 — a dark window should appear with a blue player that can move and jump
   - If tiles aren't visible, that's expected! The TileMap starts empty for students to paint

---

## What the TileSet Situation Is

This project uses **colored rectangle placeholder tiles** generated in code
(see `TileSetBuilder.gd`). This was done intentionally so no image files are needed.

**The TileSet must be built once:**

Option A — Run `TileSetBuilder.gd` as a `@tool` script:
1. Open `World.tscn`
2. Add a new Node child to TileMap
3. Attach `TileSetBuilder.gd`
4. The TileSet will be generated and assigned automatically in the Editor

Option B — Create a simple TileSet manually:
1. Select the TileMap node → Inspector → TileSet → New TileSet
2. TileSet editor opens at the bottom → Add a TileSetAtlasSource
3. Add a Physics Layer → paint a full-tile collision shape on each solid tile

**Recommended approach for class:** Demo Option B in the first 5 minutes as part of
the "Direct Instruction" segment — it reinforces the lesson content directly.

---

## Scripts Overview for Teachers

| Script | What students will read | Lesson connection |
|--------|------------------------|-------------------|
| `World.gd` | `grid_to_pixel()` and `pixel_to_grid()` functions; debug label formula | Math Connection |
| `Player.gd` | Gravity + jump velocity comments; `get_grid_position()` | Preview for Day 9 |
| `Coin.gd` | Area2D signals; `_get_grid_pos()` | Signals / Events |
| `GoalZone.gd` | `body_entered` signal; pulse animation | Design — clear goal feedback |
| `HazardZone.gd` | Respawn pattern; cooldown guard | Design — fair hazard placement |
| `MathChallenge.gd` | All four extension problems with printed answers | Math Connection exit ticket |

---

## Live Debug Label (Great for Class Discussion!)

While the game runs, the HUD shows:
```
Grid: (col=3, row=5)   Pixel: (x=192, y=320)   [tile_size=64]
```

Walk the player to different tiles and ask:
- "What column are we on now?"
- "What should pixel_x be? Let's check the formula."
- "If I move one tile right, pixel_x increases by how much?"

This makes the abstract formula immediately concrete.

---

## Differentiation Tips

**Support students:** Pre-paint a simple ground row (cols 0–15, row 7) before class so
they start with something functional and focus on adding platforms and collectibles.

**Extension students:** Point them to the comments at the bottom of `Player.gd` and
`World.gd` labelled `STUDENT EXTENSION` — these suggest scripting moving platforms,
a coin-unlock mechanic, and parallax backgrounds.
