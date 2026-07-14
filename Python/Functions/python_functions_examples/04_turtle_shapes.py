# ============================================================
#  04_turtle_shapes.py  —  Turtle Shape Library with Functions
#  Middle School Python · Unit 6 · Lesson 6.1
# ============================================================
#
#  Topics covered:
#    • Defining functions that use turtle
#    • Parameters for size, color, and position
#    • The DRY principle applied visually
#    • Function composition (draw_house calls smaller functions)
#    • jump() helper to reposition without drawing
#
#  HOW TO RUN:
#    Open in IDLE or Thonny and press F5.
#    A drawing window will appear.
# ============================================================

import turtle

# ── Canvas setup ─────────────────────────────────────────
turtle.bgcolor("white")
turtle.tracer(0)          # disable animation — draw instantly

t = turtle.Turtle()
t.hideturtle()
t.speed(0)

# ── Utility: jump to position ────────────────────────────

def jump(x, y, heading=0):
    """Move turtle to (x, y) without drawing a line."""
    t.penup()
    t.goto(x, y)
    t.setheading(heading)
    t.pendown()


# ════════════════════════════════════════════════════════
# BASIC SHAPES
# ════════════════════════════════════════════════════════

def draw_square(size, color="steelblue", filled=False):
    """
    Draw a square with the given side length.

    Parameters
    ----------
    size   : int   — side length in pixels
    color  : str   — pen (and fill) color
    filled : bool  — fill the interior if True
    """
    t.color(color)
    if filled:
        t.fillcolor(color)
        t.begin_fill()
    for _ in range(4):
        t.forward(size)
        t.left(90)
    if filled:
        t.end_fill()
    return size * 4      # return perimeter as a bonus


def draw_triangle(size, color="orangered", filled=False):
    """Draw an equilateral triangle (turn angle = 120°)."""
    t.color(color)
    if filled:
        t.fillcolor(color)
        t.begin_fill()
    for _ in range(3):
        t.forward(size)
        t.left(120)
    if filled:
        t.end_fill()


def draw_polygon(sides, size, color="purple", filled=False):
    """
    Draw any regular polygon.

    Formula: turn_angle = 360 / sides
    Try sides=36 for a near-circle!
    """
    angle = 360 / sides
    t.color(color)
    if filled:
        t.fillcolor(color)
        t.begin_fill()
    for _ in range(sides):
        t.forward(size)
        t.left(angle)
    if filled:
        t.end_fill()


def draw_star(size, color="gold", filled=True):
    """
    Draw a filled 5-pointed star.
    A star uses RIGHT turns of 144° each.
    """
    t.color(color)
    t.fillcolor(color)
    if filled:
        t.begin_fill()
    for _ in range(5):
        t.forward(size)
        t.right(144)
    if filled:
        t.end_fill()


# ════════════════════════════════════════════════════════
# COMPOUND SHAPES  (functions calling other functions)
# ════════════════════════════════════════════════════════

def draw_house(x, y, size, wall_color="wheat", roof_color="firebrick"):
    """
    Draw a house at (x, y) with given wall size.

    This function CALLS draw_square and draw_triangle internally —
    that's FUNCTION COMPOSITION.
    """
    jump(x, y)

    # Body (square)
    perimeter = draw_square(size, color=wall_color, filled=True)

    # Roof (triangle on top of the square)
    jump(x, y + size)
    draw_triangle(size, color=roof_color, filled=True)

    # Door
    door_w = size // 4
    door_h = size // 3
    jump(x + size // 2 - door_w // 2, y)
    t.color("saddlebrown")
    t.fillcolor("saddlebrown")
    t.begin_fill()
    for length in [door_w, door_h, door_w, door_h]:
        t.forward(length)
        t.left(90)
    t.end_fill()

    # Window
    win_size = size // 5
    jump(x + size // 5, y + size // 2)
    draw_square(win_size, color="skyblue", filled=True)

    return perimeter


def draw_tree(x, y, trunk_height=60, leaf_size=55, leaf_color="forestgreen"):
    """
    Draw a tree at (x, y).
    Trunk is a thin rectangle; leaves are a filled triangle on top.
    """
    trunk_width = trunk_height // 4

    # Trunk
    jump(x, y)
    t.color("saddlebrown")
    t.fillcolor("saddlebrown")
    t.begin_fill()
    for length in [trunk_width, trunk_height, trunk_width, trunk_height]:
        t.forward(length)
        t.left(90)
    t.end_fill()

    # Leaves (triangle centered above trunk)
    jump(x - (leaf_size - trunk_width) // 2, y + trunk_height)
    draw_triangle(leaf_size, color=leaf_color, filled=True)


def draw_sun(x, y, radius=30, rays=8, color="gold"):
    """Draw a sun with a configurable number of rays."""
    # Sun circle
    jump(x, y - radius)
    t.color(color)
    t.fillcolor(color)
    t.begin_fill()
    draw_polygon(36, int(2 * 3.14159 * radius / 36), color=color, filled=True)
    t.end_fill()

    # Rays
    t.width(2)
    for i in range(rays):
        jump(x, y)
        t.setheading(i * (360 / rays))
        t.pendown()
        t.forward(radius + 22)
        t.penup()
    t.width(1)


def draw_ground(width=800, color="limegreen"):
    """Draw a thick ground line across the bottom of the scene."""
    t.penup()
    t.goto(-width // 2, -230)
    t.pendown()
    t.color(color)
    t.fillcolor(color)
    t.begin_fill()
    for length in [width, 30, width, 30]:
        t.forward(length)
        t.left(90)
    t.end_fill()


# ════════════════════════════════════════════════════════
# DEMO 1 — Shape Gallery (left side)
# ════════════════════════════════════════════════════════

# Row 1: basic shapes
jump(-370, 80)
draw_square(70, "steelblue")

jump(-260, 80)
draw_triangle(75, "orangered")

jump(-150, 80)
draw_polygon(5, 55, "purple")        # pentagon

jump(-40, 80)
draw_polygon(6, 45, "teal")          # hexagon

jump(70, 80)
draw_star(60, "gold")

jump(185, 80)
draw_polygon(36, 8, "crimson")       # near-circle

# Row 2: filled versions
jump(-370, -30)
draw_square(70, "steelblue", filled=True)

jump(-260, -30)
draw_triangle(75, "orangered", filled=True)

jump(-150, -30)
draw_polygon(5, 55, "purple", filled=True)

jump(-40, -30)
draw_polygon(6, 45, "teal", filled=True)

jump(70, -30)
draw_star(60, "gold", filled=True)

jump(185, -30)
draw_polygon(36, 8, "crimson", filled=True)

# Labels
t.color("black")
t.width(1)
for label, lx in [("Square", -340), ("Triangle", -235), ("Pentagon", -125),
                   ("Hexagon", -22), ("Star", 90), ("Circle*", 198)]:
    t.penup()
    t.goto(lx, 62)
    t.write(label, font=("Arial", 8, "italic"))

t.penup()
t.goto(-370, 155)
t.write("Outline     Filled", font=("Arial", 9, "bold"))

# ════════════════════════════════════════════════════════
# DEMO 2 — Town Scene (bottom half)
# ════════════════════════════════════════════════════════

draw_ground(800, "limegreen")

# Sun
draw_sun(290, 150, radius=32, rays=10, color="gold")

# Houses
draw_house(-300, -230, 90, "wheat",      "firebrick")
draw_house(-160, -230, 80, "lightyellow","darkred")
draw_house(-30,  -230, 100,"lightblue",  "navy")
draw_house(110,  -230, 75, "mistyrose",  "sienna")

# Trees
draw_tree(-230, -230, trunk_height=55, leaf_size=60, leaf_color="darkgreen")
draw_tree( 80,  -230, trunk_height=70, leaf_size=65, leaf_color="forestgreen")
draw_tree( 215, -230, trunk_height=45, leaf_size=50, leaf_color="olivedrab")

# Title
t.penup()
t.goto(-120, 195)
t.color("darkslateblue")
t.write("Functions Shape Library  —  Unit 6", font=("Arial", 13, "bold"))

t.penup()
t.goto(-160, 175)
t.color("gray")
t.write("Every shape drawn by calling a function — zero copy-paste!",
        font=("Arial", 9, "italic"))

# ── Final update ─────────────────────────────────────────
turtle.update()

print("Drawing complete!")
print("\nChallenge questions:")
print("  1. How many houses can you add by just adding one more draw_house() call?")
print("  2. What happens if you change leaf_color in draw_tree()?")
print("  3. Can you write a draw_fence() function using a loop?")

turtle.done()
