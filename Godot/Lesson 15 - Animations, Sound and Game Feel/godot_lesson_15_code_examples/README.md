# STEM Through Games – Day 15 Starter Project
## Animations, Sound & Game Feel

---

## 📁 Project Structure

```
project/
├── project.godot          ← Godot project config (open this in Godot 4)
├── icon.svg               ← Project icon
│
├── scenes/
│   ├── Main.tscn          ← Main level (run this to play)
│   ├── Player.tscn        ← Player character scene
│   └── Coin.tscn          ← Collectible coin scene
│
├── scripts/
│   ├── Player.gd          ← Player movement + animation + sound logic
│   ├── Coin.gd            ← Coin collect animation + sound
│   ├── Main.gd            ← Level manager (score, music, mute toggle)
│   ├── MusicManager.gd    ← Autoload: background music + crossfade
│   └── AnimationHelper.gd ← Math utility: FPS calculations (teaching tool)
│
├── audio/                 ← ADD YOUR AUDIO FILES HERE
│   └── (empty — see Audio Setup below)
│
└── sprites/               ← ADD YOUR SPRITE SHEETS HERE
    └── (empty — see Sprite Setup below)
```

---

## 🚀 Getting Started

### Step 1: Open in Godot 4
1. Download and install **Godot 4.2+** from https://godotengine.org
2. Open Godot → **Import** → navigate to this folder → select `project.godot`
3. Click **Import & Edit**

### Step 2: Add Sprite Frames
The Player and Coin scenes have AnimatedSprite2D nodes ready, but need sprite images:

1. Find free sprites at:
   - **Kenney.nl** → "Platformer Pack" (free, no attribution required)
   - **opengameart.org** → search "platformer character"
2. Drag your image files into `res://sprites/`
3. Click `Player` → `AnimatedSprite2D` → `SpriteFrames`
4. For each animation (idle, run, jump, fall, hurt):
   - Click the animation name
   - Drag frames from the FileSystem panel into the animation

### Step 3: Add Audio Files
The scripts are wired up — you just need to plug in sound files:

1. Find free sounds at:
   - **freesound.org** (free with account)
   - **Kenney.nl** → "Interface Sounds" or "Impact Sounds"
   - **opengameart.org** → search "platformer sfx"
2. Drag `.wav` or `.ogg` files into `res://audio/`
3. In the **Player scene**, click each AudioStreamPlayer node:
   - `JumpSound`  → drag `jump.wav` into the Stream field
   - `LandSound`  → drag `land.wav`
   - `HurtSound`  → drag `hurt.wav`
4. In the **Coin scene**, click `CoinSound`:
   - Drag `coin_collect.wav` into Stream
5. In **Main scene**, click `BGMusic`:
   - Drag `bg_music.ogg` into Stream
   - Set `Autoplay` to **On**

---

## 🎮 Controls

| Key | Action |
|-----|--------|
| A / ← | Move left |
| D / → | Move right |
| Space / ↑ | Jump |
| M | Toggle audio mute (for silent vs. sound activity) |
| R | Restart level |

---

## 📐 Math Challenge (from Day 15)

Run `AnimationHelper.print_animation_report()` from any `_ready()` function
to print the full FPS timing breakdown to the console.

```gdscript
func _ready() -> void:
    AnimationHelper.print_animation_report()
```

Expected output:
```
═══════════════════════════════════════
  Animation Timing Report – Day 15
═══════════════════════════════════════
  IDLE:
    Frames: 4   |   FPS: 6.0
    Loop duration : 0.667 seconds
    Distance/loop : 133.3 pixels  (at 200 px/sec)
  ───────────────────────────────────────
  RUN:
    Frames: 8   |   FPS: 12.0
    Loop duration : 0.667 seconds
    Distance/loop : 133.3 pixels  (at 200 px/sec)
  ...
```

---

## 🔊 MusicManager Autoload Setup

For background music to persist across scenes:

1. **Project → Project Settings → Autoload**
2. Click the folder icon → select `res://scripts/MusicManager.gd`
3. Set Node Name: `MusicManager`
4. Click **Add**

Then from any script:
```gdscript
MusicManager.play_track(preload("res://audio/bg_music.ogg"))
MusicManager.play_track(preload("res://audio/boss.ogg"), true)  # crossfade
MusicManager.set_volume(0.5)                                     # 50% volume
MusicManager.stop()                                              # fade out
```

---

## 🧩 Extension Challenges

### Easy
- Change the `SPEED` and `JUMP_FORCE` constants in `Player.gd` and observe how it affects game feel
- Adjust animation FPS values and discuss how it changes character personality
- Change `CoinSound.pitch_scale` from 1.0 to 1.5 — does it feel more or less rewarding?

### Medium
- Add a 4th animation state: `land` — plays for 0.1 seconds when the player touches the ground
- Make coins bob up and down using a `Tween` node
- Add a second `BGMusic` track and switch between them based on player position

### Hard
- Implement a combo counter: collect coins within 2 seconds of each other for bonus points
- Use `AudioStreamPlayer.pitch_scale` to increase coin pitch with each consecutive collection
- Create an `Enemy.gd` script that calls `player.take_hurt()` on contact

---

## 📋 Day 15 Objectives Checklist

- [ ] Added sprites to AnimatedSprite2D in the Player scene
- [ ] Set FPS for idle, run, and jump animations
- [ ] Confirmed sprite flip works when moving left
- [ ] Added jump.wav to JumpSound node
- [ ] Added coin_collect.wav to CoinSound node  
- [ ] Added bg_music.ogg to BGMusic node with Autoplay=On
- [ ] Played the scene with audio muted (M key) vs. unmuted
- [ ] Completed the FPS math worksheet problems
- [ ] Answered reflection prompt: What emotion does your game create?
