# Flickering Light — Godot 4.x
## Extension Challenge | Animate One Environmental Detail

One flickering light can do more for atmosphere than ten static ones.
This script turns any `PointLight2D` into a dynamic, organic light source
with a single attached script.

---

## Step-by-Step Setup

1. In your scene, add a **PointLight2D** node where you want the torch or light.
2. In the Inspector, assign a **Texture** (use Godot's built-in `GradientTexture2D`
   or any circular glow image).
3. Set **Energy** to `1.0` and pick a warm **Color** (e.g. `#FFA040` for torch orange).
4. Attach `flickering_light.gd` to the PointLight2D.
5. Press **F5** to test — the light should flicker immediately.

---

## Choosing a Preset

Open the script and uncomment one line in `_ready()` to select a preset:

| Preset | Effect | Best For |
|--------|--------|----------|
| `PRESET_TORCH` | Steady, warm, slightly alive | Normal torches, campfires |
| `PRESET_BROKEN_ELECTRIC` | Erratic, can go fully dark | Abandoned labs, horror areas |
| `PRESET_DYING_CANDLE` | Slow, fading, gentle | Quiet memorial, sad rooms |
| `PRESET_STABLE` | No flicker | Standard lights you don't want animated |

---

## Adjusting in the Inspector

Once the script is attached, you'll see these properties in the Inspector:

| Property | Effect |
|----------|--------|
| Max Energy | Brightest the light gets |
| Min Energy | Dimmest (set to 0 for "fully off" moments) |
| Flicker Interval | Seconds between brightness changes (smaller = more chaotic) |
| Flicker Step | How much it can jump per tick |

---

## Story Design Tip

Don't add flickering lights everywhere — it loses meaning. Use them strategically:

- **One flickering light** in a dark room says "this place is barely alive"
- **A broken electric light** in an abandoned lab says "something went wrong here"
- **A dying candle** near an NPC says "this person is running out of time"

The flicker is a storytelling tool, not just a visual effect.
