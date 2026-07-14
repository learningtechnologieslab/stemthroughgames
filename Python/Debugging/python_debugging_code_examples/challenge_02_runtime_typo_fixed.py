# ============================================================
#  CHALLENGE 2 — Runtime Error: Typo in Variable Name  (FIXED)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  THE BUG:  "lenght" on line 24 — the letters 'g' and 'h'
#            are swapped.  The variable was defined as "length"
#            (correct spelling) on line 19.
#
#  WHY IT HAPPENED:
#    Python is case-sensitive and spelling-sensitive.
#    "length", "Length", and "lenght" are three completely
#    different names to Python.  It only knows about names
#    that have been explicitly assigned with = .
#
#  THE FIX:  Change "lenght" → "length"
#
#  PRO TIP:  Use an IDE with auto-complete to avoid this class
#            of bug entirely.  Also: copy-paste variable names
#            instead of retyping them when possible.
#
# ============================================================

length = float(input("Enter the length: "))
width  = float(input("Enter the width:  "))

area = length * width             # FIX: corrected spelling

print("The area is:", area)

# ---- Test cases (expected results) -------------------------
# length=5, width=3  → "The area is: 15.0"
# length=7, width=2  → "The area is: 14.0"
# ------------------------------------------------------------
