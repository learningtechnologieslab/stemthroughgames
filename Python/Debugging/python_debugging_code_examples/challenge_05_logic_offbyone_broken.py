# ============================================================
#  CHALLENGE 5 — Logic Error: Off-by-One Loop  (BROKEN)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  INTENDED BEHAVIOR:
#    Print the numbers 1 through 10, one per line.
#
#  YOUR TASK:
#    1. Run this file.  List the numbers it actually prints.
#    2. How many numbers does it print?
#       Which number is missing?  Which number shouldn't be there?
#    3. Look up (or recall):
#         range(n)       → starts at ___, stops before ___
#         range(a, b)    → starts at ___, stops before ___
#    4. How many arguments does range() need to print
#       exactly 1, 2, 3, … 10?
#
# ============================================================

for i in range(10):     # <-- what does range(10) actually produce?
    print(i)
