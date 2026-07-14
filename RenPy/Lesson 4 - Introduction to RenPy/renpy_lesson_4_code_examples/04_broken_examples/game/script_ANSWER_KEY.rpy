# =============================================================================
# Day 4 – Project 4: Bug Hunt! — ANSWER KEY (Teacher Copy)
# =============================================================================
#
# BUG 1 (line 27): Missing colon after "label start"
#   BROKEN:  label start
#   FIXED:   label start:
#
# BUG 2 (line 32): Wrong indentation — only 2 spaces instead of 4
#   BROKEN:    "This line has a problem with its indentation."   (2 spaces)
#   FIXED:     "This line has a problem with its indentation."   (4 spaces)
#
# BUG 3 (line 36): Nested label inside label start — not valid Ren'Py structure
#   BROKEN:   label middle:  (indented inside label start)
#   FIXED:    Remove or move label middle: to the top level (no indent)
#             For this exercise, the simplest fix is just to remove the
#             inner label line and its matching indented content,
#             keeping the dialogue lines at 4-space indent.
#
# BUG 4 (line 40): return appears too early, cutting off the rest of the story
#   BROKEN:   return placed after "Keep looking for bugs!"
#   FIXED:    Delete that early return; keep only the final return at the bottom
#
# BUG 5 (line 48): Unclosed quotation mark
#   BROKEN:   "Almost done — just one bug left!
#   FIXED:    "Almost done — just one bug left!"
#
# =============================================================================
# CORRECTED SCRIPT:
# =============================================================================

label start:

    "Welcome to the Bug Hunt!"

    "Can you find all the mistakes in this script?"

    "This line has a problem with its indentation."

    "Look carefully at every label and every line."

    "Some bugs are hard to spot!"

    "This is the middle of the story."

    "Keep looking for bugs!"

    "You found the early return! The story was cut off here."

    "One more line before the real ending."

    "Almost done — just one bug left!"

    return
