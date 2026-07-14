# ============================================================
#  CHALLENGE 3 — Runtime Error: Wrong Data Type  (BROKEN)
#  Middle School Python · Debugging Lesson
# ============================================================
#
#  INTENDED BEHAVIOR:
#    Ask the user for their name and age, then print a
#    friendly greeting that includes their age next year.
#
#  YOUR TASK:
#    1. Run this file. Read the error message.
#    2. What is a TypeError?  What two types does Python
#       mention in the message?
#    3. What does input() always return?
#       What function converts that into a whole number?
#    4. Where exactly should that conversion happen?
#       Fix the bug and re-run.
#
# ============================================================

name = input("What is your name? ")
age  = input("How old are you? ")  # <-- what type does input() return?

next_year = age + 1                # <-- what happens when you add
                                   #     a string and an integer?

print("Hi", name + "! Next year you will be", next_year)
