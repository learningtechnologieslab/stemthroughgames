# ============================================================
#  07_house_scene.py  —  Drawing a House Scene
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  A complete mini-project combining everything from the lesson:
#    • penup / pendown to move between parts
#    • Filled shapes (rectangle body, triangle roof, door, windows)
#    • for loops for the fence and clouds
#    • Multiple turtles (one for sky, one for scene)
#    • Functions to organize reusable drawing code
#
# ============================================================

import turtle

# ── Canvas setup ─────────────────────────────────────────
turtle.bgcolor("skyblue")
turtle.tracer(0)            # turn off animation — draw instantly, update at end

t = turtle.Turtle()
t.hideturtle()
t.speed(0)

# ── Helper: move without drawing ─────────────────────────
def jump(x, y):
    """Move the turtle to (x, y) without drawing."""
    t.penup()
    t.goto(x, y)
    t.pendown()
    t.setheading(0)

# ── Helper: filled rectangle ─────────────────────────────
def rectangle(x, y, width, height, outline_color, fill_color):
    """Draw a filled rectangle with the bottom-left corner at (x, y)."""
    jump(x, y)
    t.color(outline_color)
    t.fillcolor(fill_color)
    t.begin_fill()
    for length in [width, height, width, height]:
        t.forward(length)
        t.left(90)
    t.end_fill()

# ── Helper: filled triangle (roof) ───────────────────────
def triangle(x, y, base, height, outline_color, fill_color):
    """Draw an isoceles triangle (roof shape) with base starting at (x,y)."""
    jump(x, y)
    t.color(outline_color)
    t.fillcolor(fill_color)
    t.begin_fill()
    t.setheading(0)
    t.forward(base)
    # Calculate the angle to the peak using atan2
    import math
    peak_angle = math.degrees(math.atan2(height, base / 2))
    t.left(180 - peak_angle)
    hyp = math.sqrt((base / 2) ** 2 + height ** 2)
    t.forward(hyp)
    t.left(180 - 2 * (90 - peak_angle))
    t.forward(hyp)
    t.end_fill()

# ── Draw the ground ──────────────────────────────────────
rectangle(-400, -260, 800, 80, "darkgreen", "limegreen")

# ── Draw the house body ──────────────────────────────────
rectangle(-100, -230, 200, 180, "saddlebrown", "wheat")

# ── Draw the roof ────────────────────────────────────────
triangle(-115, -50, 230, 120, "firebrick", "firebrick")

# ── Draw the door ────────────────────────────────────────
rectangle(-22, -230, 44, 90, "saddlebrown", "sienna")

# Door handle
jump(16, -190)
t.color("gold")
t.dot(7)

# ── Draw windows ─────────────────────────────────────────
def window(x, y):
    """Draw a window at position (x, y)."""
    rectangle(x, y, 45, 45, "steelblue", "lightcyan")
    # Cross pane lines
    t.color("steelblue")
    t.width(1)
    jump(x, y + 22)          # horizontal pane
    t.setheading(0)
    t.forward(45)
    jump(x + 22, y)          # vertical pane
    t.setheading(90)
    t.forward(45)

window(-85, -130)
window(40, -130)

# ── Draw a chimney ───────────────────────────────────────
rectangle(50, -50, 30, 80, "saddlebrown", "rosybrown")

# Smoke puffs (circles using t.dot)
t.penup()
for i, (cx, cy, sz) in enumerate([(65, 40, 22), (72, 62, 16), (65, 80, 12)]):
    t.goto(cx, cy)
    t.color("lightgray")
    t.dot(sz)

# ── Draw a sun ───────────────────────────────────────────
jump(280, 140)
t.color("gold")
t.fillcolor("yellow")
t.begin_fill()
for _ in range(36):           # 36-sided polygon ≈ circle
    t.forward(7)
    t.left(10)
t.end_fill()

# Sun rays
for angle in range(0, 360, 30):
    t.penup()
    t.goto(280, 140)
    t.setheading(angle)
    t.forward(30)
    t.pendown()
    t.color("gold")
    t.forward(20)

# ── Draw clouds using overlapping circles ─────────────────
def cloud(cx, cy):
    """Draw a cloud centered near (cx, cy) using overlapping dots."""
    t.penup()
    offsets = [(-35, 0, 30), (-10, 5, 38), (20, 0, 30), (45, -5, 24)]
    for dx, dy, size in offsets:
        t.goto(cx + dx, cy + dy)
        t.color("white")
        t.dot(size)

cloud(-200, 160)
cloud(  50, 190)

# ── Draw a fence ─────────────────────────────────────────
# Each fence post is a narrow rectangle + pointed top.
t.width(1)
for post_x in range(-280, -110, 30):
    rectangle(post_x, -260, 18, 70, "peru", "burlywood")
    # Pointy top
    jump(post_x + 9, -190 + 15)
    t.color("peru")
    t.dot(20)

for post_x in range(120, 290, 30):
    rectangle(post_x, -260, 18, 70, "peru", "burlywood")
    jump(post_x + 9, -190 + 15)
    t.color("peru")
    t.dot(20)

# Horizontal fence rails
t.color("peru")
t.width(3)
for rail_y in [-200, -230]:
    jump(-280, rail_y)
    t.setheading(0)
    t.pendown()
    t.forward(170)
    jump(120, rail_y)
    t.forward(170)

# ── Draw a tree ──────────────────────────────────────────
# Trunk
rectangle(-280, -260, 22, 80, "saddlebrown", "saddlebrown")

# Leaves (stacked triangles)
for level, (tx, ty, tw, th) in enumerate([
    (-300, -180, 60, 60),
    (-290, -140, 40, 55),
    (-283, -100, 26, 50),
]):
    triangle(tx, ty, tw, th, "darkgreen", "forestgreen")

# ── Final update ─────────────────────────────────────────
turtle.update()         # show everything we drew at once

print("House scene complete!")
print("Challenge: Can you add:")
print("  - A second tree on the right?")
print("  - A path leading to the door?")
print("  - Stars in the sky (change bgcolor to 'midnightblue')?")

turtle.done()
