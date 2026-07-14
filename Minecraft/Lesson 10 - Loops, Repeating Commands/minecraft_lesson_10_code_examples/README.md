# Day 10 — Loops, Timers & Spawning
## STEM Through Games Program | Minecraft Education + MakeCode

> **Day 10 of 20** · Middle School Grades 6–8 · 60–75 minutes

---

## What's in This Folder

Eight code examples mapped directly to the Day 10 lesson plan and slide deck. Each file can be used as a standalone demo, a student starter template, or a reference during the lesson.

```
day10_minecraft/
│
├── 01_warmup/
│   └── warmup_loop_demo.js             ← Warm-up (Slide 4)
│
├── 02_for_loops/
│   └── for_loop_examples.js            ← Direct Instruction (Slide 6)
│
├── 03_while_loops/
│   └── while_loop_examples.js          ← Direct Instruction (Slide 6)
│
├── 04_activity1_spawn_diamonds/
│   └── activity1_spawn_items.js        ← Activity 1 (Slide 7)
│
├── 05_activity2_timed_spawning/
│   └── activity2_timed_spawning.js     ← Activity 2 (Slide 8)
│
├── 06_extension_dynamic_difficulty/
│   └── extension1_dynamic_difficulty.js ← Extension (Slide 11)
│
├── 07_extension_wave_system/
│   └── extension2_wave_system.js       ← Extension (Slide 11)
│
└── 08_extension_score_system/
    └── extension3_score_system.js      ← Extension (Slide 11)
```

---

## Quick Setup (Every File)

1. Open **Minecraft Education Edition**
2. Create or open a world — a flat superflat world works best for demos
3. Open **MakeCode** (press **C** or tap the agent icon)
4. Click the **JavaScript** tab at the top of the editor
5. **Select All** and **Delete** any existing code
6. **Paste** the contents of whichever file you want to use
7. Click **Play** (the green triangle) to compile and sync
8. Return to Minecraft and **type the trigger command** in chat

> **Tip:** Switch the world to **Survival** or **Adventure** mode before running mob-spawning examples so students feel the gameplay pressure. Creative mode makes mobs harmless.

---

## File-by-File Guide

---

### 01 — Warm-Up Loop Demo
**File:** `01_warmup/warmup_loop_demo.js`  
**Lesson moment:** Warm-Up (Slide 4, 10 min)  
**Trigger:** type `jump` in Minecraft chat

Prints "JUMP! (count: 1)" through "JUMP! (count: 5)" in chat.

**Purpose:** Make the abstract idea of a loop concrete before any syntax explanation. Students see five identical outputs produced by five lines that are only written once.

**Discussion question after running:**
> "What ONE thing in the code controls how many times it prints?"  
> *(Answer: the `5` in `i < 5`)*

---

### 02 — For Loop Examples
**File:** `02_for_loops/for_loop_examples.js`  
**Lesson moment:** Direct Instruction (Slide 6, 15 min)  
**Triggers:** `countme` · `rowtest` · `staircase`

| Command | What it does |
|---|---|
| `countme` | Prints 0–4 in chat — the simplest loop demo |
| `rowtest` | Places 8 grass blocks in a row in the world |
| `staircase` | Builds a 6-step wooden staircase upward |

**Teaching sequence:**  
Run `countme` first (output only). Then run `rowtest` to show the loop variable `i` doing physical work in the world. Run `staircase` last — here `i` controls *both* X position and height simultaneously, making the variable's role unmistakable.

**Key concept to say aloud:**
> "In `staircase`, we never typed six separate `blocks.place()` calls. We wrote it once, and the loop ran it six times with a different value of `i` each time."

---

### 03 — While Loop Examples
**File:** `03_while_loops/while_loop_examples.js`  
**Lesson moment:** Direct Instruction (Slide 6, 15 min)  
**Triggers:** `whilecount` · `filldown`

| Command | What it does |
|---|---|
| `whilecount` | Counts 0–4 using a while loop (same output as `countme`) |
| `filldown` | Places dirt blocks downward from player's feet to y=60 |

**The infinite loop (Example C):**  
The file contains a commented-out infinite loop — display it on the projector *without* running it. Ask students to spot the bug before revealing the answer.

> **Bug:** `mobsSpawned` is never incremented, so the condition `mobsSpawned < 3` never becomes false.

**Comparison exercise:**  
After running both `countme` (from file 02) and `whilecount`, ask students: "These produce identical output. What are the differences in the *code*?"
- For loop: counter declared *in* the loop header
- While loop: counter declared *before*, incremented *inside* manually

---

### 04 — Activity 1: Spawn Items with a For Loop
**File:** `04_activity1_spawn_diamonds/activity1_spawn_items.js`  
**Lesson moment:** Activity 1 (Slide 7, 30 min)  
**Triggers:** `spawnitems` · `spawnmore` · `spawnwide` · `spawnmix` · `clearitems`

| Command | What it does |
|---|---|
| `spawnitems` | Base activity — 5 diamonds at random X/Z, y=64 |
| `spawnmore` | Challenge 1 — 10 gold blocks, count controlled by variable |
| `spawnwide` | Challenge 2 — 5 emeralds over a 0–50 range instead of 2–18 |
| `spawnmix` | Challenge 3 — 8 blocks chosen randomly from an array |
| `clearitems` | Wipes the spawn area clean for another run |

**Recommended flow:**
1. Show `spawnitems` as a teacher demo first, walk through the code line-by-line
2. Have students paste and run `spawnitems` themselves
3. Ask them to change `5` to `20` — what happens?
4. Fast finishers try `spawnmore`, `spawnwide`, or `spawnmix`

**Math connection (Slide 9):**
```
Math.randomRange(2, 18) → 17 possible values (2 to 18 inclusive)
Probability of landing in any column: 1/17 ≈ 5.9%
```
Write `Math.randomRange(2, 18)` on the board and ask:
> "How do we calculate how many total integers are in this range?"  
> *(Answer: 18 − 2 + 1 = 17)*

---

### 05 — Activity 2: Timed Mob Spawning
**File:** `05_activity2_timed_spawning/activity2_timed_spawning.js`  
**Lesson moment:** Activity 2 (Slide 8, 30 min)  
**Triggers:** `startwave` · `stopwave` · `fastwave` · `stopfastwave` · `multiwave` · `stopmultiwave` · `clearzone` · `stopall`

| Command | What it does |
|---|---|
| `startwave` | Base activity — 1 zombie every 3 seconds (60 ticks) |
| `stopwave` | Stops the base wave |
| `fastwave` | Variant — 1 zombie every 1 second (20 ticks) |
| `stopfastwave` | Stops the fast wave |
| `multiwave` | Combines Activity 1 + 2 — 3 zombies every 3 seconds (for loop *inside* interval) |
| `stopmultiwave` | Stops the multi wave |
| `clearzone` | Fills the spawn zone (x:4–16, z:4–16) with air |
| `stopall` | Emergency stop — cancels every running interval at once |

**Teaching tip for `multiwave`:**  
This is the "aha" moment of the lesson — a for loop nested inside an interval. Draw the flow on the board:

```
Every 60 ticks:
  └─ Run the interval callback
       └─ for i = 0 to 2:
            └─ Spawn a zombie at random (x, z)
```

**Survival mode note:** Switch the world to Survival before running `fastwave` — the 1-second spawn rate is genuinely scary and creates the escalating-challenge narrative discussed on Slide 10.

---

### 06 — Extension 1: Dynamic Difficulty
**File:** `06_extension_dynamic_difficulty/extension1_dynamic_difficulty.js`  
**Lesson moment:** Extension (Slide 11)  
**Triggers:** `startdynamic` · `stopdynamic` · `wavestatus` · `resetdynamic`

Starts at a 3-second interval and speeds up by 5 ticks each wave, down to a minimum of 0.5 seconds. Mob count also grows — 1 mob at first, then +1 every 3 waves.

**How it works (advanced pattern):**  
`game.runInterval()` cannot change speed once running. The solution: cancel the interval and restart it with a new delay after each wave fires. This "restart the timer" pattern is used in real games.

**Math extension:**
```
Wave N delay = 60 - (5 × (N - 1)) ticks
Reaches minimum (10 ticks) at wave 11
Sum of delays for waves 1–11 = ~350 ticks ≈ 17.5 seconds
```
This is an arithmetic sequence — a great connection to CCSS 7th grade patterns.

---

### 07 — Extension 2: Wave System
**File:** `07_extension_wave_system/extension2_wave_system.js`  
**Lesson moment:** Extension (Slide 11)  
**Triggers:** `startwave2` · `stopwave2` · `wavestatus2` · `clearzone2`

Normal waves: 2 zombies. Every 5th wave is a boss wave: 4 zombies + 1 skeleton archer.

**The modulo operator `%`:**  
This file introduces modulo (`%`) — the remainder after division. Write it on the board:

```
waveCount % 5   →   0 when wave is a multiple of 5
5 % 5 = 0  ✓ boss wave
10 % 5 = 0  ✓ boss wave
7 % 5 = 2   ✗ normal wave
```

Students who haven't seen modulo before often find this genuinely surprising. It's worth spending a minute explaining with concrete division examples.

**Math extension:**
```
After 20 waves:
  Boss waves:  Math.floor(20 / 5) = 4
  Normal waves: 20 - 4 = 16
  Total mobs:   (16 × 2) + (4 × 4) = 48
```

---

### 08 — Extension 3: Score System
**File:** `08_extension_score_system/extension3_score_system.js`  
**Lesson moment:** Extension (Slide 11) + Day 11 Preview  
**Triggers:** `startgame` · `collect` · `showscore` · `resetscore` · `penalty`

Tracks score with a variable and displays it live in the Minecraft scoreboard HUD using `/scoreboard` commands.

| Command | What it does |
|---|---|
| `startgame` | Spawns diamonds every 5 sec, initializes score at 0 |
| `collect` | Awards +1 point (manual stand-in for pickup event) |
| `showscore` | Prints current score to chat |
| `resetscore` | Resets score, stops spawning, clears diamonds |
| `penalty` | Subtracts 1 point (stand-in for mob-hurt event) |

**Day 11 preview:**  
The file contains a commented-out preview of the `mobs.onMobKilled()` and block pickup events students will implement next lesson. You can show this section to build anticipation.

---

## Chat Command Quick Reference

| Command | File | What it does |
|---|---|---|
| `jump` | warmup | Prints loop output 5 times |
| `countme` | for_loops | Prints 0–4 in chat |
| `rowtest` | for_loops | Places 8 grass blocks in a row |
| `staircase` | for_loops | Builds a 6-step staircase |
| `whilecount` | while_loops | Counts 0–4 with while loop |
| `filldown` | while_loops | Fills blocks down to y=60 |
| `spawnitems` | activity1 | Spawns 5 diamonds at random positions |
| `spawnmore` | activity1 | Spawns 10 gold blocks |
| `spawnwide` | activity1 | Spawns 5 emeralds over wide area |
| `spawnmix` | activity1 | Spawns 8 random block types |
| `clearitems` | activity1 | Clears the spawn area |
| `startwave` | activity2 | 1 zombie every 3 sec |
| `stopwave` | activity2 | Stops base wave |
| `fastwave` | activity2 | 1 zombie every 1 sec |
| `stopfastwave` | activity2 | Stops fast wave |
| `multiwave` | activity2 | 3 zombies every 3 sec |
| `stopmultiwave` | activity2 | Stops multi wave |
| `stopall` | activity2 | Stops all running intervals |
| `clearzone` | activity2 | Clears the spawn zone |
| `startdynamic` | ext1 | Dynamic difficulty wave |
| `stopdynamic` | ext1 | Stops dynamic wave |
| `wavestatus` | ext1 | Shows wave speed info |
| `resetdynamic` | ext1 | Full reset |
| `startwave2` | ext2 | Boss wave system |
| `stopwave2` | ext2 | Stops wave system |
| `wavestatus2` | ext2 | Shows next boss wave |
| `startgame` | ext3 | Starts score game |
| `collect` | ext3 | Awards +1 point |
| `showscore` | ext3 | Displays score |
| `resetscore` | ext3 | Resets everything |
| `penalty` | ext3 | Subtracts 1 point |

---

## Recommended World Settings

| Setting | Value | Why |
|---|---|---|
| World type | Flat / Superflat | Clear sightlines for spawned items |
| Game mode | Survival or Adventure | Mobs become a real threat |
| Difficulty | Easy or Normal | Zombies are dangerous but not overwhelming |
| Cheats | On | Required for `/scoreboard` commands in Extension 3 |
| Starting coordinates | Near x=10, z=10, y=64 | Spawn zones are centered around this area |

---

## Troubleshooting

**Mobs spawn but I don't see them**  
Make sure you're in Survival or Adventure mode — in Creative mode mobs are passive. Also check that the spawn zone (x:5–15, z:5–15, y:64) is loaded and visible from your current position.

**"Command not found" errors in the console**  
This happens when MakeCode hasn't finished syncing. Click the Play button again and wait for the green checkmark before typing commands.

**Extension 3 scoreboard doesn't appear**  
The `/scoreboard` command requires **Cheats** to be enabled in the world settings. Go to Edit World → Game Settings → Cheats: On.

**Interval keeps running after I paste new code**  
If you had an interval running and then replaced the code, it may still be active in memory. Type `stopall` first, or close and re-enter the world.

**Blocks place in the wrong location**  
The spawn examples use absolute world coordinates (x:2–18, z:2–18, y:64). If your world's spawn point is far from those coordinates, update the numbers in `Math.randomRange()` to match where you are standing. Alternatively, use the `rowtest` / `staircase` examples which calculate position relative to the player.

---

## Connections to the Lesson Plan

| Lesson Plan Section | Code File(s) |
|---|---|
| Warm-Up (10 min) | `01_warmup` |
| Direct Instruction — For Loops | `02_for_loops` |
| Direct Instruction — While Loops | `03_while_loops` |
| Activity 1: Spawn Items | `04_activity1_spawn_diamonds` |
| Activity 2: Timed Spawning | `05_activity2_timed_spawning` |
| Math Connection (Slide 9) | Notes in `activity1_spawn_items.js` |
| Game Narrative (Slide 10) | Run `fastwave` then `startwave` for comparison |
| Extension: Dynamic Difficulty | `06_extension_dynamic_difficulty` |
| Extension: Wave System | `07_extension_wave_system` |
| Extension: Score System | `08_extension_score_system` |
| Day 11 Preview | Bottom of `extension3_score_system.js` |

---

## What's Next — Day 11 Preview

In Day 11, students will replace the manual `collect` and `penalty` commands in Extension 3 with automatic event listeners:

```javascript
// Fires when the player kills a mob
mobs.onMobKilled(function (mob) {
    playerScore += 10
    updateScoreboard()
})

// Fires when a block is mined/picked up
blocks.onBlockMined(function (pos) {
    if (blocks.testForBlock(DIAMOND, pos)) {
        playerScore++
        updateScoreboard()
    }
})
```

Encourage students to save their Day 10 projects tonight and test their spawning. Ask them to sketch a HUD design showing score, lives, and a wave counter — they'll build it next class.

---

*STEM Through Games Program — Confidential Educational Material*  
*Day 10 of 20 | Loops, Timers & Spawning | Minecraft Education Edition*
