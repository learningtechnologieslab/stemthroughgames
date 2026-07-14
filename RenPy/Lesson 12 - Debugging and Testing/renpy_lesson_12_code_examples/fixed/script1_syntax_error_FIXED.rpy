# =============================================================================
# SCRIPT 1 — FIXED VERSION
# Bug Type: Syntax Error (was missing colon after "label start")
#
# THE FIX:
#   Changed:  label start
#   To:       label start:
#
# WHY: In RenPy (and Python), a colon (:) is required after every label,
#      menu, if, and elif statement. Without it, the parser doesn't know
#      that a block of code is about to begin.
# =============================================================================

define e = Character("Ms. Ellis", color="#2E86AB")
define p = Character("Player", color="#A23B72")

label start:    # FIXED: Added the missing colon
    e "Welcome to Westbrook Middle School!"
    e "Today is your first day, and I have a feeling it's going to be great."
    p "Thanks! I'm a little nervous, but excited."
    e "That's completely normal. Every great adventure starts with a little nervousness."
    return
