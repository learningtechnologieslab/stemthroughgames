# ============================================================
#  CHALLENGE 5 — Logic Error: Off-by-One Loop  (FIXED)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  THE BUG:  range(10) generates 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
#            — it starts at 0 and stops BEFORE 10.
#            The output is missing 10 and includes 0.
#
#  THE FIX:  range(1, 11)  starts at 1, stops before 11,
#            producing 1, 2, 3, 4, 5, 6, 7, 8, 9, 10. ✓
#
#  HOW range() WORKS:
#    range(stop)        → 0, 1, 2, … stop-1
#    range(start, stop) → start, start+1, … stop-1
#
#  MEMORY TRICK:
#    Think of range() like a slice of a number line:
#    the left boundary is INCLUDED, the right is EXCLUDED.
#    range(1, 11) covers [1 … 10], not including 11.
#
# ============================================================

for i in range(1, 11):  # FIX: start=1, stop=11 (stops before 11)
    print(i)

# ---- Bonus: range() quick reference -----------------------
#
#  range(5)       →  0, 1, 2, 3, 4
#  range(1, 6)    →  1, 2, 3, 4, 5
#  range(0, 10, 2)→  0, 2, 4, 6, 8    (step of 2)
#  range(10, 0, -1)→ 10, 9, 8, … 1    (count down)
#
# -----------------------------------------------------------
