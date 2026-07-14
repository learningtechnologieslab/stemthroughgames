# =============================================================
# Day 15 EXTENSION: extension/hurt.mcfunction
#
# CHALLENGE: Add a "hurt" state with sound + particle effect.
# This is the 4th animation state from the extension challenge.
#
# HOW IT WORKS:
# We use a scoreboard objective that tracks damage taken.
# When the score goes above 0, the player just took a hit.
#
# SETUP: Add this objective first (run once):
#   /scoreboard objectives add damage_taken minecraft.custom:damage_taken
#
# Then call this function from tick.mcfunction:
#   function day15:extension/hurt
# =============================================================

# Play the hurt sound if the player took damage this tick
execute as @a[scores={damage_taken=1..}] at @s run playsound custom.hurt player @s ~ ~ ~ 0.9 1.0

# Spawn a visual particle effect at the player's position (mimics knockback flash)
execute as @a[scores={damage_taken=1..}] at @s run particle damage_indicator ~ ~1 ~ 0.3 0.3 0.3 0.05 10

# Reset the damage tracker
scoreboard players set @a damage_taken 0

# ── MATH CHALLENGE ───────────────────────────────────────────
# QUESTION: You want the hurt effect to show for 0.4 seconds.
# How many ticks is that?
#
# Formula: seconds × 20 = ticks
# Answer:  0.4 × 20 = 8 ticks
#
# TRY IT: Add a cooldown scoreboard to lock movement-sounds
# for 8 ticks after taking damage (simulates knockback stun).
# ─────────────────────────────────────────────────────────────
