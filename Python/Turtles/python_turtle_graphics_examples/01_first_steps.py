# ============================================================
#  01_first_steps.py  —  Your Very First Turtle Program
#  Middle School Python · Unit 5 · Lesson 5.1
# ============================================================
#
#  Topics covered:
#    • Importing the turtle module
#    • Creating a Turtle object
#    • forward(), backward(), left(), right()
#    • Watching code produce a visual result
#
#  HOW TO RUN:
#    Open this file in IDLE or Thonny and press F5 (Run).
#    A new window will appear — that's the turtle canvas!
# ============================================================

import turtle

# ── Setup ────────────────────────────────────────────────
t = turtle.Turtle()   # create our turtle, named t
t.speed(3)            # 1=slow, 10=fast — 3 is good for learning

# ── Example 1: A single line ────────────────────────────
# forward(100) moves the turtle 100 pixels in the direction it's facing.
# The turtle starts facing East (right), so this draws a horizontal line.

t.forward(100)        # draw a line 100 pixels long

# ── Example 2: Turn and draw again ──────────────────────
# left(90) rotates the turtle 90 degrees counterclockwise.
# After turning, the next forward() goes in the NEW direction.

t.left(90)            # face North (up)
t.forward(80)         # draw upward

t.right(45)           # turn 45 degrees clockwise (face NE)
t.forward(60)         # draw diagonally

# ── Example 3: Use backward() ───────────────────────────
t.backward(40)        # back up 40 pixels (same direction, reversed)

# ── Example 4: Move without drawing (penup / pendown) ───
t.penup()             # lift the pen — movement won't draw a line
t.goto(-150, -100)    # jump to a new location on the canvas
t.pendown()           # put the pen back down — drawing resumes

t.forward(120)        # draw from the new position

# ── Keep the window open ─────────────────────────────────
# Without this line, the window closes immediately!
turtle.done()
