# ============================================================
# Day 8 — Chunk Coordinates & World Design
# Minecraft Education Edition  |  .mcfunction command file
# ============================================================
# How to use:
#   Option A) Type commands one at a time into the Minecraft chat bar (press T).
#   Option B) Paste this file into a behaviour pack's functions/ folder and run
#             it with:  /function day8_commands
# ============================================================


# ------------------------------------------------------------
# SECTION 1 — NAVIGATION & COORDINATES
# ------------------------------------------------------------

# Teleport to the world origin (0, 64, 0)
# Y=64 is standard surface level on a flat world
/tp @s 0 64 0

# Teleport to specific coordinates from your sketch
# Replace X, Y, Z with your values
/tp @s 48 64 32

# Check your current coordinates (shows in chat)
/tp @s ~ ~ ~

# Summon a marker at a specific location so you can see it
/summon armor_stand 0 64 0


# ------------------------------------------------------------
# SECTION 2 — SETTING THE WORLD SPAWN
# ------------------------------------------------------------

# Set the world spawn point (where players respawn)
# Replace X Y Z with your chosen starting block
/setworldspawn 0 64 0

# Teleport yourself to the current spawn point
/tp @s 0 64 0

# Set your personal spawn (bed / respawn anchor equivalent)
/spawnpoint @s 0 64 0


# ------------------------------------------------------------
# SECTION 3 — /fill COMMANDS  (the big one!)
# ------------------------------------------------------------
# Syntax: /fill X1 Y1 Z1  X2 Y2 Z2  block_type
# This places a filled rectangular region of blocks.
# Think of (X1,Y1,Z1) as one corner and (X2,Y2,Z2) as the opposite corner.

# --- Build a flat platform (8 blocks wide × 1 block tall × 4 blocks deep) ---
/fill 0 63 0  7 63 3  stone

# --- Build a raised platform (step up from the first) ---
/fill 10 64 0  17 64 3  stone

# --- Build a wall (3 blocks tall, 8 blocks wide) ---
/fill 0 64 0  7 66 0  cobblestone

# --- Carve out a gap (replace blocks with air — creates a hazard pit!) ---
/fill 20 63 0  23 63 3  air

# --- Fill a pit with lava (hazard zone) ---
/fill 20 62 0  23 62 3  lava

# --- Build a goal platform with a beacon base ---
/fill 50 63 0  55 63 5  diamond_block

# --- Clear an area back to air (undo a section) ---
/fill 0 64 0  60 70 10  air replace

# --- Replace only a specific block type (e.g. dirt → grass) ---
/fill 0 63 0  60 63 10  grass replace dirt


# ------------------------------------------------------------
# SECTION 4 — PLACING COLLECTIBLES & GOAL MARKERS
# ------------------------------------------------------------

# Place a gold block as a visible collectible marker
/setblock 10 65 2  gold_block

# Place an emerald block as a checkpoint
/setblock 25 65 2  emerald_block

# Place a beacon (goal zone centrepiece)
/setblock 52 64 2  beacon

# Place a chest at spawn so students can grab tools
/setblock 2 64 2  chest


# ------------------------------------------------------------
# SECTION 5 — GAME MODE SWITCHING  (for testing)
# ------------------------------------------------------------

# Switch to Adventure mode — tests hazards properly
# (players can't break or place blocks)
/gamemode adventure @s

# Switch back to Creative mode — for building
/gamemode creative @s

# Switch to Survival — full gameplay test
/gamemode survival @s

# Give yourself back creative flight after testing
/gamemode creative @s


# ------------------------------------------------------------
# SECTION 6 — BOUNDARY BARRIERS
# ------------------------------------------------------------

# Build an invisible barrier wall along the north edge (Z=−1)
# Barrier blocks stop players but are invisible in-game
/fill 0 63 -1  60 70 -1  barrier

# Build a barrier wall along the south edge (Z=10)
/fill 0 63 10  60 70 10  barrier

# Build barrier walls on the west and east ends
/fill -1 63 -1  -1 70 10  barrier
/fill 61 63 -1  61 70 10  barrier


# ------------------------------------------------------------
# SECTION 7 — CHUNK MATH HELPERS
# ------------------------------------------------------------
# A chunk is always 16 × 16 blocks (X and Z axes).
# To find which chunk a block is in:
#   chunk_X = floor(block_X / 16)
#   chunk_Z = floor(block_Z / 16)
#
# To teleport to the start of a chunk (e.g. chunk 3 on X axis):
#   block_X = 3 * 16 = 48
/tp @s 48 64 0

# Teleport to start of chunk (2, 1):
#   X = 2*16 = 32,  Z = 1*16 = 16
/tp @s 32 64 16


# ------------------------------------------------------------
# SECTION 8 — EXTENSION: COMMAND BLOCKS
# (for the Extension differentiation tier)
# ------------------------------------------------------------

# Place a command block (requires cheats / op permissions)
/give @s command_block

# Once placed, open the command block GUI and enter:
#   /title @a[r=3] actionbar  You reached the Goal! 🎉
# Set it to "Repeat" and "Always Active" to trigger
# whenever a player walks within 3 blocks.

# Alternatively, use a chain of command blocks:
#   Block 1 (Impulse, needs Redstone):  /detect ... 
#   Block 2 (Chain):  /title @a[r=3] title  Level Complete!
#   Block 3 (Chain):  /playsound random.levelup @a[r=3]
