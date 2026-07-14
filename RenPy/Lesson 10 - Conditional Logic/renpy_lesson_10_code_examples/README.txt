# =============================================================================
#  DAY 10 REN'PY EXAMPLES — Teacher Guide
#  STEM Through Games | Ren'Py Unit
# =============================================================================

OVERVIEW
--------
This folder contains four ready-to-use Ren'Py projects for Day 10:
Conditional Logic. Each file is a standalone .rpy script that can be dropped
into any Ren'Py project folder.


FILE SUMMARY
------------

  demo/
    script.rpy
      The TEACHER LIVE-DEMO. Walk through this on the projector during Phase 2.
      Features: has_key Boolean, menu choice, if/else door scene, jump labels.
      Heavily annotated — every line has a comment explaining WHY it's there.
      Run it twice: once picking up the key, once ignoring it.

  guided_practice/
    script.rpy
      The STUDENT STARTER FILE for Phase 3. Contains the full Abandoned Lab
      story with three TODO blocks the class completes in order:
        • TODO 1 (security_door) — done as a class together
        • TODO 2 (read_whiteboard) — done in pairs
        • TODO 3 (extension, hidden_room) — early finisher challenge

    script_ANSWER_KEY.rpy
      Completed version of the guided practice. Teacher reference only.
      Do not distribute until after students have attempted the tasks.

  independent_template/
    script_SCAFFOLDED.rpy
      Fill-in-the-blank template for students who need extra support.
      Every blank is marked with ___________ with a comment explaining
      exactly what goes there.

    script_ON_GRADE.rpy
      Clean blank canvas for on-grade students. Includes a quick-reference
      comment block at the top with the key Ren'Py syntax for the lesson.

  extension/
    script_EXTENSION.rpy
      Challenge script for fast finishers. Introduces:
        • elif chains
        • "and" / "or" combined conditions
        • Three-item inventory tracking
      Includes three marked ★ CHALLENGE sections for further exploration.


HOW TO SET UP A REN'PY PROJECT
--------------------------------
Each .rpy script needs to live inside a Ren'Py project's /game folder.

Quick setup:
  1. Open the Ren'Py launcher
  2. Click "Create New Project"
  3. Name it (e.g. "Day10_Demo")
  4. Replace the generated /game/script.rpy with the file from this folder
  5. Click "Launch Project"

For the guided_practice, give students script.rpy only. Keep
script_ANSWER_KEY.rpy on the teacher machine.


LESSON TIMING GUIDE
--------------------
  Phase 1 (0–8 min):   No file needed — discussion activity
  Phase 2 (8–20 min):  demo/script.rpy — teacher types live on projector
  Phase 3 (20–35 min): guided_practice/script.rpy — students on their machines
  Phase 4 (35–45 min): independent_template/ — students choose their level
  Phase 5 (45–50 min): No file needed — journal reflection + exit ticket


COMMON SETUP ISSUES
--------------------
  Error: "label 'start' not found"
    → The file was placed in the wrong folder. Must be in /game/

  Error: "IndentationError"
    → Mixed tabs and spaces. Select all, use Edit > Convert Indentation to Spaces

  Error: "NameError: has_key"
    → Student forgot the  default has_key = False  line at the top

  Game starts but choices don't work
    → Check that the menu block is indented correctly and choices have colons


DIFFERENTIATION NOTES
----------------------
  Scaffolded:   script_SCAFFOLDED.rpy  — fill in blanks, all structure provided
  On Grade:     script_ON_GRADE.rpy    — blank canvas with syntax reference
  Extension:    script_EXTENSION.rpy   — elif, "and"/"or", ★ challenges

  For students who finish the extension early:
    Ask them to add a "memory" variable that tracks something the player
    SAID (not just an item they found). See Challenge 3 in the extension file.
