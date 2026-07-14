# ============================================================
#  04_color_and_style.py  —  Color, Pen Width & Filled Shapes
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  Topics covered:
#    • t.color()    — set outline color by name or hex
#    • t.width()    — change pen thickness
#    • t.speed()    — control drawing speed
#    • t.fillcolor()— set the fill color separately
#    • t.begin_fill() / t.end_fill() — fill a closed shape
#    • turtle.bgcolor() — change the canvas background
#    • hideturtle() — remove the arrow for a clean finish
#
# ============================================================

import turtle

# ── Change the background color ──────────────────────────
turtle.bgcolor("midnightblue")

t = turtle.Turtle()
t.speed(6)
t.hideturtle()          # hide the arrow — we'll show shapes only

# ── Example 1: Colored outline shapes ────────────────────
# t.color() sets the color of the pen line.
# Pass any CSS color name (e.g. 'red', 'gold', 'chartreuse')
# or a hex string (e.g. '#FF5733').

shapes = [
    {"sides": 3, "length": 90,  "color": "tomato",      "x": -280, "y":  80},
    {"sides": 4, "length": 80,  "color": "deepskyblue",  "x": -100, "y":  80},
    {"sides": 5, "length": 70,  "color": "limegreen",    "x":  70,  "y":  80},
    {"sides": 6, "length": 60,  "color": "gold",         "x":  230, "y":  80},
]

for shape in shapes:
    t.penup()
    t.goto(shape["x"], shape["y"])
    t.pendown()

    t.color(shape["color"])
    t.width(3)

    angle = 360 / shape["sides"]
    for _ in range(shape["sides"]):
        t.forward(shape["length"])
        t.left(angle)

# ── Example 2: Filled shapes ─────────────────────────────
# begin_fill() tells turtle: "I'm about to draw a shape — remember it."
# After drawing, end_fill() fills the enclosed area with the fill color.

filled_shapes = [
    {"sides": 3, "length": 85,  "outline": "white",    "fill": "crimson",     "x": -280, "y": -100},
    {"sides": 4, "length": 75,  "outline": "white",    "fill": "royalblue",   "x": -100, "y": -100},
    {"sides": 5, "length": 65,  "outline": "white",    "fill": "darkorange",  "x":  70,  "y": -100},
    {"sides": 6, "length": 55,  "outline": "white",    "fill": "mediumorchid","x":  230,  "y": -100},
]

for shape in filled_shapes:
    t.penup()
    t.goto(shape["x"], shape["y"])
    t.pendown()

    t.color(shape["outline"])          # outline color
    t.fillcolor(shape["fill"])         # fill color (can be different)
    t.width(2)

    t.begin_fill()                     # ← start recording the shape
    angle = 360 / shape["sides"]
    for _ in range(shape["sides"]):
        t.forward(shape["length"])
        t.left(angle)
    t.end_fill()                       # ← fill everything inside

# ── Example 3: Vary pen width ────────────────────────────
# width() controls how thick the pen stroke is.

t.penup()
t.goto(-150, -210)
t.pendown()
t.setheading(0)        # face East again

for thickness in [1, 3, 5, 8, 12]:
    t.color("cyan")
    t.width(thickness)
    t.forward(55)
    t.penup()
    t.forward(5)       # small gap between lines
    t.pendown()

# Label
t.penup()
t.goto(-148, -230)
t.color("white")
t.write("width: 1  3  5  8  12", font=("Arial", 9, "normal"))

# ── Example 4: Using hex color codes ─────────────────────
# Hex codes give you millions of exact colors (like web design).
# Format: '#RRGGBB' — two hex digits each for Red, Green, Blue.

t.penup()
t.goto(80, -185)
t.pendown()
t.setheading(0)

hex_colors = ["#FF6B6B", "#FFE66D", "#4ECDC4", "#45B7D1", "#96CEB4"]

t.width(5)
for hex_color in hex_colors:
    t.color(hex_color)
    t.forward(40)
    t.penup()
    t.forward(4)
    t.pendown()

t.penup()
t.goto(78, -205)
t.color("white")
t.write("hex colors", font=("Arial", 9, "italic"))

turtle.done()
