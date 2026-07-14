# ============================================================
#  02_input_validation.py  —  Loops & User Input
#  Middle School Python · Unit 4 · Lesson 4.2
# ============================================================
#
#  Topics covered:
#    • Repeating until valid input is received
#    • Sentinel values (a value that signals "stop")
#    • Accumulating input inside a loop
#    • Building a simple menu
# ============================================================

print("=" * 50)
print("  INPUT VALIDATION WITH WHILE LOOPS")
print("=" * 50)

# ------------------------------------------------------------
# Example 1: Keep asking until the user enters a positive number
# ------------------------------------------------------------
print("\n--- Example 1: Must Enter a Positive Number ---")

number = -1                  # start with an invalid value to enter the loop
while number <= 0:
    number = int(input("Enter a positive number: "))
    if number <= 0:
        print("That's not positive! Try again.")

print(f"Great! You entered {number}.")

# ------------------------------------------------------------
# Example 2: Password gate — try until correct
# ------------------------------------------------------------
print("\n--- Example 2: Password Gate ---")

SECRET = "python123"         # the correct password
attempts = 0
password = ""

while password != SECRET:
    password = input("Enter the password: ")
    attempts += 1
    if password != SECRET:
        print(f"Wrong! You have tried {attempts} time(s).")

print(f"Access granted! It took you {attempts} attempt(s).")

# ------------------------------------------------------------
# Example 3: Sentinel value — add numbers until user types 0
# ------------------------------------------------------------
print("\n--- Example 3: Sum Until 0 (Sentinel Value) ---")
print("Enter numbers to add up. Type 0 to stop.\n")

running_total = 0
entry_count = 0
user_input = -1              # any non-zero value to start

while user_input != 0:
    user_input = int(input("Enter a number (0 to stop): "))
    if user_input != 0:
        running_total += user_input
        entry_count += 1
        print(f"  Running total: {running_total}")

if entry_count > 0:
    average = running_total / entry_count
    print(f"\nYou entered {entry_count} number(s).")
    print(f"Total : {running_total}")
    print(f"Average: {average:.2f}")
else:
    print("You didn't enter any numbers.")

# ------------------------------------------------------------
# Example 4: Simple text menu
# ------------------------------------------------------------
print("\n--- Example 4: Simple Menu ---")
print("(Type the number of your choice)\n")

choice = ""
while choice != "3":
    print("--- MENU ---")
    print("1. Say hello")
    print("2. Tell a joke")
    print("3. Quit")
    choice = input("Your choice: ")

    if choice == "1":
        print("Hello there, future Python programmer! 👋\n")
    elif choice == "2":
        print("Why do programmers prefer dark mode?")
        print("Because light attracts bugs! 🐛\n")
    elif choice == "3":
        print("Goodbye!")
    else:
        print("Invalid choice — please enter 1, 2, or 3.\n")
