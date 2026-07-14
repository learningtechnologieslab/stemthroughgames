# Day 13 — Dialogue Systems & Game Narrative
## Code Examples: Minecraft Education Edition

**STEM Through Games · Middle School (Grade 6–8) · 60 Minutes**

---

## What Is In This Folder?

These files are the hands-on companion to the Day 13 lesson plan. They guide
you — step by step — through building a branching NPC dialogue system inside
Minecraft Education Edition, covering the same concepts the original Godot lesson
taught using GDScript: arrays, indexed sequences, conditional logic, and variables.

There is no traditional "code" to run here. Minecraft Education Edition uses
**commands** instead of a programming language. Every command in these files goes
directly into the **Minecraft chat** (press `T`) or into a **Command Block**
inside your world.

---

## Folder Structure

```
day13-minecraft/
│
├── README.md                          ← You are here
│
├── 01_basic_npc/
│   └── npc_dialogue.txt               ← Place your first NPC and write its opening lines
│
├── 02_scoreboard_variables/
│   └── scoreboard_variables.txt       ← Learn how scoreboards work as variables
│
├── 03_branching_dialogue/
│   ├── branching_dialogue.txt         ← The full two-NPC branching system
│   └── dialogue_tree_diagram.txt      ← ASCII diagram of the story tree
│
├── 04_extension_quest_chain/
│   ├── extension_quest_chain.txt      ← Three-NPC chain for advanced students
│   └── state_diagram.txt              ← Scoreboard state table + array parallel
│
└── teacher_setup/
    ├── teacher_guide.txt              ← World setup, differentiation, troubleshooting
    └── command_quick_reference.txt    ← Printable command cheat sheet
```

---

## How to Use These Files

**Students:** Open the files in order — 01, 02, 03 — reading each one inside
Minecraft Education Edition with your world open alongside it. Every file tells
you exactly where to type each command and what it does.

**Teachers:** Read `teacher_setup/teacher_guide.txt` before class. It covers
world setup, sharing with students, differentiation tiers, and a full
troubleshooting guide for common mistakes.

---

## What You Will Build (Progression)

### Example 01 — Basic NPC Dialogue *(~5 min)*
Your first NPC. No branching yet — just an ordered sequence of dialogue lines
and the connection to arrays and index positions.

**You will learn:**
- How to place an NPC using the NPC Spawn Egg
- How to write dialogue text in the NPC Edit dialog
- How dialogue lines map to array positions (index 0, 1, 2...)

**Commands used:**
```
(none — this example is all done through the NPC editor UI)
```

---

### Example 02 — Scoreboard Variables *(~10 min)*
Scoreboards are Minecraft's version of variables. You create a `trust` variable
and change it based on what the player clicks.

**You will learn:**
- How to create a scoreboard objective (variable)
- How to set, add to, and read a score
- How `/execute if score` works as an `if` statement

**Commands used:**
```
/scoreboard objectives add trust dummy
/scoreboard objectives setdisplay sidebar trust
/scoreboard players set @p trust 0
/scoreboard players set @p trust 1
/execute if score @p trust matches 1 run say ...
```

**The code parallel:**
| GDScript | Minecraft Command |
|---|---|
| `var trust = 0` | `/scoreboard objectives add trust dummy` |
| `trust = 1` | `/scoreboard players set @p trust 1` |
| `trust += 1` | `/scoreboard players add @p trust 1` |
| `if trust == 1:` | `/execute if score @p trust matches 1 run` |

---

### Example 03 — Full Branching Dialogue *(~20 min, main activity)*
The complete lesson project. Two NPCs, two choices, two outcomes, and a
second character whose dialogue changes based on what the player decided.

**NPCs you build:**
- **Elder Mira** — opens the story, presents the choice
- **Guard Rowan** — responds differently based on the player's trust score

**You will learn:**
- How to chain Command Blocks to trigger multi-step reactions
- How to use `/title @p actionbar` to display in-world messages
- How to build a dialogue tree that matches your paper design
- How to reset the quest state for testing

**Commands used:**
```
/scoreboard objectives add trust dummy
/scoreboard objectives add questStarted dummy
/scoreboard players set @p trust 1
/scoreboard players set @p trust 0
/execute if score @p trust matches 1 run title @p actionbar {"text":"...","color":"green"}
/execute if score @p trust matches 0 run title @p actionbar {"text":"...","color":"red"}
/execute as @a[distance=..4] if score @s trust matches 1 run title @s actionbar {...}
/scoreboard players set @p trust 0   ← reset for testing
```

**Dialogue tree this builds:**

```
               ┌─────────────────────┐
               │      ELDER MIRA     │
               │  "Will you help?"   │
               └──────────┬──────────┘
                          │
           ┌──────────────┴──────────────┐
           │                             │
    [I will help!]               [No thanks.]
     trust = 1                    trust = 0
           │                             │
           ▼                             ▼
  "Thank you! Speak            "A pity. The village
   to Guard Rowan."             will suffer."
           │
           ▼
    ┌──────────────┐
    │  GUARD ROWAN │
    │  (checks     │
    │   trust)     │
    └──────┬───────┘
           │
    ┌──────┴──────┐
 trust=1       trust=0
    │              │
 "Gate open    "Cannot let
  for you!"     you through."
```

---

### Example 04 — Extension: Multi-NPC Quest Chain *(for early finishers)*
A third NPC — Wizard Selene — who only rewards players who completed both
previous conversations. Introduces multiple simultaneous scoreboard conditions
and a "reward given" flag to prevent repeating.

**New concepts:**
- Checking multiple conditions at once with chained `/execute if`
- Using a `rewardGiven` flag to run logic exactly once
- Tracking full player state across a 3-NPC quest chain

**Scoreboard state table:**

| Scenario | trust | questStarted | gateUnlocked | rewardGiven |
|---|---|---|---|---|
| Fresh start | 0 | 0 | 0 | 0 |
| Talked to Mira + helped | 1 | 1 | 0 | 0 |
| Passed the gate | 1 | 1 | 1 | 0 |
| Got Selene's reward | 1 | 1 | 1 | 1 |
| Talked to Mira + refused | 0 | 1 | 0 | 0 |

---

## Math Connection: Arrays and Indexing

The core math concept in this lesson is **ordered sequences with index positions**.
Minecraft dialogue and scoreboard variables use the same logic as arrays in code.

### Array rules (apply everywhere):
1. The first position is always **index 0**
2. The last valid index is **total items − 1**
3. Going past the end means **out of bounds** (no more content)

### In Minecraft NPC dialogue:
```
NPC pages (0-indexed):
  Page 0 → "Welcome to the village, traveler."
  Page 1 → "Goblins have been raiding our farms."
  Page 2 → "Will you help us?"

Total pages: 3
Valid page numbers: 0, 1, 2
Last valid page: 3 − 1 = 2
```

### In GDScript (the Godot version of the same lesson):
```gdscript
var dialogue = [
    "Welcome to the village, traveler.",
    "Goblins have been raiding our farms.",
    "Will you help us?"
]
var dialogue_index = 0

func _on_next_pressed():
    dialogue_index += 1
    if dialogue_index < dialogue.size():   # bounds check
        $DialogueLabel.text = dialogue[dialogue_index]
    else:
        hide()
```

Both versions express the same idea. Minecraft uses a visual editor
and typed commands; GDScript uses written code — but the **logic is identical**.

---

## Quick Command Reference

The full reference card is in `teacher_setup/command_quick_reference.txt`.
Here are the most-used commands for this lesson:

```
# Create a variable
/scoreboard objectives add <name> dummy

# Set a variable
/scoreboard players set @p <name> <number>

# Check a variable (if statement)
/execute if score @p <name> matches <value> run <command>

# Show a message on screen
/title @p actionbar {"text":"Hello!","color":"green"}

# Reset everything for testing
/scoreboard players set @p trust 0
/scoreboard players set @p questStarted 0
```

---

## Troubleshooting

**"My NPC button doesn't do anything."**
→ Make sure you are in **Adventure** or **Survival** mode when testing, not Creative.
→ Check that the On-Click Command starts with `/`.

**"I get 'Unknown scoreboard objective' error."**
→ You need to create the variable first:
  `/scoreboard objectives add trust dummy`

**"/execute command gives a syntax error."**
→ Check for the word `run` before the final command:
  `/execute if score @p trust matches 1 run say hi`

**"The title message never appears."**
→ Check your JSON — use straight double quotes `"`, not curly `"` or `"`.
→ The full format is: `{"text":"your message","color":"green"}`

**"My Command Block isn't firing."**
→ Open the block and check: type is correct (Impulse/Repeat/Chain),
  and "Always Active" is selected (not "Needs Redstone").

---

## Assessment Checklist

Use this to check your own work before the exit ticket:

- [ ] I can place an NPC and write its dialogue text
- [ ] I know what index position 0 means in a sequence
- [ ] I created a `trust` scoreboard variable
- [ ] My NPC has two buttons that set trust to different values
- [ ] I used `/execute if score` to show different messages
- [ ] I can explain the difference between a book story and a Minecraft story
- [ ] I can reset my quest state for a fresh test run

---

## Exit Ticket Questions

Answer these on a sticky note, in your journal, or out loud to your teacher:

1. What does "dialogue line 0" mean in your NPC story sequence?
2. What Minecraft command is the equivalent of `if trust == 1` in code?
3. Name one way a Minecraft story differs from a book story.

---

## What's Next — Day 14 Preview

Day 14 expands on what you built today by connecting narrative choices to
**world events**: opening passages with `/fill`, summoning goblins with `/summon`
if the player refused to help, and triggering weather changes tied to the
story's emotional arc. The scoreboard variables you built today carry over.

Keep your world saved — you will need it!

---

*STEM Through Games · Day 13 of 20 · Game Design / Narrative*
*Standards: CCSS.MATH.CONTENT.6.SP · CSTA 2-AP-11 · CSTA 2-AP-12 · ISTE 1.5c*
