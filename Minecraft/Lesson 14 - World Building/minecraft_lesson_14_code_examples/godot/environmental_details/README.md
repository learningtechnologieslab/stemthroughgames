# Environmental Details — Godot 4.x
## World Atmosphere via Code | Part B, Task 1 + Extension

This script gives you three code-based tools for making your Minecraft or Godot world
feel like it has a history. These are all **non-dialogue** techniques — pure visual
storytelling through color, placement, and animation.

---

## The Three Techniques

### 1. Mood Tinting
Apply a color tint to any sprite, tilemap layer, or background to set the
emotional tone of a space instantly.

```
apply_mood_tint($Background, MOOD_COLD)    # lonely, eerie
apply_mood_tint($Background, MOOD_DANGER)  # dangerous, corrupted
apply_mood_tint($Background, MOOD_WARM)    # cozy, nostalgic
```

### 2. Random Debris Scattering
Takes a group of sprite nodes placed roughly in position and applies tiny random
offsets and rotations so they look naturally scattered — not copy-pasted.

```
scatter_debris($RubbleGroup.get_children())
```

### 3. Danger Pulse
Slowly pulses a node red using a sine wave. Tells the player "danger" without
a single word.

```
enable_danger_pulse($HazardZone)
```

---

## Step-by-Step Setup

### Option A — Add to an existing Level script
If your Level node already has a script attached:

1. Copy the three functions (`apply_mood_tint`, `scatter_debris`, `enable_danger_pulse`)
   and the pulse variables into your existing script.
2. Call the functions from your `_ready()` function.
3. Make sure `_process(delta)` is either copied in or already present.

### Option B — Add as a separate node
1. Add a new **Node2D** to your scene. Rename it `WorldDetails`.
2. Attach `environmental_details.gd` to it.
3. Call its functions from your Level's `_ready()` using `$WorldDetails.apply_mood_tint(...)`.

---

## Design Tips for Students

| You Want To Show... | Use This Mood Color |
|---------------------|---------------------|
| Danger / combat zone | `MOOD_DANGER` (red) |
| Abandoned / forgotten place | `MOOD_GREY` |
| Ancient / magical ruins | `MOOD_COLD` (blue) |
| Poisoned / corrupted area | `MOOD_CORRUPT` (green) |
| Warm home or memory | `MOOD_WARM` (amber) |

**Debris scattering tip:** Place your Sprite2D debris nodes in the *approximate*
location you want them, then let the scatter function add natural variation. You're
designing the cluster, the code adds the personality.
