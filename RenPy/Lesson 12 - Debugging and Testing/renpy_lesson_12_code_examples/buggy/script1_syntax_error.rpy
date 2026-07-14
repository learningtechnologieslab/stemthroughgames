# =============================================================================
# SCRIPT 1 — BUGGY VERSION
# Bug Type: Syntax Error
# Difficulty: Easy
#
# STUDENT CHALLENGE:
#   Something is wrong with this script. RenPy won't even launch it.
#   Can you find and fix the bug?
#
# HINT: Look very carefully at the very first line of the label.
# =============================================================================

define e = Character("Ms. Ellis", color="#2E86AB")
define p = Character("Player", color="#A23B72")

label start   # <-- BUG IS ON THIS LINE
    e "Welcome to Westbrook Middle School!"
    e "Today is your first day, and I have a feeling it's going to be great."
    p "Thanks! I'm a little nervous, but excited."
    e "That's completely normal. Every great adventure starts with a little nervousness."
    return
