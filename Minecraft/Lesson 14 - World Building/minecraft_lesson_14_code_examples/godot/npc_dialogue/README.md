# NPC Dialogue — Godot 4.x
## Core Lesson Example | Part B, Task 2

This is the **core code example** for Day 14. It creates an NPC that shows a line of
story dialogue when the player walks nearby, and hides it when they walk away.

---

## What You'll Build

```
NPC (Area2D)
├── Sprite2D          ← the NPC's visual (your character art)
├── CollisionShape2D  ← the trigger zone around the NPC
└── DialogueLabel     ← the text that appears (hidden by default)
```

---

## Step-by-Step Setup in Godot

### Step 1 — Create the NPC node tree
1. In your scene, add a new **Area2D** node. Rename it `NPC`.
2. Inside `NPC`, add a **Sprite2D** node (add your character texture here).
3. Inside `NPC`, add a **CollisionShape2D** node.
   - In the Inspector, set **Shape** to `CircleShape2D`
   - Set the **Radius** to about `80` pixels — this is how close the player needs to get
4. Inside `NPC`, add a **Label** node. Rename it `DialogueLabel`.
   - Type your dialogue in the **Text** field
   - Position it above the NPC sprite
   - In the Inspector, check **Autowrap Mode → Word** so long lines wrap nicely

### Step 2 — Attach the script
1. Click the `NPC` (Area2D) node to select it
2. Click the scroll icon in the toolbar → **Attach Script**
3. Leave the defaults and click **Create**
4. Delete everything in the new script and paste in the contents of `npc_dialogue.gd`

### Step 3 — Connect the signals
1. With `NPC` selected, open the **Node** panel (next to Inspector)
2. Double-click **`body_entered`** → click **Connect** (leave defaults)
3. Double-click **`body_exited`** → click **Connect** (leave defaults)
4. Godot will add the signal functions to your script automatically.
   Make sure your script matches `npc_dialogue.gd`.

### Step 4 — Test it
Press **F5** to run your scene. Walk your player into the NPC's circle — the dialogue
should appear. Walk away — it should disappear.

---

## Customization Guide

Open `npc_dialogue.gd` and look for lines marked `# 🎨 CUSTOMIZE:`.

| Line | What to Change |
|------|---------------|
| `npc_name` | The NPC's name shown above the dialogue |
| `dialogue_lines` | The story clues this NPC says |
| `current_line` cycling | Whether the NPC says one line or cycles through several |

---

## Common Problems

| Problem | Fix |
|---------|-----|
| Dialogue never appears | Check that the `body_entered` signal is connected to the script (Node panel → Signals tab) |
| Dialogue appears for everything, not just player | Make sure your Player node is named exactly `"Player"` |
| Collision zone too small/large | Select CollisionShape2D and adjust the circle Radius in Inspector |
| Text runs off screen | Set Label's **Autowrap Mode** to Word, and set a max width in the Layout settings |
