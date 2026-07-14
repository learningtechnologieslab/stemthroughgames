# ============================================================
# Day 9 — Example 3: Comparison Operators
# STEM Through Games | Minecraft Education Edition
# ============================================================
#
# WHAT THIS DEMONSTRATES:
#   All six comparison operators used in real Minecraft
#   game conditions. Every comparison returns True or False —
#   these are called Boolean values.
#
# MATH CONNECTION:
#   These operators come directly from math class!
#   ==  means "equal to"              (like = in equations)
#   !=  means "not equal to"          (like ≠)
#   <   means "less than"             (like <)
#   >   means "greater than"          (like >)
#   <=  means "less than or equal"    (like ≤)
#   >=  means "greater than or equal" (like ≥)
# ============================================================

score = 5
health = 25
weapon = "sword"
time_left = 8
high_score = 10


# --- == (Equal to) ---
# True only when both sides are EXACTLY the same value
if score == 0:
    player.say("Score is zero — showing tutorial.")
else:
    player.say("Score is " + str(score) + " (not zero, skipping tutorial).")


# --- != (Not equal to) ---
# True when the two sides are DIFFERENT
if weapon != "sword":
    player.say("No sword equipped — attack disabled.")
else:
    player.say("Sword equipped — ready to fight!")


# --- < (Less than) ---
# True when the LEFT side is strictly SMALLER than the right
if time_left < 10:
    player.say("Hurry! Only " + str(time_left) + " seconds left!")
else:
    player.say("Time remaining: " + str(time_left))


# --- > (Greater than) ---
# True when the LEFT side is strictly LARGER than the right
if score > high_score:
    player.say("New high score! Saving record.")
else:
    player.say("Score " + str(score) + " doesn't beat high score of " + str(high_score) + ".")


# --- <= (Less than or equal to) ---
# True when left side is smaller than OR exactly equal to the right
if health <= 0:
    player.say("Game Over!")
    mobs.spawn(ZOMBIE, pos(0, 0, 0))
else:
    player.say("Still alive — health is " + str(health) + ".")


# --- >= (Greater than or equal to) ---
# True when left side is larger than OR exactly equal to the right
if score >= 10:
    player.say("You Win! Score reached " + str(score) + "!")
else:
    player.say("Need " + str(10 - score) + " more points to win.")


# ============================================================
# EXPERIMENT: Change the values at the top (score, health,
# weapon, time_left, high_score) and re-run to see which
# branches trigger. Can you make every condition True?
# ============================================================
