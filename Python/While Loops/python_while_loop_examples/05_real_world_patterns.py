# ============================================================
#  05_real_world_patterns.py  —  While Loops in Real Life
#  Middle School Python · Unit 4 · Lesson 4.2
# ============================================================
#
#  Topics covered:
#    • ATM PIN checker (limited attempts)
#    • Multiplication quiz with score tracking
#    • Simple to-do list app
#    • Collatz conjecture (math pattern)
#    • Dice roll simulator
# ============================================================

import random

print("=" * 50)
print("  REAL-WORLD WHILE LOOP PATTERNS")
print("=" * 50)

# ============================================================
# PATTERN 1: Limited Attempts (ATM PIN)
# ============================================================
print("\n" + "~" * 40)
print("  PATTERN 1: ATM PIN Checker")
print("~" * 40)

CORRECT_PIN = "1234"
MAX_ATTEMPTS = 3
attempts = 0
locked = False

while attempts < MAX_ATTEMPTS:
    pin = input(f"Enter PIN ({MAX_ATTEMPTS - attempts} attempt(s) remaining): ")
    attempts += 1

    if pin == CORRECT_PIN:
        print("✅ PIN accepted! Welcome.")
        break
    else:
        remaining = MAX_ATTEMPTS - attempts
        if remaining > 0:
            print(f"❌ Wrong PIN. {remaining} attempt(s) left.")
        else:
            locked = True
            print("🔒 Account locked after 3 failed attempts.")

# ============================================================
# PATTERN 2: Quiz / Score Tracker
# ============================================================
print("\n" + "~" * 40)
print("  PATTERN 2: Multiplication Quiz")
print("~" * 40)

score = 0
question_number = 0
total_questions = 5

print(f"Answer {total_questions} multiplication questions!\n")

while question_number < total_questions:
    question_number += 1
    a = random.randint(1, 12)
    b = random.randint(1, 12)
    correct_answer = a * b

    try:
        answer = int(input(f"Q{question_number}: {a} x {b} = "))
    except ValueError:
        print("  Please enter a number! This question won't count.")
        question_number -= 1   # don't count this attempt
        continue

    if answer == correct_answer:
        print("  ✅ Correct!\n")
        score += 1
    else:
        print(f"  ❌ Nope — the answer was {correct_answer}\n")

percentage = (score / total_questions) * 100
print(f"Quiz over! Score: {score}/{total_questions} ({percentage:.0f}%)")

if percentage == 100:
    print("🌟 Perfect score!")
elif percentage >= 80:
    print("🎉 Great job!")
elif percentage >= 60:
    print("👍 Not bad — keep practicing!")
else:
    print("📚 Review your times tables and try again.")

# ============================================================
# PATTERN 3: To-Do List (add/remove/view)
# ============================================================
print("\n" + "~" * 40)
print("  PATTERN 3: Simple To-Do List")
print("~" * 40)

todo_list = []

while True:
    print("\nOptions: [a]dd  [d]one  [v]iew  [q]uit")
    action = input("What would you like to do? ").lower().strip()

    if action == "q":
        print("Saving and closing your to-do list. Bye!")
        break

    elif action == "a":
        task = input("Enter a task: ").strip()
        if task:
            todo_list.append(task)
            print(f"  Added: '{task}'")
        else:
            print("  Task can't be empty!")

    elif action == "d":
        if not todo_list:
            print("  Your list is empty — nothing to mark done!")
        else:
            print("  Current tasks:")
            for i, task in enumerate(todo_list, start=1):
                print(f"    {i}. {task}")
            try:
                index = int(input("  Mark task # as done: ")) - 1
                if 0 <= index < len(todo_list):
                    removed = todo_list.pop(index)
                    print(f"  ✅ '{removed}' marked as done!")
                else:
                    print("  Invalid number.")
            except ValueError:
                print("  Please enter a number.")

    elif action == "v":
        if not todo_list:
            print("  Your list is empty!")
        else:
            print(f"  You have {len(todo_list)} task(s):")
            for i, task in enumerate(todo_list, start=1):
                print(f"    {i}. {task}")

    else:
        print("  Unknown option. Try a, d, v, or q.")

# ============================================================
# PATTERN 4: Collatz Conjecture
# ============================================================
print("\n" + "~" * 40)
print("  PATTERN 4: Collatz Conjecture")
print("~" * 40)
print("  Rule: if n is even → n = n ÷ 2")
print("        if n is odd  → n = n × 3 + 1")
print("  Does it always reach 1? (Mathematicians think yes!)\n")

try:
    start = int(input("Pick any positive whole number: "))
except ValueError:
    start = 27          # default if input fails

n = start
sequence = [n]
steps = 0

while n != 1:
    if n % 2 == 0:
        n = n // 2      # integer division
    else:
        n = n * 3 + 1
    sequence.append(n)
    steps += 1

print(f"\nStarted at {start}, reached 1 in {steps} step(s).")
print(f"Highest value reached: {max(sequence)}")
print(f"Sequence: {sequence}")

# ============================================================
# PATTERN 5: Dice Roller — roll until you get a 6
# ============================================================
print("\n" + "~" * 40)
print("  PATTERN 5: Roll Until You Get a 6")
print("~" * 40)

roll_count = 0
roll = 0

while roll != 6:
    roll = random.randint(1, 6)
    roll_count += 1
    symbol = "🎲"
    print(f"  Roll {roll_count}: {roll} {symbol}")

print(f"\nGot a 6 after {roll_count} roll(s)!")
print(f"(On average, you'd expect to roll {roll_count} time(s) to get a 6.)")
