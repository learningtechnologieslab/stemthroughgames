# ============================================================
#  CHALLENGE 2 — Runtime Error: Typo in Variable Name  (BROKEN)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  INTENDED BEHAVIOR:
#    Ask the user for a rectangle's length and width,
#    then calculate and print the area.
#
#  YOUR TASK:
#    1. Run this file. Read the error message carefully.
#    2. What kind of error is it?  (Hint: NameError)
#    3. Python will name the variable it can't find.
#       Compare that name to where the variable was first
#       created — can you spot the difference?
#    4. Fix the single typo and re-run to verify.
#
# ============================================================

length = float(input("Enter the length: "))
width  = float(input("Enter the width:  "))

area = lenght * width             # <-- look very carefully here

print("The area is:", area)
