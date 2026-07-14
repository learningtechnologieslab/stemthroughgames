# ============================================================
#  CHALLENGE 1 — Syntax Error: The Missing Colon  (BROKEN)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  INTENDED BEHAVIOR:
#    Ask the user for their age and print whether
#    they are a teenager (13–19).
#
#  YOUR TASK:
#    1. Run this file and read the error message carefully.
#    2. Which line does Python point to?
#    3. What punctuation is Python expecting that it didn't find?
#    4. Fix the bug, then test with ages: 12, 16, and 20.
#       Make sure all three give the correct answer!
#
# ============================================================

age = int(input("How old are you? "))

if age >= 13 and age <= 19        # <-- look carefully at this line
    print("You are a teenager!")
else:
    print("You are not a teenager.")
