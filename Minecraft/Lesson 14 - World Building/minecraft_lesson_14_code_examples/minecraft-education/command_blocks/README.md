# Command Block Sequences — Minecraft Education Edition
## Extension Challenge | Atmospheric Effects via Commands

Command blocks let you run Minecraft commands automatically — triggered by
players entering an area, on a timer, or chained in sequence.

This guide covers atmospheric commands that serve environmental storytelling:
setting the time of day, changing weather, playing sounds, and spawning particles.

---

## Getting a Command Block

Command blocks can't be found in the normal inventory. Use this command:
```
/give @p command_block 1
```

Place it in the world and right-click to enter a command.

---

## Command Block Types

| Type | Color | What It Does |
|------|-------|-------------|
| **Impulse** (default) | Orange | Runs once when powered (by button, lever, or redstone) |
| **Chain** | Green | Runs after the previous block in the chain runs |
| **Repeat** | Purple | Runs every game tick while powered (use for continuous effects) |

---

## Atmospheric Command Reference

### TIME OF DAY

Set the world to a specific time when the player arrives in an area.
Tie this to a pressure plate at the entrance.

```
# Dawn — hope, new beginning, journey starting
/time set 23000

# Noon — clarity, safety, neutral
/time set 6000

# Sunset — melancholy, something ending
/time set 12000

# Night — danger, mystery, unknown
/time set 18000

# Always day (disables day/night cycle entirely — good for safe areas)
/gamerule doDaylightCycle false
/time set 6000

# Re-enable the cycle when the player leaves
/gamerule doDaylightCycle true
```

---

### WEATHER

Weather is one of the most powerful mood tools in Minecraft.

```
# Clear skies — safety, peace, hope
/weather clear

# Rain — sadness, tension, something wrong
/weather rain

# Thunderstorm — danger, fear, climax
/weather thunder

# Set weather duration in seconds (300 = 5 minutes)
/weather rain 300
```

---

### SOUND EFFECTS

Play an ambient sound at the player's location to set atmosphere.
Use a Repeat command block to loop a sound continuously in an area.

```
# Creepy cave ambience — abandoned underground areas
/playsound ambient.cave @a ~ ~ ~ 1 1

# Underwater ambience — flooded areas
/playsound ambient.underwater.loop @a ~ ~ ~ 0.8 1

# Nether ambience — corrupted or hellish areas
/playsound ambient.nether.wastes.loop @a ~ ~ ~ 0.5 1

# Rain sound — even indoors, to emphasize isolation
/playsound weather.rain @a ~ ~ ~ 0.6 1

# Wind — open, lonely places
/playsound ambient.basalt_deltas.loop @a ~ ~ ~ 0.4 1

# Distant thunder — impending danger
/playsound ambient.cave @a ~ ~ ~ 1.5 0.5

# Stop all sounds (use when leaving an area)
/stopsound @a
```

**Command syntax explained:**
- `@a` = affects all players
- `~ ~ ~` = at the player's current position
- The 4th number is **volume** (0.0–1.0, or higher for extra loud)
- The 5th number is **pitch** (1.0 = normal, lower = deeper, higher = higher)

---

### PARTICLE EFFECTS

Particles add visual atmosphere — dust, spores, smoke, magic.

```
# Dust particles — abandoned, dry, forgotten places
/particle minecraft:basic_flame_particle ~ ~1 ~ 0.5 0.5 0.5 0.02 20

# Ash particles — destroyed or burning area aftermath
/particle minecraft:basic_smoke_particle ~ ~1 ~ 1 1 1 0.05 30

# Glowing spores — magical, ancient, or eerie places
/particle minecraft:endrod ~ ~1 ~ 0.3 0.3 0.3 0.03 15

# Rain droplets (use indoors for a leaking roof effect)
/particle minecraft:water_splash_particle ~ ~3 ~ 0.8 0 0.8 0.01 5

# Portal particles — cursed, corrupted, or magical areas
/particle minecraft:portal_ease ~ ~1 ~ 0.5 0.5 0.5 0.1 25
```

**Particle syntax:** `/particle [type] [x] [y] [z] [spread_x] [spread_y] [spread_z] [speed] [count]`

---

## Putting It Together: Atmosphere Sequence

This is a 4-block chain command that fires when a player steps on a pressure plate
at the entrance to a ruined city area:

**Block 1 (Impulse, triggered by pressure plate)**
```
/time set 12000
```
*Sets to sunset — something is ending.*

**Block 2 (Chain)**
```
/weather rain 600
```
*Starts rain for 10 minutes.*

**Block 3 (Chain)**
```
/playsound ambient.cave @a ~ ~ ~ 0.6 0.8
```
*Plays a distant cave ambience.*

**Block 4 (Chain)**
```
/particle minecraft:basic_smoke_particle ~ ~2 ~ 2 0.5 2 0.02 40
```
*Adds smoke particles around the entrance.*

Result: the moment the player steps into the ruined city, the sky turns amber,
rain begins, a low hum fills the air, and smoke drifts past. All without a
single word of text.

---

## Design Tip: Use Commands Sparingly

Just like NPC dialogue — one well-placed atmospheric command does more than five
competing ones. Pick the single most powerful effect for each area and commit to it.

| Area Type | Best Single Effect |
|-----------|-------------------|
| Abandoned lab | `/playsound ambient.cave` on loop |
| Ancient temple | `/time set 12000` (sunset) + `/weather clear` |
| Flooded city | `/weather rain` + water particles |
| Safe haven | `/time set 6000` (noon) + `/weather clear` |
| Cursed zone | `/weather thunder` + portal particles |
