# Day 15 — Animations, Sound & Game Feel
## STEM Through Games · Minecraft Edition

This folder contains all the code examples for Day 15. There are two
components to install: a **resource pack** (handles custom sounds) and a
**datapack** (handles the command logic that triggers those sounds).

---

## 📁 Folder Structure

```
day15_minecraft/
│
├── resourcepack/                  ← Drop into .minecraft/resourcepacks/
│   ├── pack.mcmeta                  Pack metadata (required by Minecraft)
│   └── assets/minecraft/
│       ├── sounds.json              Defines all custom sound events
│       └── sounds/custom/           ← PUT YOUR .ogg AUDIO FILES HERE
│           ├── footstep.ogg
│           ├── footstep_soft.ogg
│           ├── jump.ogg
│           ├── land.ogg
│           ├── collect.ogg
│           ├── hurt.ogg
│           └── theme.ogg
│
├── datapack/                      ← Drop into world/datapacks/
│   ├── pack.mcmeta
│   └── data/
│       ├── minecraft/tags/functions/
│       │   ├── load.json            Registers load.mcfunction
│       │   └── tick.json            Registers tick.mcfunction (runs every tick)
│       └── day15/functions/
│           ├── load.mcfunction      ← Runs once on /reload
│           ├── tick.mcfunction      ← Runs 20x per second (the game loop)
│           ├── setup.mcfunction     ← Teacher runs this once per world
│           ├── sounds/
│           │   ├── footstep.mcfunction
│           │   ├── jump.mcfunction
│           │   ├── land.mcfunction
│           │   └── collect.mcfunction
│           ├── music/
│           │   ├── play.mcfunction
│           │   └── stop.mcfunction
│           ├── demo/
│           │   ├── silent_mode.mcfunction   ← Version 1 (warm-up activity)
│           │   └── sound_mode.mcfunction    ← Version 2 (warm-up activity)
│           └── extension/
│               ├── hurt.mcfunction          ← Extension challenge A
│               └── biome_music.mcfunction   ← Extension challenge B
│
└── math_worksheet.md              ← Print-ready FPS & Ticks worksheet
```

---

## 🚀 Installation (Step-by-Step)

### Step 1 — Get audio files

You need `.ogg` audio files for each sound event. Free sources:

| Site | What to search |
|------|----------------|
| [freesound.org](https://freesound.org) | "footstep", "jump", "coin collect" |
| [opengameart.org](https://opengameart.org) | chiptune, 8-bit music |
| [kenney.nl](https://kenney.nl/assets) | "interface sounds", "impact sounds" |

> **Converting audio:** Minecraft requires `.ogg` format. If you have `.mp3`
> or `.wav` files, use [Audacity](https://www.audacityteam.org/) (free) to
> export as OGG Vorbis.

Place your `.ogg` files inside `resourcepack/assets/minecraft/sounds/custom/`.
The filenames must exactly match what's listed in `sounds.json`.

---

### Step 2 — Install the resource pack

1. Open Minecraft → **Options** → **Resource Packs**
2. Click **Open Pack Folder**
3. Copy the entire `resourcepack/` folder into that location
4. Back in Minecraft, move "Day 15" from the left column to the right (active) column
5. Click **Done**

> ✅ **Test it:** Open chat and type:
> `/playsound custom.jump player @s`
> You should hear your jump sound immediately.

---

### Step 3 — Install the datapack

1. Create or open a **Singleplayer world** (or use your class server)
2. Navigate to your world's save folder:
   - Windows: `%appdata%\.minecraft\saves\YOUR_WORLD_NAME\`
   - Mac: `~/Library/Application Support/minecraft/saves/YOUR_WORLD_NAME/`
3. Open the `datapacks/` folder inside your world
4. Copy the entire `datapack/` folder there
5. Back in Minecraft, run `/reload`

> ✅ **Test it:** You should see the green confirmation message:
> `[Day 15] Scoreboards loaded! Sound system ready.`

---

### Step 4 — Run the world setup

Once the datapack is loaded, run this command **once** in-game:

```
/function day15:setup
```

This will:
- Create the coin-pickup scoreboard
- Spawn some gold nuggets nearby to test
- Start the background music
- Print a checklist confirming everything worked

---

## 🎮 In-Class Usage Guide

### Warm-Up Activity (0–10 min)

Switch between Version 1 and Version 2 for the class comparison demo:

```
/function day15:demo/silent_mode     ← Version 1: all custom sounds off
/function day15:demo/sound_mode      ← Version 2: all sounds enabled
```

Walk around, jump, and collect gold nuggets in each mode.
Ask students: *"What specifically felt different? List 3 things."*

---

### Main Activity (25–50 min)

Students work in their own worlds. The sound system runs automatically
once the datapack and resource pack are installed.

**Sound trigger reference:**

| Action | What triggers it |
|--------|-----------------|
| Walking | `motion` scoreboard detects movement |
| Jumping | `OnGround:0b` NBT tag (player is airborne) |
| Landing | `was_jumping=1` flag + `OnGround:1b` |
| Collecting | `nuggets_collected` scoreboard ticks up |
| Music | Manual: `/function day15:music/play` |

---

### Math Connection (50–65 min)

Print `math_worksheet.md` or display it on screen. Key formulas:

```
Loop Time (seconds) = Frames ÷ FPS

Seconds = Ticks ÷ 20
Ticks   = Seconds × 20
```

The footstep cooldown in `sounds/footstep.mcfunction` is set to **6 ticks**.
Ask students to calculate: *How many seconds is that?* (Answer: 0.3 sec)

Then have them experiment: change the `6` to `3` or `10` and describe
how it changes the feel of movement.

---

## 🔧 How the Code Works

### The Game Loop

Minecraft runs `tick.mcfunction` exactly **20 times per second**. This is
your game loop — similar to `_physics_process()` in Godot.

```
tick.mcfunction
 ├── sounds/footstep.mcfunction    Check if player is walking
 ├── sounds/jump.mcfunction        Check if player just left the ground  
 ├── sounds/land.mcfunction        Check if player just landed
 ├── sounds/collect.mcfunction     Check if player picked up a nugget
 ├── (decrement all cooldown timers)
 └── (reset motion tracker)
```

### State Machine: The Jump

The jump logic is a classic **two-state machine**:

```
State 0 (GROUNDED):  was_jumping = 0
  → If player goes airborne: play sound, set was_jumping = 1 → State 1

State 1 (AIRBORNE):  was_jumping = 1
  → If player lands: play land sound, set was_jumping = 0 → State 0
```

This ensures the jump sound plays exactly **once** per jump, not every
tick the player is in the air.

### Cooldown Timers

Without a cooldown, footstep sounds would play 20 times per second —
way too fast. The `step_cooldown` scoreboard acts like a timer:

```
Tick 1:   Player walks → play sound → set step_cooldown = 6
Tick 2:   step_cooldown = 5 (decremented, sound skipped)
Tick 3:   step_cooldown = 4
Tick 4:   step_cooldown = 3
Tick 5:   step_cooldown = 2
Tick 6:   step_cooldown = 1
Tick 7:   step_cooldown = 0 → play sound again if still walking
```

**Math connection:** 6 ticks ÷ 20 ticks/sec = **0.3 seconds** between steps.

---

## 🧩 Extension Challenges

### Challenge A — Hurt State

Open `extension/hurt.mcfunction`. This adds a particle + sound effect
when the player takes damage.

**To activate:** Add this line to `tick.mcfunction`:
```
function day15:extension/hurt
```

**Setup required** (run once):
```
/scoreboard objectives add damage_taken minecraft.custom:damage_taken
```

### Challenge B — Biome Music

Open `extension/biome_music.mcfunction`. This plays different music
depending on which biome the player is in.

**To activate:** Add this line to `tick.mcfunction`:
```
function day15:extension/biome_music
```

**Extra sounds needed** in `sounds.json` and your audio folder:
- `custom.theme_tense` (underground/cave music)

### Challenge C — 10-Coin Fanfare *(design your own)*

Modify `sounds/collect.mcfunction` to track total coins collected.
When the player reaches 10, play a special fanfare sound.

**Hint:** You'll need a second scoreboard that adds 1 each time a coin
is collected, and a condition: `scores={total_nuggets=10..}`.

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| No sounds play at all | Check that the resource pack is active in Options → Resource Packs |
| "No such sound" error | Make sure your `.ogg` files are in `sounds/custom/` and filenames match `sounds.json` |
| Sounds play but footsteps don't stop | Check that `tick.mcfunction` includes the `scoreboard players set @a motion 0` reset line |
| Datapack not loading | Run `/reload` after placing the folder, then check for the green confirmation message |
| Music doesn't loop | Add `"stream": true` to the sound entry in `sounds.json`, then re-enable the resource pack |
| Command errors on older version | This pack targets **Java Edition 1.20+** (pack_format 18/26). Check your Minecraft version. |

---

## 📋 Quick Command Reference

```bash
# Load / reload everything
/reload

# One-time world setup
/function day15:setup

# Warm-up demo
/function day15:demo/silent_mode
/function day15:demo/sound_mode

# Music controls
/function day15:music/play
/function day15:music/stop

# Test a specific sound manually
/playsound custom.footstep player @s
/playsound custom.jump player @s
/playsound custom.collect player @s
/playsound custom.theme music @s

# Debug: view scoreboard values
/scoreboard players list @s
```

---

## 🔗 Free Audio Resources

- **[freesound.org](https://freesound.org)** — Large library of CC-licensed sound effects
- **[opengameart.org](https://opengameart.org)** — Music and SFX specifically for games
- **[kenney.nl](https://kenney.nl/assets)** — High-quality free game asset packs (highly recommended for class use)
- **[Audacity](https://www.audacityteam.org/)** — Free audio editor for converting and trimming files

---

*Day 15: Animations, Sound & Game Feel · STEM Through Games · Minecraft Edition*
