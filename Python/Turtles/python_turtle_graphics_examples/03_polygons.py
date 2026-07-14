# ============================================================
#  03_polygons.py  —  Drawing Regular Polygons
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  Topics covered:
#    • The Exterior Angle Theorem: turn = 360 ÷ sides
#    • Using a for loop to draw repeated sides
#    • Changing just two variables to draw ANY polygon
#    • Drawing multiple shapes using penup / pendown
#    • Watching the formula work visually
#
# ============================================================

import turtle

t = turtle.Turtle()
t.speed(5)

# ── The magic formula ────────────────────────────────────
#
#   turn_angle = 360 / number_of_sides
#
#   Why? Because drawing a complete closed shape means
#   turning a total of 360°. If each turn is equal, then
#   each turn = 360 ÷ sides.
#
#   Triangle: 360 / 3 = 120°
#   Square:   360 / 4 = 90°
#   Pentagon: 360 / 5 = 72°
#   Hexagon:  360 / 6 = 60°

# ── Example 1: Draw a triangle ───────────────────────────
print("Drawing: Triangle (3 sides, 120° turns)")

sides  = 3
length = 100
angle  = 360 / sides     # = 120.0

t.color("orangered")
t.width(2)

for i in range(sides):
    t.forward(length)
    t.left(angle)

# ── Move to a new spot ───────────────────────────────────
t.penup()
t.goto(180, 0)
t.pendown()

# ── Example 2: Draw a square ─────────────────────────────
print("Drawing: Square (4 sides, 90° turns)")

sides  = 4
length = 80
angle  = 360 / sides     # = 90.0

t.color("steelblue")

for i in range(sides):
    t.forward(length)
    t.left(angle)

# ── Move to a new spot ───────────────────────────────────
t.penup()
t.goto(-220, -10)
t.pendown()

# ── Example 3: Draw a pentagon ───────────────────────────
print("Drawing: Pentagon (5 sides, 72° turns)")

sides  = 5
length = 75
angle  = 360 / sides     # = 72.0

t.color("forestgreen")

for i in range(sides):
    t.forward(length)
    t.left(angle)

# ── Move to a new spot ───────────────────────────────────
t.penup()
t.goto(-50, -120)
t.pendown()

# ── Example 4: Draw a hexagon ────────────────────────────
print("Drawing: Hexagon (6 sides, 60° turns)")

sides  = 6
length = 65
angle  = 360 / sides     # = 60.0

t.color("purple")

for i in range(sides):
    t.forward(length)
    t.left(angle)

# ── Example 5: 36 sides ≈ a circle! ─────────────────────
# When the number of sides is large and each side is short,
# the polygon looks like a smooth circle.

t.penup()
t.goto(80, -150)
t.pendown()

print("Drawing: 36-sided polygon (looks like a circle!)")

sides  = 36
length = 12
angle  = 360 / sides     # = 10.0

t.color("gold")
t.width(3)

for i in range(sides):
    t.forward(length)
    t.left(angle)

# ── Labels ───────────────────────────────────────────────
t.penup()
t.color("black")
t.goto(-30, 170)
t.write("Polygon Gallery  —  turn = 360 ÷ sides",
        font=("Arial", 13, "bold"))

# ── Summary in the console ───────────────────────────────
print("\nSummary:")
for sides in [3, 4, 5, 6, 8, 12, 36]:
    print(f"  {sides:2d} sides → turn = {360/sides:.1f}°")

turtle.done()
