# ============================================================
# DAY 5 — EXAMPLE 7: Student Fill-In Template
# STEM Through Games | Introduction to Ren'Py
# ============================================================
#
# PURPOSE:
#   A guided template for students to write their OWN scene.
#   Fill in every blank marked with  ___  to complete the script.
#   Then save and run it!
#
# INSTRUCTIONS:
#   1. Replace every ___ with your own text
#   2. Do NOT change the structure or the Ren'Py keywords
#   3. Save the file as script.rpy in your Ren'Py project folder
#   4. Click "Launch Project" to run your game
#   5. Show your teacher before moving on to the challenge!
# ============================================================


# ── STEP 1: Define your two characters ───────────────────────────────────────
# Replace ___ with a short variable name (one lowercase letter works great)
# Replace "___" with your character's display name

define ___ = Character("___")         # Example: define a = Character("Alex")
define ___ = Character("___")         # Example: define b = Character("Blake")


# ── STEP 2: Write your scene ─────────────────────────────────────────────────

label start:

    # Narrator: Set the scene. Where are your characters? What's happening?
    "___"

    # Character 1 speaks first
    ___ "___"

    # Character 2 responds
    ___ "___"

    # Narrator: Describe an action or reaction
    "___"

    # Character 1 says something else
    ___ "___"

    # Character 2 replies
    ___ "___"

    # Narrator: End the scene
    "___"

    return


# ── CHECKLIST BEFORE YOU RUN ─────────────────────────────────────────────────
#
#   □  I replaced every ___ with real text
#   □  My two define lines are ABOVE label start (not inside it)
#   □  Every line inside label start is indented (4 spaces)
#   □  I used LOWERCASE variable names (a, b, etc.)
#   □  I used Character with a CAPITAL C
#   □  The last line inside label start is "return"
#
# ── EXAMPLE OF A COMPLETED TEMPLATE ─────────────────────────────────────────
#
#   define a = Character("Alex")
#   define b = Character("Blake")
#
#   label start:
#
#       "Two students stood outside the science fair."
#
#       a "I can't believe we forgot the poster board."
#
#       b "Do we have time to go back and get it?"
#
#       "Alex checked their watch and grimaced."
#
#       a "We have exactly eight minutes."
#
#       b "Then let's run!"
#
#       "And they did."
#
#       return
