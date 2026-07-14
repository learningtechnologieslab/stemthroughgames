# World Setup Guide — Minecraft Education Edition
## Teacher Prep | Before Class

This guide covers the recommended world settings and setup steps for Day 14's
main activity, so students can build and explore without technical interruptions.

---

## Recommended World Settings

Go to **Settings** (pencil icon on the world tile) before students join.

### Game Settings

| Setting | Recommended Value | Why |
|---------|------------------|-----|
| **Default Game Mode** | Creative | Students need to build freely |
| **Difficulty** | Peaceful | No mobs interrupting the build activity |
| **Daylight Cycle** | Off (or set by command) | So time of day stays intentional |
| **Weather Cycle** | Off | Same — let students set weather with commands |
| **Fire Spreads** | Off | Prevents accidental fire damage |
| **TNT Explodes** | Off | Prevents accidental destruction |
| **Mob Spawning** | Off | Keeps focus on building |

### Education Settings

| Setting | Recommended Value |
|---------|------------------|
| **Education Edition** | On (required for NPCs) |
| **Immersive Reader** | On (accessibility support) |
| **Code Builder** | Off (not needed today) |
| **Chemistry** | Off (not needed today) |

### Multiplayer Settings (if applicable)

| Setting | Recommended Value |
|---------|------------------|
| **Multiplayer** | On (if students share worlds) |
| **Player Permissions (Default)** | Member |
| **Host Permissions** | Operator (you) |

---

## Starter World Options

### Option A — Flat World (Recommended for beginners)
Start with a completely flat surface. Students build from scratch on a clean canvas.

**How:** New World → World Type: **Flat**

**Pros:** No terrain to work around, full creative control
**Cons:** Students must build everything, including the ground

---

### Option B — Default World (Recommended for most classes)
Use normal terrain generation for a natural landscape base.

**How:** New World → World Type: **Default**

**Pros:** Natural terrain gives students something to build *into* (ruins in a forest,
a flooded valley, etc.), which often sparks better environmental storytelling
**Cons:** Students may spend too long exploring terrain instead of building

---

### Option C — Pre-Built Starter World (Recommended for support students)
Build a partial world beforehand with structures roughed in — crumbling walls,
a cleared area, basic terrain shaping — so students focus on the story details
rather than starting from nothing.

---

## Commands to Run at Session Start

Paste these into chat one at a time to configure the world:

```
# Set to peaceful (no mob interruptions)
/difficulty peaceful

# Give all students operator access (if they need to run commands themselves)
# Skip this if you want to run commands on their behalf
/op @a

# Set a neutral time of day to start
/time set 6000

# Clear weather
/weather clear

# Confirm education features are enabled (run once)
/give @p npc_spawn_egg 1
```

If the last command gives you an NPC spawn egg, Education Edition features are active.
If it gives an error, go to World Settings → Experiments → Education Edition → On.

---

## Saving and Backing Up Student Worlds

**Students must export their world before the end of class** or risk losing work.

### How Students Export Their World
1. Press **Esc** → **Settings**
2. Scroll to **Export World**
3. Save to OneDrive, Google Drive, a USB drive, or email to themselves

### For Teachers: Exporting All Worlds via Admin
If your school uses a managed Minecraft Education deployment, check with your
IT administrator for bulk world backup options.

---

## Switching Students to Adventure Mode for Playtesting

When students are done building and want to let classmates explore:
```
/gamemode adventure @a
```

Adventure mode lets players explore and interact with NPCs but prevents them from
breaking or placing blocks — protecting the builder's work during playtesting.

Switch back to creative for continued building:
```
/gamemode creative @a
```

---

## Common Problems and Fixes

| Problem | Fix |
|---------|-----|
| NPC Spawn Egg not in inventory | Check Education Edition is enabled in World Settings → Experiments |
| NPC dialogue doesn't open | Make sure the player is in Survival or Adventure mode (not Creative) |
| Students accidentally destroying each other's builds | Run `/gamemode adventure @a` to prevent block breaking |
| Commands not working | Player needs Operator permissions: run `/op [playername]` |
| World running slowly | Reduce render distance: Settings → Video → Render Distance → 6 or lower |
| Students can't join | Check Multiplayer is enabled and you're on the same network/account |

---

*Day 14 — World Building & Level Storytelling*
*STEM Through Games | Minecraft Education Edition*
