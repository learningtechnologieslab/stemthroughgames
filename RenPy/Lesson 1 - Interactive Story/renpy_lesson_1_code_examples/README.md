# STEM Through Games — RenPy Code Examples
## Teacher Guide & File Index

---

### What's in This Folder

These six `.rpy` files are ready-to-run code examples for the
**Introduction to RenPy** unit. They are designed to be introduced
**progressively**, with each file building on the last.

---

### File Index

| File | Concept | Best Used |
|---|---|---|
| `01_hello_world.rpy` | Labels, narration, `return` | Day 2 — first look at RenPy |
| `02_characters.rpy` | `define`, `Character()`, dialogue | Day 2 — adding speakers |
| `03_choices.rpy` | `menu:`, player choice, rejoining paths | Day 3 — the heart of VNs |
| `04_branching_paths.rpy` | `label`, `jump`, true branching | Day 3–4 — story maps |
| `05_variables.rpy` | `default`, `$`, `if/elif/else` | Day 4–5 — persistent choices |
| `06_lost_robot_mini_vn.rpy` | Everything combined | Day 5–6 — full demo / model |

---

### How to Run Any Example

1. Download and install RenPy from **https://www.renpy.org**
2. Open the RenPy launcher and click **"Create New Project"**
3. Name your project (e.g., `HelloWorld`) and choose a resolution
4. Navigate to your project folder → open the `game/` subfolder
5. Replace `script.rpy` with the example file (or paste the contents in)
6. Back in the launcher, click **"Launch Project"**

> **Tip:** Students can also paste code directly into the built-in
> script editor by clicking "script.rpy" in the launcher.

---

### Concepts by Lesson Day

#### Day 2 — Opening RenPy / First Script
- Introduce `01_hello_world.rpy` as a live demo
- Walk through every line together; students type it themselves
- Key questions: *"What does `label start:` do? What does `return` do?"*

#### Day 2–3 — Adding Characters
- Show `02_characters.rpy` — focus on the `define` line
- Ask students to change the name and color, then relaunch
- Key question: *"What happens if you remove the `define` line?"*

#### Day 3 — Choices
- Show `03_choices.rpy` — trace through both paths on the board first
- Emphasize **indentation**: "RenPy uses spaces to know what belongs where"
- Key activity: Draw the story map on the whiteboard, then match it to code

#### Day 4 — Branching Paths
- Show `04_branching_paths.rpy` — introduce `label` and `jump`
- Have students trace the flow: *"What happens if I pick Option A?"*
- Key concept: labels = named locations, jump = teleport to that location

#### Day 4–5 — Variables
- `05_variables.rpy` connects to if/then logic
- Bridge to CS: *"This is the same `if` statement used in Python, JavaScript, everywhere"*
- Challenge: add a second variable and use it in the ending

#### Day 5–6 — Full Mini VN
- Use `06_lost_robot_mini_vn.rpy` as a **model** for student projects
- Don't just show it — have students READ the code and predict outcomes
- Story mapping activity: draw the full branch diagram from the code

---

### RenPy Quick Reference Card

```
# Comment (not read by RenPy)

define x = Character("Name", color="#hexcode")   # create a character

default my_var = False                           # create a variable

label start:                                     # required starting point
    "Narrator text."                             # narration
    x "Character dialogue."                      # character speaks
    $ my_var = True                              # change a variable
    menu:                                        # show a choice
        "Option A":
            "This runs for A."
        "Option B":
            "This runs for B."
    if my_var:                                   # check a variable
        "This runs if True."
    else:
        "This runs if False."
    jump another_label                           # go to a label
    return                                       # end the scene/game

label another_label:                             # a named scene
    "More story here."
    return
```

---

### Common Student Mistakes (and How to Fix Them)

| Mistake | Error Message / Symptom | Fix |
|---|---|---|
| Forgetting the colon after `label start` | Parse error | Add `:` at the end |
| Wrong indentation | Parse error or dialogue appears wrong | Use 4 spaces consistently; never mix tabs and spaces |
| Putting `define` inside `label start` | Characters don't work | Move `define` lines above `label start` |
| Forgetting quotes around dialogue | Parse error | Wrap all text in `" "` |
| Using `#` inside a color string | Wrong color | Use `color="#ff0000"` with the `#` *inside* the quotes |
| Jumping to a label that doesn't exist | Name error at runtime | Check spelling matches exactly |
| Not ending with `return` | Game loops or crashes | Always end every label path with `return` or `jump` |

---

### Extension Ideas for Fast Finishers

1. **Add a background image** — `scene bg classroom` (requires an image file)
2. **Add music** — `play music "audio/theme.mp3"`
3. **Add a character sprite** — `show maya happy` (requires sprite files)
4. **Create multiple endings** — use variables to unlock a "secret" ending
5. **Port a fairy tale** — rewrite a known story (e.g., Little Red Riding Hood) as a branching VN

---

*STEM Through Games Program — Introduction to RenPy Unit*
*Examples designed for middle school learners (Grades 6–8)*
