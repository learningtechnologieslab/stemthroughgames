# =============================================================
# Day 15: sounds/collect.mcfunction
#
# Plays a "ding" collect sound when a player picks up a gold nugget.
# Gold nuggets represent coins in our game world.
#
# HOW THIS WORKS:
# Minecraft's stat system tracks item pickups automatically.
# We create a scoreboard objective that reads the "picked_up" stat
# for a specific item, then check if the count has increased.
#
# SETUP REQUIRED:
#   Run this command once to create the pickup tracker:
#   /scoreboard objectives add nuggets_collected minecraft.picked_up:gold_nugget
#
#   Or use the setup.mcfunction file included in this pack.
# =============================================================

# Play collect sound for any player who has collected at least 1 nugget
execute as @a[scores={nuggets_collected=1..}] at @s run playsound custom.collect player @s ~ ~ ~ 1.0 1.2

# Reset the counter so we only play once per pickup, not every tick
scoreboard players set @a[scores={nuggets_collected=1..}] nuggets_collected 0

# ── EXTENSION CHALLENGE ──────────────────────────────────────
# What if collecting 10 nuggets plays a "level up" fanfare?
# Hint: use a second scoreboard to track TOTAL collected, not per-tick.
# 
# /scoreboard objectives add total_nuggets dummy
# Then add 1 to total_nuggets each time the collect sound plays,
# and check: if total_nuggets >= 10, play a fanfare sound!
# ─────────────────────────────────────────────────────────────
