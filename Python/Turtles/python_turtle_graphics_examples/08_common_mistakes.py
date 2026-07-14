# ============================================================
#  08_common_mistakes.py  —  Bugs & Fixes
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  Each section shows a BROKEN version (commented out so the
#  file still runs) followed by the correct FIXED version.
#
#  Mistakes covered:
#    1. Forgetting turtle.done() — window disappears
#    2. Calling turtle.forward() instead of t.forward()
#    3. Confusing left() and right() directions
#    4. Forgetting the indent inside a for loop
#    5. Using the wrong turn angle for a polygon
#    6. Forgetting pendown() after penup()
#    7. Using '#' in a hex color (causes crash)
#
# ============================================================

import turtle

t = turtle.Turtle()
t.speed(4)
t.width(2)

def jump(x, y):
    t.penup()
    t.goto(x, y)
    t.pendown()
    t.setheading(0)

print("=" * 55)
print("  COMMON TURTLE MISTAKES & FIXES")
print("=" * 55)

# ============================================================
# MISTAKE 1: Forgetting turtle.done()
# ============================================================
print("\n1. Forgetting turtle.done()")
print("   BROKEN: The window flashes and disappears immediately.")
print("   # import turtle")
print("   # t = turtle.Turtle()")
print("   # t.forward(100)")
print("   # (no turtle.done() — window closes!)")
print()
print("   FIXED: Always add turtle.done() as the LAST line.")

# ============================================================
# MISTAKE 2: turtle.forward() vs t.forward()
# ============================================================
print("\n2. AttributeError — wrong object name")

# BROKEN — uncomment to see the error:
# turtle.forward(100)     # ← AttributeError in some Python versions
#                         #   because turtle is the MODULE, not your turtle

# FIXED:
jump(-300, 200)
t.color("teal")
t.forward(80)
t.penup()
t.goto(-300, 178)
t.write("t.forward(80)  ✓  correct object", font=("Arial", 9, "normal"))

# ============================================================
# MISTAKE 3: Confusing left() and right()
# ============================================================
print("\n3. Left vs Right — easy to mix up!")
print("   left() = counterclockwise (CCW)")
print("   right() = clockwise (CW)")
print("   Facing East: left(90) → face North.  right(90) → face South.")

# BROKEN attempt — draws wrong shape:
# t.forward(100)
# t.right(90)    # ← student expected to turn left, got right

# FIXED: draw an L-shape going left then up
jump(-200, 100)
t.color("orangered")
t.forward(80)        # go right
t.left(90)           # turn LEFT (counterclockwise) → now face North
t.forward(60)        # go up
t.penup()
t.goto(-205, 78)
t.write("left(90)→ up ✓", font=("Arial", 9, "normal"))

# Compare: right(90) goes DOWN
jump(0, 100)
t.color("steelblue")
t.forward(80)
t.right(90)          # turn RIGHT (clockwise) → now face South
t.forward(60)        # go DOWN
t.penup()
t.goto(-5, 78)
t.write("right(90)→ down ✓", font=("Arial", 9, "normal"))

# ============================================================
# MISTAKE 4: Indent error in for loop
# ============================================================
print("\n4. Indent error — only 1 side drawn instead of 4")

# BROKEN — only draws one side because the turn is OUTSIDE the loop:
# for i in range(4):
#     t.forward(80)
# t.left(90)          # ← de-indented — only runs once after loop ends!

# FIXED: both lines indented inside the loop
jump(-280, -10)
t.color("purple")
for i in range(4):
    t.forward(60)     # ← inside loop
    t.left(90)        # ← also inside loop — draws a complete square

t.penup()
t.goto(-280, -88)
t.write("both lines indented → full square ✓", font=("Arial", 9, "normal"))

# ============================================================
# MISTAKE 5: Wrong polygon turn angle
# ============================================================
print("\n5. Wrong turn angle — open shape, not closed")

# BROKEN — using 60° for a triangle (that's for a hexagon):
jump(0, -10)
t.color("tomato")
for i in range(3):
    t.forward(70)
    t.left(60)       # wrong! 60° for 3 sides leaves an open shape
t.penup()
t.goto(0, -88)
t.write("left(60) on triangle → broken ✗", font=("Arial", 9, "normal"))

# FIXED — triangle needs 360 / 3 = 120°:
jump(150, -10)
t.color("limegreen")
for i in range(3):
    t.forward(70)
    t.left(120)      # correct: 360 / 3 = 120
t.penup()
t.goto(148, -88)
t.write("left(120) → closed triangle ✓", font=("Arial", 9, "normal"))

# ============================================================
# MISTAKE 6: Forgetting pendown() after penup()
# ============================================================
print("\n6. Forgetting pendown() — invisible drawing")

jump(-280, -150)
t.color("gold")
t.penup()
t.goto(-200, -150)   # moved but drew nothing

# BROKEN: still trying to draw while pen is up
t.forward(80)        # this draws nothing!

t.penup()
t.goto(-280, -190)
t.write("moved without pendown → nothing drawn ✗", font=("Arial", 9, "normal"))

# FIXED:
jump(-280, -220)
t.color("gold")
t.penup()
t.goto(-200, -220)
t.pendown()          # ← remembered to put pen down!
t.forward(80)

t.penup()
t.goto(-280, -248)
t.write("pendown() before forward → line drawn ✓", font=("Arial", 9, "normal"))

# ============================================================
# MISTAKE 7: Using '#' in hex color strings
# ============================================================
print("\n7. Hash in color string — crash or wrong color")
print("   BROKEN:  t.color('#FF6B6B')  ← some versions crash!")
print("   FIXED:   t.color('#FF6B6B')  ← with hash is actually OK in turtle")
print("   But to be safe, use a color NAME: t.color('tomato')")

# Safe named-color equivalent
jump(0, -150)
t.color("tomato")    # safe — always works
t.fillcolor("tomato")
t.begin_fill()
for _ in range(4):
    t.forward(60)
    t.left(90)
t.end_fill()

t.penup()
t.goto(-2, -220)
t.write("t.color('tomato') → always safe ✓", font=("Arial", 9, "normal"))

# ── Summary checklist ────────────────────────────────────
print("\n" + "=" * 55)
print("  CHECKLIST BEFORE YOU RUN YOUR TURTLE PROGRAM")
print("=" * 55)
checklist = [
    "Did you import turtle?",
    "Did you create t = turtle.Turtle()?",
    "Are you using t.forward() not turtle.forward()?",
    "Is the loop body properly indented?",
    "Did you use 360 / sides for your polygon angles?",
    "Did you call pendown() after every penup()?",
    "Does the last line say turtle.done()?",
]
for item in checklist:
    print(f"  [ ]  {item}")

turtle.done()
