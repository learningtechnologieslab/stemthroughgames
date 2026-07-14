# ============================================================
#  06_creative_patterns.py  —  Spirals, Stars & Flowers
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  Topics covered:
#    • Varying forward() distance each iteration → spiral
#    • Turning by a non-round angle → overlapping star pattern
#    • Nested loops: draw a shape, rotate, repeat → flower
#    • Changing color inside a loop using a list
#    • t.speed(0) for instant drawing of complex patterns
#
# ============================================================

import turtle

# ── Pattern 1: Square Spiral ─────────────────────────────
# Each side is slightly longer than the last.
# Result: a growing square that spirals outward.

print("Drawing Pattern 1: Square Spiral...")

t = turtle.Turtle()
turtle.bgcolor("black")
t.speed(0)          # 0 = instant (fastest)
t.hideturtle()

colors = ["teal", "steelblue", "deepskyblue", "cyan"]

for i in range(80):
    t.color(colors[i % len(colors)])   # cycle through colors
    t.width(1.5)
    t.forward(i * 3)                   # each step is 3px longer
    t.left(91)                         # 91° instead of 90° creates the spiral effect

input("Press ENTER to see Pattern 2...")  # pause so you can admire it

# ── Pattern 2: Rainbow Star Burst ────────────────────────
# Turning 144° per step on a 5-pointed star.
# Running the loop 50 times with slight rotation creates a burst.

print("Drawing Pattern 2: Rainbow Star Burst...")

t.clear()
t.penup()
t.goto(0, 0)
t.pendown()
t.setheading(0)

rainbow = ["red", "orangered", "orange", "gold", "yellow",
           "yellowgreen", "limegreen", "cyan", "deepskyblue",
           "dodgerblue", "blueviolet", "orchid"]

for i in range(60):
    t.color(rainbow[i % len(rainbow)])
    t.width(2)

    # Draw one 5-pointed star
    for _ in range(5):
        t.forward(120)
        t.right(144)           # 144° = exterior angle of a 5-pointed star

    t.left(6)                  # rotate the whole thing by 6° before next star

input("Press ENTER to see Pattern 3...")

# ── Pattern 3: Hexagonal Flower ──────────────────────────
# Draw a hexagon, rotate a little, draw again.
# 60 repetitions × 6° = 360° — a complete flower.

print("Drawing Pattern 3: Hexagonal Flower...")

t.clear()
t.penup()
t.goto(0, 0)
t.pendown()
t.setheading(0)

petal_colors = ["tomato", "coral", "gold", "limegreen", "dodgerblue", "orchid"]

for i in range(60):
    t.color(petal_colors[i % len(petal_colors)])
    t.width(1)

    # Draw one hexagon petal
    for _ in range(6):
        t.forward(80)
        t.left(60)

    t.left(6)   # rotate 6° before drawing the next hexagon

input("Press ENTER to see Pattern 4...")

# ── Pattern 4: Teal Spiral (the classic) ─────────────────
# The simplest and most satisfying spiral:
# forward by a growing amount, turn a fixed angle.

print("Drawing Pattern 4: Classic Spiral...")

t.clear()
t.penup()
t.goto(0, 0)
t.pendown()
t.setheading(0)

t.color("teal")
t.width(2)

for i in range(150):
    t.forward(i * 2)        # distance grows with each step
    t.left(91)              # just 1° off from 90° creates the outward drift

input("Press ENTER to see Pattern 5...")

# ── Pattern 5: Nested squares (concentric) ───────────────
# Draw a square, then a slightly larger one outside it.
# The squares share the same center by adjusting start position.

print("Drawing Pattern 5: Concentric Squares...")

t.clear()
t.hideturtle()

for i in range(1, 20):
    size = i * 18
    t.penup()
    t.goto(-size / 2, -size / 2)   # center each square
    t.pendown()
    t.setheading(0)

    # Alternate colors
    if i % 2 == 0:
        t.color("teal")
    else:
        t.color("gold")

    t.width(2)
    for _ in range(4):
        t.forward(size)
        t.left(90)

print("\nAll patterns complete!")
print("Try changing the numbers and see what happens:")
print("  - Change 91 to 89 or 121")
print("  - Change the range() count")
print("  - Swap the color list")

turtle.done()
