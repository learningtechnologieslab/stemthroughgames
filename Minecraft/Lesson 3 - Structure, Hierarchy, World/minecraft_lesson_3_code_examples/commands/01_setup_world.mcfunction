# ============================================================
# STEM through Games — Day 3: Structure, Hierarchy & the World
# FILE: 01_setup_world.mcfunction
#
# PURPOSE:
#   Sets up the starting flat world for the lesson.
#   Run this ONCE at the beginning of class to give every
#   student the same clean starting point.
#
# HOW TO RUN IN MINECRAFT EDUCATION:
#   1. Place a Command Block (give @s command_block)
#   2. Paste this file's commands one by one, OR
#   3. Copy the whole file into a .mcfunction file and run with:
#        /function stem_day3/01_setup_world
#
# WHAT IT DOES:
#   - Clears a 40x10x40 area at spawn
#   - Lays a flat bedrock + dirt ground layer (the "Ground Plane")
#   - Teleports the player to the starting position
#   - Gives the player the blocks they'll need
# ============================================================

# Step 1: Clear the build area (40 wide, 10 tall, 40 deep)
# Origin is (0, 64, 0) — the world spawn point
fill ~-20 ~0 ~-20 ~20 ~10 ~20 air

# Step 2: Lay the Ground Plane — bedrock base, then dirt surface
# This is the ROOT of our hierarchy: everything sits on top of it
fill ~-20 ~-1 ~-20 ~20 ~-1 ~20 bedrock
fill ~-20 ~0 ~-20 ~20 ~0 ~20 dirt

# Step 3: Add grass on top so it looks like a real world surface
fill ~-20 ~1 ~-20 ~20 ~1 ~20 grass_block

# Step 4: Teleport the player to the starting position
tp @s 0 66 0

# Step 5: Give the player the building materials for today
#   Oak planks  → Player House
#   Stone bricks → Enemy Fortress
#   Stone        → Outer Wall
#   Oak signs    → NameTag signs
#   Chests       → Chest Rooms
give @s oak_planks 64
give @s stone_bricks 64
give @s stone 64
give @s oak_sign 16
give @s chest 8
give @s torch 32

# Step 6: Set the time to day and clear weather
time set day
weather clear

# Step 7: Send a welcome message to all players
say === STEM Day 3: Structure and Hierarchy ===
say Your building materials have been added to your inventory.
say Build origin is at (0, 64, 0). Press F3 to see your coordinates!
