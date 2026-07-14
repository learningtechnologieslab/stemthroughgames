# ============================================================
# STEM through Games — Day 3: Structure, Hierarchy & the World
# FILE: 05_teleport_demo.mcfunction
#
# PURPOSE:
#   Demonstrates absolute vs. relative coordinates using /tp.
#   Each command is a separate "demo" — run them one at a time
#   and discuss with students what happened and why.
#
# TEACHER NOTE:
#   Copy and paste ONE command at a time into the chat window.
#   Ask the discussion question before running the next one.
# ============================================================

# ─────────────────────────────────────────────────────────────
# DEMO 1: Absolute Teleport
# Jumps the player to an EXACT world coordinate.
# The coordinate is measured from the world origin (0, 64, 0).
# DISCUSSION: "The structures stayed. Only YOU moved. Why?"
# ─────────────────────────────────────────────────────────────
tp @s 50 66 0

# ─────────────────────────────────────────────────────────────
# DEMO 2: Return to compound
# ─────────────────────────────────────────────────────────────
tp @s 0 66 0

# ─────────────────────────────────────────────────────────────
# DEMO 3: Relative Teleport (the ~ ~ ~ syntax)
# Moves the player +5 blocks on the X axis FROM WHERE THEY ARE.
# The ~ means "add this to my CURRENT coordinate."
# DISCUSSION: "How is this like a local offset vs. absolute?"
# ─────────────────────────────────────────────────────────────
tp @s ~5 ~0 ~0

# ─────────────────────────────────────────────────────────────
# DEMO 4: Relative teleport in all three axes
# Moves +3 East, stays same height, +3 South
# DISCUSSION: "Which axis is which? How do you know?"
# ─────────────────────────────────────────────────────────────
tp @s ~3 ~0 ~3

# ─────────────────────────────────────────────────────────────
# DEMO 5: Teleport ABOVE the Player House roof
# Absolute coordinate of the roof: (-5, 71, -5)
# DISCUSSION: "How did we figure out this coordinate? What math?"
# ─────────────────────────────────────────────────────────────
tp @s -5 71 -5

# ─────────────────────────────────────────────────────────────
# DEMO 6: Teleport to the Chest Room
# World position of first chest: (-7, 68, -7)  (one block above)
# DISCUSSION: "This chest is a child of Player House.
#   Player House NW corner is at (-8, 66, -8).
#   Chest local offset = (1, 1, 1).
#   world = parent + local = (-8+1, 66+1, -8+1) = (-7, 67, -7). ✓"
# ─────────────────────────────────────────────────────────────
tp @s -7 68 -7

# ─────────────────────────────────────────────────────────────
# DEMO 7: Teleport all players to the same spot (class reset)
# Use this to gather everyone together for discussion
# ─────────────────────────────────────────────────────────────
tp @a 0 66 5

# ─────────────────────────────────────────────────────────────
# DEMO 8: The Math Challenge — students predict BEFORE running
# Player House is at (-8, 66, -8).
# If we "move the house" 10 blocks east, where does it go?
# New House position = (-8 + 10, 66, -8) = (2, 66, -8)
# New Chest Room world pos = (2+1, 66+1, -8+1) = (3, 67, -7)
# The command below teleports you to where the CHEST ROOM
# WOULD BE if the house had moved. Ask: "Is there anything here?"
# ─────────────────────────────────────────────────────────────
tp @s 3 68 -7
