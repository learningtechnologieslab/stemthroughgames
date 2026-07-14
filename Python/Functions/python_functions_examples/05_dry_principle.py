# ============================================================
#  05_dry_principle.py  —  The DRY Principle in Action
#  Middle School Python · Unit 6 · Lesson 6.1
# ============================================================
#
#  DRY = "Don't Repeat Yourself"
#
#  Topics covered:
#    • Side-by-side comparison of WET vs. DRY code
#    • Why repetition causes bugs and extra work
#    • Refactoring repeated code into functions
#    • Real-world scenarios where DRY saves time
#
# ============================================================

print("=" * 55)
print("  THE DRY PRINCIPLE")
print("=" * 55)
print("  DRY = Don't Repeat Yourself")
print("  WET = Write Every Time  (the bad version)")
print("=" * 55)

# ══════════════════════════════════════════════════════════
# SCENARIO 1: Report Card Printer
# ══════════════════════════════════════════════════════════

print("\n─── Scenario 1: Report Card Printer ───")

# ── WET version (copy-pasted) ────────────────────────────
print("\nWET VERSION (copy-paste):")

# Student 1
name1 = "Alice"
score1 = 92
if score1 >= 90:
    grade1 = "A"
elif score1 >= 80:
    grade1 = "B"
elif score1 >= 70:
    grade1 = "C"
else:
    grade1 = "F"
print(f"  {name1}: {score1}/100  →  Grade: {grade1}")

# Student 2  (identical logic — just different variables)
name2 = "Bob"
score2 = 74
if score2 >= 90:
    grade2 = "A"
elif score2 >= 80:
    grade2 = "B"
elif score2 >= 70:
    grade2 = "C"
else:
    grade2 = "F"
print(f"  {name2}: {score2}/100  →  Grade: {grade2}")

# Student 3  (same again...)
name3 = "Carol"
score3 = 88
if score3 >= 90:
    grade3 = "A"
elif score3 >= 80:
    grade3 = "B"
elif score3 >= 70:
    grade3 = "C"
else:
    grade3 = "F"
print(f"  {name3}: {score3}/100  →  Grade: {grade3}")

print("  ^ 30 lines for 3 students. Bug in the grade logic? Fix in 3 places.")

# ── DRY version ──────────────────────────────────────────
print("\nDRY VERSION (with a function):")

def letter_grade(score):
    """Return the letter grade for a numeric score."""
    if score >= 90:
        return "A"
    elif score >= 80:
        return "B"
    elif score >= 70:
        return "C"
    else:
        return "F"

def print_report(name, score):
    """Print one line of a report card."""
    grade = letter_grade(score)
    print(f"  {name}: {score}/100  →  Grade: {grade}")

# Now adding students is ONE line each
students = [("Alice", 92), ("Bob", 74), ("Carol", 88),
            ("David", 55), ("Emma", 100)]

for name, score in students:
    print_report(name, score)

print("  ^ 3 lines of logic, 5 students, zero copy-paste.")
print("  ^ Bug in the grade logic? Fix letter_grade() ONCE — all students fixed.")

# ══════════════════════════════════════════════════════════
# SCENARIO 2: Shopping Cart
# ══════════════════════════════════════════════════════════

print("\n─── Scenario 2: Shopping Cart ───")

# ── DRY version ──────────────────────────────────────────

def apply_discount(price, percent):
    """Return a price after applying a percentage discount."""
    discount_amount = price * (percent / 100)
    return price - discount_amount

def format_price(price):
    """Return a price string like '$12.99'."""
    return f"${price:.2f}"

def print_item(name, original_price, discount_percent=0):
    """Print one cart item with optional discount."""
    if discount_percent > 0:
        final = apply_discount(original_price, discount_percent)
        saved = original_price - final
        print(f"  {name:<20} {format_price(original_price):>8}"
              f"  -{discount_percent}%  →  {format_price(final):>8}"
              f"  (save {format_price(saved)})")
    else:
        print(f"  {name:<20} {format_price(original_price):>8}")

print("\nYour Cart:")
print(f"  {'Item':<20} {'Price':>8}        {'Final':>8}")
print("  " + "-" * 52)
print_item("Python Textbook",     49.99, 20)
print_item("USB Keyboard",        29.99, 10)
print_item("Notebook (3-pack)",    8.99)
print_item("Mechanical Pencils",   5.49)
print_item("Laptop Stand",        39.99, 15)

print("\n  ^ Changing the discount format? Edit format_price() ONCE.")

# ══════════════════════════════════════════════════════════
# SCENARIO 3: The "Fix in One Place" Demo
# ══════════════════════════════════════════════════════════

print("\n─── Scenario 3: Fix in One Place ───")
print("  Imagine you drew 10 squares without functions.")
print("  Now you need to change 50 pixels to 80 pixels.")
print("  With copy-paste: edit 10 places. Miss one? Bug.")
print()
print("  With a function: change draw_square's default once.")
print()
print("  BEFORE (10 repetitions of forward(50)):")
print("    for _ in range(4): t.forward(50)  t.left(90)   # 1")
print("    for _ in range(4): t.forward(50)  t.left(90)   # 2")
print("    ...                                             # 3-10")
print()
print("  AFTER (one function definition, 10 one-line calls):")
print("    def draw_square(size=80):              # change default once!")
print("        for _ in range(4): t.forward(size) t.left(90)")
print()
print("    draw_square()   # 1")
print("    draw_square()   # 2")
print("    ...             # 3-10  ← all automatically use the new size")

# ── DRY benefits summary ──────────────────────────────────
print("\n─── DRY Benefits Summary ───")

benefits = {
    "Easier to fix":  "Change the function once — all callers get the fix.",
    "Easier to read": "draw_house() tells you WHAT. 40 loops tell you HOW.",
    "Easier to grow": "Add a feature to the function; every caller gains it.",
    "Fewer bugs":     "One correct implementation beats 10 identical copies.",
    "Shorter code":   "10-line function called 5× = 10 lines, not 50.",
}

for benefit, explanation in benefits.items():
    print(f"\n  ✓ {benefit}")
    print(f"    {explanation}")
