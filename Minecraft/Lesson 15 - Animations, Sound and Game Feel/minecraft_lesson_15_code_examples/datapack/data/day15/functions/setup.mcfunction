# =============================================================
# Day 15: setup.mcfunction
#
# Run this ONCE to set up everything in your world.
# Usage: /function day15:setup
#
# This is a helper for teachers and students — it handles all the
# one-time setup steps so you can focus on the lesson content.
# =============================================================

# Create the item-pickup tracking objectives
# (These can't be created in load.mcfunction because duplicates cause errors)
scoreboard objectives add nuggets_collected minecraft.picked_up:gold_nugget
scoreboard objectives add total_nuggets dummy "Total Coins"

# Give players some gold nuggets to test the collect sound
give @a gold_nugget 16

# Place a few gold nuggets on the ground nearby for pickup testing
summon item ~ ~1 ~ {Item:{id:"minecraft:gold_nugget",Count:1b},PickupDelay:0}
summon item ~1 ~1 ~ {Item:{id:"minecraft:gold_nugget",Count:1b},PickupDelay:0}
summon item ~-1 ~1 ~ {Item:{id:"minecraft:gold_nugget",Count:1b},PickupDelay:0}

# Start the background music
function day15:music/play

# Print a checklist to confirm everything loaded
tellraw @a [{"text":"\n=== Day 15 Setup Complete ===\n","color":"green","bold":true}]
tellraw @a [{"text":"✓ ","color":"green"},{"text":"Scoreboards created\n","color":"white"}]
tellraw @a [{"text":"✓ ","color":"green"},{"text":"Coin pickup tracking ready\n","color":"white"}]
tellraw @a [{"text":"✓ ","color":"green"},{"text":"Background music started\n","color":"white"}]
tellraw @a [{"text":"✓ ","color":"green"},{"text":"Gold nuggets spawned nearby\n","color":"white"}]
tellraw @a [{"text":"\nTIP: ","color":"yellow"},{"text":"Walk around, jump, and collect nuggets to test your sounds!","color":"gray"}]
