# ============================================================
#  09_free_draw_starters.py  —  Free-Draw Project Templates
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  Five starter templates for the free-draw project.
#  Each template is complete and runnable — students can
#  modify colors, sizes, and add their own shapes.
#
#  Templates included:
#    A. Nighttime cityscape
#    B. Solar system (concentric orbits)
#    C. Kaleidoscope pattern
#    D. Robot face
#    E. Underwater scene
#
#  HOW TO USE:
#    1. Read through all five templates.
#    2. Pick the one you like most (or mix ideas).
#    3. Customize — change colors, sizes, add new elements.
#    4. Add at least two comments explaining your choices.
# ============================================================

import turtle
import math

# ── Choose which template to run ─────────────────────────
# Change this number (A–E) to switch templates:
TEMPLATE = "A"

# ============================================================
if TEMPLATE == "A":
    # ── Template A: Nighttime Cityscape ───────────────────
    print("Template A: Nighttime Cityscape")

    turtle.bgcolor("midnightblue")
    t = turtle.Turtle()
    t.hideturtle()
    t.speed(0)
    turtle.tracer(0)

    def jump(x, y):
        t.penup(); t.goto(x, y); t.pendown(); t.setheading(0)

    def building(x, w, h, color):
        """Draw a filled building rectangle."""
        jump(x, -260)
        t.color("black")
        t.fillcolor(color)
        t.begin_fill()
        for side in [w, h, w, h]:
            t.forward(side)
            t.left(90)
        t.end_fill()

        # Windows: small yellow rectangles
        for row in range(2, h - 20, 28):
            for col in range(8, w - 6, 20):
                if (row + col) % 3 != 0:   # some windows lit, some dark
                    jump(x + col, -260 + row)
                    t.fillcolor("gold")
                    t.color("gold")
                    t.begin_fill()
                    for s in [10, 14, 10, 14]:
                        t.forward(s)
                        t.left(90)
                    t.end_fill()

    # Draw several buildings of different heights
    building(-380, 70, 180, "#1A1A2E")
    building(-300, 55, 240, "#16213E")
    building(-235, 80, 200, "#0F3460")
    building(-145, 60, 300, "#1A1A2E")
    building(-75,  90, 160, "#16213E")
    building( 25,  50, 280, "#0F3460")
    building( 85,  75, 210, "#1A1A2E")
    building(170,  60, 160, "#16213E")
    building(240,  85, 230, "#0F3460")
    building(335,  55, 180, "#1A1A2E")

    # Ground
    jump(-400, -260)
    t.color("black")
    t.fillcolor("#0A0A0F")
    t.begin_fill()
    for s in [800, 30, 800, 30]:
        t.forward(s)
        t.left(90)
    t.end_fill()

    # Moon
    jump(280, 160)
    t.color("lightyellow")
    t.fillcolor("lightyellow")
    t.begin_fill()
    for _ in range(36):
        t.forward(5)
        t.left(10)
    t.end_fill()

    # Stars
    import random
    random.seed(42)
    for _ in range(80):
        sx = random.randint(-390, 390)
        sy = random.randint(20, 280)
        t.penup()
        t.goto(sx, sy)
        t.dot(random.choice([2, 2, 3, 4]), "white")

    turtle.update()
    print("Cityscape drawn! Try changing the building colors or heights.")

# ============================================================
elif TEMPLATE == "B":
    # ── Template B: Solar System ──────────────────────────
    print("Template B: Solar System")

    turtle.bgcolor("black")
    t = turtle.Turtle()
    t.hideturtle()
    t.speed(0)
    turtle.tracer(0)

    def circle(cx, cy, r, outline, fill):
        """Draw a filled circle of radius r centered at (cx, cy)."""
        t.penup()
        t.goto(cx, cy - r)      # start at bottom of circle
        t.pendown()
        t.setheading(0)
        t.color(outline)
        t.fillcolor(fill)
        t.begin_fill()
        for _ in range(72):
            t.forward(2 * math.pi * r / 72)
            t.left(5)
        t.end_fill()

    def orbit_ring(cx, cy, r):
        """Draw a faint orbit circle."""
        t.penup()
        t.goto(cx, cy - r)
        t.pendown()
        t.setheading(0)
        t.color("#333333")
        t.width(1)
        for _ in range(72):
            t.forward(2 * math.pi * r / 72)
            t.left(5)

    # Sun
    circle(0, 0, 50, "gold", "yellow")
    t.penup()
    t.goto(-18, -8)
    t.color("darkorange")
    t.write("Sun", font=("Arial", 10, "bold"))

    # Planets: (name, orbit_radius, planet_radius, angle, color)
    planets = [
        ("Mercury", 80,  6,  40,  "gray"),
        ("Venus",  120,  9, 100,  "burlywood"),
        ("Earth",  170, 10, 200,  "dodgerblue"),
        ("Mars",   220,  7, 300,  "tomato"),
        ("Jupiter",300, 22,  50,  "peru"),
        ("Saturn", 370, 16, 150,  "khaki"),
    ]

    for name, orbit_r, planet_r, angle_deg, color in planets:
        orbit_ring(0, 0, orbit_r)

        # Calculate planet position on orbit
        angle_rad = math.radians(angle_deg)
        px = orbit_r * math.cos(angle_rad)
        py = orbit_r * math.sin(angle_rad)

        circle(px, py, planet_r, "white", color)

        # Label
        t.penup()
        t.goto(px + planet_r + 3, py - 5)
        t.color("white")
        t.write(name, font=("Arial", 7, "normal"))

        # Saturn's rings
        if name == "Saturn":
            t.penup()
            t.goto(px - planet_r - 12, py)
            t.pendown()
            t.setheading(0)
            t.color("tan")
            t.width(2)
            t.forward((planet_r + 12) * 2)

    # Stars
    import random
    random.seed(7)
    for _ in range(150):
        t.penup()
        t.goto(random.randint(-400, 400), random.randint(-300, 300))
        t.dot(random.choice([1, 1, 2]), "white")

    turtle.update()
    print("Solar system drawn! Try adding Uranus and Neptune.")

# ============================================================
elif TEMPLATE == "C":
    # ── Template C: Kaleidoscope Pattern ──────────────────
    print("Template C: Kaleidoscope")

    turtle.bgcolor("black")
    t = turtle.Turtle()
    t.hideturtle()
    t.speed(0)
    turtle.tracer(0)

    colors = [
        "deeppink", "hotpink", "violet", "mediumpurple",
        "cornflowerblue", "deepskyblue", "aquamarine",
        "limegreen", "gold", "orange"
    ]

    # Draw 40 overlapping pentagons, each rotated by 9°
    # 40 × 9° = 360° — a complete revolution
    for i in range(40):
        t.color(colors[i % len(colors)])
        t.width(1.5)

        t.penup()
        t.goto(0, 0)
        t.pendown()

        # Draw a pentagon
        for _ in range(5):
            t.forward(160)
            t.left(72)     # 360 / 5 = 72°

        t.left(9)          # rotate 9° for next iteration

    turtle.update()
    print("Kaleidoscope drawn! Try changing 72 to 60 (hexagon) or 90 (square).")

# ============================================================
elif TEMPLATE == "D":
    # ── Template D: Robot Face ────────────────────────────
    print("Template D: Robot Face")

    turtle.bgcolor("lightgray")
    t = turtle.Turtle()
    t.hideturtle()
    t.speed(0)
    turtle.tracer(0)

    def jump(x, y):
        t.penup(); t.goto(x, y); t.pendown(); t.setheading(0)

    def filled_rect(x, y, w, h, color):
        jump(x, y)
        t.fillcolor(color); t.color("darkgray"); t.begin_fill()
        for s in [w, h, w, h]:
            t.forward(s); t.left(90)
        t.end_fill()

    def filled_circle(x, y, r, color):
        t.penup(); t.goto(x, y - r); t.pendown()
        t.setheading(0); t.color("darkgray"); t.fillcolor(color)
        t.begin_fill()
        for _ in range(36):
            t.forward(2 * math.pi * r / 36); t.left(10)
        t.end_fill()

    # Head
    filled_rect(-100, -100, 200, 200, "silver")

    # Eyes
    filled_circle(-40, 50, 25, "deepskyblue")
    filled_circle( 40, 50, 25, "deepskyblue")
    # Pupils
    filled_circle(-40, 50, 10, "black")
    filled_circle( 40, 50, 10, "black")
    # Shine dots
    filled_circle(-33, 56, 4, "white")
    filled_circle( 47, 56, 4, "white")

    # Nose (small square)
    filled_rect(-10, 5, 20, 20, "steelblue")

    # Mouth (row of small rectangles = teeth)
    for mx in range(-50, 55, 20):
        filled_rect(mx, -50, 16, 12, "white")

    # Mouth outline
    jump(-55, -50)
    t.color("darkgray"); t.width(2)
    t.forward(110)

    # Antennae
    t.color("darkgray"); t.width(3)
    jump(0, 100)
    t.setheading(90)
    t.forward(50)
    filled_circle(0, 155, 8, "red")

    # Ears
    filled_rect(-125, 10, 25, 40, "darkgray")
    filled_rect( 100, 10, 25, 40, "darkgray")
    # Ear detail
    filled_rect(-120, 18, 14, 22, "steelblue")
    filled_rect( 106, 18, 14, 22, "steelblue")

    # Label
    t.penup(); t.goto(-55, -130)
    t.color("black")
    t.write("ROBO-TURTLE v1.0", font=("Arial", 13, "bold"))

    turtle.update()
    print("Robot drawn! Try changing the eye color or adding a body below.")

# ============================================================
elif TEMPLATE == "E":
    # ── Template E: Underwater Scene ──────────────────────
    print("Template E: Underwater Scene")

    turtle.bgcolor("midnightblue")
    t = turtle.Turtle()
    t.hideturtle()
    t.speed(0)
    turtle.tracer(0)

    def jump(x, y):
        t.penup(); t.goto(x, y); t.pendown(); t.setheading(0)

    def filled_rect(x, y, w, h, color):
        jump(x, y); t.fillcolor(color); t.color(color); t.begin_fill()
        for s in [w, h, w, h]: t.forward(s); t.left(90)
        t.end_fill()

    # Sea floor
    filled_rect(-400, -260, 800, 80, "#4A2800")

    # Seaweed (wavy tall rectangles)
    import random
    random.seed(99)
    for sx in range(-350, 360, 40):
        seaweed_h = random.randint(60, 130)
        filled_rect(sx, -260 + 80, 12, seaweed_h, random.choice(["darkgreen", "green", "olivedrab"]))

    # Bubbles floating up
    for _ in range(40):
        bx = random.randint(-380, 380)
        by = random.randint(-200, 280)
        bsize = random.choice([5, 8, 10, 6])
        t.penup(); t.goto(bx, by)
        t.color("lightcyan"); t.dot(bsize)

    # Simple fish function
    def fish(fx, fy, size, color, facing="right"):
        """Draw a simple triangular fish."""
        t.penup(); t.goto(fx, fy); t.pendown()
        t.color(color); t.fillcolor(color)
        t.setheading(0 if facing == "right" else 180)
        t.begin_fill()
        t.forward(size); t.left(150); t.forward(size * 0.8)
        t.left(60); t.forward(size * 0.8); t.left(150)
        t.end_fill()
        # Tail
        tail_x = fx - size * 0.1 if facing == "right" else fx + size * 0.1
        t.penup(); t.goto(tail_x, fy)
        t.pendown(); t.color(color); t.fillcolor(color)
        t.setheading(150 if facing == "right" else 30)
        t.begin_fill()
        for s in [size * 0.4, size * 0.3, size * 0.5]:
            t.forward(s); t.right(120)
        t.end_fill()
        # Eye
        t.penup()
        eye_x = fx + size * 0.7 if facing == "right" else fx - size * 0.7
        t.goto(eye_x, fy + size * 0.2)
        t.dot(max(3, size // 8), "black")

    # Scatter some fish around
    fish(-200,  50, 45, "tomato",      "right")
    fish(  50,  30, 55, "gold",        "left")
    fish(-100, 120, 35, "deepskyblue", "right")
    fish( 200,  80, 50, "coral",       "left")
    fish(-300, -60, 40, "orchid",      "right")
    fish( 100, -40, 30, "limegreen",   "left")

    # Coral mounds on sea floor
    for cx in [-250, -80, 100, 270]:
        t.penup(); t.goto(cx, -180)
        t.color("tomato"); t.dot(random.randint(25, 50))
        t.color("coral");  t.dot(random.randint(15, 30))

    # Sun rays from the surface
    for angle in range(-30, 31, 15):
        t.penup(); t.goto(angle * 5, 290)
        t.pendown(); t.setheading(270)
        t.color("lightyellow"); t.width(1)
        t.pendown()
        # Dotted ray going downward
        for _ in range(20):
            t.forward(10); t.penup(); t.forward(5); t.pendown()

    turtle.update()
    print("Underwater scene drawn! Try adding a shark or a treasure chest!")

else:
    print(f"Unknown template '{TEMPLATE}'. Change TEMPLATE to A, B, C, D, or E.")

turtle.done()
