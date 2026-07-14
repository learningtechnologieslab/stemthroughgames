# =============================================================================
# SCRIPT 3 — BUGGY VERSION
# Bug Type: Logic Error
# Difficulty: Medium
#
# STUDENT CHALLENGE:
#   This script RUNS without crashing — but the story goes wrong.
#   When you pick "Go to the library," you end up somewhere unexpected.
#   This is a LOGIC ERROR: the code is valid, but it does the wrong thing.
#
# HOW TO FIND IT:
#   Play through the game and test BOTH choices in the menu.
#   Trace each "jump" statement and check: does the destination label
#   match what the choice says?
# =============================================================================

define m = Character("Maya", color="#E76F51")
define r = Character("Rowan", color="#457B9D")

label start:
    m "School's out. Where do you want to go?"
    r "Hmm, I could use a quiet place to study... or I could grab a snack."

    menu:
        "Go to the library":
            jump cafeteria    # <-- BUG: should jump to 'library', not 'cafeteria'

        "Go to the cafeteria":
            jump cafeteria

label library:
    r "Ah, perfect. It's quiet in here."
    m "I'll find us a good table."
    r "This is exactly what I needed."
    jump ending

label cafeteria:
    r "Mmm, something smells good."
    m "Pizza day! Best day of the week."
    r "Now I can't focus on anything else."
    jump ending

label ending:
    m "Whatever we did, today turned out pretty well."
    r "Agreed. Same time tomorrow?"
    return
