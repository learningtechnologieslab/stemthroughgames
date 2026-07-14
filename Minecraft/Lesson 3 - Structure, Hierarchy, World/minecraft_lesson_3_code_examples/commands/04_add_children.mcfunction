# ============================================================
# STEM through Games — Day 3: Structure, Hierarchy & the World
# FILE: 04_add_children.mcfunction
#
# PURPOSE:
#   Adds the remaining child structures to complete the
#   full hierarchy from the lesson plan:
#
#   Outer Wall         (root)
#   ├─ Player House    (child of Outer Wall)
#   │  ├─ Chest Room   ← adding now
#   │  └─ NameTag      ← already placed
#   ├─ Enemy Fortress  ← adding now
#   │  └─ Enemy Chest  ← adding now
#   └─ Ground Plane    (already exists from setup)
# ============================================================

# ─────────────────────────────────────────────────────────────
# CHEST ROOM — child of Player House
# Local offset from House NW corner (-8, 66, -8): (+1, 0, +1)
# World position of first chest: (-7, 67, -7)
# ─────────────────────────────────────────────────────────────

# Place two chests side by side in the NW corner of the house
setblock -7 67 -7  chest[facing=south]
setblock -6 67 -7  chest[facing=south]

# Label the chest room with a sign on the wall above
setblock -7 69 -8  oak_wall_sign[facing=south]{Text1:'{"text":"[ CHEST ROOM ]"}',Text2:'{"text":"Child of: Player House"}',Text3:'{"text":"Local offset:"}',Text4:'{"text":"(1, 1, 1) from House NW"}'}

# ─────────────────────────────────────────────────────────────
# ENEMY FORTRESS — child of Outer Wall, sibling of Player House
# Placed in the EAST side of the compound
# Local offset from Outer Wall SW corner: (+12, 0, +2)
# World position: (2, 66, -8)
# ─────────────────────────────────────────────────────────────

# Fortress floor
fill 2 66 -8  8 66 -2  stone_bricks

# Fortress walls (stone bricks — visually different from Player House)
fill 2 67 -8  8 69 -8  stone_bricks
fill 2 67 -2  8 69 -2  stone_bricks
fill 2 67 -8  2 69 -2  stone_bricks
fill 8 67 -8  8 69 -2  stone_bricks

# Fortress roof (leave open / battlements)
fill 2 70 -8  8 70 -8  stone_bricks
fill 2 70 -2  8 70 -2  stone_bricks
fill 2 70 -8  2 70 -2  stone_bricks
fill 8 70 -8  8 70 -2  stone_bricks

# Fortress door gap
fill 5 67 -2  5 68 -2  air

# Interior torches for the fortress
setblock 3 69 -7  torch
setblock 7 69 -3  torch

# ─────────────────────────────────────────────────────────────
# ENEMY CHEST — child of Enemy Fortress
# Local offset from Fortress NW corner (2, 66, -8): (+1, +1, +1)
# World position: (3, 67, -7)
# ─────────────────────────────────────────────────────────────
setblock 3 67 -7  chest[facing=south]

# Label the enemy fortress
setblock 5 70 -2  oak_sign[facing=south]{Text1:'{"text":"[ ENEMY FORTRESS ]"}',Text2:'{"text":"Child of: Outer Wall"}',Text3:'{"text":"Sibling of: Player House"}',Text4:'{"text":"Local offset: (12,0,2)"}'}

# ─────────────────────────────────────────────────────────────
# ANNOUNCE the completed hierarchy
# ─────────────────────────────────────────────────────────────
say Full compound hierarchy is now built!
say
say HIERARCHY:
say   Outer Wall  (root)
say     Player House  (child of Outer Wall)
say       Chest Room  (child of Player House)
say       NameTag Sign  (child of Player House)
say     Enemy Fortress  (child of Outer Wall)
say       Enemy Chest  (child of Fortress)
say     Ground Plane  (child of Outer Wall)
say
say DISCUSS: Pick any structure. What is its absolute world position?
say MATH: Can you find the local offset from its parent's corner?
