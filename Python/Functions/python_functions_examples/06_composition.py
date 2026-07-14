# ============================================================
#  06_composition.py  —  Function Composition
#  Middle School Python · Unit 6 · Lesson 6.1
# ============================================================
#
#  Function COMPOSITION means: functions that call
#  other functions to build bigger behavior.
#
#  Topics covered:
#    • Functions calling other functions
#    • Building complex behavior from small pieces
#    • Helper functions (small utilities used internally)
#    • Using composition to make programs easy to expand
#
#  KEY IDEA:
#    Real programs are built from LAYERS of functions.
#    Each layer calls the one below it.
# ============================================================

print("=" * 55)
print("  FUNCTION COMPOSITION")
print("=" * 55)
print("  Functions calling other functions to build")
print("  bigger, more complex behavior from simple parts.")
print("=" * 55)

# ══════════════════════════════════════════════════════════
# EXAMPLE 1: Building a Greeting System
# (3 layers: format → greet → announce)
# ══════════════════════════════════════════════════════════

print("\n─── Example 1: Three-Layer Greeting System ───")

# Layer 1 — the smallest helper
def make_title(text):
    """Wrap text in title formatting."""
    return f"★ {text.upper()} ★"

# Layer 2 — uses Layer 1
def greet_student(name, grade):
    """Create a personalised greeting line."""
    title = make_title(f"welcome, {name}!")     # calls Layer 1
    return f"{title}  (Grade {grade})"

# Layer 3 — uses Layer 2
def announce_class(students):
    """
    Print a welcome announcement for a list of students.
    Each entry is a (name, grade) tuple.
    """
    print("\n  CLASS ROLL CALL")
    print("  " + "=" * 40)
    for name, grade in students:
        greeting = greet_student(name, grade)   # calls Layer 2
        print(f"  {greeting}")
    print("  " + "=" * 40)
    print(f"  {len(students)} students present today.\n")

# Main program — only uses the top layer
roster = [
    ("Alice",   6),
    ("Bob",     7),
    ("Carol",   8),
    ("David",   6),
    ("Emma",    7),
]

announce_class(roster)

# ══════════════════════════════════════════════════════════
# EXAMPLE 2: Pizza Order System
# ══════════════════════════════════════════════════════════

print("\n─── Example 2: Pizza Order System ───")

def format_toppings(toppings):
    """Convert a list of toppings to a readable string."""
    if not toppings:
        return "no toppings (plain)"
    if len(toppings) == 1:
        return toppings[0]
    return ", ".join(toppings[:-1]) + " & " + toppings[-1]

def calculate_price(size, num_toppings):
    """Return the total price of a pizza."""
    base_prices = {"small": 8.99, "medium": 11.99, "large": 14.99}
    base = base_prices.get(size, 11.99)
    topping_cost = num_toppings * 1.50
    return base + topping_cost

def print_order_summary(name, size, toppings):
    """
    Print a formatted pizza order summary.
    Calls format_toppings() and calculate_price() internally.
    """
    topping_str = format_toppings(toppings)         # calls helper 1
    price = calculate_price(size, len(toppings))    # calls helper 2

    print(f"\n  ORDER FOR: {name}")
    print(f"  Size    : {size.capitalize()}")
    print(f"  Toppings: {topping_str}")
    print(f"  TOTAL   : ${price:.2f}")

def process_orders(orders):
    """
    Process a list of orders.
    Each order is a (name, size, toppings) tuple.
    """
    print("\n  🍕 PIZZA PALACE — ORDER QUEUE")
    print("  " + "-" * 38)
    for name, size, toppings in orders:
        print_order_summary(name, size, toppings)   # calls the summary function
    print("\n  " + "-" * 38)
    print("  All orders received!\n")

# Main program — one call does everything
orders = [
    ("Alice",  "large",  ["pepperoni", "mushrooms", "olives"]),
    ("Bob",    "medium", ["cheese"]),
    ("Carol",  "small",  []),
    ("David",  "large",  ["bacon", "onions"]),
]

process_orders(orders)

# ══════════════════════════════════════════════════════════
# EXAMPLE 3: Number Classifier (chained conditions)
# ══════════════════════════════════════════════════════════

print("\n─── Example 3: Number Analysis ───")

def is_even(n):
    """Return True if n is even."""
    return n % 2 == 0

def is_prime(n):
    """Return True if n is a prime number."""
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True

def is_perfect_square(n):
    """Return True if n is a perfect square."""
    import math
    root = int(math.sqrt(n))
    return root * root == n

def describe_number(n):
    """
    Return a full description of a number.
    Calls is_even(), is_prime(), and is_perfect_square().
    """
    tags = []

    tags.append("even" if is_even(n) else "odd")

    if is_prime(n):
        tags.append("prime")

    if is_perfect_square(n):
        tags.append("perfect square")

    if n % 3 == 0:
        tags.append("multiple of 3")

    if n % 5 == 0:
        tags.append("multiple of 5")

    return f"{n:>4}  →  {', '.join(tags)}"

def analyze_range(start, end):
    """Print descriptions for every number from start to end."""
    print(f"\n  Numbers {start}–{end}:")
    for n in range(start, end + 1):
        print(f"  {describe_number(n)}")

analyze_range(1, 20)

# ── Composition diagram ────────────────────────────────────
print("\n─── How Composition Works ───")
print("""
  process_orders()          ← top level: you call this
      └── print_order_summary()
              ├── format_toppings()   ← tiny helper
              └── calculate_price()  ← tiny helper

  analyze_range()           ← top level
      └── describe_number()
              ├── is_even()           ← tiny helper
              ├── is_prime()          ← tiny helper
              └── is_perfect_square() ← tiny helper

  Each layer is small and easy to test independently.
  Together they build complex behavior.
""")
