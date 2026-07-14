# Day 4 – Ren'Py Code Examples
## STEM through Games · Introduction to Ren'Py

---

## How to use these projects

Each folder is a standalone Ren'Py project. To run any of them:

1. Open the **Ren'Py Launcher**
2. Click **"preferences"** and set your projects directory to this folder, OR
3. Click **"+ Create New Project"**, then copy the `game/script.rpy` file into it, OR
4. Simply drag the project folder into the Ren'Py Launcher window

The script file you need is always at: `project_name/game/script.rpy`

---

## Projects in this package

### 01_hello_world
**Use for:** Opening demo, first live coding moment  
**Concepts:** `label start:`, quoted dialogue, `return`, indentation  
The simplest possible Ren'Py game. Show this on the projector, then have
students type it themselves.

---

### 02_narrator_dialogue
**Use for:** Showing what a longer narrator story looks like  
**Concepts:** Multiple dialogue lines, comments (`#`), blank lines  
A short mystery story told entirely through narrator text. Good for
demonstrating that a game is just a sequence of lines, played top to bottom.

---

### 03_named_character
**Use for:** Extension challenge demo (45–55 min)  
**Concepts:** `define`, `Character()`, character speech syntax  
Two characters have a conversation. Introduces `define` and shows how to
mix narrator lines with character dialogue. Use as a live demo before
students attempt Project 5.

---

### 04_broken_examples
**Use for:** Debugging activity (any time, great for early finishers)  
**Concepts:** Reading error messages, common syntax mistakes  
Contains **5 intentional bugs**. Students launch the game, read the error,
fix one bug, and repeat until the game runs cleanly.

`script.rpy`          — the broken version (give to students)  
`script_ANSWER_KEY.rpy` — corrected version with explanations (teacher only)

**Bugs planted:**
1. Missing colon after `label start`
2. Wrong indentation (2 spaces instead of 4)
3. Nested `label` inside another `label`
4. `return` placed too early, cutting off the story
5. Unclosed quotation mark

---

### 05_extension_challenge
**Use for:** Students who finish early; take-home creative work  
**Concepts:** All Day 4 concepts, creative writing in code  
A fill-in-the-blank template with `TODO` markers guiding students to write
their own 5–8 line scene with at least one named character.

`script.rpy`         — student template (give to students)  
`script_EXAMPLE.rpy` — a completed example (teacher reference)

---

## Quick syntax reference

```
# This is a comment — Ren'Py ignores it

define alex = Character("Alex")   # Creates a named character

label start:                       # Marks the beginning of the game

    "Narrator text goes in quotes."         # No character variable = narrator

    alex "Character speech like this."      # Variable + quotes = character speaks

    return                                  # Ends the label — always needed
```

### Common errors and fixes

| Error | Likely cause | Fix |
|-------|-------------|-----|
| `SyntaxError` on `label start` | Missing colon | `label start:` |
| `IndentationError` | Wrong number of spaces | Use exactly 4 spaces |
| `SyntaxError` on a dialogue line | Unclosed quote | Add closing `"` |
| Game ends too early | `return` in wrong place | Move `return` to the very end |
| Name shows as variable, not text | `define` is missing | Add `define name = Character("Name")` |

---

## Teacher notes

- **Projector tip:** Keep `01_hello_world/game/script.rpy` open in your editor
  during the live demo. Delete its contents and type it from scratch so students
  see the whole process.

- **Circulate during activity:** The most common sticking points are the colon
  and the 4-space indent. A quick "does your label start: have a colon?" check
  fixes 80% of broken projects.

- **Early finishers:** Point them to `04_broken_examples` (bug hunt) first,
  then `05_extension_challenge` if they finish that too.

- **Saving work:** Remind students to save (`Ctrl+S`) before clicking Launch
  in the Ren'Py Launcher. The launcher runs the saved version, not unsaved changes.
