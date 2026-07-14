# ============================================================
#  03_break_and_continue.py  —  Controlling Loop Flow
#  Middle School Python · Unit 4 · Lesson 4.2
# ============================================================
#
#  Topics covered:
#    • break  — exit the loop immediately
#    • continue — skip the rest of this iteration
#    • while True: with break (common real-world pattern)
#    • Combining break and continue in one loop
# ============================================================

print("=" * 50)
print("  BREAK AND CONTINUE")
print("=" * 50)

# ------------------------------------------------------------
# Example 1: break — stop at the first multiple of 7
# ------------------------------------------------------------
print("\n--- Example 1: break — stop at first multiple of 7 ---")

n = 1
while n <= 100:
    if n % 7 == 0:           # % is the "remainder" operator
        print(f"Found it! {n} is the first multiple of 7.")
        break                # exit the loop right now
    n += 1

# ------------------------------------------------------------
# Example 2: continue — skip even numbers, print only odds
# ------------------------------------------------------------
print("\n--- Example 2: continue — print only odd numbers 1-20 ---")

num = 0
while num < 20:
    num += 1
    if num % 2 == 0:         # if num is even...
        continue             # ...skip the print and go back to check condition
    print(num, end="  ")

print()  # newline after the row

# ------------------------------------------------------------
# Example 3: while True + break — the "loop forever until done" pattern
# ------------------------------------------------------------
print("\n--- Example 3: while True + break (quit when done) ---")
print("Keep entering words. Type 'done' to finish.\n")

words = []
while True:                  # loop runs forever...
    word = input("Enter a word (or 'done' to stop): ")
    if word.lower() == "done":
        break                # ...until we break out here
    words.append(word)
    print(f"  Added '{word}'. List so far: {words}")

print(f"\nYou collected {len(words)} word(s): {words}")

# ------------------------------------------------------------
# Example 4: skip negative numbers, stop at 999
# ------------------------------------------------------------
print("\n--- Example 4: Skip negatives, stop at 999 ---")
print("Enter numbers to add. Negative numbers are ignored. Enter 999 to stop.\n")

total = 0
count = 0

while True:
    value = int(input("Enter a number: "))

    if value == 999:
        print("Stopping!")
        break                # sentinel value — exit loop

    if value < 0:
        print(f"  Skipping {value} (negative numbers don't count).")
        continue             # skip the rest of this iteration

    total += value
    count += 1
    print(f"  Added {value}. Running total: {total}")

if count > 0:
    print(f"\nFinal total : {total}")
    print(f"Numbers counted: {count}")
    print(f"Average    : {total / count:.2f}")
else:
    print("No valid numbers were entered.")

# ------------------------------------------------------------
# Example 5: Finding prime numbers using continue
# ------------------------------------------------------------
print("\n--- Example 5: Find primes from 2 to 30 using continue ---")

candidate = 2
primes = []

while candidate <= 30:
    is_prime = True
    divisor = 2

    # Check if candidate is divisible by anything smaller than itself
    while divisor < candidate:
        if candidate % divisor == 0:
            is_prime = False
            break            # no need to keep checking
        divisor += 1

    if not is_prime:
        candidate += 1
        continue             # skip adding to list; move to next candidate

    primes.append(candidate)
    candidate += 1

print(f"Primes from 2 to 30: {primes}")
