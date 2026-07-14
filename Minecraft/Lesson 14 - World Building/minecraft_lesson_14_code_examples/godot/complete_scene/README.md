# Complete Scene — Godot 4.x
## All Techniques Together | Teacher Demo / Advanced Students

This folder shows how all four Day 14 tools work together in a single scene:
mood tinting, debris scattering, flickering light, NPC dialogue, and parallax background.

---

## Quick Start

1. Build the node tree shown in `complete_scene.gd`'s header comment.
2. Attach `complete_scene.gd` to the **Level** (root Node2D).
3. Attach `../npc_dialogue/npc_dialogue.gd` to the **NPC** (Area2D).
4. Attach `../flickering_light/flickering_light.gd` to the **Torch** (PointLight2D).
5. In the Inspector for the Level node, set **World Type** to one of:
   - `abandoned_lab`
   - `ancient_temple`
   - `flooded_city`
   - `danger_zone`
   - `safe_haven`
6. Press **F5** — the mood tint, scattered debris, and parallax will apply automatically.

---

## How the Scripts Connect

```
Level (complete_scene.gd)
│  → sets mood tint on Background + ParallaxBackground
│  → scatters RubbleGroup children
│  → configures ParallaxBackground layers
│
├── NPC (npc_dialogue.gd)
│      → handles its own dialogue show/hide independently
│
└── Torch (flickering_light.gd)
       → handles its own flicker independently
```

Each script is **independent** — they don't call each other. The Level script
handles world-level setup; the NPC and Torch each manage their own behavior.
This is a core software design principle: **separation of concerns**.

---

## Changing the World Type

The `world_type` property in the Inspector drives the mood color:

| world_type | Color Effect | Narrative Feel |
|------------|-------------|----------------|
| `abandoned_lab` | Cold blue-white | Clinical, eerie, something went wrong |
| `ancient_temple` | Warm amber | Old, sacred, long-forgotten |
| `flooded_city` | Blue-green | Submerged, hopeless, changed forever |
| `danger_zone` | Warning red | Hostile, corrupted, don't stay long |
| `safe_haven` | Warm gold | Shelter, calm, a place worth protecting |

---

## For Teachers: Demo Script

Use this scene to walk students through the "Show Don't Tell" concept:

1. Set `world_type = "safe_haven"` — *"This world feels safe. Why? We haven't said anything."*
2. Change to `world_type = "danger_zone"` — *"Same room. Same words. Completely different story."*
3. Point out the debris scatter — *"Notice how the rubble looks natural, not copy-pasted."*
4. Walk into the NPC zone — *"The NPC tells us lore, not instructions."*
5. Watch the torch — *"One flickering light. What does that say about this place?"*

The lesson: **every element is a storytelling choice**.
