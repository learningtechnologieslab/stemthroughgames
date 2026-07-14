# ─────────────────────────────────────────────────────────────────────────────
# 03_coin_zone_collect.mcfunction
# STEM Through Games — Day 7: Collision Detection
# ─────────────────────────────────────────────────────────────────────────────
#
# PURPOSE
#   These commands go in CHAIN blocks connected to the REPEAT detector block
#   from 02_coin_zone_detect.mcfunction.
#
#   Each CHAIN block must be set to:
#     Block Type  → CHAIN
#     Condition   → CONDITIONAL  (only fires when previous block succeeded)
#     Redstone    → ALWAYS ACTIVE
#
# CHAIN BLOCK ORDER (left to right from the Repeat block):
#   [1] Score increment
#   [2] Remove the coin block
#   [3] Show feedback to the player
#
# ─────────────────────────────────────────────────────────────────────────────


# ── CHAIN BLOCK 1: Add 1 to score for any player in the zone ────────────────
#
#    Put this in the FIRST chain block after the Repeat detector.
#    The selector MUST match the /testfor selector exactly so only
#    the player who triggered the detection gets the point.
#
/scoreboard players add @a[x=10,y=64,z=10,dx=3,dy=2,dz=3] score 1


# ── CHAIN BLOCK 2: Remove the coin block ────────────────────────────────────
#
#    /fill replaces a region with a different block.
#    Here we replace the single gold block at (11, 64, 11) with air,
#    making the coin visually disappear.
#
#    Syntax: /fill <x1> <y1> <z1> <x2> <y2> <z2> <block>
#    For a single block, x1=x2, y1=y2, z1=z2.
#
/fill 11 64 11 11 64 11 air


# ── CHAIN BLOCK 3: Show a title message ─────────────────────────────────────
#
#    /title shows text on screen.
#    "actionbar" appears at the bottom-center — less intrusive than "title".
#    "subtitle" appears below the main title.
#
#    Options:
#      /title @a title "Big Text"          → large center screen
#      /title @a subtitle "Small Text"     → below main title
#      /title @a actionbar "Bottom Text"   → bottom of screen (best for coins)
#
/title @a[x=10,y=64,z=10,dx=3,dy=2,dz=3] actionbar "Coin collected! +1"


# ─────────────────────────────────────────────────────────────────────────────
# IMPORTANT: THE COIN BLOCK MUST BE REPLACED AFTER COLLECTION
# ─────────────────────────────────────────────────────────────────────────────
#
# Problem: Once the gold block is replaced with air, the /fill command keeps
# running every tick (it does nothing, which is fine).  But the /testfor
# will keep detecting the player if they stand still, awarding infinite score!
#
# Solutions (pick one):
#
#   A) Add a cooldown objective — advanced, covered in Day 9.
#
#   B) Use /fill to place a barrier block instead of air:
#      /fill 11 64 11 11 64 11 barrier
#      This is invisible to players but stops the zone from re-triggering
#      because the barrier occupies the block space.
#
#   C) Move the /testfor zone off-axis after collection (advanced).
#
# For today's lesson, Solution B is recommended:
/fill 11 64 11 11 64 11 barrier
#
# ─────────────────────────────────────────────────────────────────────────────
