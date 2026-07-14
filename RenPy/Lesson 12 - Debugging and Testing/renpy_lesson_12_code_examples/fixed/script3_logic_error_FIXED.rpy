# =============================================================================
# SCRIPT 3 — FIXED VERSION
# Bug Type: Logic Error (wrong jump target in menu choice)
#
# THE FIX:
#   Changed:  jump cafeteria   (inside the "Go to the library" choice)
#   To:       jump library
#
# WHY THIS IS TRICKY:
#   RenPy does NOT crash on a logic error — it happily jumps to 'cafeteria'
#   even though the player chose the library. The only way to catch this
#   bug is to TEST every path and watch what actually happens.
#
# LESSON: Always test every single menu choice after writing it!
# =============================================================================

define m = Character("Maya", color="#E76F51")
define r = Character("Rowan", color="#457B9D")

label start:
    m "School's out. Where do you want to go?"
    r "Hmm, I could use a quiet place to study... or I could grab a snack."

    menu:
        "Go to the library":
            jump library    # FIXED: now correctly jumps to 'library'

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
