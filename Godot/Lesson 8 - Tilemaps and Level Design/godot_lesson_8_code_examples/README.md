# Day 8 – Tilemaps & Level Design
## STEM Through Games Program — Godot 4 Starter Project

---

## 🚀 Quick Start (Do This First!)

1. **Open Godot 4** (version 4.2 or later)
2. Click **Import** → navigate to this folder → select `project.godot` → click **Import & Edit**
3. Press **F5** (or the ▶ Play button) — you should see a blue player character you can move!

> **Controls:** A / D or ← → to move &nbsp;|&nbsp; Space, W, or ↑ to jump

---

## 📁 Project Structure

```
Day8_TileMap_Starter/
├── project.godot          ← Godot project config (open this!)
├── scenes/
│   └── World.tscn         ← Main scene: TileMap + Player + HUD
├── scripts/
│   ├── World.gd           ← Game loop, camera, HUD, debug label
│   ├── Player.gd          ← Movement, gravity, jump physics
│   ├── Coin.gd            ← Collectible — detects player, animates
│   ├── GoalZone.gd        ← Level-complete trigger
│   ├── HazardZone.gd      ← Respawn trigger
│   ├── TileSetBuilder.gd  ← Generates placeholder tiles in code (@tool)
│   └── MathChallenge.gd   ← Standalone math worksheet (run separately)
├── assets/
│   └── sprites/
│       └── icon.svg       ← Project icon
└── README.md              ← This file
```

---

## 🗺️ Your 4-Step Activity

### Step 1 — Open the Starter Project
- The scene tree is already set up: **World → TileMap, Camera2D, Player, Coin, GoalZone, HazardZone, HUD**
- Click each node to inspect its properties in the Inspector panel

### Step 2 — Paint Your Level
1. Select the **TileMap** node in the Scene Tree
2. The **TileMap editor** panel opens at the bottom of the screen
3. Select a tile from the TileSet palette (ground, wall, ceiling)
4. Paint platforms, walls, and floors based on your warm-up sketch!

> **Tile Guide:**
> | Atlas Coord | Tile Type | Has Collision? |
> |-------------|-----------|----------------|
> | (0, 0) | Ground / Platform | ✅ Yes |
> | (1, 0) | Wall | ✅ Yes |
> | (2, 0) | Ceiling | ✅ Yes |
> | (3, 0) | Decorative background | ❌ No |

### Step 3 — Check Collision Layers
- Run the scene (F5)
- Does the player land on your tiles? If not, check that the TileSet has a **Physics Layer** assigned
- Enable **Debug → Visible Collision Shapes** to see collision outlines in play mode

### Step 4 — Place Player, Coin & Goal
Move each node to match your level sketch using the **Math Connection** formula:

```
pixel_x = col × 64
pixel_y = row × 64
```

**Example:** Player starting at col 1, row 6:
```
Position.x = 1 × 64 = 64
Position.y = 6 × 64 = 384
→ Set Player position to Vector2(64, 384)
```

Select the node → Inspector → **Transform → Position** → enter the values.

---

## 🔢 Math Connection (Live Debug Label!)

While the game is running, look at the **bottom-left corner** of the screen. You'll see:

```
Grid: (col=3, row=5)   Pixel: (x=192, y=320)   [tile_size=64]
```

This updates every frame showing exactly where the player is in both coordinate systems.
**This is the formula from the lesson running in real code!** (See `World.gd` → `_process`)

---

## 🧮 Math Challenge Script

Want to check your answers to the extension questions?

1. Create a new scene: **Scene → New Scene → Other Node → Node**
2. Attach `scripts/MathChallenge.gd` to that Node
3. Press F5 — answers print to the **Output** panel

Edit the coordinates inside `_check_my_level()` to verify **your** level's tile positions.

---

## 🚀 Extension Challenges

Finished early? Try one of these:

| Challenge | What to do |
|-----------|------------|
| **Multiple Coins** | Duplicate the Coin node (Ctrl+D) and place several around your level |
| **Multiple Hazards** | Duplicate HazardZone nodes to create a longer danger section |
| **Moving Platform** | Add a Node2D, attach an AnimationPlayer, animate its position between two tiles |
| **Background Layer** | Add a second TileMap layer (TileMap → Layers panel) for decorative background tiles |
| **Coin Counter** | The HUD already tracks coins — can you add a "coins needed to open goal" mechanic? |

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Player falls through tiles | Check TileSet has a Physics Layer (TileSet editor → Physics Layers) |
| Coin doesn't disappear | Make sure the Coin node has a CollisionShape2D and collision_mask includes layer 2 |
| Goal doesn't trigger | GoalZone collision_mask must include layer 2 (Player layer) |
| TileMap panel not visible | Click the TileMap node first, then look for the panel at the bottom |
| Tiles look wrong / missing | In the TileMap inspector, check that `tile_set` is assigned |

---

## 📘 GDScript Quick Reference

```gdscript
# Variables
var speed: float = 250.0        # a decimal number
var coins: int   = 0            # a whole number
var name: String = "Player"     # text

# If / else
if is_on_floor():
    velocity.y = -JUMP_FORCE   # jump when on the ground

# Print to Output panel (great for debugging!)
print("Player position:", global_position)

# Signals — listening for events from other nodes
body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    print("Something entered!", body.name)
```

---

*STEM Through Games Program — Day 8: Tilemaps & Level Design*
*Godot 4.2+ required*
