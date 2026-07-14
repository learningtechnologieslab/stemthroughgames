# ============================================================
#  CHALLENGE 4 — Logic Error: The Broken Accumulator  (FIXED)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  THE BUG:  "total = i" replaces total with i every time
#            through the loop.  By the end, total just holds
#            the last value of i (which is 5), not the sum.
#
#  THE FIX:  "total += i"  which means  "total = total + i"
#            This adds i to whatever total already holds,
#            accumulating the running sum.
#
#  HAND TRACE (broken):          HAND TRACE (fixed):
#    i=1 → total = 1               i=1 → total = 0+1 = 1
#    i=2 → total = 2               i=2 → total = 1+2 = 3
#    i=3 → total = 3               i=3 → total = 3+3 = 6
#    i=4 → total = 4               i=4 → total = 6+4 = 10
#    i=5 → total = 5  ← wrong!     i=5 → total = 10+5 = 15 ✓
#
#  KEY LESSON:
#    No error message ≠ correct program.
#    Always verify the output matches what you expect!
#
# ============================================================

total = 0

for i in range(1, 6):
    total += i          # FIX: += adds i to the running total
                        #      instead of replacing it

print("Sum:", total)    # Expected: Sum: 15

# ---- Bonus: understanding += --------------------------------
# total += i   is shorthand for   total = total + i
# Other shorthand operators:
#   total -= i   →   total = total - i
#   total *= i   →   total = total * i
# ------------------------------------------------------------
