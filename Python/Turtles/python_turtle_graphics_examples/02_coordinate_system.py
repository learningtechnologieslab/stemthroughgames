# ============================================================
#  02_coordinate_system.py  —  Exploring the Canvas Grid
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  Topics covered:
#    • The (x, y) coordinate system
#    • turtle starts at (0, 0) — the center
#    • goto(x, y) — jump to any position
#    • xcor(), ycor(), heading() — read the turtle's state
#    • home() — return to origin
#    • Drawing axis lines to visualize the grid
#
# ============================================================

import turtle

t = turtle.Turtle()
t.speed(4)

# ── Draw the x-axis ──────────────────────────────────────
# The x-axis is a horizontal line through y = 0.
# We'll draw it from x = -250 to x = 250.

t.penup()
t.goto(-250, 0)       # move to the left end of the axis
t.pendown()

t.color("lightgray")
t.goto(250, 0)         # draw the x-axis line

# Add an arrow tip and label at the positive end
t.write(" +x", font=("Arial", 10, "normal"))

# Label the negative end
t.penup()
t.goto(-260, 0)
t.write("-x", font=("Arial", 10, "normal"))

# ── Draw the y-axis ──────────────────────────────────────
t.penup()
t.goto(0, -200)
t.pendown()
t.goto(0, 200)
t.write("  +y", font=("Arial", 10, "normal"))

t.penup()
t.goto(0, -210)
t.write("  -y", font=("Arial", 10, "normal"))

# ── Mark the origin ──────────────────────────────────────
t.goto(0, 0)
t.dot(10, "gold")           # draw a gold dot at the center
t.write("  (0, 0)  origin", font=("Arial", 10, "bold"))

# ── Visit four quadrants with goto() ─────────────────────
# goto(x, y) teleports the turtle to exact coordinates.
# Positive x = right.  Positive y = up.

t.color("teal")
t.penup()

destinations = [
    ( 150,  100, "( 150,  100)  Quadrant I"),
    (-150,  100, "(-150,  100)  Quadrant II"),
    (-150, -100, "(-150, -100)  Quadrant III"),
    ( 150, -100, "( 150, -100)  Quadrant IV"),
]

for x, y, label in destinations:
    t.goto(x, y)
    t.dot(8, "teal")
    t.write(f"  {label}", font=("Arial", 9, "italic"))

# ── Print turtle's state to the console ──────────────────
# These methods let you READ the turtle's current position.
print("Current position:")
print(f"  x = {t.xcor():.1f}")
print(f"  y = {t.ycor():.1f}")
print(f"  heading = {t.heading():.1f}°  (0° = East)")

# ── Go home ──────────────────────────────────────────────
t.penup()
t.home()                    # snaps back to (0, 0) facing East
t.color("gold")
t.pendown()
t.forward(60)
t.write("  ← home() put me here!", font=("Arial", 10, "normal"))

turtle.done()
