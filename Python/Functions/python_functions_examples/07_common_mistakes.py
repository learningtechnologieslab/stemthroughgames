# ============================================================
#  07_common_mistakes.py  —  Common Function Mistakes & Fixes
#  Middle School Python · Unit 6 · Lesson 6.1
# ============================================================
#
#  Each mistake is shown as a commented-out broken version
#  followed by the working FIXED version.
#
#  Mistakes covered:
#    1. Forgetting the colon after def
#    2. Body not indented
#    3. Calling before defining
#    4. Missing parentheses on call
#    5. Return value not captured
#    6. Defining but never calling
#    7. Confusing print with return
#    8. Changing a parameter doesn't affect the caller
# ============================================================

print("=" * 55)
print("  COMMON FUNCTION MISTAKES & FIXES")
print("=" * 55)

# ════════════════════════════════════════════════════════
# MISTAKE 1: Forgetting the colon after def
# ════════════════════════════════════════════════════════
print("\n─── Mistake 1: Missing colon ───")

# BROKEN — SyntaxError: expected ':'
# def square()          # ← no colon!
#     print("square")

# FIXED:
def square():           # ← colon is required
    print("square drawn")

square()
print("  Rule: def name() MUST end with a colon, just like for and if.")

# ════════════════════════════════════════════════════════
# MISTAKE 2: Body not indented
# ════════════════════════════════════════════════════════
print("\n─── Mistake 2: Body not indented ───")

# BROKEN — IndentationError
# def greet():
# print("Hello")        # ← at column 0, not inside the function!

# FIXED:
def greet():
    print("Hello!")     # ← 4 spaces in — belongs to the function

greet()
print("  Rule: Everything inside a function must be indented 4 spaces.")

# ════════════════════════════════════════════════════════
# MISTAKE 3: Calling before defining
# ════════════════════════════════════════════════════════
print("\n─── Mistake 3: Calling before defining ───")
print("  BROKEN (would crash):")
print("    say_hi()         # ← NameError: name 'say_hi' is not defined")
print("    def say_hi():")
print("        print('Hi')")
print()

# FIXED: define first, call after
def say_hi():
    print("Hi there!")

say_hi()    # ← defined above, so this works
print("  Rule: Python reads top-to-bottom. Define functions ABOVE their first call.")

# ════════════════════════════════════════════════════════
# MISTAKE 4: Missing parentheses on call
# ════════════════════════════════════════════════════════
print("\n─── Mistake 4: Missing () on call ───")

def wave():
    print("👋 Waving!")

# BROKEN — this does NOT call the function:
result_without_parens = wave          # just stores a reference to the function
print(f"  Without ():  {result_without_parens}")  # prints something like <function wave at 0x...>

# FIXED — add () to actually run it:
wave()    # ← () makes it execute
print("  Rule: name refers to the function itself.  name() CALLS it.")

# ════════════════════════════════════════════════════════
# MISTAKE 5: Return value not captured
# ════════════════════════════════════════════════════════
print("\n─── Mistake 5: Return value not captured ───")

def add(a, b):
    return a + b

# BROKEN — result is thrown away:
add(3, 4)                              # returns 7, but nobody stores it
x = add(3, 4)
print(f"  If you don't capture: result is lost (disappeared into the void).")

# Also broken — trying to print a variable that was never assigned:
# print(total)   # ← NameError!

# FIXED:
total = add(3, 4)           # ← capture the return value
print(f"  Captured: total = {total}")

# Or use it directly:
print(f"  Direct use: add(10, 5) = {add(10, 5)}")
print("  Rule: return sends a value back. You MUST catch it or use it right away.")

# ════════════════════════════════════════════════════════
# MISTAKE 6: Defining but never calling
# ════════════════════════════════════════════════════════
print("\n─── Mistake 6: Defined but never called ───")

def announce_winner(name):
    """Announce the winner."""
    print(f"🏆 The winner is {name}!")

# BROKEN — the function exists but nothing happens:
winner = "Alice"
# (forgot to call announce_winner!)
print("  Without the call: nothing prints from announce_winner().")

# FIXED:
announce_winner(winner)     # ← actually run it
print("  Rule: a function definition is just a stored recipe. Call it to cook!")

# ════════════════════════════════════════════════════════
# MISTAKE 7: Confusing print with return
# ════════════════════════════════════════════════════════
print("\n─── Mistake 7: print vs return ───")

def square_with_print(n):
    print(n * n)        # shows output but returns NOTHING (None)

def square_with_return(n):
    return n * n        # sends the value back — caller can use it

# With print version — can't reuse the result:
square_with_print(5)    # prints 25
saved = square_with_print(5)
print(f"  Saved from print version: {saved}")  # None — useless!

# With return version — fully usable:
result = square_with_return(5)
print(f"  Saved from return version: {result}")  # 25
print(f"  Can do math: {result + 10}")            # 35

print("  Rule: Use return when you need the value later.")
print("         Use print only for direct display to the user.")

# ════════════════════════════════════════════════════════
# MISTAKE 8: Expecting a parameter change to affect the caller
# ════════════════════════════════════════════════════════
print("\n─── Mistake 8: Parameters are local copies ───")

def try_to_triple(n):
    """Try to triple n — but this only changes the local copy!"""
    n = n * 3
    print(f"  Inside the function: n = {n}")
    # n is a LOCAL variable — changing it doesn't affect 'my_number'

my_number = 7
try_to_triple(my_number)
print(f"  Outside the function: my_number = {my_number}")  # still 7!

# FIXED — use return to send the new value back:
def triple(n):
    return n * 3

my_number = triple(my_number)    # replace my_number with the returned value
print(f"  After triple(my_number): my_number = {my_number}")  # 21

print("  Rule: Parameters are LOCAL copies. To 'change' the caller's variable,")
print("         use return and reassign: x = my_function(x).")

# ── Quick summary ─────────────────────────────────────────
print("\n─── Quick Checklist ───")
checklist = [
    "def name():      ← colon at the end",
    "    body         ← 4 spaces indent",
    "name()           ← () to call (not just 'name')",
    "x = name()       ← capture return value if needed",
    "Define ABOVE the first call",
    "return to send a value back (don't rely on print)",
]
for item in checklist:
    print(f"  ✓  {item}")
