# ============================================================
#  05_pen_up_down.py  —  Pen Up, Pen Down & Complex Paths
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  Topics covered:
#    • penup() / pendown() — draw disconnected shapes
#    • Drawing a dashed line using a loop + penup/pendown
#    • Drawing multiple separated shapes
#    • Combining penup() with goto() to reposition freely
#    • Drawing initials using only turtle commands
#
# ============================================================

import turtle

t = turtle.Turtle()
t.speed(6)
t.width(3)

# ── Example 1: Two separate squares ──────────────────────
# Without penup(), moving between shapes draws a connecting line.
# With penup(), the turtle repositions invisibly.

def draw_square(size, color):
    """Draw a filled square of the given size and color."""
    t.color(color)
    t.fillcolor(color)
    t.begin_fill()
    for _ in range(4):
        t.forward(size)
        t.left(90)
    t.end_fill()

t.penup()
t.goto(-300, 150)
t.pendown()
draw_square(80, "steelblue")

t.penup()                   # ← lift pen before repositioning
t.goto(-150, 150)           # ← jump — NO line drawn here
t.pendown()                 # ← put pen back down
draw_square(80, "coral")

t.penup()
t.goto(0, 150)
t.pendown()
draw_square(80, "gold")

t.penup()
t.goto(150, 150)
t.pendown()
draw_square(80, "mediumseagreen")

# ── Example 2: Dashed line ───────────────────────────────
# A dashed line is just: draw a bit, penup, move a bit, pendown, repeat.

t.penup()
t.goto(-300, 60)
t.pendown()
t.setheading(0)     # face East

t.color("purple")
t.width(4)

for _ in range(20):
    t.pendown()
    t.forward(20)   # draw a dash
    t.penup()
    t.forward(10)   # skip a gap

t.pendown()

# ── Example 3: Dotted arc path ───────────────────────────
# penup/down inside a loop creates a series of dots along a curve.

t.penup()
t.goto(-300, -20)
t.pendown()
t.setheading(0)

t.color("darkorange")

for i in range(25):
    t.dot(8 + i % 5)       # alternating dot sizes
    t.penup()
    t.forward(18)
    t.left(3)              # slight curve each step
    t.pendown()

# ── Example 4: Drawing the letter "H" ────────────────────
# Use only forward, backward, left, right, penup, pendown.

def draw_H(x, y, size, color):
    """Draw a capital H with origin at bottom-left."""
    t.penup()
    t.goto(x, y)
    t.pendown()
    t.setheading(90)    # face up

    t.color(color)
    t.width(5)

    # Left vertical stroke
    t.forward(size)

    # Move to the crossbar (midpoint)
    t.penup()
    t.goto(x, y + size / 2)
    t.pendown()
    t.setheading(0)             # face right

    # Crossbar
    t.forward(size * 0.7)

    # Right vertical stroke — go to bottom, draw up
    t.penup()
    t.goto(x + size * 0.7, y)
    t.pendown()
    t.setheading(90)
    t.forward(size)

def draw_I(x, y, size, color):
    """Draw a capital I with origin at bottom-left."""
    t.color(color)
    t.width(5)

    # Vertical bar
    t.penup()
    t.goto(x + size * 0.2, y)
    t.pendown()
    t.setheading(90)
    t.forward(size)

    # Top serif
    t.penup()
    t.goto(x, y + size)
    t.pendown()
    t.setheading(0)
    t.forward(size * 0.4)

    # Bottom serif
    t.penup()
    t.goto(x, y)
    t.pendown()
    t.forward(size * 0.4)

draw_H(-80, -200, 120, "teal")
draw_I( 80, -200, 120, "tomato")

# ── Label ────────────────────────────────────────────────
t.penup()
t.goto(-100, -230)
t.color("black")
t.width(1)
t.write("Initials drawn with penup/pendown", font=("Arial", 11, "italic"))

turtle.done()
