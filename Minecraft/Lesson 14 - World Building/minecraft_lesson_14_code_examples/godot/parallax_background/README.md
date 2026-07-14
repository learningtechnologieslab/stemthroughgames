# Parallax Background — Godot 4.x
## Extension Challenge | Add Depth to Your World

A parallax background is one of the most powerful atmospheric tools in 2D game
design. Far objects scroll slowly; close objects scroll fast. The result: a world
that feels physically real and vast — completely without words.

---

## Step-by-Step Setup

### Step 1 — Create the node tree
Add these nodes to your scene (in this exact parent-child order):

```
ParallaxBackground
├── FarLayer (ParallaxLayer)
│   └── FarSprite (Sprite2D)        ← your distant sky/mountain art
├── MidLayer (ParallaxLayer)
│   └── MidSprite (Sprite2D)        ← mid-distance details
└── NearLayer (ParallaxLayer)
    └── NearSprite (Sprite2D)       ← foreground details (optional)
```

> **Naming matters:** The node names `FarLayer`, `MidLayer`, `NearLayer` must match
> exactly, or change the names in the script to match yours.

### Step 2 — Add art to each layer
- Each `Sprite2D` gets a texture (your background art).
- Far layer: simple silhouettes, low detail (mountains, skyline, tree line)
- Mid layer: more detail (ruined buildings, tree canopy, cliff face)
- Near layer: high detail foreground (grass, broken fence, rubble)

### Step 3 — Attach the script
Attach `parallax_background.gd` to the **ParallaxBackground** node.

### Step 4 — Set mirroring width
In the script, change `1024` to the pixel width of your widest background sprite.
This is what makes the background tile seamlessly as the camera moves.

---

## What Makes a Good Parallax Background?

| Layer | Art Style | What It Communicates |
|-------|-----------|----------------------|
| Far | Soft, desaturated silhouettes | Scale — how big is this world? |
| Mid | Semi-detailed, medium contrast | Setting — what kind of place is this? |
| Near | Sharp, high contrast details | Story — what happened here recently? |

**Design tip:** Your near-layer details are prime real estate for environmental
storytelling. A broken fence post, dead vines, a fallen sign — these are the
details players notice as they move, placed exactly where the camera shows them.
