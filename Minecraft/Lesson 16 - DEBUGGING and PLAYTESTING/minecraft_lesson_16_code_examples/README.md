# Day 16 – Debugging & Playtesting
## Code Examples for Minecraft Education Edition

**STEM Through Games Program · Middle School Game Design**

---

## What's in This Package

This folder contains hands-on code examples for Day 16 of the Minecraft
Education Edition game design curriculum. Students work through four
real, runnable bugs — experience the broken behavior firsthand, then
apply debugging strategies to find and fix each one.

```
minecraft-debug-examples/
│
├── README.md                        ← You are here
│
├── buggy/                           ← Give these to students
│   ├── bug1_undefined_variable.js
│   ├── bug2_event_not_triggering.js
│   ├── bug3_command_block_fail.mcfunction
│   └── bug4_mob_behavior.js
│
├── fixed/                           ← Teacher reference / answer key
│   ├── bug1_undefined_variable_fixed.js
│   ├── bug2_event_not_triggering_fixed.js
│   ├── bug3_command_block_fail_fixed.mcfunction
│   └── bug4_mob_behavior_fixed.js
│
├── bonus_complete_minigame.js       ← Working mini-game for fast finishers
│
└── teacher-notes/
    └── setup_guide.txt              ← World-building instructions per bug
```

---

## How to Load Code into Minecraft Education Edition

### JavaScript files (.js)

1. Open **Minecraft Education Edition**
2. Create or open the prepared world for that bug
3. Click the **Code Builder** button (the `< >` icon in the toolbar, or press **C**)
4. Select **MakeCode**
5. In MakeCode, click the **JavaScript** tab (top of the editor)
6. Select all the existing code and **delete it**
7. Paste the contents of the `.js` file
8. Click **Done** to return to the world and test

### Command files (.mcfunction)

`.mcfunction` files contain commands for Command Blocks. Each line is
one command, entered into a separate Command Block.

1. Build the Command Block setup described in `teacher-notes/setup_guide.txt`
2. Right-click each Command Block to open its interface
3. Type or paste the corresponding command (one command per block)
4. Set the block mode as noted in the comments at the top of the file
5. Power with redstone to test

---

## The Four Bugs

### Bug 1 – Undefined Variable Error
**File:** `buggy/bug1_undefined_variable.js`

**The scenario:** A score counter that's supposed to track how many
checkpoint pads the player steps on. The score should go up each time.

**What students see:** The score always prints as `1`, never higher.
No crash, no error — just wrong output every time.

**The concept:** Variable *scope*. A variable declared with `let` inside
a function is created fresh each time that function runs, then thrown away.
Only variables declared at the *top level* of the program persist
across multiple event firings.

**The fix:** Move `let score = 0` outside the event handler so it's
declared once and shared across all calls.

**Debugging tool used:** `say("score before = " + score)` placed at the
very start of the event handler reveals that score is always `0` before
the increment — proving it was being reset on each call.

---

### Bug 2 – Event Not Triggering
**File:** `buggy/bug2_event_not_triggering.js`

**The scenario:** A parkour checkpoint system. Walking over emerald
blocks should save progress and print a message.

**What students see:** Absolute silence. No message, no error, nothing.
The code appears to not run at all.

**The concept:** "Silent failure" — the event IS firing (the player IS
walking), but the condition inside never matches because the code
checks for `diamond_block` instead of `emerald_block`.

**The fix:** Change `blocks.diamond_block` to `blocks.emerald_block`
to match the blocks actually placed in the world.

**Debugging tool used:** `say("walk event fired!")` placed *before* the
`if` statement confirms the event handler is running. This splits the
problem: "the event works, but the condition doesn't match." That
points directly to the block type check.

---

### Bug 3 – Command Block Silent Fail
**File:** `buggy/bug3_command_block_fail.mcfunction`

**The scenario:** A boss battle trigger sequence: announce the battle,
spawn a boss, set difficulty, give the player a sword.

**What students see:** Redstone powered, Command Block activates, and
absolutely nothing happens. No sound, no mob, no announcement.

**The concept:** Command syntax must be exact. One wrong character
causes the entire command to fail silently. Unlike code, commands
don't give a line number or error message — they just do nothing.

**The bugs in this file:**
- `titl` should be `title`
- `summom` should be `summon`
- `diamond_swrod` should be `diamond_sword`

**The fix:** Correct all three spelling errors.

**Debugging tool used:** Copy the command, open the chat bar, type `/`
and paste it. Minecraft immediately shows a red error for invalid
commands — much faster than testing block by block.

---

### Bug 4 – Mob Behavior Not Working
**File:** `buggy/bug4_mob_behavior.js`

**The scenario:** A wave-based mob spawner for a survival arena. Every
20 seconds, a new wave of enemies should appear near the player.

**What students see:** Mixed results — the wave counter works, but one
mob type does nothing, one mob spawns far away, and one briefly appears
then immediately dies.

**The concept:** Three separate bugs in one file, representing the most
common mob-spawning mistakes:
1. Using a mob type not available in Education Edition (`"Giant"`)
2. Using absolute world coordinates instead of player-relative offsets
3. Spawning inside the ground (y offset of -1 suffocates the mob)

**The fixes:**
1. Replace `"Giant"` with `MobType.Zombie`
2. Replace `pos(0, 0, 0)` with `positions.add(player.position(), world(x, y, z))`
3. Change y offset from `-1` to `+1`

**Debugging tool used:** `/summon Giant` in chat immediately reveals
that "Giant" is not a valid entity. `say("player pos: " + player.position())`
shows that `pos(0,0,0)` is a fixed point, not relative to the player.

---

## The Debug Loop (Day 16 Strategy)

Every bug in this package can be found using the same four-step process:

```
1. READ     Observe the symptom carefully.
            What exactly is wrong? "Nothing happens" is different from
            "wrong output" which is different from "crash."

2. PRINT    Add say() statements to find out what's actually happening.
            Before the bug:  say("checkpoint A — score is: " + score)
            After the bug:   say("checkpoint B — we got here")
            Narrow down to the line that never prints.

3. INSPECT  Use Code Builder's output panel.
            Watch variables change in real time while the game runs.

4. ASK      Stuck after 3 minutes? Ask a partner.
            Describe the symptom out loud — often you'll spot it yourself
            in the process of explaining it.
```

---

## Classroom Usage Notes

### Sequence
Work through bugs in order. Bug 1 introduces scope (the hardest concept).
Bugs 2 and 3 build confidence with simpler "wrong value" errors. Bug 4
challenges students to handle multiple bugs at once.

### Pairing
Bugs 1 and 4 work well as pair activities. Bugs 2 and 3 are good for
independent practice once students have the `say()` strategy internalized.

### The Bonus Mini-Game
`bonus_complete_minigame.js` is a complete "Diamond Rush" game that
uses all four fixes together. Fast finishers can:
- Load it and play it as-is
- Add a new mechanic (e.g., power-up blocks, health system)
- Deliberately re-introduce one of the bugs and see if a partner can find it

### Connecting to the Peer Feedback Form
After debugging, students playtest each other's *own* games (from
previous days), not these examples. The examples are the warm-up.
The real creative work is applying the feedback loop to their own projects.

---

## Standards Connections

| Concept in Code | Standard |
|---|---|
| Variable scope (Bug 1) | CSTA 2-AP-11: Create clearly named variables |
| Event-driven programming (Bug 2) | CSTA 2-AP-12: Design and iteratively develop programs |
| Syntax and testing (Bug 3) | CSTA 2-AP-16: Incorporate existing code |
| Systematic debugging (all) | CSTA 2-AP-19: Document programs; CCSS.Math.Practice.MP1 |

---

*STEM Through Games Program · Day 16 · Minecraft Education Edition*
