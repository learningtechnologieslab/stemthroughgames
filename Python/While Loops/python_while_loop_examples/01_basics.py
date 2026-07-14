# ============================================================
#  01_basics.py  —  While Loop Fundamentals
#  Middle School Python · Unit 4 · Lesson 4.2
# ============================================================
#
#  Topics covered:
#    • Basic while loop syntax
#    • Counting up and counting down
#    • Loop with a step value
#    • while loop vs for loop comparison
# ============================================================

print("=" * 50)
print("  WHILE LOOP BASICS")
print("=" * 50)

# ------------------------------------------------------------
# Example 1: Count UP from 1 to 5
# ------------------------------------------------------------
print("\n--- Example 1: Count Up ---")

count = 1                    # start value
while count <= 5:            # condition: keep going while count is 5 or less
    print(count)
    count += 1               # IMPORTANT: update count or we loop forever!

print("Done counting up!")

# ------------------------------------------------------------
# Example 2: Count DOWN from 10 to 1
# ------------------------------------------------------------
print("\n--- Example 2: Countdown ---")

countdown = 10
while countdown > 0:
    print(f"T-minus {countdown}...")
    countdown -= 1           # subtract 1 each time

print("🚀 Blast off!")

# ------------------------------------------------------------
# Example 3: Count by 3s (using a step)
# ------------------------------------------------------------
print("\n--- Example 3: Count by 3s ---")

number = 0
while number <= 30:
    print(number, end="  ")  # end="  " keeps output on one line
    number += 3

print()  # blank line after the row of numbers

# ------------------------------------------------------------
# Example 4: Sum the numbers 1 through 10
# ------------------------------------------------------------
print("\n--- Example 4: Summing 1 to 10 ---")

total = 0
n = 1
while n <= 10:
    total += n               # add n to the running total
    n += 1

print(f"1 + 2 + 3 + ... + 10 = {total}")

# ------------------------------------------------------------
# Example 5: while vs for — doing the same thing two ways
# ------------------------------------------------------------
print("\n--- Example 5: while vs for (same result) ---")

print("Using while:")
i = 0
while i < 5:
    print(f"  i = {i}")
    i += 1

print("Using for:")
for i in range(5):
    print(f"  i = {i}")

print("\nBoth loops print exactly the same thing!")
print("Use 'for' when you know the count. Use 'while' when you don't.")
