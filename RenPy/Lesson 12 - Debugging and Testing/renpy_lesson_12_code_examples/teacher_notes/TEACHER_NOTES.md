# Day 12 — RenPy Debugging Scripts: Teacher Notes

## Overview

This folder contains **5 buggy scripts** and **5 matching fixed scripts** for the Day 12 Debugging & Testing lesson. Each script is a self-contained short visual novel with intentional errors for students to find and fix.

---

## Folder Structure

```
renpy_examples/
├── buggy/
│   ├── script1_syntax_error.rpy
│   ├── script2_indentation_error.rpy
│   ├── script3_logic_error.rpy
│   ├── script4_name_and_logic_error.rpy
│   └── script5_challenge_mixed_bugs.rpy
├── fixed/
│   ├── script1_syntax_error_FIXED.rpy
│   ├── script2_indentation_error_FIXED.rpy
│   ├── script3_logic_error_FIXED.rpy
│   ├── script4_name_and_logic_error_FIXED.rpy
│   └── script5_challenge_mixed_bugs_FIXED.rpy
└── teacher_notes/
    ├── demo_script_for_projection.rpy   ← Use this for the live demo
    └── TEACHER_NOTES.md                 ← This file
```

---

## How to Set Up Each Script as a RenPy Project

Each `.rpy` file needs to be placed in a RenPy project to run. Before class:

1. Create 5 new RenPy projects (File → New Project in the RenPy Launcher)
   - Name them: `Debug_Script_1` through `Debug_Script_5`
2. Open each project's `game/` folder
3. **Delete** the default `script.rpy` inside `game/`
4. **Copy** the corresponding buggy script file into `game/` and rename it `script.rpy`
5. Create a simple `options.rpy` with the game title if RenPy asks for one

> **Tip:** Pre-load all 5 projects on student computers the day before class.
> Name the desktop shortcuts clearly: "Debug Challenge 1 (Easy)" etc.

---

## Script Reference Card

| Script | File | Bug Type | Difficulty | Story Setting |
|--------|------|----------|------------|---------------|
| 1 | `script1_syntax_error.rpy` | Syntax Error | ⭐ Easy | First day of school |
| 2 | `script2_indentation_error.rpy` | Indentation Error | ⭐ Easy | Talent show decision |
| 3 | `script3_logic_error.rpy` | Logic Error | ⭐⭐ Medium | After-school choices |
| 4 | `script4_name_and_logic_error.rpy` | Name Error + Logic | ⭐⭐ Medium | Sports tryouts |
| 5 | `script5_challenge_mixed_bugs.rpy` | 3 Mixed Bugs | ⭐⭐⭐ Challenge | School mystery |

---

## Bug Answer Key

### Script 1 — Syntax Error
- **Location:** Line 13 — `label start`
- **Fix:** Add a colon → `label start:`
- **Error message RenPy shows:** `SyntaxError: invalid syntax`
- **Teaching point:** The colon tells RenPy "a block of code follows." Every `label`, `menu`, `if`, and `elif` must end with a colon.

### Script 2 — Indentation Error
- **Location 1:** Line 22 — `s "You'd be amazing!..."` is at the wrong indent level (menu level instead of inside the choice)
- **Location 2:** Line 28 — `s "I'll help you write the jokes!"` has too many leading spaces (16 instead of 12)
- **Fix:** Correct both lines to 12 spaces of indentation
- **Error message RenPy shows:** `IndentationError: unexpected indent` or `IndentationError: expected an indented block`
- **Teaching point:** RenPy uses Python's indentation rules. Inside a menu choice, code needs exactly 12 spaces (3 levels × 4 spaces).

### Script 3 — Logic Error
- **Location:** Line 22 — `jump cafeteria` inside the "Go to the library" choice
- **Fix:** Change to `jump library`
- **Error message RenPy shows:** *None* — the game runs without crashing
- **Teaching point:** Logic errors are silent. The only way to catch them is to test every path and verify that what happens matches what you intended.

### Script 4 — Name Error + Logic Error (two bugs)
- **Bug 1 Location:** Line 23 — `if made_team:` is checked before `made_team` is ever assigned
- **Bug 1 Fix:** Add `$ made_team = False` before the `if` statement
- **Bug 2 Location:** Near the bottom — `jump finalle` (double-L typo)
- **Bug 2 Fix:** Change `finalle` → `finale`
- **Error message for Bug 1:** `NameError: name 'made_team' is not defined`
- **Error message for Bug 2:** `Exception: Label 'finalle' does not exist`
- **Teaching point:** Always initialize variables before using them. Always check your spelling on label names — they're case-sensitive.

### Script 5 — Challenge (3 mixed bugs)
- **Bug 1:** `$ clues_found += 1` on line ~21, but `clues_found` was never initialized → add `$ clues_found = 0` at the top of `label start`
- **Bug 2:** `jump interveiw_witness` (e/i swap) → fix to `jump interview_witness`
- **Bug 3:** `d "Was there anything unusual about them?` — missing closing `"` → add the closing quote
- **Teaching point:** Real-world scripts have multiple overlapping bugs. Use a systematic approach — fix one bug, test, then look for the next. Don't try to fix everything at once.

---

## Classroom Tips

### For struggling pairs
- Hand them the "Bug Types Cheat Sheet" (from the slide deck)
- Reduce their requirement: Scripts 1 and 2 only, or Script 3 as a stretch goal
- Sit with them and use the Rubber Duck technique: "Read me this line. Now read the next one. What should happen here?"

### For advanced pairs who finish early
- Have them write a NEW buggy version of Script 3 with a different logic error and swap with another group
- Challenge: Can they create a bug that produces a specific error message?
- Introduce the RenPy developer console (press **Shift+D** while a game is running) — they can inspect variables live

### Common student mistakes to watch for
- **Fixing indentation visually but using the wrong character:** Make sure students are using spaces, not tabs. Mixing tabs and spaces causes hard-to-see errors.
- **Fixing Bug 1 but not testing the rest:** Remind students to run through all paths after every fix.
- **Giving up on Script 5 because it "has too many errors":** Encourage them to fix one bug, test, then hunt the next one. Don't fix everything at once.

---

## Exit Ticket Answer Guide

**Question 1** (describe a bug you fixed):
Any clear description of a bug type + fix is acceptable. Look for: correct bug name, correct line location, and a logical explanation of the fix.

**Question 2** (most useful debugging strategy):
All strategies are valid. Listen for metacognitive insight — "I liked rubber duck debugging because saying it out loud made me hear the problem" shows deeper learning than "I checked the line number."

**Question 3** (open question):
Collect these and use them to inform Day 13 and the upcoming project check-ins. Common questions: "How do I know when I've found ALL the bugs?" and "Does RenPy always tell you the right line number?" (Answer: not always — the error shows where the parser got confused, which can be after the actual bug.)

---

*Day 12 — STEM Through Games Program — RenPy Visual Novel Unit*
