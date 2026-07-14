# =============================================================================
# SCRIPT 4 — FIXED VERSION
# Bug Type: Name Error + Logic Error (two bugs fixed)
#
# FIX #1 — Variable used before assignment:
#   The 'if made_team' check was BEFORE the variable was ever set.
#   Solution: Initialize 'made_team' to False at the top of the label,
#   OR move the if/else check to AFTER the menu where the variable is set.
#   We chose to initialize it first, which is the cleaner approach.
#
#   Changed:  (nothing — just added)  $ made_team = False  before the if check
#
# FIX #2 — Typo in label name:
#   Changed:  jump finalle
#   To:       jump finale
#
#   RenPy is case-sensitive and spelling-sensitive. 'finalle' and 'finale'
#   are completely different names to RenPy — it will crash trying to find
#   a label called 'finalle' that doesn't exist.
# =============================================================================

define t = Character("Taylor", color="#6A0572")
define c = Character("Coach Rivera", color="#1A535C")

label start:
    $ made_team = False    # FIXED #1: Initialize the variable before using it

    if made_team:
        t "I can't believe I actually made the team!"
    else:
        t "I'm so nervous about tryouts today."

    c "Taylor! Come on in. Tryouts start in five minutes."
    t "I'm ready, Coach. I've been practicing every day."

    menu:
        "Give it everything you've got":
            $ made_team = True
            c "Incredible effort out there today, Taylor."
            jump results_good

        "Play it safe — don't risk embarrassing yourself":
            $ made_team = False
            c "You seemed hesitant today. Don't hold back next time."
            jump results_bad

label results_good:
    c "I'm pleased to tell you — you made the team!"
    t "YES! I knew all that practice would pay off!"
    jump finale    # FIXED #2: Corrected 'finalle' → 'finale'

label results_bad:
    c "You didn't make it this round, but keep working hard."
    t "I'll be back next year. I promise."
    jump finale    # FIXED #2: Corrected 'finalle' → 'finale'

label finale:
    t "Whatever happens, I gave it my all."
    return
