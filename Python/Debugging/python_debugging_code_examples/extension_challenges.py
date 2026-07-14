# ================================================================
#  EXTENSION CHALLENGES — Debugging Lesson
#  Middle School Python · For students who finish early
#
#  These programs have more subtle bugs. Use the 5-step process:
#    1. READ the error (or the wrong output)
#    2. UNDERSTAND what type of error it is
#    3. HYPOTHESIZE where the bug is
#    4. TEST one fix at a time
#    5. VERIFY the output is actually correct
# ================================================================


# ----------------------------------------------------------------
#  EXTENSION A — Multiple Bugs (find ALL of them)
# ----------------------------------------------------------------
#
#  INTENDED BEHAVIOR:
#    Ask for a student's name and three test scores.
#    Print their average and a letter grade:
#      90–100 → A,  80–89 → B,  70–79 → C,  below 70 → F
#
#  There are THREE bugs in this program.
#  Find and fix all three before the output is correct.
#
# ----------------------------------------------------------------

def calculate_grade(average):
    if average >= 90:
        return "A"
    elif average >= 80:
        return "B"
    elif average >= 70
        return "C"
    else:
        return "F"

name   = input("Student name: ")
score1 = float(input("Score 1: "))
score2 = float(input("Score 2: "))
score3 = float(input("Score 3: "))

average = score1 + score2 + score3 / 3   # bug: operator precedence

grade = calculate_grade(average)

print(name + "scored an average of" + average + "— Grade: " + grade)


# ----------------------------------------------------------------
#  EXTENSION B — Write Your Own Bug
# ----------------------------------------------------------------
#
#  PART 1: Write a short Python program (10–15 lines) that:
#    • Uses at least one variable, one if statement, and one loop
#    • Works correctly
#
#  PART 2: Introduce exactly ONE intentional bug.
#    It can be any type: syntax, runtime, or logic.
#    Do NOT label or comment which line has the bug.
#
#  PART 3: Swap your file with a partner.
#    Can they find your bug using the 5-step process?
#    Can you find theirs?
#
# ---- Write your working program below this line ---------------




# ---- Now save a copy with your intentional bug ----------------
#  (Use File → Save As → give it a name like: my_bug.py)




# ----------------------------------------------------------------
#  EXTENSION C — Rubber Duck Debugging
# ----------------------------------------------------------------
#
#  Choose any one of the 5 main challenges.
#  Write a comment above EVERY SINGLE LINE of the broken version
#  explaining in plain English exactly what that line does.
#
#  Example:
#    # This line asks the user to type their age,
#    # converts their answer from a string to an integer,
#    # and stores it in a variable called 'age'.
#    age = int(input("How old are you? "))
#
#  Then answer in comments at the bottom:
#    # The bug is on line ___ because ...
#    # I know this because ...
#    # The fix is ...
#
#  Paste the challenge code here and annotate it:




# ----------------------------------------------------------------
#  EXTENSION D — print() Debugging
# ----------------------------------------------------------------
#
#  INTENDED BEHAVIOR:
#    Count how many even numbers are between 1 and 20.
#    Expected answer: 10  (2, 4, 6, 8, 10, 12, 14, 16, 18, 20)
#
#  This program gives the wrong count.
#  Use ONLY print() statements to inspect the variables —
#  no guessing allowed.  Add prints inside the loop to watch
#  what's happening, then fix the bug.
#
#  When you're done, remove your debug print() statements.
#
# ----------------------------------------------------------------

count = 0

for i in range(1, 20):           # something might be off here...
    if i % 2 == 0:
        count = count + 1

print("Even numbers found:", count)   # Expected: 10
