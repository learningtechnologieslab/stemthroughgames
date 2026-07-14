# ============================================================
#  02_parameters.py  —  Parameters & Arguments
#  Middle School Python · Unit 6 · Lesson 6.1
# ============================================================
#
#  Topics covered:
#    • Parameters: variables in the function definition
#    • Arguments: values passed at call time
#    • Multiple parameters
#    • Default (optional) parameter values
#    • Keyword arguments
#
#  KEY IDEA:
#    Parameters are the BLANKS on a form.
#    Arguments are what you FILL IN when you use the form.
# ============================================================

print("=" * 55)
print("  PARAMETERS & ARGUMENTS")
print("=" * 55)

# ── One parameter ────────────────────────────────────────
print("\n--- One Parameter ---")

def greet(name):
    """Greet a person by name."""
    print(f"Hello, {name}! Welcome to Python class.")

# Each call passes a different argument for 'name'
greet("Alice")      # name = "Alice"
greet("Bob")        # name = "Bob"
greet("Ms. Chen")   # name = "Ms. Chen"

print("\n^ Same function, 3 different results — because the argument changed.")

# ── Numeric parameters ───────────────────────────────────
print("\n--- Numeric Parameters ---")

def count_up_to(limit):
    """Count from 1 up to limit (inclusive)."""
    for n in range(1, limit + 1):
        print(n, end="  ")
    print()  # newline

count_up_to(5)    # prints: 1  2  3  4  5
count_up_to(10)   # prints: 1  2  3  4  5  6  7  8  9  10
count_up_to(3)    # prints: 1  2  3

# ── Two parameters ───────────────────────────────────────
print("\n--- Two Parameters ---")

def introduce(first_name, grade):
    """Introduce a student with their name and grade."""
    print(f"My name is {first_name} and I am in grade {grade}.")

introduce("Sam", 6)
introduce("Jordan", 8)
introduce("Riley", 7)

# ── Default parameter values ─────────────────────────────
print("\n--- Default Parameter Values ---")

def greet_with_language(name, language="English"):
    """Greet someone; default language is English."""
    greetings = {
        "English": "Hello",
        "Spanish": "Hola",
        "French":  "Bonjour",
        "Japanese":"Konnichiwa",
    }
    word = greetings.get(language, "Hello")  # fall back to Hello if unknown
    print(f"{word}, {name}!")

# If you don't supply language, it defaults to "English"
greet_with_language("Alex")                       # uses default
greet_with_language("María", "Spanish")           # overrides default
greet_with_language("Amélie", "French")           # overrides default
greet_with_language("Yuki", "Japanese")           # overrides default

print("\n^ First call uses the DEFAULT value — all others supply their own.")

# ── Keyword arguments (named at call site) ────────────────
print("\n--- Keyword Arguments ---")

def make_sandwich(bread, filling, sauce="mayo"):
    """Print a sandwich order."""
    print(f"  Sandwich: {filling} on {bread} with {sauce}")

# Positional (order matters)
make_sandwich("wheat", "turkey", "mustard")

# Keyword (order doesn't matter when you name them)
make_sandwich(filling="cheese", bread="rye")          # sauce defaults to mayo
make_sandwich(bread="sourdough", sauce="pesto", filling="avocado")

# ── Real-world analogy reminder ───────────────────────────
print("\n--- Parameter vs. Argument Summary ---")
print("""
  PARAMETER  = the blank on a form (in the def line)
  ARGUMENT   = what you write in the blank (at the call)

  def draw_square( size  ):    ← 'size' is the PARAMETER
                    ^^^^
  draw_square(    100   )      ← 100 is the ARGUMENT
                   ^^^
  Inside the function body, Python reads: size = 100
""")

# ── Mini challenge ───────────────────────────────────────
print("--- Mini Challenge: Times Table ---")

def times_table(number, rows=10):
    """Print the times table for 'number' up to 'rows'."""
    print(f"\n  × {number} table")
    print("  " + "-" * 20)
    for i in range(1, rows + 1):
        print(f"  {i:2d} × {number} = {i * number}")

times_table(7)          # 7 times table, 10 rows (default)
times_table(3, rows=5)  # 3 times table, only 5 rows
