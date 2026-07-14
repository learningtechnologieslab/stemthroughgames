# Day 13 – Dialogue Systems & Game Narrative
### STEM Through Games | Godot 4 Project

---

## 📦 What's in This Project

This Godot 4 project contains everything from the Day 13 lesson — from the exact starter code shown in class to a fully working village scene with branching dialogue.

### Project Structure

```
Day13_DialogueSystems/
│
├── project.godot              ← Open THIS file in Godot to load the project
│
├── scripts/
│   ├── DialogueManager.gd     ← Autoload singleton (the engine of all dialogue)
│   ├── DialogueBox.gd         ← UI panel that displays dialogue on screen
│   ├── BasicDialogueDemo.gd   ← ⭐ START HERE — the lesson's starter code
│   ├── ArrayExplorer.gd       ← Interactive array index visualizer
│   ├── NPC.gd                 ← Village Elder NPC with branching dialogue
│   ├── Merchant.gd            ← Second NPC — dialogue reacts to your choices!
│   ├── Player.gd              ← Top-down player movement
│   ├── VillageScene.gd        ← Ties everything together with a HUD
│   └── MainMenu.gd            ← Scene selector
│
└── scenes/
    ├── MainMenu.tscn          ← Entry point (set as main scene)
    ├── BasicDialogueDemo.tscn ← Lesson starter code in action
    ├── VillageScene.tscn      ← Full playable demo
    └── ArrayExplorer.tscn     ← Math visualizer tool
```

---

## 🚀 How to Open in Godot

1. Download and install **Godot 4.3** (or later) from [godotengine.org](https://godotengine.org)
2. Open Godot → click **"Import"**
3. Navigate to this folder and select **`project.godot`**
4. Click **"Import & Edit"**
5. Press **F5** (or the Play button) to run

> **First-time setup:** Go to **Project → Project Settings → Autoload** and make sure `DialogueManager` is listed, pointing to `res://scripts/DialogueManager.gd`. If it's missing, add it there.

---

## 📚 Learning Path (Read Scripts in This Order)

### Step 1 — The Lesson's Core Code
**Open:** `scripts/BasicDialogueDemo.gd`

This is the exact code from the lesson plan, with comments added:
```gdscript
var dialogue = [
    "Welcome to the village, traveler.",
    "We have a problem with goblins...",
    "Will you help us?"
]
var dialogue_index = 0

func _on_next_pressed():
    dialogue_index += 1
    if dialogue_index < dialogue.size():
        $DialogueLabel.text = dialogue[dialogue_index]
    else:
        hide()  # end of dialogue
```

**Run it** and watch the console — it prints the array state every time you click Next.

---

### Step 2 — The Math Visualizer
**Open:** `scripts/ArrayExplorer.gd`

Click through array elements and see the index math in real time. Try pressing **"Crash!"** to see what happens when you go out of bounds — and why the bounds check `if index < array.size()` exists!

---

### Step 3 — The Full System
**Open:** `scripts/DialogueManager.gd` → then `scripts/NPC.gd`

The `DialogueManager` is an **Autoload singleton** — a script that exists for the entire lifetime of the game. Any scene can call it:
```gdscript
DialogueManager.start_dialogue("Village Elder", first_meeting_lines)
```

---

### Step 4 — Branching & Variables
**Open:** `scripts/Merchant.gd`

The Merchant's dialogue **changes based on variables** set during the Village Elder conversation. This is the core of interactive storytelling!

---

## 🧮 Math Connections

| Concept | Where You See It |
|---------|-----------------|
| **Array indexing** | `dialogue[0]` is always the first line |
| **Bounds checking** | `if index < array.size()` prevents crashes |
| **Off-by-one** | Valid indices: `0` to `size()-1` (NOT `size()`) |
| **Loop counter** | `dialogue_index += 1` traverses the array |
| **Conditional logic** | `if/elif/else` chooses which dialogue array to use |
| **Vector math** | `Player.gd` uses `Vector2` and `normalize()` for movement |

---

## 🎯 Student Exercises

### Beginner
1. Open `BasicDialogueDemo.gd` and add 2 more lines to the `dialogue` array
2. Run the game — does it work? How did adding lines change the index range?

### Intermediate
3. In `NPC.gd`, modify `goblin_choices` to add a **third choice** (e.g., "Ask for more information")
4. Add a `trust_change` value to your new choice. What happens to the trust bar?

### Advanced
5. Create a new script `Wizard.gd` by copying `NPC.gd`
6. Give the Wizard dialogue that reacts to the `reputation` variable  
   (`"hero"`, `"neutral"`, or `"coward"`)
7. Add the Wizard to the Village Scene

### Challenge
8. Implement a **Dictionary-based** dialogue system where each entry has:
   ```gdscript
   {"speaker": "Elder", "text": "Hello!", "emotion": "happy"}
   ```
   Update `DialogueBox.gd` to display the `emotion` field

---

## 💡 Key GDScript Concepts Used

```gdscript
# Arrays
var my_array = ["a", "b", "c"]
print(my_array[0])          # "a"  — first element
print(my_array.size())      # 3    — number of elements
print(my_array[my_array.size()-1])  # "c" — last element

# Signals
signal dialogue_ended                       # declare
dialogue_ended.emit()                       # fire
some_function.connect(_on_dialogue_ended)  # listen

# Autoload (singleton)
# DialogueManager is available EVERYWHERE in the project
DialogueManager.start_dialogue("NPC", lines)
DialogueManager.get_variable("trust", 0)

# Dictionaries
var choice = {"text": "Help!", "trust_change": 2}
var result = choice.get("text", "default")  # safe access
```

---

## 🛠 Troubleshooting

**"DialogueManager is not a recognized class"**  
→ Go to Project → Project Settings → Autoload, and add `res://scripts/DialogueManager.gd` with the name `DialogueManager`

**"Cannot find node '$Panel/DialogueLabel'"**  
→ Check that your scene node names exactly match what's in the script's `@onready var` declarations

**Dialogue never ends / loops**  
→ Check that `dialogue_index` is being incremented correctly and the bounds check uses `<` not `<=`

**Player can't move**  
→ Go to Project → Project Settings → Input Map and add: `move_left`, `move_right`, `move_up`, `move_down`, `interact`

---

## 📖 What's Next — Day 14 Preview

Day 14 will upgrade this system with:
- **Dictionary-based dialogue** with speaker portraits and emotions
- **Quest tracking** with multiple active objectives  
- **Relationship variables** that persist across the whole game

---

*STEM Through Games | Day 13 of 20 | Narrative Design & Branching Dialogue*
