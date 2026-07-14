# ============================================================
#  DAY 7 — EXAMPLE 1: Hello, Menu!
#  The absolute simplest branching choice.
#
#  CONCEPTS COVERED:
#    • menu:  block syntax
#    • Quoted choice strings
#    • jump   statement
#    • label  bookmarks
#    • return to end a label
#
#  HOW TO RUN:
#    1. Open RenPy launcher → Create a new project
#    2. Replace the contents of script.rpy with this file
#    3. Click "Launch Project"
# ============================================================

label start:

    # Plain narration — no character, just the story voice
    "You are standing in front of two doors."
    "The left door is painted red. The right door is painted blue."

    # ── THE MENU ─────────────────────────────────────────
    # Rules to remember:
    #   • "menu:" is followed by a colon — no text on the same line
    #   • Each choice is indented 8 spaces (two levels)
    #   • Each choice string is quoted and ends with a colon
    #   • The jump inside each choice is indented 12 spaces
    # ─────────────────────────────────────────────────────
    menu:
        "Open the red door":
            jump red_door

        "Open the blue door":
            jump blue_door


# ── PATH A ───────────────────────────────────────────────
label red_door:

    "You push open the red door."
    "Inside you find a cozy library filled with books."
    "You spend the afternoon reading. It was a great choice."

    return      # <-- Always end a label with return!


# ── PATH B ───────────────────────────────────────────────
label blue_door:

    "You push open the blue door."
    "It opens onto a sunny garden with a fountain."
    "You sit by the water and listen to birdsong."

    return
