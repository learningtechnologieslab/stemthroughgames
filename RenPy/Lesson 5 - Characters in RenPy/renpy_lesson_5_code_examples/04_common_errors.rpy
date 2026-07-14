# ============================================================
# DAY 5 — EXAMPLE 4: Common Errors & How to Fix Them
# STEM Through Games | Introduction to Ren'Py
# ============================================================
#
# PURPOSE:
#   Study the three most common Day 5 mistakes and their fixes.
#   This file is for READING and LEARNING — it will NOT run as-is
#   because the "broken" versions are commented out on purpose.
#
# HOW TO USE:
#   Read each section. The ✗ lines show the mistake.
#   The ✓ lines show the correct version.
#   The explanation tells you WHY the rule exists.
# ============================================================


# ════════════════════════════════════════════════════════════
# ERROR 1: Wrong capitalization on the variable name
# ════════════════════════════════════════════════════════════
#
# Ren'Py (like Python) is case-sensitive.
# The variable you DEFINED must be used EXACTLY the same way.
#
# If you define:   define a = Character("Alex")
# You must use:    a "Hello!"          (lowercase a)
# NOT:             A "Hello!"          (uppercase A — different variable!)
#
#
# ── BROKEN VERSION (do not copy) ─────────────────────────────────────────────
#
#   define a = Character("Alex")
#
#   label start:
#       A "Hi there!"    ← ERROR: Ren'Py looks for variable "A" (capital)
#       return           #         but you only defined "a" (lowercase)
#
#
# ── FIXED VERSION ────────────────────────────────────────────────────────────

define a = Character("Alex")

label start:

    a "Hi there!"    # ✓ Lowercase a — matches the define line exactly

    return


# ════════════════════════════════════════════════════════════
# ERROR 2: Missing indentation inside the label block
# ════════════════════════════════════════════════════════════
#
# Every line INSIDE a label block must be indented.
# Standard indentation = 4 spaces (or 1 Tab key press).
# Ren'Py uses indentation to know what belongs inside the label.
#
#
# ── BROKEN VERSION (do not copy) ─────────────────────────────────────────────
#
#   label start:
#   a "Hi there!"    ← ERROR: Not indented — Ren'Py doesn't know this
#   return           #         line belongs inside "label start"
#
#
# ── FIXED VERSION ────────────────────────────────────────────────────────────
#
#   label start:
#       a "Hi there!"    ← ✓ Indented 4 spaces — clearly inside the label
#       return
#
#   (The working code above already shows this correctly.)


# ════════════════════════════════════════════════════════════
# ERROR 3: Lowercase "c" in Character()
# ════════════════════════════════════════════════════════════
#
# Character() is a built-in Ren'Py function.
# It MUST be spelled with a capital C.
# character() (lowercase c) does not exist — Ren'Py won't recognize it.
#
#
# ── BROKEN VERSION (do not copy) ─────────────────────────────────────────────
#
#   define a = character("Alex")    ← ERROR: lowercase "c"
#                                   #  Ren'Py will show a NameError
#
#
# ── FIXED VERSION ────────────────────────────────────────────────────────────
#
#   define a = Character("Alex")    ← ✓ Capital "C" — correct!
#
#   (The working code at the top of this file already shows this correctly.)


# ════════════════════════════════════════════════════════════
# ERROR 4 (BONUS): define inside the label block
# ════════════════════════════════════════════════════════════
#
# The "define" line must come BEFORE (outside) the label block.
# Putting it inside the label can cause unexpected behavior.
#
#
# ── BROKEN VERSION (do not copy) ─────────────────────────────────────────────
#
#   label start:
#       define a = Character("Alex")    ← Works in some cases, but WRONG style
#       a "Hi there!"                   #  Always put define lines at the TOP
#       return
#
#
# ── FIXED VERSION ────────────────────────────────────────────────────────────
#
#   define a = Character("Alex")    ← ✓ At the top, BEFORE label start
#
#   label start:
#       a "Hi there!"
#       return


# ── QUICK REFERENCE TABLE ────────────────────────────────────────────────────
#
#   What you typed             | What Ren'Py sees          | Fix
#   ─────────────────────────────────────────────────────────────────────
#   A "Hello!"                 | Unknown variable A        | Use lowercase: a
#   a "Hello!" (no indent)     | Syntax outside label      | Add 4 spaces before a
#   define a = character(...)  | NameError: character      | Capitalize: Character
#   define inside label        | May work but bad practice | Move above label start
