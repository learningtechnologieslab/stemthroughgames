# Day 7 — Menus & Choices: RenPy Examples
## STEM Through Games · Middle School Program

---

### How to Use These Files

Each `.rpy` file is a standalone example. To run any of them:

1. Open the **RenPy launcher**
2. Click **"Create New Project"** (or use an existing one)
3. Open the project folder and find `game/script.rpy`
4. **Replace** the contents of `script.rpy` with the example file
5. Click **"Launch Project"** in the launcher

> **Tip:** Keep a backup copy of your own `script.rpy` before replacing it!

---

### Files at a Glance

| File | Purpose | Use When |
|------|---------|----------|
| `example_01_hello_menu.rpy` | Simplest possible menu + two paths | First 5 minutes of direct instruction |
| `example_02_crossroads.rpy` | Full lesson starter scene with characters, scenes, and two endings | Guided practice (class types along) |
| `example_03_nested_menus.rpy` | A choice inside a choice — three possible endings | Challenge ⭐⭐ extension |
| `example_04_common_mistakes.rpy` | Broken code next to fixed code — five common errors | Debug warm-up or troubleshooting reference |
| `example_05_secret_ending.rpy` | Uses a variable to unlock a hidden third ending | Challenge ⭐⭐⭐ extension |
| `example_06_student_template.rpy` | Fill-in-the-blanks scaffold for student's own story | Main activity (support tier) |
| `example_07_model_answer.rpy` | Complete polished story showing strong student work | Show AFTER students attempt their own |

---

### Recommended Teaching Order

```
Direct Instruction  →  example_01  (simplest syntax demo)
                    →  example_04  (show common errors, normalise debugging)

Guided Practice     →  example_02  (class types along together)

Main Activity       →  example_06  (students fill in the template)

Challenge           →  example_03  (nested menus)
                    →  example_05  (secret ending — preview of Day 8 variables)

Reflection          →  example_07  (show as model after activity)
```

---

### Syntax Quick Reference

```renpy
# ── Label ───────────────────────────────────
label my_label_name:
    "Dialogue or narration goes here."
    return

# ── Menu ────────────────────────────────────
menu:
    "Choice text A":        # 8 spaces + quotes + colon
        jump label_a        # 12 spaces

    "Choice text B":
        jump label_b

# ── Character ───────────────────────────────
define alex = Character("Alex", color="#6C63FF")
alex "This is dialogue with a name tag."

# ── Scene change ────────────────────────────
scene bg_forest
with dissolve

# ── Variable (Day 8 preview) ─────────────────
default score = 0
$ score += 1
if score >= 2:
    jump secret_ending
```

---

### Indentation Rules

RenPy uses Python-style indentation. **Spaces only — no tabs.**

| Block level | Spaces |
|-------------|--------|
| Inside a label | 4 |
| Inside a menu | 8 |
| Inside a menu choice | 12 |

---

### Common Error Messages

| Error | Likely Cause | Fix |
|-------|-------------|-----|
| `could not find label 'X'` | Typo in jump or missing label | Check spelling in both `jump` and `label` |
| `ParseError: expected a menu item` | Wrong indentation in menu | Indent choices 8 spaces |
| `expected ':'` | Missing colon after choice text | Add `:` at end of the choice string |
| Story falls through to next scene | Missing `return` | Add `return` at end of the label |
