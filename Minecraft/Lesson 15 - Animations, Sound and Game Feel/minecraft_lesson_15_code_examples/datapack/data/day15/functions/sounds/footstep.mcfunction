# =============================================================
# Day 15: sounds/footstep.mcfunction
#
# Plays a custom footstep sound when the player is walking.
#
# CONCEPT: We check two things:
#   1. Is the player moving? (motion score > 0)
#   2. Is the cooldown finished? (step_cooldown = 0)
#
# Without the cooldown, sounds would play 20x per second — way too fast.
# The cooldown timer creates a realistic step rhythm.
#
# MATH CONNECTION:
#   Cooldown = 6 ticks. At 20 ticks/sec: 6 ÷ 20 = 0.3 seconds between steps.
#   Try changing the cooldown value and listening to the difference!
# =============================================================

# Play footstep IF: player is moving AND cooldown has expired
execute as @a[scores={motion=1.., step_cooldown=0}] at @s run playsound custom.footstep player @s ~ ~ ~ 0.6 1.0

# Reset the cooldown for anyone who just played a step sound
# 6 ticks = 0.3 seconds. Feels natural for a walking pace.
# Try 3 (fast/running feel) or 10 (slow/cautious feel)
execute as @a[scores={motion=1.., step_cooldown=0}] run scoreboard players set @s step_cooldown 6

# EXTENSION: Play a softer sound when sneaking
# Sneaking players move slower, so the cooldown is longer too.
execute as @a[sneaking=true, scores={motion=1.., step_cooldown=0}] at @s run playsound custom.footstep_soft player @s ~ ~ ~ 0.25 0.85
