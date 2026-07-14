# ============================================================
#  CHALLENGE 4 — Logic Error: The Broken Accumulator  (BROKEN)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  INTENDED BEHAVIOR:
#    Add up the numbers 1 through 5 and print the total.
#    Expected output:  Sum: 15
#
#  YOUR TASK:
#    1. Run this file.  What does it actually print?
#    2. There is NO error message — this is a logic bug.
#       The code runs fine but gives the wrong answer.
#    3. Trace through the loop by hand:
#
#       i=1 → total = ___
#       i=2 → total = ___
#       i=3 → total = ___
#       i=4 → total = ___
#       i=5 → total = ___   (this is what gets printed)
#
#    4. What is line 27 actually doing to "total" each time?
#       What should it be doing instead?
#
# ============================================================

total = 0

for i in range(1, 6):
    total = i           # <-- what does this line actually do?
                        #     hint: is it adding, or replacing?

print("Sum:", total)
