# ============================================================
#  01_first_function.py  —  Your Very First Functions
#  Middle School Python · Unit 6 · Lesson 6.1
# ============================================================
#
#  Topics covered:
#    • def keyword and function syntax
#    • Calling a function by name
#    • Functions vs. repeated code (the DRY principle)
#    • Simple functions that print output
#
#  KEY IDEA:
#    A function is a NAMED, REUSABLE block of code.
#    You write it once, then call it as many times as you need.
# ============================================================

print("=" * 55)
print("  YOUR VERY FIRST FUNCTIONS")
print("=" * 55)

# ── Why functions exist: the "before" picture ────────────
# Without functions, drawing 3 squares means copy-pasting code:

print("\n--- WITHOUT a function (copy-paste code) ---")
print("Square 1:")
for i in range(4):
    print("  forward(50)  left(90)")

print("Square 2:")
for i in range(4):
    print("  forward(50)  left(90)")   # identical!

print("Square 3:")
for i in range(4):
    print("  forward(50)  left(90)")   # still identical!

print("\n^ That's 12 lines doing the same thing 3 times.")
print("  Change the size? Edit in 3 places. Add a 4th square? Copy again. Ugh.")

# ── The "after" picture: define a function ───────────────

print("\n--- WITH a function (the DRY way) ---")

# STEP 1: DEFINE the function (stores the recipe)
def draw_square():
    """Simulate drawing a 50-pixel square."""
    for i in range(4):
        print("  forward(50)  left(90)")

# STEP 2: CALL the function (runs the recipe)
print("Square 1:")
draw_square()

print("Square 2:")
draw_square()

print("Square 3:")
draw_square()

print("Square 4:")
draw_square()   # adding a 4th costs ONE line, not four!

# ── Four parts of every function ────────────────────────
print("\n--- The Four Parts ---")
print("""
  def  greet():            # ① 'def' keyword  ② function name  ③ () parentheses  ④ colon
      \"\"\"Say hello.\"\"\"    # optional docstring: describes what the function does
      print("Hello!")      # indented body — runs every time you call greet()

  greet()                  # CALL — triggers the whole body
""")

# ── Definition vs. call ──────────────────────────────────
print("--- Definition vs. Call ---\n")

def greet():
    """Print a friendly greeting."""
    print("Hello, future Python programmer! 👋")

# Just defining the function does NOTHING visible yet.
print("(Function defined — nothing runs yet)")

# The CALL is what runs the code:
greet()        # Output: Hello, future Python programmer!
greet()        # Same output — runs again for free!
greet()        # And again!

print("\nThree greetings — zero copy-paste. That's the power of functions.")

# ── Functions can do any kind of work ────────────────────
print("\n--- Functions Can Do Many Things ---")

def print_separator():
    """Print a row of dashes."""
    print("-" * 40)

def announce_lesson():
    """Print a lesson banner."""
    print_separator()
    print("  Python Functions — Unit 6 · Lesson 6.1")
    print_separator()

announce_lesson()
print("(Notice: announce_lesson CALLS print_separator inside it!)")
print("(That's called function COMPOSITION — functions calling other functions.)")
