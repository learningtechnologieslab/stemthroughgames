# ============================================================
# STEM through Games — Day 3: Structure, Hierarchy & the World
# FILE: 06_math_challenges.mcfunction
#
# PURPOSE:
#   These commands ARE the math challenge questions from the
#   lesson plan, made interactive. Students calculate the
#   answer first, then run the command to check.
#
# HOW TO USE:
#   1. Pose the question (see CHALLENGE comment)
#   2. Students work out the answer on paper
#   3. Run the /tp command — if they land in the right spot,
#      they were correct!
# ============================================================

# ─────────────────────────────────────────────────────────────
# CHALLENGE 1
# "Player House is at world position (-8, 66, -8).
#  The Chest Room is at local offset (1, 1, 1) from the house.
#  What is the Chest Room's WORLD position?"
#
# Answer:  world = parent + local
#          = (-8+1, 66+1, -8+1)
#          = (-7, 67, -7)
#
# Run this — if you land at the chest, you're correct!
# ─────────────────────────────────────────────────────────────
tp @s -7 68 -7


# ─────────────────────────────────────────────────────────────
# CHALLENGE 2
# "Player House moves 100 blocks east (X + 100).
#  New House position = (-8+100, 66, -8) = (92, 66, -8)
#  What is the NEW world position of the Chest Room?"
#
# Answer:  new world = new parent + same local offset
#          = (92+1, 66+1, -8+1)
#          = (93, 67, -7)
#
# Run this — there's nothing there (house didn't actually move),
# but students should land at the CORRECT coordinate.
# ─────────────────────────────────────────────────────────────
tp @s 93 67 -7


# ─────────────────────────────────────────────────────────────
# CHALLENGE 3
# "The NameTag sign is at local offset (0, 2, 0) from the house.
#  House is at (-8, 66, -8).
#  What is the sign's world position BEFORE the house moves?"
#
# Answer:  (-8+0, 66+2, -8+0) = (-8, 68, -8)
# ─────────────────────────────────────────────────────────────
tp @s -8 68 -8


# ─────────────────────────────────────────────────────────────
# CHALLENGE 4 — Extension (three-level hierarchy)
# "The Outer Wall is at world corner (-10, 66, -10).
#  Player House local offset from wall = (2, 0, 2).
#  Chest Room local offset from house = (1, 1, 1).
#
#  What is the Chest Room's world position?
#  (Chained vector addition — add all offsets together)
#
# Answer:  wall + house_offset + chest_offset
#          = (-10+2+1, 66+0+1, -10+2+1)
#          = (-7, 67, -7)
#
# Same as Challenge 1 — because the CHAIN adds up the same way!
# This is the insight: no matter how deep the hierarchy,
# world_pos = sum of all parent offsets.
# ─────────────────────────────────────────────────────────────
tp @s -7 68 -7


# ─────────────────────────────────────────────────────────────
# CHALLENGE 5 — Three axes, all different
# "Enemy Fortress is at world position (2, 66, -8).
#  Enemy Chest is at local offset (1, 1, 1) from the fortress.
#  The Outer Wall then shifts: Z + 50.
#
#  New Outer Wall corner = (-10, 66, -10+50) = (-10, 66, 40)
#  New Fortress world pos (same local offset from wall, Z+50):
#    original = (2, 66, -8) → new = (2, 66, -8+50) = (2, 66, 42)
#  New Enemy Chest world pos:
#    = (2+1, 66+1, 42+1) = (3, 67, 43)
# ─────────────────────────────────────────────────────────────
tp @s 3 67 43
