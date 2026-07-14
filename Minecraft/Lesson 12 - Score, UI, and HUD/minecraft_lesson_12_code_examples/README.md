# STEM Through Games — Day 12: Score, UI & HUD
## Minecraft Education Edition Code Examples

**Subject:** Game Design & Development  
**Platform:** Minecraft Education Edition + MakeCode (JavaScript)  
**Grade Level:** Middle School (Grades 6–8)  
**Day:** 12 of 20  

---

## What's in This Folder

These code examples accompany the Day 12 lesson plan and slide deck. Every file is commented line-by-line so students can read, understand, and modify the code independently.

```
minecraft_hud_day12/
│
├── README.md                          ← You are here
│
├── commands/
│   ├── step1_setup_scoreboards.mcfunction   ← Chat commands to run first
│   └── scoreboard_reference.mcfunction      ← Full command cheat sheet
│
├── makecode/
│   ├── step2_basic_hud.js                   ← Core lesson: score + health HUD
│   └── step3_countdown_timer.js             ← Challenge extension: timer
│
├── extensions/
│   ├── extension_multi_item_scoring.js      ← Advanced: lookup table scoring
│   └── extension_multiplayer_leaderboard.js ← Advanced: live leaderboard
│
└── teacher_demos/
    ├── teacher_demo_type_conversion.js      ← Demo: integers vs. strings
    └── teacher_demo_timer_math.js           ← Demo: linear function y = b - x
```

---

## Before You Start

### What Students Need
- Minecraft Education Edition (version 1.14 or later)
- A world with cheats/operator permissions enabled
- Access to MakeCode (pause menu → MakeCode)
- A keyboard (the MakeCode JavaScript editor requires typing)

### What Teachers Need
- Operator (`/op`) permissions in the world
- Projector or screen to demonstrate live
- Printed copies of `scoreboard_reference.mcfunction` make an excellent desk reference card

---

## Step-by-Step Guide

### Step 1 — Set Up the Scoreboards (5 minutes)

Run these three commands in the Minecraft chat (press **T**):

```
/scoreboard objectives add score dummy Score
/scoreboard objectives add health dummy Health
/scoreboard objectives setdisplay sidebar score
```

The sidebar should appear on the right side of the screen. See `commands/step1_setup_scoreboards.mcfunction` for the full annotated version and optional timer setup.

> **Why do this first?** The MakeCode scripts use `/scoreboard players set` to update values, but the objectives must exist before values can be assigned. If students run MakeCode before this step, the commands will silently fail with no visible error.

---

### Step 2 — Add the Core HUD Script (10 minutes)

1. Press **Escape** → click **MakeCode**
2. Click the **JavaScript** tab (top right of MakeCode editor)
3. Select all existing code and delete it
4. Open `makecode/step2_basic_hud.js` and copy the entire contents
5. Paste into MakeCode and click **Play** (green triangle)
6. In Minecraft chat, type `start` to initialize the HUD

**Test it:**
- Pick up a dirt block → Score increases by 10
- Get hit by a mob → Health decreases by 5

**What this file teaches:**
- Declaring variables with `let`
- Event handlers (`player.onItemPickedUp`, `player.onEntityHurt`)
- Arithmetic operators (`+=`, `-=`)
- String concatenation to build scoreboard commands
- The `@p` player selector

---

### Step 3 — Add the Countdown Timer (10 minutes)

`makecode/step3_countdown_timer.js` is a **complete replacement** for step2 — it includes everything from step 2 plus the timer.

1. In MakeCode, select all and delete
2. Paste `step3_countdown_timer.js`
3. Click Play
4. Type `start` in chat — the game begins immediately
5. Type `pause` to pause/resume the timer

**The core math formula:**
```
remaining_seconds = MAX_SECONDS - elapsed_seconds
```
This is the linear function **y = b − x**, where:
- **b** = 60 (the starting value — change `MAX_SECONDS` to adjust)
- **x** = elapsed_seconds (grows by 1 each second)
- **y** = remaining_seconds (what the HUD displays)

**When elapsed = 60**, remaining = 0 → game over triggers.

**Bonus challenges built into the file:**
- Timer flashes a warning at 10 seconds remaining
- Timer pauses when player health reaches zero
- MM:SS format code is included but commented out — students uncomment it

---

## Extensions (Early Finishers)

### Multi-Item Scoring (`extensions/extension_multi_item_scoring.js`)

Replaces the single `DIRT` pickup with a full scoring table:

| Item | Points |
|------|--------|
| Dirt | 10 |
| Gravel | 25 |
| Iron Ore | 50 |
| Gold Ore | 75 |
| Diamond | 150 |
| Emerald | 200 |

**New concept introduced:** Objects as lookup tables — students add new items by editing one line in `SCORE_TABLE`, with no changes needed elsewhere. Opens a discussion on the "DRY" principle (Don't Repeat Yourself).

### Multiplayer Leaderboard (`extensions/extension_multiplayer_leaderboard.js`)

Shows how Minecraft's sidebar **automatically sorts** multiple players by score — giving a live leaderboard with no extra code. Each player runs the script on their own device; the sidebar updates in real time.

**Key insight for students:** The `@p` selector updates only *your* score. `@a` would overwrite everyone's. This is an intuitive introduction to scope.

---

## Teacher Demos

These files are designed to be run live while projecting to the class.

### `teacher_demo_type_conversion.js`

Run the following chat commands in order, pausing after each to discuss:

| Command | What students see | Teaching moment |
|---------|-------------------|-----------------|
| `demo1` | `42 + 10 = 52` | Integer arithmetic works as expected |
| `demo2` | `"42" + "10" = "4210"` | **The surprise** — strings concatenate, not add |
| `demo3` | Full scoreboard command string | How `+` builds the command |
| `demo4` | Good vs. bad score variable | Why we declare scores as numbers |
| `demo5` | Bank balance analogy | Real-world connection |

**Demo 2 is the key moment.** Most students expect `"42" + "10"` to equal `"52"`. When they see `"4210"`, the motivation for storing scores as integers becomes immediately clear.

### `teacher_demo_timer_math.js`

| Command | What it shows |
|---------|---------------|
| `mathshow` | Prints a table of elapsed → remaining values |
| `tickdemo` | Converts tick counts to seconds and MM:SS |
| `livedemo` | **Live 10-second countdown** printed to chat |
| `slope` | Algebra: y-intercept vs. slope for different MAX values |

`livedemo` is the most engaging — students watch the formula execute in real time in the chat window. Pair it with drawing the line `y = 60 − x` on the board as the demo runs.

---

## Concept Map

This diagram shows how the Day 12 concepts connect:

```
GAME EVENT                    MAKECODE HANDLER              MINECRAFT HUD
──────────                    ────────────────              ─────────────
Player picks up item   →   onItemPickedUp() fires   →   playerScore += 10
                                                    →   executeCommand(
                                                            "/scoreboard ... " + playerScore
                                                        )
                                                    →   Sidebar updates ✓

Player takes damage    →   onEntityHurt() fires     →   playerHealth -= 5
                                                    →   executeCommand(...)
                                                    →   Sidebar updates ✓

1 second passes        →   everyInterval(1000)      →   elapsedSeconds += 1
                                                    →   remaining = MAX - elapsed
                                                    →   executeCommand(...)
                                                    →   Timer sidebar updates ✓
```

**Key equivalence with Godot (for teachers using both):**

| Godot | Minecraft/MakeCode |
|-------|--------------------|
| `CanvasLayer` + `Label` node | Scoreboard objective + sidebar display |
| `func update_score(n)` | `updateScoreDisplay()` function |
| `str(score)` | String concatenation: `"" + score` |
| Custom signal + `connect()` | `player.onItemPickedUp()` event handler |
| `_process(delta)` | `loops.everyInterval(1000)` |

---

## Common Problems & Fixes

**The sidebar doesn't appear.**  
Run `/scoreboard objectives setdisplay sidebar score` in chat. Also run `/scoreboard players set @p score 0` — players don't appear in the sidebar until they have at least one score entry.

**The score doesn't update when I pick up items.**  
Make sure you picked up `DIRT` specifically (the default trigger). Check that the MakeCode script is running (click Play). Verify the `score` objective exists with `/scoreboard objectives list`.

**`everyInterval` isn't counting down.**  
The timer starts paused. Type `start` in the Minecraft chat to begin. If the timer still doesn't move, confirm that `timerRunning = true` is being set in the `start` handler.

**String concatenation shows wrong results.**  
This is usually `demo2` happening accidentally — a variable was initialized as a string (`let score = "0"`) instead of a number (`let score = 0`). Check the declaration at the top of the script.

**`/scoreboard players set @p score` fails silently.**  
The objective doesn't exist yet. Run Step 1 commands again. Objective names are case-sensitive: `score` ≠ `Score`.

---

## Modifying the Examples

**Change the item that awards points:**  
In `step2_basic_hud.js`, replace `DIRT` in `player.onItemPickedUp(DIRT, ...)` with any MakeCode block constant: `GRASS`, `IRON_ORE`, `GOLD_ORE`, `DIAMOND`, `EMERALD`, etc.

**Change the timer length:**  
In `step3_countdown_timer.js`, edit `const MAX_SECONDS = 60`. One change, and every part of the timer adjusts automatically.

**Add a second scoreboard display:**  
Minecraft only shows one objective in the sidebar at a time. To show multiple values simultaneously, use `/scoreboard objectives setdisplay belowname health` — this displays health numbers floating below each player's name.

**Award points for building instead of collecting:**  
Replace `player.onItemPickedUp` with `player.onBlockPlaced`. Same structure, different trigger.

---

## Next Lesson Preview — Day 13

Day 13 builds directly on this lesson:

- Connect the `timerRunning = false` event to a full game-over screen
- Introduce game states: `PLAYING`, `PAUSED`, `GAME_OVER`
- Use `/title` and `/subtitle` commands for polished UI feedback
- Chain multiple events into a complete game loop

The `onTimerExpired()` function in `step3_countdown_timer.js` is the starting point for Day 13's game-over sequence.

---

*© STEM Through Games Program | Middle School Track | Day 12 of 20*
