# ─────────────────────────────────────────────────────────────────────────────
# 05_multi_zone_template.mcfunction
# STEM Through Games — Day 7: Collision Detection
# ─────────────────────────────────────────────────────────────────────────────
#
# PURPOSE
#   A complete template for the summative activity: three coin zones that
#   each disappear on contact and contribute to a shared scoreboard.
#
#   This is the full Command Block layout to build in your world.
#
# WHAT TO BUILD (for each coin zone):
#   One REPEAT block  (detector)
#   Three CHAIN blocks attached to it in a row  (responder)
#
# SUGGESTED WORLD LAYOUT
#   Build each coin station underground so the command blocks are hidden
#   but the gold block markers are visible on the surface.
#
#   Coin 1 Station: command blocks at (10, 60, 10) → gold block at (11, 64, 11)
#   Coin 2 Station: command blocks at (20, 60, 10) → gold block at (21, 64, 11)
#   Coin 3 Station: command blocks at (30, 60, 10) → gold block at (31, 64, 11)
#
# ─────────────────────────────────────────────────────────────────────────────


# ══════════════════════════════════════════════════════════════
# COIN STATION 1
# Visual marker: gold block at (11, 64, 11)
# Detection box:  4×3×4 around the gold block
# ══════════════════════════════════════════════════════════════

# [REPEAT block — Unconditional, Always Active]
/testfor @a[x=10,y=64,z=10,dx=3,dy=2,dz=3]

# [CHAIN 1 — Conditional, Always Active]  add to score
/scoreboard players add @a[x=10,y=64,z=10,dx=3,dy=2,dz=3] score 1

# [CHAIN 2 — Conditional, Always Active]  remove gold block
/fill 11 64 11 11 64 11 barrier

# [CHAIN 3 — Conditional, Always Active]  feedback message
/title @a[x=10,y=64,z=10,dx=3,dy=2,dz=3] actionbar "Coin 1 collected! +1"


# ══════════════════════════════════════════════════════════════
# COIN STATION 2
# Visual marker: gold block at (21, 64, 11)
# Detection box:  4×3×4 around the gold block
# ══════════════════════════════════════════════════════════════

# [REPEAT block]
/testfor @a[x=20,y=64,z=10,dx=3,dy=2,dz=3]

# [CHAIN 1]
/scoreboard players add @a[x=20,y=64,z=10,dx=3,dy=2,dz=3] score 1

# [CHAIN 2]
/fill 21 64 11 21 64 11 barrier

# [CHAIN 3]
/title @a[x=20,y=64,z=10,dx=3,dy=2,dz=3] actionbar "Coin 2 collected! +1"


# ══════════════════════════════════════════════════════════════
# COIN STATION 3
# Visual marker: gold block at (31, 64, 11)
# Detection box:  4×3×4 around the gold block
# ══════════════════════════════════════════════════════════════

# [REPEAT block]
/testfor @a[x=30,y=64,z=10,dx=3,dy=2,dz=3]

# [CHAIN 1]
/scoreboard players add @a[x=30,y=64,z=10,dx=3,dy=2,dz=3] score 1

# [CHAIN 2]
/fill 31 64 11 31 64 11 barrier

# [CHAIN 3]
/title @a[x=30,y=64,z=10,dx=3,dy=2,dz=3] actionbar "Coin 3 collected! +1"


# ══════════════════════════════════════════════════════════════
# ALL-COINS WIN CONDITION  (add a 4th REPEAT block for this)
# ══════════════════════════════════════════════════════════════

# [REPEAT block — Unconditional, Always Active]
# Fires when score reaches 3 (all coins collected)
/scoreboard players test @a score 3 *

# [CHAIN 1 — Conditional]
/title @a title "ALL COINS FOUND!"

# [CHAIN 2 — Conditional]
/title @a subtitle "You win! Final score: 3"

# [CHAIN 3 — Conditional]  play victory sound
/playsound random.levelup @a


# ─────────────────────────────────────────────────────────────────────────────
# CUSTOMIZATION IDEAS
# ─────────────────────────────────────────────────────────────────────────────
#
# Change the visual marker block:
#   Replace "gold_block" with "diamond_block", "emerald_block", "redstone_block"
#   to give coins different visual styles or point values.
#
# Change the zone size:
#   Smaller dx/dy/dz = tighter hitbox = harder to collect
#   Larger  dx/dy/dz = looser hitbox  = easier to collect
#   This directly connects to the lesson's hitbox design discussion!
#
# Add a time limit:
#   Create a "time" objective and decrement it each tick with:
#   /scoreboard players remove @a time 1
#   Then test if time hits 0 for a game-over condition.
#
# ─────────────────────────────────────────────────────────────────────────────
