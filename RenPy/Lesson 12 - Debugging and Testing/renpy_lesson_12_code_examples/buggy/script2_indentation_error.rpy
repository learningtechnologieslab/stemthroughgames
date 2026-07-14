# =============================================================================
# SCRIPT 2 — BUGGY VERSION
# Bug Type: Indentation Error
# Difficulty: Easy
#
# STUDENT CHALLENGE:
#   This script has an indentation problem. One or more lines are not
#   lined up at the correct level. RenPy will report an IndentationError.
#
# HINT: Count the spaces at the start of each line carefully.
#       Everything inside a label must be indented by exactly 4 spaces.
#       Everything inside a menu choice must be indented by 8 spaces.
# =============================================================================

define s = Character("Sam", color="#F4A261")
define j = Character("Jordan", color="#2A9D8F")

label start:
    s "Hey Jordan, I heard there's a talent show coming up."
    j "Yeah! I'm trying to decide whether to sign up."
    s "You totally should. What are you thinking of doing?"

    menu:
        "Suggest singing":
            j "Singing... I haven't done that in front of people before."
        s "You'd be amazing! You sing in the hallway all the time."   # <-- BUG: wrong indent level
            j "Ha! You noticed that?"

        "Suggest a comedy skit":
            j "A comedy skit? That could be really fun actually."
                s "I'll help you write the jokes!"   # <-- BUG: too many spaces
            j "Deal. Let's do it!"

    j "Thanks for the encouragement. I'll sign up tomorrow."
    return
