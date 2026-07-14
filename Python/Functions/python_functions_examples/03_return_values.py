# ============================================================
#  03_return_values.py  —  Return Values
#  Middle School Python · Unit 6 · Lesson 6.1
# ============================================================
#
#  Topics covered:
#    • The return keyword
#    • Capturing a return value in a variable
#    • Using a return value in expressions
#    • Returning vs. printing (an important distinction)
#    • Early return and returning multiple values
#
#  KEY IDEA:
#    return sends a value BACK to the caller.
#    The caller can store it, print it, or use it in math.
# ============================================================

print("=" * 55)
print("  RETURN VALUES")
print("=" * 55)

# ── Basic return ─────────────────────────────────────────
print("\n--- Basic return ---")

def double(n):
    """Return twice the value of n."""
    return n * 2

# Capture the returned value in a variable
result = double(5)
print(f"double(5) returned: {result}")   # 10

# Use the return value directly in an expression
print(f"double(7) + double(3) = {double(7) + double(3)}")  # 20

# ── Return vs. Print — a critical difference ──────────────
print("\n--- Return vs. Print ---")

def add_and_print(a, b):
    """Adds a and b and PRINTS the result (no return)."""
    print(a + b)           # side-effect: shows output
    # implicitly returns None

def add_and_return(a, b):
    """Adds a and b and RETURNS the result."""
    return a + b           # sends the value back

# Using the printing version — can't store or reuse the result
add_and_print(3, 4)        # prints 7, but we can't use that 7
saved = add_and_print(3, 4)
print(f"  saved = {saved}  ← it's None! Nothing was returned.")

# Using the returning version — the result is usable
total = add_and_return(3, 4)
print(f"  total = {total}  ← 7 was returned and stored!")
print(f"  total * 2 = {total * 2}")     # we can do math with it

# ── Geometry examples ─────────────────────────────────────
print("\n--- Geometry Functions ---")

def rectangle_area(width, height):
    """Return the area of a rectangle."""
    return width * height

def rectangle_perimeter(width, height):
    """Return the perimeter of a rectangle."""
    return 2 * (width + height)

def circle_area(radius):
    """Return the approximate area of a circle."""
    import math
    return math.pi * radius ** 2

w, h = 8, 5
print(f"Rectangle {w}×{h}:")
print(f"  Area      = {rectangle_area(w, h)}")
print(f"  Perimeter = {rectangle_perimeter(w, h)}")
print(f"  Circle r=6 area ≈ {circle_area(6):.2f}")

# Compose: use one function's result inside another call
width = 10
height = 4
area = rectangle_area(width, height)
print(f"\nA pool is {width}m × {height}m.")
print(f"  Surface area = {area} m²")
print(f"  Tiles needed (0.5m² each) = {area / 0.5:.0f} tiles")

# ── Early return ─────────────────────────────────────────
print("\n--- Early Return (Guard Clauses) ---")

def safe_divide(numerator, denominator):
    """Divide two numbers; return None if denominator is 0."""
    if denominator == 0:
        print("  Error: cannot divide by zero!")
        return None        # exit immediately with None
    return numerator / denominator

print(safe_divide(10, 2))   # 5.0
print(safe_divide(7, 0))    # prints error and returns None
print(safe_divide(15, 3))   # 5.0

# ── Returning multiple values ─────────────────────────────
print("\n--- Returning Multiple Values ---")

def min_max(numbers):
    """Return both the smallest and largest value in a list."""
    return min(numbers), max(numbers)   # Python packs these as a tuple

scores = [72, 95, 88, 61, 100, 77]
low, high = min_max(scores)             # unpack both values
print(f"Scores: {scores}")
print(f"  Lowest  = {low}")
print(f"  Highest = {high}")
print(f"  Range   = {high - low}")

# ── Building with returns ─────────────────────────────────
print("\n--- Using Return Values to Build Programs ---")

def celsius_to_fahrenheit(c):
    """Convert Celsius to Fahrenheit."""
    return (c * 9/5) + 32

def describe_temperature(fahrenheit):
    """Return a description based on temperature."""
    if fahrenheit >= 90:
        return "🔥 Hot"
    elif fahrenheit >= 70:
        return "😊 Warm"
    elif fahrenheit >= 50:
        return "🧥 Cool"
    else:
        return "❄️  Cold"

temps_c = [0, 15, 25, 38, -10]
print(f"{'Celsius':>10}  {'Fahrenheit':>12}  Description")
print("-" * 40)
for c in temps_c:
    f = celsius_to_fahrenheit(c)
    desc = describe_temperature(f)
    print(f"{c:>10}°C  {f:>10.1f}°F  {desc}")
