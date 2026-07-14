# =============================================================================
# SCRIPT 4 — BUGGY VERSION
# Bug Type: Name Error + Logic Error (two bugs)
# Difficulty: Medium
#
# STUDENT CHALLENGE:
#   There are TWO bugs hiding in this script.
#
#   Bug #1 — Variable used before it's assigned:
#     A variable is being checked in an 'if' statement before it was
#     ever given a value. Think about WHEN the variable gets set.
#
#   Bug #2 — Typo in a label name:
#     One 'jump' statement is trying to go to a label that doesn't exist
#     because of a spelling mistake.
#
# STRATEGY: Read every 'if' and 'jump' carefully. For each one, ask:
#   - Does this variable exist at this point in the story?
#   - Does this label name match exactly?
# =============================================================================

define t = Character("Taylor", color="#6A0572")
define c = Character("Coach Rivera", color="#1A535C")

label start:
    # Bug #1: 'made_team' is checked here before it is ever defined
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
    jump finale

label results_bad:
    c "You didn't make it this round, but keep working hard."
    t "I'll be back next year. I promise."
    jump finale

label finale:    # Bug #2: jump below says 'finalle' (double-l typo)
    t "Whatever happens, I gave it my all."
    return

# Note: somewhere later in a longer script there is this line:
# jump finalle    <-- BUG: 'finalle' is misspelled, should be 'finale'
