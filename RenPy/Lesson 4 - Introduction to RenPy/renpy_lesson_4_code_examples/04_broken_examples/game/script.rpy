# =============================================================================
# Day 4 – Project 4: Bug Hunt!
# This file has INTENTIONAL ERRORS. Your job: find them and fix them.
#
# There are 6 bugs hidden in this script.
# Read the error messages Ren'Py gives you — they point to the right line.
#
# HINT: Look for these kinds of mistakes:
#   - Missing colons after label names
#   - Wrong indentation (too many or too few spaces)
#   - Unclosed quotation marks
#   - return in the wrong place
# =============================================================================


# BUG HUNT INSTRUCTIONS:
# 1. Try to launch this project in Ren'Py.
# 2. Read the error message carefully — it will say which line is broken.
# 3. Fix ONE bug at a time and relaunch.
# 4. Keep going until the game runs all the way through!


label start          # <-- BUG 1: Something is missing at the end of this line

    "Welcome to the Bug Hunt!"

    "Can you find all the mistakes in this script?"

  "This line has a problem with its indentation."    # <-- BUG 2

    "Look carefully at every label and every line."

    "Some bugs are hard to spot!"

    label middle:     # <-- BUG 3: Labels cannot be defined inside another label like this

        "This is the middle of the story."

        "Keep looking for bugs!"

    return            # <-- BUG 4: This return ends the label too early — move it to the bottom

    "You found the early return! The story was cut off here."

    "One more line before the real ending."

    "Almost done — just one bug left!

    return            # <-- BUG 5: Look at the line two above this one very carefully
