# ============================================================
# Day 9 — Example 1: Warm-Up If/Else Thinking
# STEM Through Games | Minecraft Education Edition
# ============================================================
#
# WHAT THIS DEMONSTRATES:
#   The basic if / else structure using simple, relatable
#   Minecraft scenarios. No variables needed — just logic!
#
# HOW TO RUN IN MINECRAFT EDUCATION:
#   1. Open your world in Minecraft Education Edition
#   2. Press C to open Code Builder
#   3. Select Python mode
#   4. Paste or type this code, then click Run
# ============================================================

# ----------------------------------------------------------
# SCENARIO 1: Lava Check
# "IF the player touches lava THEN take damage ELSE keep walking"
# ----------------------------------------------------------

touching_lava = True   # Try changing this to False!

if touching_lava:
    player.say("Ouch! Taking damage from lava!")
else:
    player.say("Safe to walk — no lava here.")

# ----------------------------------------------------------
# SCENARIO 2: Score Check
# "IF score reaches 10 THEN level up ELSE keep playing"
# ----------------------------------------------------------

score = 7   # Try changing this to 10 or higher!

if score >= 10:
    player.say("Level Up! Great job!")
else:
    player.say("Keep going! Score is " + str(score))

# ----------------------------------------------------------
# SCENARIO 3: Mob Awareness
# "IF a Zombie sees the player THEN chase ELSE wander"
# ----------------------------------------------------------

zombie_sees_player = False   # Try changing this to True!

if zombie_sees_player:
    player.say("Zombie spotted you — RUN!")
else:
    player.say("Zombie is wandering. You're safe.")

# ============================================================
# CHALLENGE: Write your OWN if/else scenario below.
# Think of a Minecraft situation with two possible outcomes.
#
# my_condition = True
# if my_condition:
#     player.say("YOUR TRUE outcome here")
# else:
#     player.say("YOUR FALSE outcome here")
# ============================================================
