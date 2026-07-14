# ============================================================
#  CHALLENGE 1 — Syntax Error: The Missing Colon  (FIXED)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  THE BUG:  Missing colon (:) at the end of the if statement.
#
#  WHY IT HAPPENED:
#    Python uses a colon to signal "a block of code follows."
#    Every if, elif, else, for, while, and def line MUST end
#    with a colon.  Forgetting it is one of the most common
#    beginner mistakes — even experienced programmers do it!
#
#  THE FIX:  Add the colon → if age >= 13 and age <= 19:
#
# ============================================================

age = int(input("How old are you? "))

if age >= 13 and age <= 19:       # FIX: added the colon here
    print("You are a teenager!")
else:
    print("You are not a teenager.")

# ---- Test cases (expected results) -------------------------
# Age 12  → "You are not a teenager."
# Age 16  → "You are a teenager!"
# Age 20  → "You are not a teenager."
# ------------------------------------------------------------
