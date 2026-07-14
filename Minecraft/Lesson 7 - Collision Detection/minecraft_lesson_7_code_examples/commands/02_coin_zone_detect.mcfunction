# ─────────────────────────────────────────────────────────────────────────────
# 02_coin_zone_detect.mcfunction
# STEM Through Games — Day 7: Collision Detection
# ─────────────────────────────────────────────────────────────────────────────
#
# PURPOSE
#   This command goes in a REPEAT Command Block set to ALWAYS ACTIVE.
#   It runs every game tick (~20 times per second) and checks whether
#   any player is standing inside Coin Zone 1.
#
#   When /testfor succeeds, any CONDITIONAL chain blocks connected to
#   it will fire.  When /testfor fails, conditional chains are skipped.
#
# HOW TO USE
#   1. Place a Command Block in your world.
#   2. Right-click it → set Block Type to REPEAT.
#   3. Set Condition to UNCONDITIONAL.
#   4. Set Redstone to ALWAYS ACTIVE.
#   5. Paste the command below into the text field.
#   6. Repeat for each coin zone, changing the coordinates each time.
#
# UNDERSTANDING THE PARAMETERS
#   /testfor @a[x=10,y=64,z=10,dx=3,dy=2,dz=3]
#            ─┬─ ────────────────────────────────
#             │  Selector with position filter:
#             │    x, y, z  → corner of the detection box (lowest coords)
#             │    dx       → how many extra blocks East  (dx=3 → 4 blocks wide)
#             │    dy       → how many extra blocks Up    (dy=2 → 3 blocks tall)
#             │    dz       → how many extra blocks South (dz=3 → 4 blocks deep)
#             @a  → test ALL players (use @p for nearest player only)
#
# ─────────────────────────────────────────────────────────────────────────────

# ── COIN ZONE 1 ─────────────────────────────────────────────
# Place a gold block at (11, 64, 11) as a visual marker.
# Detection zone is a 4×3×4 block box around it.
/testfor @a[x=10,y=64,z=10,dx=3,dy=2,dz=3]


# ─────────────────────────────────────────────────────────────────────────────
# TEACHER NOTE
# ─────────────────────────────────────────────────────────────────────────────
# After placing this Repeat Block, place CHAIN blocks directly next to it
# (touching the output face — the arrow on the block shows which face).
# Those chain blocks hold the response logic from 03_coin_zone_collect.mcfunction.
#
# The chain of blocks looks like this:
#
#   [REPEAT /testfor]  →→  [CHAIN /scoreboard add]  →→  [CHAIN /fill air]
#                            (Conditional)                (Conditional)
#
# "Conditional" means: only run if the previous block succeeded.
# ─────────────────────────────────────────────────────────────────────────────
