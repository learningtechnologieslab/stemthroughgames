# =============================================================
# Day 15 EXTENSION: extension/biome_music.mcfunction
#
# CHALLENGE: Play different music depending on which biome
# the player is currently standing in.
#
# This teaches: conditional logic, state awareness, and how
# game designers use audio to reinforce environmental storytelling.
#
# SETUP: Add sounds for each biome theme to your sounds.json:
#   custom.theme_cave, custom.theme_forest, custom.theme_ocean
#
# Add this to your resource pack's sounds.json, then call this
# function from tick.mcfunction (or every 100 ticks to save performance).
# =============================================================

# ── CAVE / UNDERGROUND ────────────────────────────────────────
# Check if the player is below Y=40 (underground zone)
execute as @a[y=-64,dy=104] at @s run stopsound @s music
execute as @a[y=-64,dy=104] at @s run playsound custom.theme_tense music @s ~ ~ ~ 0.4 1.0

# ── OCEAN / WATER ─────────────────────────────────────────────
# Check if the player is inside water (the "in_water" advancement predicate)
# Simplified: check if player is in a water biome
execute as @a in minecraft:overworld at @s if biome ~ ~ ~ minecraft:ocean run stopsound @s music
execute as @a in minecraft:overworld at @s if biome ~ ~ ~ minecraft:ocean run playsound custom.theme music @s ~ ~ ~ 0.3 0.9

# ── SURFACE / DEFAULT ────────────────────────────────────────
# Players above Y=64 and not in special biome get the normal theme
execute as @a[y=64,dy=256] at @s run playsound custom.theme music @s ~ ~ ~ 0.4 1.0

# ── DISCUSSION QUESTION ────────────────────────────────────────
# Why would a cave use "theme_tense" and the surface use "theme"?
# What does music tempo communicate about danger level?
# How does this connect to emotional design?
# ──────────────────────────────────────────────────────────────
