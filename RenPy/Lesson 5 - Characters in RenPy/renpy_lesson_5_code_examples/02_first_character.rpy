# ============================================================
# DAY 5 — EXAMPLE 2: Your First Character
# STEM Through Games | Introduction to Ren'Py
# ============================================================
#
# PURPOSE:
#   Add a named character to your game.
#   This is the MAIN ACTIVITY code for Day 5.
#
# CONCEPTS COVERED:
#   - define  →  creates a character variable
#   - Character("Name")  →  the Ren'Py character object
#   - Using the variable to speak a line of dialogue
#   - Difference between character dialogue and narrator text
#
# NEW SYNTAX:
#
#   define a = Character("Alex")
#   │      │               └─ Display name shown on screen
#   │      └─ Variable (your shorthand for this character)
#   └─ Keyword that creates the variable
#
# RULE: The "define" line MUST come BEFORE the "label start:" block.
# ============================================================


# ── STEP 1: DEFINE YOUR CHARACTER ────────────────────────────────────────────
# This line creates a character named "Alex".
# We use the variable "a" as a shorthand in our script.

define a = Character("Alex")


# ── STEP 2: USE THE CHARACTER IN YOUR SCRIPT ─────────────────────────────────

label start:

    # ── Character dialogue ────────────────────────────────────────────────
    # Format:  variable "Dialogue text goes here."
    # The character's name ("Alex") will appear above the dialogue box.

    a "Hi there! My name is Alex."

    a "When you see my name above the text box, that means I'M speaking!"

    # ── Narrator text ────────────────────────────────────────────────────
    # A plain string with NO variable = narrator text.
    # No name label appears — this is the "voice" of the story.

    "The room felt quiet after Alex finished speaking."

    # ── Back to character dialogue ────────────────────────────────────────
    a "See the difference? The narrator line had no name above it."

    a "Pretty cool, right? That's how Ren'Py knows who is speaking!"

    return


# ── WHAT TO NOTICE WHEN YOU RUN THIS ────────────────────────────────────────
#
#   ✓ "Alex" appears as a label above lines 1, 2, 4, and 5
#   ✓ Line 3 (narrator text) has NO name label above it
#   ✓ The define line is OUTSIDE and ABOVE the label block
#   ✓ All dialogue lines inside the label are indented (4 spaces)
#
# ── COMMON MISTAKE CHECK ─────────────────────────────────────────────────────
#
#   ✗  A "Hi there!"          ← Capital A — wrong! Variable is lowercase a
#   ✗  a "Hi there!"          ← No indent inside label — will cause an error
#   ✗  define a = character() ← Lowercase c — must be Character() with capital C
#
#   ✓  a "Hi there!"          ← Correct! Lowercase variable + 4-space indent
#
# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
#
#   1. Change "Alex" in the define line to your own character's name
#   2. Change the dialogue text to something your character would say
#   3. Add one more narrator line anywhere between dialogue lines
