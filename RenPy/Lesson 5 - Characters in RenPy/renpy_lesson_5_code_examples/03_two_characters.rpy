# ============================================================
# DAY 5 — EXAMPLE 3: Two Characters Talking
# STEM Through Games | Introduction to Ren'Py
# ============================================================
#
# PURPOSE:
#   Add a second character and create a back-and-forth conversation.
#   This is the CHALLENGE code for Day 5.
#
# CONCEPTS COVERED:
#   - Defining multiple characters with different variables
#   - Alternating dialogue between two speakers
#   - Mixing character dialogue with narrator text
#   - Each character's name appearing separately above the text box
#
# KEY RULE:
#   Every character needs its OWN variable (a different letter or word).
#   You cannot use the same variable for two different characters!
#
#   ✓  define a = Character("Alex")      ← variable a → Alex
#   ✓  define j = Character("Jordan")   ← variable j → Jordan
#   ✗  define a = Character("Alex")
#      define a = Character("Jordan")   ← WRONG! Same variable used twice
# ============================================================


# ── DEFINE BOTH CHARACTERS ───────────────────────────────────────────────────
# Each character gets its own variable and display name.

define a = Character("Alex")
define j = Character("Jordan")


# ── THE CONVERSATION ─────────────────────────────────────────────────────────

label start:

    # Narrator sets the scene — no name label
    "It was lunchtime. Alex spotted Jordan across the cafeteria."

    # Alex speaks first
    a "Hey Jordan! Have you heard about the new game that just came out?"

    # Jordan responds
    j "No way — which one? I've been out of the loop all week."

    # Narrator adds action — no name label
    "Alex pulled out their phone and showed Jordan the screen."

    a "It's called Echoes. It's a mystery visual novel. Super creepy."

    j "A visual novel? Like... the kind WE'RE learning to make?"

    a "Exactly! Maybe we could make something even better."

    j "I'm in. Let's start planning after school!"

    # Narrator closes the scene
    "They both smiled, already imagining the story they would build."

    return


# ── WHAT TO NOTICE WHEN YOU RUN THIS ────────────────────────────────────────
#
#   ✓ "Alex" and "Jordan" appear as separate labels above the dialogue box
#   ✓ The name switches each time a different character speaks
#   ✓ Narrator lines (no variable) have no name label at all
#   ✓ Two define lines at the top — one per character
#
# ── CHALLENGE REQUIREMENTS CHECKLIST ────────────────────────────────────────
#
#   ☑  Two define statements with DIFFERENT variables (a and j)
#   ☑  Each character has a unique, descriptive name
#   ☑  At least 4 dialogue lines alternating between the two
#   ☑  All lines properly indented inside label start
#   ☑  Narrator lines mixed in for scene setting
#   ☑  Script ends with return
#
# ── BONUS CHALLENGE ──────────────────────────────────────────────────────────
#
#   Try adding a THIRD character! For example:
#
#     define t = Character("Taylor")
#
#   Then add Taylor into the conversation somewhere in the middle.
#
# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
#
#   Replace Alex and Jordan with your own original characters.
#   Think about:
#     - Who are they? (friends, rivals, strangers?)
#     - Where are they? (school, space station, haunted castle?)
#     - What do they want? (to solve a mystery, to get somewhere?)
