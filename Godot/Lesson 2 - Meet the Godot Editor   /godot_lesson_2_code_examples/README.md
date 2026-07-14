# STEM Through Games — Day 2: Coordinate Explorer
## Godot 4 Starter Project

A hands-on Godot 4 project for **Day 2** of the STEM Through Games program.
Students explore 2D coordinate systems by moving a robot sprite around a
grid-lined canvas, collecting stars, and editing GDScript directly.

---

## 📦 How to Open This Project

1. Download and install **Godot 4** (free) from https://godotengine.org
2. Launch Godot → click **Import**
3. Navigate to this folder and select `project.godot`
4. Click **Import & Edit**
5. Press **F5** (or the ▶ Play button) to run

> **Godot version:** Tested on Godot 4.3+  
> **Renderer:** GL Compatibility (works on all hardware)

---

## 🗂️ Project Structure

```
godot_day2/
├── project.godot          ← Godot project config (open this to import)
├── scenes/
│   ├── main.tscn          ← Main scene: Coordinate Explorer
│   └── sandbox.tscn       ← Student sandbox: free experimentation
├── scripts/
│   ├── main.gd            ← Explorer logic (grid, UI, star collection)
│   ├── player.gd          ← Robot movement (arrow keys / WASD)
│   ├── sandbox.gd         ← Sandbox with student TODO challenges
│   └── coord_label.gd     ← UI label helper
└── assets/
    └── sprites/
        ├── player.svg     ← Robot character
        ├── star.svg       ← Collectible star
        ├── target.svg     ← Challenge target marker
        └── dot.svg        ← Grid helper dot
```

---

## 🎮 Scene 1 — Coordinate Explorer (`main.tscn`)

The main learning scene. Features:

| Feature | Description |
|---------|-------------|
| **Live coordinate display** | Shows the robot's exact X and Y position in real time |
| **Visual grid** | 50px grid with axis labels at edges |
| **Stars to collect** | 5 stars placed at specific positions — students move to collect |
| **Target marker** | A red target; the panel shows the pixel distance to it |
| **Quadrant display** | Shows which screen region the robot is currently in |
| **Click to teleport** | Click anywhere on the screen to instantly move the robot there |

### Keyboard Controls

| Key | Action |
|-----|--------|
| **Arrow Keys / WASD** | Move the robot |
| **Click** | Teleport robot to click position |
| **R** | Reset robot to center (512, 300) |
| **T** | Move target to a new random position |
| **G** | Toggle the coordinate grid on/off |
| **0** | Jump to (0, 0) — top-left corner |
| **1** | Jump to (512, 300) — center |

---

## 🧪 Scene 2 — Sandbox (`sandbox.tscn`)

A minimal scene where students edit `scripts/sandbox.gd` directly.

### Student TODOs in `sandbox.gd`

1. **TODO 1** — Change the `Vector2(x, y)` in `_ready()` to move the sprite  
2. **TODO 2** — Calculate the correct position for a quarter/three-quarter placement  
3. **Extension A** — Animate the sprite with `_process()` and `delta`  
4. **Extension B** — Place three sprites in a diagonal line  
5. **Extension C** — Visit all four corners and record the coordinates  

### Sandbox Keyboard Shortcuts

| Key | Position | Location |
|-----|----------|----------|
| **1** | (0, 0) | Top-left corner |
| **2** | (1024, 0) | Top-right corner |
| **3** | (0, 600) | Bottom-left corner |
| **4** | (1024, 600) | Bottom-right corner |
| **5** | (512, 300) | Center |
| **R** | (512, 300) | Reset to center |
| **Space** | Runs TODO 2 code | Student challenge |

---

## 📐 Math Concepts Covered

| Godot Concept | Math Connection |
|---------------|-----------------|
| `position = Vector2(x, y)` | Ordered pairs on a coordinate plane |
| X increases right | Same as math class |
| Y increases **downward** | **Opposite** from math class! |
| `(0, 0)` = top-left | Origin location differs by context |
| `distance_to()` | Pythagorean theorem / distance formula |
| `clamp(value, min, max)` | Restricting a value to a range |

---

## 🛠️ Teacher Notes

### Quick Demo Flow (matches lesson plan)
1. Open project → run → point out the four panels
2. Press arrow keys — watch X/Y numbers change in the panel
3. Ask: "When I press DOWN, does Y go up or down?" (it goes UP — it increases)
4. Press **G** to toggle the grid — show where lines cross
5. Click a spot — show how the numbers jump to that position
6. Open `sandbox.gd` in the Godot script editor — start TODO 1 together

### Modifying for Your Class
- **Change window size:** Edit `project.godot` → `window/size/viewport_width` and `viewport_height`
- **Change star positions:** Open `main.tscn` in the editor → click each `Star` node → edit `Position` in the Inspector
- **Change robot speed:** Open `player.gd` → change the `SPEED` constant at the top
- **Add more stars:** Duplicate an existing Star node in the Scene panel

### Common Student Issues
| Problem | Fix |
|---------|-----|
| Script errors on open | Make sure you're using Godot 4.3 or later |
| Robot won't move | Click the Godot viewport first to give it focus |
| SVG textures show as white boxes | Re-import assets: Project → Reimport All |

---

## 📄 License
Created for educational use. Free to modify and distribute for classroom use.
