# ============================================================
# DAY 5 — EXAMPLE 1: Starter Template
# STEM Through Games | Introduction to Ren'Py
# ============================================================
#
# PURPOSE:
#   This is the bare-minimum script every Ren'Py game needs.
#   Use this as your starting point before adding characters.
#
# CONCEPTS COVERED:
#   - The "label start:" block (where every game begins)
#   - Narrator text (a plain string in quotes)
#   - The "return" statement (ends the game cleanly)
#
# HOW TO USE:
#   1. Open your Ren'Py project
#   2. Replace the contents of script.rpy with this code
#   3. Click "Launch Project" to run it
# ============================================================


# ── NARRATOR TEXT ────────────────────────────────────────────────────────────
# A plain string in quotes with NO character variable = narrator text.
# No name label appears above the dialogue box.

label start:

    "Welcome to my very first Ren'Py game!"

    "This is narrator text. No character name appears above it."

    "The game ends when it reaches the return statement below."

    return

# ── WHAT TO NOTICE WHEN YOU RUN THIS ────────────────────────────────────────
#
#   ✓ Text appears in the dialogue box at the bottom of the screen
#   ✓ No name label appears above the text — that's narrator style
#   ✓ Click (or press Enter/Space) to advance to the next line
#   ✓ After the last line, the game closes — that's what "return" does
#
# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
#
#   Change the text inside the quotes to anything you like!
#   Example: "It was a dark and stormy night..."
#
# ── COMING NEXT ──────────────────────────────────────────────────────────────
#
#   In Example 2, we add a character so their name appears
#   above the dialogue box — just like in a real visual novel!
