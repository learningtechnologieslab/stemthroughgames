# ============================================================
#  06_common_mistakes.py  —  Bugs & How to Fix Them
#  Middle School Python · Unit 4 · Lesson 4.2
# ============================================================
#
#  Each section shows a BROKEN version followed by the FIX.
#  The broken code is commented out so the file runs safely.
#
#  Mistakes covered:
#    1. Forgetting to update the loop variable (infinite loop)
#    2. Off-by-one errors (looping too many or too few times)
#    3. Using = instead of == in the condition
#    4. Forgetting int() when reading input
#    5. Updating the counter AFTER the loop instead of inside it
#    6. Condition that is never True (loop never runs)
# ============================================================

print("=" * 50)
print("  COMMON WHILE LOOP MISTAKES & FIXES")
print("=" * 50)

# ============================================================
# MISTAKE 1: Forgetting to update the variable
# ============================================================
print("\n--- Mistake 1: Forgetting to update the variable ---")

# BROKEN (infinite loop — DO NOT UNCOMMENT):
# x = 1
# while x <= 5:
#     print(x)
#     # x never changes → loops forever!

# FIX: always update inside the loop body
print("BROKEN code would loop forever. Here is the FIX:")

x = 1
while x <= 5:
    print(x)
    x += 1          # ← update x so the condition eventually becomes False

print("Loop finished correctly.\n")

# ============================================================
# MISTAKE 2: Off-by-one error (too many iterations)
# ============================================================
print("--- Mistake 2: Off-by-one — printing 1 extra number ---")

# BROKEN: uses < instead of <=, so it stops one number too early
print("BROKEN (stops too early — misses the last number):")
i = 1
while i < 5:        # condition should be i <= 5
    print(i, end="  ")
    i += 1
print()

# FIX:
print("FIXED (prints all 5 numbers):")
i = 1
while i <= 5:       # <= includes 5 in the loop
    print(i, end="  ")
    i += 1
print()

# ============================================================
# MISTAKE 3: Using = (assignment) instead of == (comparison)
# ============================================================
print("\n--- Mistake 3: = vs == in condition ---")

# BROKEN — SyntaxError in Python, so we just describe it:
# while answer = "yes":   # ← = is assignment, not comparison!
#     ...

# FIX:
print("BROKEN: while answer = 'yes'  ← SyntaxError!")
print("FIXED : while answer == 'yes'  ← == compares values")

answer = "yes"
while answer == "yes":
    print("  Inside the loop!")
    answer = "no"   # update so we don't loop forever

print()

# ============================================================
# MISTAKE 4: Forgetting to convert input() to int
# ============================================================
print("--- Mistake 4: Forgetting int() with input ---")

# BROKEN — comparing a string to a number never works as expected:
# user_input = input("Enter a number: ")
# while user_input < 10:   # ← TypeError! can't compare str and int
#     ...

# FIX:
print("BROKEN: comparing input() directly to an int causes a TypeError.")
print("FIXED : always wrap input() in int() when you expect a number.\n")

guess = 0
while guess != 7:
    try:
        guess = int(input("Guess the magic number (1-10): "))  # int() converts str → int
    except ValueError:
        print("  That's not a number — try again!")
        continue

print("You found the magic number!\n")

# ============================================================
# MISTAKE 5: Updating the counter OUTSIDE (after) the loop
# ============================================================
print("--- Mistake 5: Counter updated outside the loop ---")

# BROKEN (infinite loop):
# count = 0
# while count < 5:
#     print(count)
# count += 1    # ← indented wrong — this is OUTSIDE the loop!

# FIX: make sure the update is indented inside the loop body
print("BROKEN: count += 1 is outside the loop → infinite loop!")
print("FIXED : indent count += 1 so it is INSIDE the loop body:\n")

count = 0
while count < 5:
    print(f"  count = {count}")
    count += 1  # properly indented — runs every iteration

print()

# ============================================================
# MISTAKE 6: Condition is never True — loop never runs
# ============================================================
print("--- Mistake 6: Loop body never executes ---")

# BROKEN: starting value makes condition False right away
start = 10
print(f"BROKEN: start = {start}, condition is start < 5  → loop never runs")

while start < 5:        # 10 < 5 is False immediately
    print("This never prints!")  # dead code

print("  (Nothing was printed — the loop was skipped entirely.)\n")

# FIX: check your starting value vs your condition
start = 1
print(f"FIXED: start = {start}, condition is start < 5  → loop runs correctly")
while start < 5:
    print(f"  start = {start}")
    start += 1

# ============================================================
# Quick reference summary
# ============================================================
print("\n" + "=" * 50)
print("  QUICK CHECKLIST BEFORE YOU RUN A WHILE LOOP")
print("=" * 50)
checklist = [
    "Is the starting value correct?",
    "Is the condition using == not = ?",
    "Does the loop body UPDATE the variable?",
    "Is the update line INSIDE the loop (indented)?",
    "Does the starting value make the condition True at least once?",
    "Is input() wrapped in int() if you need a number?",
]
for item in checklist:
    print(f"  ☐  {item}")
