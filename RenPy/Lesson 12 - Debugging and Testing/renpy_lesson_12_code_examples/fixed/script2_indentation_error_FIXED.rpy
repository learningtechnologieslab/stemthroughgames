# =============================================================================
# SCRIPT 2 — FIXED VERSION
# Bug Type: Indentation Error (two misaligned lines inside the menu)
#
# THE FIXES:
#   Fix 1 — Line after "Suggest singing" choice:
#     Changed:  s "You'd be amazing!..."  (wrong indent: was at menu level)
#     To:             s "You'd be amazing!..."  (correct: 8 spaces, inside choice)
#
#   Fix 2 — Line inside "Suggest a comedy skit":
#     Changed:                s "I'll help you write..."  (too many spaces: 16)
#     To:             s "I'll help you write..."  (correct: 8 spaces)
#
# INDENTATION RULES IN RENPY:
#   label:              → 0 spaces
#       dialogue        → 4 spaces
#       menu:           → 4 spaces
#           "Choice":   → 8 spaces
#               dialogue inside choice → 12 spaces
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
            s "You'd be amazing! You sing in the hallway all the time."   # FIXED: 12 spaces
            j "Ha! You noticed that?"

        "Suggest a comedy skit":
            j "A comedy skit? That could be really fun actually."
            s "I'll help you write the jokes!"   # FIXED: 12 spaces (was 16)
            j "Deal. Let's do it!"

    j "Thanks for the encouragement. I'll sign up tomorrow."
    return
