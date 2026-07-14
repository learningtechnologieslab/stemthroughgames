# Minecraft Education Edition — NPC Dialogue Setup
## Core Lesson Example | Part B, Task 2

This guide covers everything you need to set up story NPCs in Minecraft Education Edition.

---

## What Is an NPC in Minecraft Education?

NPCs (Non-Player Characters) are special entities unique to Minecraft Education Edition.
They don't move or attack — they exist purely to deliver dialogue and (optionally) run
commands when a player interacts with them.

Unlike signs, NPCs:
- Show a proper dialogue box with a name and message
- Can run commands when the player clicks a button in the dialogue window
- Look like a customizable character, not a block

---

## Step-by-Step: Placing and Configuring an NPC

### Step 1 — Enable Education Edition Features
1. From the main menu, open your world's **Settings** (pencil icon)
2. Scroll to **Experiments**
3. Enable **Education Edition** (if not already on)
4. Save and re-enter the world

### Step 2 — Switch to Creative Mode
Type this command in chat (press T or /):
```
/gamemode creative
```

### Step 3 — Get the NPC Spawn Egg
- Open your **inventory** (E)
- Search for **NPC Spawn Egg**
- If you don't see it, open the **Education** tab in the inventory

### Step 4 — Place the NPC
- Right-click to place the NPC Spawn Egg on the ground
- The NPC will appear as a default character

### Step 5 — Edit the NPC
1. **Right-click** the NPC while in Creative mode
2. Click the **Edit NPC** pencil icon (top-right of the dialogue box)
3. You'll see three fields:
   - **Name** → What appears at the top of the dialogue box
   - **Dialogue** → The story text the player reads
   - **Button name + command** → Optional: a button the player can click

### Step 6 — Write Story Dialogue
Type your dialogue in the **Dialogue** field. See the examples below.

### Step 7 — Close and Test
Click the X to close the editor. Now **right-click the NPC as a player**
(switch to survival or adventure mode first) — the dialogue box will open.

---

## Switching Player Mode for Testing

```
/gamemode survival    ← to test NPC interaction
/gamemode creative   ← to keep building
/gamemode adventure  ← to let other players explore without breaking blocks
```

---

## Example NPC Dialogue Scripts

These are ready-to-paste dialogue examples for different world types.
Copy the text from the Dialogue column directly into the NPC's Dialogue field.

---

### WORLD TYPE: Abandoned Laboratory

**NPC Name:** The Last Technician

**Dialogue:**
```
The generators went offline three weeks ago.
I've been running on emergency power since then.

Don't touch the containment units in Lab 4.
Whatever you do.
```

**Why this works:** Specific details (generators, Lab 4, three weeks) make the
world feel real. The warning creates curiosity without explaining anything.

---

### WORLD TYPE: Ancient Temple / Ruins

**NPC Name:** Stone Guardian

**Dialogue:**
```
You carry the same light they carried,
long ago.

This temple has slept for four hundred years.
I have been watching.

The one you seek left through the eastern passage.
```

**Why this works:** The Guardian's age (400 years of watching) is environmental
storytelling through NPC — it tells us the temple is ancient without a sign that
says "ANCIENT TEMPLE."

---

### WORLD TYPE: Flooded City

**NPC Name:** Driftwood Annie

**Dialogue:**
```
The water came up fast.
Faster than anyone expected.

Most folks headed north. Some went up to
the towers. I haven't seen them come down.

This used to be the market district.
You're standing where the bakery was.
```

**Why this works:** "You're standing where the bakery was" places the player inside
the history. It makes the flooded world personal and specific.

---

### WORLD TYPE: Dangerous / Cursed Area

**NPC Name:** The Watcher

**Dialogue:**
```
Turn back.

I've said that to forty-seven people now.
Three of them listened.
```

**Why this works:** Brevity. The Watcher doesn't explain the danger — the number
"forty-seven" does all the work. Less is more.

---

### WORLD TYPE: Safe Haven / Sanctuary

**NPC Name:** Elder Maren

**Dialogue:**
```
You made it.

We don't ask where people came from anymore.
There's food by the eastern fire,
and a spare blanket in the storehouse.

Rest. You're safe here.
```

**Why this works:** Contrast. After a dangerous journey, "You're safe here" hits
harder than any description of safety could.

---

## Dialogue Writing Tips for Students

### The Rule of Specificity
Vague dialogue feels fake. Specific dialogue feels real.

| Weak (vague) | Strong (specific) |
|-------------|-------------------|
| "Something bad happened here." | "The last shift never checked out." |
| "This place is dangerous." | "Don't go past the red line. Anyone who has hasn't come back." |
| "I've been here a long time." | "I've watched the sun set from this window 1,247 times." |

### The Rule of Implication
NPCs shouldn't explain everything. Leave gaps that the player fills in.

- **Bad:** "There was a war and everyone died and the city was destroyed."
- **Good:** "The bells stopped ringing the morning after the soldiers left."

### The Rule of In-World Voice
NPCs live in this world. They don't describe it — they react to it.

- **Bad:** "This is an abandoned laboratory where experiments went wrong."
- **Good:** "They told us the experiments were safe. They were wrong."

---

## Adding a Button to NPC Dialogue (Optional)

In the NPC editor, you can add up to 6 buttons. Each button:
- Has a label (the text shown on the button)
- Runs a command when clicked

Example: A button that teleports the player deeper into the dungeon
- **Button label:** `Enter the dungeon`
- **Command:** `/tp @p 120 64 -45`

Example: A button that gives the player a key item
- **Button label:** `Take the journal`
- **Command:** `/give @p written_book 1`
