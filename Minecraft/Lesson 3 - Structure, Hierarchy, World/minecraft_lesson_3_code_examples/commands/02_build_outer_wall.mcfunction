# ============================================================
# STEM through Games — Day 3: Structure, Hierarchy & the World
# FILE: 02_build_outer_wall.mcfunction
#
# PURPOSE:
#   Builds the Outer Wall — the ROOT (parent) structure that
#   contains everything else. This is the "World" node.
#
# TEACHER NOTE:
#   Run this to demo the outer wall, OR let students build it
#   by hand first, then run this to check/correct their work.
#
# COORDINATES:
#   The wall forms a 20x20 boundary centered on (0, 66, 0).
#   Corners: (-10, 66, -10) to (10, 66, 10)
#   Wall height: 3 blocks tall
# ============================================================

# --- BUILD THE OUTER WALL (the "World" / root node) ---

# North wall  (Z = -10)
fill -10 66 -10  10 68 -10  stone

# South wall  (Z = +10)
fill -10 66  10  10 68  10  stone

# West wall   (X = -10)
fill -10 66 -10 -10 68  10  stone

# East wall   (X = +10)
fill  10 66 -10  10 68  10  stone

# --- LABEL THE ENTRANCE (a gap in the south wall) ---
# Cut a doorway in the south wall so students can walk in
fill -1 66 10  1 67 10  air

# --- PLACE A WELCOME SIGN AT THE ENTRANCE ---
# This sign labels the structure in our hierarchy
setblock 0 68 10 oak_sign[facing=north]{Text1:'{"text":"[ OUTER WALL ]"}',Text2:'{"text":"Root / World Node"}',Text3:'{"text":"Everything lives"}',Text4:'{"text":"inside here."}'}

# --- ANNOUNCE SUCCESS ---
say Outer Wall built! This is the ROOT of our hierarchy.
say Notice: it forms a boundary that will CONTAIN all child structures.
say DISCUSS: Why is this the "parent" of everything we build today?
