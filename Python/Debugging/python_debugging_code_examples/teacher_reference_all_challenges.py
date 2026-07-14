# ================================================================
#  TEACHER REFERENCE — Debugging Lesson
#  Middle School Python · All 5 Challenges (Bugs + Fixes)
#
#  Do NOT distribute to students before the activity.
#
#  Each challenge section includes:
#    - The broken code
#    - The exact bug explained
#    - The fixed version
#    - Common student misconceptions to watch for
# ================================================================


# ----------------------------------------------------------------
#  CHALLENGE 1 — Syntax Error: The Missing Colon
# ----------------------------------------------------------------

# --- BROKEN ---
# if age >= 13 and age <= 19        ← no colon → SyntaxError
#     print("You are a teenager!")

# --- BUG ---
# Missing colon at the end of the if statement.
# Python raises:  SyntaxError: expected ':'

# --- FIXED ---
# if age >= 13 and age <= 19:
#     print("You are a teenager!")

# --- COMMON MISCONCEPTIONS ---
# • Students may think the error is on the line with print(),
#   because Python sometimes points there. Explain that the
#   parser realises something is wrong when it hits the indent,
#   not necessarily the exact line with the typo.
# • Some students add the colon to the else line instead —
#   the else already has one; the if line is missing it.


print("=" * 60)
print("CHALLENGE 1 DEMO — broken code raises SyntaxError")
print("Uncomment the broken block below to see the error.")
print("=" * 60)

# Uncomment to show students the error:
# age = int(input("How old are you? "))
# if age >= 13 and age <= 19
#     print("You are a teenager!")
# else:
#     print("You are not a teenager.")

# Working version:
age = int(input("How old are you? "))
if age >= 13 and age <= 19:
    print("You are a teenager!")
else:
    print("You are not a teenager.")


# ----------------------------------------------------------------
#  CHALLENGE 2 — Runtime Error: Typo in Variable Name
# ----------------------------------------------------------------

# --- BROKEN ---
# length = float(input("Enter the length: "))
# width  = float(input("Enter the width:  "))
# area = lenght * width     ← 'lenght' was never defined → NameError

# --- BUG ---
# "lenght" is a misspelling of "length".
# Python raises:  NameError: name 'lenght' is not defined

# --- FIXED ---
# area = length * width

# --- COMMON MISCONCEPTIONS ---
# • Students sometimes hunt on the wrong line. Point them to the
#   NameError message: Python will print the exact bad name.
# • Ask: "Where was 'lenght' ever assigned with =?" — it wasn't.
# • Good opportunity to teach copy-paste / auto-complete habits.

print("\n" + "=" * 60)
print("CHALLENGE 2 DEMO — NameError")
print("=" * 60)

length = float(input("Enter the length: "))
width  = float(input("Enter the width:  "))
area = length * width        # fixed spelling
print("The area is:", area)


# ----------------------------------------------------------------
#  CHALLENGE 3 — Runtime Error: Wrong Data Type
# ----------------------------------------------------------------

# --- BROKEN ---
# age  = input("How old are you? ")   ← returns a str, e.g. "14"
# next_year = age + 1                 ← str + int → TypeError

# --- BUG ---
# input() always returns a string. You can't add an integer (1) to
# a string ("14"). Python raises:
#   TypeError: can only concatenate str (not "int") to str

# --- FIXED ---
# age = int(input("How old are you? "))

# --- COMMON MISCONCEPTIONS ---
# • Students sometimes try:  next_year = int(age) + 1  (after input)
#   — this works too! Discuss both placements and which is cleaner.
# • Some students confuse this with Challenge 2. Clarify: NameError
#   is about a name that doesn't exist; TypeError is about the wrong
#   type of value being used in an operation.

print("\n" + "=" * 60)
print("CHALLENGE 3 DEMO — TypeError")
print("=" * 60)

name = input("What is your name? ")
age  = int(input("How old are you? "))   # fixed: wrapped in int()
next_year = age + 1
print("Hi " + name + "! Next year you will be", next_year)


# ----------------------------------------------------------------
#  CHALLENGE 4 — Logic Error: The Broken Accumulator
# ----------------------------------------------------------------

# --- BROKEN ---
# for i in range(1, 6):
#     total = i     ← replaces total with i each time; ends up as 5

# --- BUG ---
# total = i  assigns (replaces).
# total += i  accumulates (adds to existing value).
# No error message — this is a pure logic bug.
# Output: "Sum: 5"  instead of  "Sum: 15"

# --- FIXED ---
# total += i

# --- COMMON MISCONCEPTIONS ---
# • This is the most conceptually challenging bug. Many students
#   read "total = i" as "total becomes i" which is literally true
#   but misses the point — it forgets the previous total.
# • Use a physical analogy: if you're counting money and you keep
#   putting the new coin in your pocket instead of adding it to the
#   pile, you'll always end up with just the last coin.
# • The hand-trace in the slide is very effective here. Walk through
#   it on the board before revealing the fix.

print("\n" + "=" * 60)
print("CHALLENGE 4 DEMO — Logic error (no error message!)")
print("=" * 60)

print("--- BROKEN output ---")
total = 0
for i in range(1, 6):
    total = i           # bug: replaces instead of accumulates
print("Sum:", total)    # prints 5, not 15

print("\n--- FIXED output ---")
total = 0
for i in range(1, 6):
    total += i          # fix: accumulates correctly
print("Sum:", total)    # prints 15 ✓


# ----------------------------------------------------------------
#  CHALLENGE 5 — Logic Error: Off-by-One Loop
# ----------------------------------------------------------------

# --- BROKEN ---
# for i in range(10):  ← produces 0, 1, 2, … 9  (not 1–10)
#     print(i)

# --- BUG ---
# range(10) starts at 0 by default and stops BEFORE 10.
# Output prints 0–9 instead of 1–10. No error message.

# --- FIXED ---
# for i in range(1, 11):  ← start=1, stop=11 → 1, 2, … 10

# --- COMMON MISCONCEPTIONS ---
# • "Why doesn't range(10) go up to 10?" — Python uses exclusive
#   upper bounds, like Python slices and most CS conventions.
#   A useful answer: range(0, 10) gives you exactly 10 numbers.
# • Some students try range(1, 10) → still off by one (stops at 9).
#   Make sure they test the last value.
# • Off-by-one errors are so common they have a name in CS: OBOE.
#   Mention this — it makes students feel like real programmers.

print("\n" + "=" * 60)
print("CHALLENGE 5 DEMO — Off-by-one (no error message!)")
print("=" * 60)

print("--- BROKEN: range(10) → 0 through 9 ---")
for i in range(10):
    print(i, end=" ")
print()

print("\n--- FIXED: range(1, 11) → 1 through 10 ---")
for i in range(1, 11):
    print(i, end=" ")
print()


# ----------------------------------------------------------------
#  SUMMARY TABLE
# ----------------------------------------------------------------
print("\n" + "=" * 60)
print("SUMMARY")
print("=" * 60)
print(f"{'Challenge':<14} {'Error Type':<14} {'The Bug'}")
print("-" * 60)
print(f"{'1':<14} {'Syntax':<14} Missing colon after if condition")
print(f"{'2':<14} {'Runtime':<14} Typo: 'lenght' instead of 'length'")
print(f"{'3':<14} {'Runtime':<14} input() returns str; needs int()")
print(f"{'4':<14} {'Logic':<14} total = i instead of total += i")
print(f"{'5':<14} {'Logic':<14} range(10) starts at 0, not 1")
print("=" * 60)
