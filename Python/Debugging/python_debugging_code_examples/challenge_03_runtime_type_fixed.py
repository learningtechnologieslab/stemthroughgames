# ============================================================
#  CHALLENGE 3 — Runtime Error: Wrong Data Type  (FIXED)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  THE BUG:  input() always returns a STRING, even if the
#            user types a number.  Adding a string to an
#            integer (age + 1) causes a TypeError because
#            Python doesn't know whether to treat "14" as
#            the number 14 or the text "14".
#
#  WHY IT HAPPENED:
#    Python has strict rules about mixing types in arithmetic.
#    "14" + 1  →  TypeError  (string + int makes no sense)
#     14  + 1  →  15         (int + int is fine)
#
#  THE FIX:  Wrap input() with int() to convert the string
#            to an integer before doing the math.
#            age = int(input("How old are you? "))
#
# ============================================================

name = input("What is your name? ")
age  = int(input("How old are you? "))  # FIX: convert to int

next_year = age + 1

print("Hi " + name + "! Next year you will be", next_year)

# ---- Test cases (expected results) -------------------------
# name="Alex", age=13  → "Hi Alex! Next year you will be 14"
# name="Sam",  age=17  → "Hi Sam! Next year you will be 18"
# ------------------------------------------------------------
