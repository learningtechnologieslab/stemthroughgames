# ============================================================
# STEM through Games — Day 3: Structure, Hierarchy & the World
# FILE: 03_build_player_house.mcfunction
#
# PURPOSE:
#   Builds the Player House — a CHILD of the Outer Wall.
#   This structure demonstrates that children live INSIDE
#   their parent and their position is measured from the
#   parent's corner, not from the world origin.
#
# HIERARCHY SO FAR:
#   Outer Wall  (root / World)
#   └─ Player House  ← we're building this now
#      └─ Chest Room  (next step)
#      └─ NameTag Sign (next step)
#
# LOCAL POSITION of Player House:
#   Measured from Outer Wall's SW corner (-10, 66, -10):
#   Local offset = (+2, 0, +2) → world position = (-8, 66, -8)
# ============================================================

# --- PLAYER HOUSE FLOOR (oak planks) ---
# World coords: (-8, 66, -8) to (-2, 66, -2)
# Local offset from Outer Wall corner: (2, 0, 2) to (8, 0, 8)
fill -8 66 -8  -2 66 -2  oak_planks

# --- PLAYER HOUSE WALLS ---
# North wall
fill -8 67 -8  -2 69 -8  oak_planks
# South wall (with door gap)
fill -8 67 -2  -2 69 -2  oak_planks
fill -6 67 -2  -5 68 -2  air

# West wall
fill -8 67 -8  -8 69 -2  oak_planks
# East wall
fill -2 67 -8  -2 69 -2  oak_planks

# --- PLAYER HOUSE ROOF ---
fill -8 70 -8  -2 70 -2  oak_planks

# --- INTERIOR LIGHTING ---
setblock -5 69 -5  torch

# --- NAMETAG SIGN on the door (child of Player House) ---
# Local offset from House entrance: (0, +2, 0)  → labels the building
setblock -5 70 -2  oak_sign[facing=south]{Text1:'{"text":"[ PLAYER HOUSE ]"}',Text2:'{"text":"Child of: Outer Wall"}',Text3:'{"text":"Local offset:"}',Text4:'{"text":"(+2, 0, +2) from SW"}'}

# --- ANNOUNCE ---
say Player House built! It is a CHILD of the Outer Wall.
say DISCUSS: What is the local position of the house from the wall corner?
say MATH CHECK: Wall SW corner = (-10, 66, -10). House starts at (-8, 66, -8).
say That means local offset = (2, 0, 2). Does that match your guess?
